import random
import uuid

# Configuration
OUTPUT_FILE = "populate_full_curriculum.sql"
QUESTIONS_PER_LEVEL = 10

# Grades mapping
GRADES = {
    "Pre-K 3": -2,
    "Pre-K 4": -1,
    "Kindergarten": 0,
    "1st Grade": 1,
    "2nd Grade": 2,
    "3rd Grade": 3,
    "4th Grade": 4,
    "5th Grade": 5
}

# Topics
TOPICS = ["Math", "Science", "Social Studies"]

def escape_sql(text):
    return text.replace("'", "''")

def generate_header():
    return """-- =============================================================
-- AUTOMATICALY GENERATED CURRICULUM (generate_curriculum.py)
-- =============================================================
-- 10 Questions per Level, All Grades (-2 to 5)
-- =============================================================

BEGIN;

-- 1. CLEANUP
DELETE FROM student_progress WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM questions WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM challenges WHERE is_exam = FALSE;

"""

def generate_footer():
    return """
COMMIT;
"""

def generate_challenge_sql(grade_key, grade_val, level):
    # Determine topic based on level to ensure variety, or just rotate
    # For simplicity, let's say:
    # Levels 1-4: Math
    # Levels 5-7: Science
    # Levels 8-10: Social Studies
    # EXCEPT Pre-K which has specific themes
    
    topic = "Math"
    if grade_val < 0:
        # Pre-K specific themes often override this, but we'll stick to a mapping
        if level <= 4: topic = "Math"
        elif level <= 7: topic = "Science"
        else: topic = "Social Studies"
        if grade_val == -1 and level <= 10: topic = "Ocean" # Override for Pre-K 4 Ocean theme? Or mix it.
        # Let's keep standard topics for consistency with code
        if topic == "Ocean": topic = "Science" 
    else:
        if level <= 5: topic = "Math"
        elif level <= 8: topic = "Science"
        else: topic = "Social Studies"

    challenge_id = f"gen_{grade_val}_{level}"
    if grade_val < 0:
         challenge_id = f"gen_neg{abs(grade_val)}_{level}"
         
    sql = f"INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('{challenge_id}', '{topic}', {grade_val}, {level}, FALSE);\n"
    return challenge_id, sql

def generate_math_question(grade_val, level):
    # Procedural Math Gen
    q_text = ""
    correct = ""
    wrongs = []
    
    # Difficulty scalars
    base = 5 + (grade_val + 3) * 5 # Base number range increases with grade
    modifier = level * (grade_val + 2) # Level multiplier
    
    op = random.choice(['+', '-'])
    if grade_val >= 2: op = random.choice(['+', '-', 'x'])
    if grade_val >= 4: op = random.choice(['+', '-', 'x', '/'])
    
    if op == '+':
        a = random.randint(1, base + modifier)
        b = random.randint(1, base + modifier)
        ans = a + b
        q_text = f"What is {a} + {b}?"
        correct = str(ans)
        wrongs = [str(ans + random.randint(1, 5)), str(abs(ans - random.randint(1, 5)))]
    elif op == '-':
        a = random.randint(5, base + modifier + 10)
        b = random.randint(1, a)
        ans = a - b
        q_text = f"What is {a} - {b}?"
        correct = str(ans)
        wrongs = [str(ans + random.randint(1, 3)), str(abs(ans - random.randint(1, 3)))]
    elif op == 'x':
        range_limit = 5 + grade_val # Grade 2: up to 7x7, Grade 5: up to 10x10
        if range_limit > 12: range_limit = 12
        a = random.randint(0, range_limit + int(level/2))
        b = random.randint(0, range_limit)
        ans = a * b
        q_text = f"What is {a} x {b}?"
        correct = str(ans)
        wrongs = [str(ans + a), str(abs(ans - b))]
    elif op == '/':
        b = random.randint(2, 10)
        ans = random.randint(1, 10 + grade_val)
        a = b * ans
        q_text = f"What is {a} / {b}?"
        correct = str(ans)
        wrongs = [str(ans + 1), str(ans - 1 if ans > 1 else 2)]

    # Dedupe wrongs
    if wrongs[0] == correct: wrongs[0] = str(int(correct) + 10)
    if wrongs[1] == correct: wrongs[1] = str(int(correct) + 7)
    if wrongs[0] == wrongs[1]: wrongs[1] = str(int(wrongs[0]) + 1)
        
    return q_text, correct, wrongs[0], wrongs[1]

# Static Content Banks (Small subsets to mix in)
SCIENCE_QUESTIONS = [
    ("What do plants need?", "Sunlight", "Pizza", "Toys"),
    ("Which is a liquid?", "Water", "Ice", "Steam"),
    ("The sun is a...?", "Star", "Planet", "Moon"),
    ("Frogs start as...?", "Tadpoles", "Eggs", "Fish"),
    ("Birds have...?", "Feathers", "Fur", "Scales"),
    ("Fish live in...?", "Water", "Trees", "Dirt"),
    ("Which animal barks?", "Dog", "Cat", "Cow"),
    ("Ice is frozen...?", "Water", "Milk", "Juice"),
    ("Humans breathe...?", "Air", "Water", "Dirt"),
    ("The Earth is...?", "Round", "Flat", "Square"),
]

SOCIAL_QUESTIONS = [
    ("Firefighters drive...?", "Trucks", "Cars", "Boats"),
    ("We learn at...?", "School", "Home", "Park"),
    ("Red light means...?", "Stop", "Go", "Run"),
    ("Green light means...?", "Go", "Stop", "Wait"),
    ("Policemen help...?", "Safe", "Danger", "Run"),
    ("USA flag colors?", "Red White Blue", "Green Yellow", "Pink"),
    ("Mail carriers bring...?", "Mail", "Pizza", "Toys"),
    ("Teachers help us...?", "Learn", "Sleep", "Eat"),
    ("Doctors help when...?", "Sick", "Happy", "Sad"),
    ("We buy food at...?", "Grocery Store", "Bank", "Library")
]

def generate_static_question(topic, i):
    if topic == "Science":
        q = SCIENCE_QUESTIONS[i % len(SCIENCE_QUESTIONS)]
        return q[0], q[1], q[2], q[3]
    elif topic == "Social Studies" or topic == "Social":
        q = SOCIAL_QUESTIONS[i % len(SOCIAL_QUESTIONS)]
        return q[0], q[1], q[2], q[3]
    else:
        # Fallback to math if topic unexpected
        return generate_math_question(1, 1)

def main():
    f = open(OUTPUT_FILE, "w", encoding="utf-8")
    f.write(generate_header())

    total_q = 0

    for grade_name, grade_val in GRADES.items():
        f.write(f"\n-- {grade_name} (Grade {grade_val})\n")
        
        for level in range(1, 11):
            cid, c_sql = generate_challenge_sql(grade_name, grade_val, level)
            f.write(c_sql)
            
            # Determine Topic from SQL generation logic (re-derived for simplicity)
            topic = "Math"
            if "Math" in c_sql: topic = "Math"
            elif "Science" in c_sql: topic = "Science"
            elif "Social" in c_sql: topic = "Social Studies"
            elif "Ocean" in c_sql: topic = "Science"

            f.write(f"INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES\n")
            
            rows = []
            for i in range(QUESTIONS_PER_LEVEL):
                q_id = f"q_{cid}_{i+1}"
                
                if topic == "Math":
                    qt, cor, w1, w2 = generate_math_question(grade_val, level)
                else:
                    qt, cor, w1, w2 = generate_static_question(topic, i)
                    # Add variety to static text to avoid unique constraint violations if we enforce them (we don't usually)
                    # But to make it less boring:
                    if i > 5: # If we run out of static, fallback to math or variations
                         qt, cor, w1, w2 = generate_math_question(grade_val, level) 
                
                rows.append(f"('{q_id}', '{cid}', '{escape_sql(qt)}', '{escape_sql(cor)}', '{escape_sql(w1)}', '{escape_sql(w2)}')")
                total_q += 1

            f.write(",\n".join(rows))
            f.write(";\n")

    f.write(generate_footer())
    f.close()
    print(f"Generated {OUTPUT_FILE} with {total_q} questions.")

if __name__ == "__main__":
    main()
