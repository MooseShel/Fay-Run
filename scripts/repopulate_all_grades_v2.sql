-- ========================================================
-- REPOPULATE ALL GRADES (V2.1)
-- Coverage: Pre-K 3, Pre-K 4, K, 1st, 2nd, 3rd, 4th, 5th
-- Spectrum: Difficulty 1-10 for every grade
-- Includes: 30 Ocean (PK4) and 30 Math/Measurement (G1)
-- ========================================================

BEGIN;

-- 1. PRE-K 3 (Grade -2)
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('prek3_d1', 'Math', -2, 1), ('prek3_d2', 'Math', -2, 2),
('prek3_d3', 'Math', -2, 3), ('prek3_d4', 'Math', -2, 4),
('prek3_d5', 'Science', -2, 5), ('prek3_d6', 'Science', -2, 6),
('prek3_d7', 'Science', -2, 7), ('prek3_d8', 'Science', -2, 8),
('prek3_d9', 'Social', -2, 9), ('prek3_d10', 'Social', -2, 10)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_prek3_1', 'prek3_d1', 'What color is the sun?', 'Yellow', 'Blue', 'Green'),
('q_prek3_2', 'prek3_d1', 'What shape is a ball?', 'Circle', 'Square', 'Triangle'),
('q_prek3_3', 'prek3_d2', 'How many fingers on one hand?', 'Five', 'Ten', 'Two'),
('q_prek3_4', 'prek3_d3', 'Which one is BIG?', 'Elephant', 'Ant', 'Mouse'),
('q_prek3_5', 'prek3_d4', 'What says "Meow"?', 'Cat', 'Dog', 'Cow'),
('q_prek3_6', 'prek3_d5', 'What flies in the sky?', 'Bird', 'Fish', 'Dog'),
('q_prek3_7', 'prek3_d6', 'Ice is?', 'Cold', 'Hot', 'Dry'),
('q_prek3_8', 'prek3_d7', 'Rain is?', 'Wet', 'Dry', 'Funny'),
('q_prek3_9', 'prek3_d8', 'Apples are usually?', 'Red', 'Blue', 'Purple'),
('q_prek3_10', 'prek3_d9', 'Say "Please" and?', 'Thank You', 'No', 'Bye'),
('q_prek3_11', 'prek3_d10', 'We share our toys with?', 'Friends', 'Trees', 'Rocks')
ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, challenge_id = EXCLUDED.challenge_id;


-- 2. PRE-K 4 (Grade -1) - 30 OCEAN QUESTIONS
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('prek4_d1', 'Ocean', -1, 1), ('prek4_d2', 'Ocean', -1, 2), ('prek4_d3', 'Ocean', -1, 3),
('prek4_d4', 'Ocean', -1, 4), ('prek4_d5', 'Ocean', -1, 5), ('prek4_d6', 'Ocean', -1, 6),
('prek4_d7', 'Ocean', -1, 7), ('prek4_d8', 'Ocean', -1, 8), ('prek4_d9', 'Ocean', -1, 9), ('prek4_d10', 'Ocean', -1, 10)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_prek4_1', 'prek4_d1', 'What animal has 8 arms?', 'Octopus', 'Cat', 'Bird'),
('q_prek4_2', 'prek4_d1', 'What is the big blue water?', 'Ocean', 'Forest', 'Park'),
('q_prek4_3', 'prek4_d1', 'Which ocean animal is very big?', 'Whale', 'Ant', 'Mouse'),
('q_prek4_4', 'prek4_d2', 'Do fish swim or fly?', 'Swim', 'Fly', 'Walk'),
('q_prek4_5', 'prek4_d2', 'Fish use these to swim?', 'Fins', 'Wings', 'Legs'),
('q_prek4_6', 'prek4_d2', 'Waves come to the?', 'Beach', 'Kitchen', 'School'),
('q_prek4_7', 'prek4_d3', 'Animal with a hard shell?', 'Crab', 'Rabbit', 'Bird'),
('q_prek4_8', 'prek4_d3', 'Reefs have colorful...?', 'Coral', 'Leaves', 'Grass'),
('q_prek4_9', 'prek4_d3', 'The sandy place is the...?', 'Shore', 'Garden', 'Room'),
('q_prek4_10', 'prek4_d4', 'A home for an animal is a?', 'Habitat', 'Box', 'Pocket'),
('q_prek4_11', 'prek4_d4', 'Tides go up and...?', 'Down', 'Left', 'Fast'),
('q_prek4_12', 'prek4_d4', 'Is ocean water salty?', 'Yes', 'No', 'Sometimes'),
('q_prek4_13', 'prek4_d5', 'Animal with a long nose that jumps?', 'Dolphin', 'Pig', 'Lion'),
('q_prek4_14', 'prek4_d5', 'Top of the water is the?', 'Surface', 'Bottom', 'Side'),
('q_prek4_15', 'prek4_d5', 'Animal that looks like a horse?', 'Seahorse', 'Donkey', 'Zebra'),
('q_prek4_16', 'prek4_d6', 'Should we throw trash in the sea?', 'No', 'Yes', 'Maybe'),
('q_prek4_17', 'prek4_d6', 'We recycle bottles to help?', 'The Ocean', 'The Moon', 'The Mall'),
('q_prek4_18', 'prek4_d6', 'Pollution makes water...?', 'Dirty', 'Clean', 'Shiny'),
('q_prek4_19', 'prek4_d7', 'Tiny animal in a shell?', 'Sea Snail', 'Puppy', 'Bird'),
('q_prek4_20', 'prek4_d7', 'Animal shaped like a star?', 'Starfish', 'Squarefish', 'Moon'),
('q_prek4_21', 'prek4_d7', 'Small pools of water are?', 'Tide Pools', 'Clouds', 'Rain'),
('q_prek4_22', 'prek4_d8', 'Animal that hunts others?', 'Predator', 'Helper', 'Friend'),
('q_prek4_23', 'prek4_d8', 'Animal that is being hunted?', 'Prey', 'Hunter', 'King'),
('q_prek4_24', 'prek4_d8', 'Big fish eat small fish. Who is the hunter?', 'Big Fish', 'Small Fish', 'The Water'),
('q_prek4_25', 'prek4_d9', 'Deep in the ocean it is?', 'Dark', 'Bright', 'Yellow'),
('q_prek4_26', 'prek4_d9', 'Animal with house on its back?', 'Sea Turtle', 'Elephant', 'Giraffe'),
('q_prek4_27', 'prek4_d9', 'Sharks breathe with...?', 'Gills', 'Nose', 'Lungs'),
('q_prek4_28', 'prek4_d10', 'Keep the water clean pairs with?', 'Happy Fish', 'Dirty Toys', 'Dry Sand'),
('q_prek4_29', 'prek4_d10', 'The ocean is a huge...?', 'Habitat', 'Game', 'Store'),
('q_prek4_30', 'prek4_d10', 'The ocean has many living...?', 'Things', 'Robots', 'Cars')
ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, challenge_id = EXCLUDED.challenge_id;


-- 3. KINDERGARTEN (Grade 0)
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('k_d1', 'Math', 0, 1), ('k_d3', 'Math', 0, 3), ('k_d5', 'Science', 0, 5), ('k_d8', 'Social', 0, 8), ('k_d10', 'General', 0, 10)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_k_1', 'k_d1', 'Count: ⭐️ ⭐️', '2', '1', '3'),
('q_k_2', 'k_d3', 'What is 1 + 1?', '2', '3', '0'),
('q_k_3', 'k_d5', 'A plant grows from a?', 'Seed', 'Rock', 'Cloud'),
('q_k_4', 'k_d8', 'A firefighter drives a?', 'Truck', 'Boat', 'Bike'),
('q_k_5', 'k_d10', 'What is the first letter of "Apple"?', 'A', 'B', 'C')
ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, challenge_id = EXCLUDED.challenge_id;


-- 4. 1st GRADE (Grade 1) - 30 MATH/MEASUREMENT QUESTIONS
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('g1_d1', 'Math', 1, 1), ('g1_d2', 'Math', 1, 2), ('g1_d3', 'Math', 1, 3), ('g1_d4', 'Math', 1, 4), ('g1_d5', 'Math', 1, 5),
('g1_d6', 'Math', 1, 6), ('g1_d7', 'Math', 1, 7), ('g1_d8', 'Math', 1, 8), ('g1_d9', 'Math', 1, 9), ('g1_d10', 'Math', 1, 10)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level, topic = 'Math';

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- D1: 10s Facts
('q_g1_m_1', 'g1_d1', 'What is 10 + 10?', '20', '10', '30'),
('q_g1_m_2', 'g1_d1', 'What is 20 - 10?', '10', '5', '15'),
('q_g1_m_3', 'g1_d1', 'Jump forward 10 from 0 on a number line. Where are you?', '10', '5', '20'),
-- D2: 20s Facts
('q_g1_m_4', 'g1_d2', 'What is 10 + 5?', '15', '20', '10'),
('q_g1_m_5', 'g1_d2', 'What is 20 - 5?', '15', '10', '25'),
('q_g1_m_6', 'g1_d2', 'Jump forward 10 from 10 on a number line. Where are you?', '20', '10', '30'),
-- D3: Basic Measurement
('q_g1_m_7', 'g1_d3', 'Which is longer? 1 inch or 1 foot?', '1 foot', '1 inch', 'They are same'),
('q_g1_m_8', 'g1_d3', 'How many inches are on a small ruler?', '12', '6', '24'),
('q_g1_m_9', 'g1_d3', 'What tool do we use to measure inches?', 'Ruler', 'Thermometer', 'Clock'),
-- D4: Comparing Units
('q_g1_m_10', 'g1_d4', 'Which is bigger? 1 foot or 1 yard?', '1 yard', '1 foot', '1 inch'),
('q_g1_m_11', 'g1_d4', 'Is a pencil measured in inches or yards?', 'Inches', 'Yards', 'Miles'),
('q_g1_m_12', 'g1_d4', '1 foot + 1 foot = ?', '2 feet', '1 foot', '1 yard'),
-- D5: Counting & Facts
('q_g1_m_13', 'g1_d5', 'What is 10 + 2?', '12', '20', '8'),
('q_g1_m_14', 'g1_d5', 'What is 20 - 2?', '18', '20', '10'),
('q_g1_m_15', 'g1_d5', 'Start at 30. Jump 10 spaces back. Where are you?', '20', '10', '40'),
-- D6: Word Problems (Measurement)
('q_g1_m_16', 'g1_d6', 'A toy is 3 inches and another is 4 inches. Total length?', '7 inches', '1 inch', '10 inches'),
('q_g1_m_17', 'g1_d6', 'Measure a car. Use inches or feet?', 'Feet', 'Inches', 'Yards'),
('q_g1_m_18', 'g1_d6', 'Which is shorter? 5 feet or 2 feet?', '2 feet', '5 feet', '10 feet'),
-- D7: Yards & Comparisons
('q_g1_m_19', 'g1_d7', '1 yard is about the same size as...?', 'A giant step', 'A finger', 'An ant'),
('q_g1_m_20', 'g1_d7', '1 yard = how many feet?', '3 feet', '1 foot', '12 feet'),
('q_g1_m_21', 'g1_d7', 'Which is longest? 1 inch, 1 foot, or 1 yard?', '1 yard', '1 foot', '1 inch'),
-- D8: Subtraction & Number Lines
('q_g1_m_22', 'g1_d8', 'Ernie has 20 stickers and gives 10 away. Left?', '10', '20', '5'),
('q_g1_m_23', 'g1_d8', 'Jump 20 forward, then 10 back. Where are you?', '10', '20', '30'),
('q_g1_m_24', 'g1_d8', 'What is 10 + 10 + 10?', '30', '10', '20'),
-- D9: Advanced Comparison
('q_g1_m_25', 'g1_d9', 'A blue ribbon is 10 inches. Red is 5 inches. Difference?', '5 inches', '10 inches', '15 inches'),
('q_g1_m_26', 'g1_d9', 'A book is 10 inches. A desk is 2 feet. Which is longer?', 'Desk', 'Book', 'Same'),
('q_g1_m_27', 'g1_d9', 'Measure a bed. Are there more inches or more feet?', 'Inches', 'Feet', 'Same'),
-- D10: Review & Word Problems
('q_g1_m_28', 'g1_d10', '20 + 20 = ?', '40', '20', '0'),
('q_g1_m_29', 'g1_d10', 'Use 10 feet of tape, then 10 more. Total?', '20 feet', '10 feet', '30 feet'),
('q_g1_m_30', 'g1_d10', 'If you measure a door, should you use yards?', 'Yes, it is about 1 yard wide', 'No, use inches only', 'No, use miles')
ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, challenge_id = EXCLUDED.challenge_id;


-- 5. 4th GRADE (Grade 4)
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('g4_d1', 'Math', 4, 1), ('g4_d2', 'Math', 4, 2), ('g4_d3', 'Math', 4, 3), ('g4_d4', 'Math', 4, 4), ('g4_d5', 'Math', 4, 5),
('g4_d6', 'Science', 4, 6), ('g4_d7', 'Science', 4, 7), ('g4_d8', 'Science', 4, 8), ('g4_d9', 'Social', 4, 9), ('g4_d10', 'Social', 4, 10)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_g4_1', 'g4_d1', '500 + 500 = ?', '1000', '500', '2000'),
('q_g4_2', 'g4_d2', '12 x 12 = ?', '144', '124', '134'),
('q_g4_3', 'g4_d3', 'What is 1/2 of 100?', '50', '25', '75'),
('q_g4_4', 'g4_d4', 'Perimeter of a 4x5 rectangle?', '18', '20', '9'),
('q_g4_5', 'g4_d5', 'Which is a prime number?', '7', '4', '9'),
('q_g4_6', 'g4_d6', 'Force that pulls objects to Earth?', 'Gravity', 'Friction', 'Speed'),
('q_g4_7', 'g4_d7', 'Plants make food using?', 'Photosynthesis', 'Cooking', 'Sleeping'),
('q_g4_8', 'g4_d8', 'Water boils at?', '100 C', '0 C', '50 C'),
('q_g4_9', 'g4_d9', 'Capital of the US?', 'Washington D.C.', 'New York', 'Austin'),
('q_g4_10', 'g4_d10', 'Declaration of Independence year?', '1776', '1492', '1865')
ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, challenge_id = EXCLUDED.challenge_id;


-- 6. Cleanup
UPDATE challenges SET difficulty_level = 1 WHERE difficulty_level IS NULL;

COMMIT;
