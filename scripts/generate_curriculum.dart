import 'dart:io';
import 'dart:math';

// Configuration
const String outputFile = 'scripts/populate_full_curriculum.sql';
const int questionsPerLevel = 10;

// Grades mapping
const Map<String, int> grades = {
  "Pre-K 3": -2,
  "Pre-K 4": -1,
  "Kindergarten": 0,
  "1st Grade": 1,
  "2nd Grade": 2,
  "3rd Grade": 3,
  "4th Grade": 4,
  "5th Grade": 5
};

String escapeSql(String text) {
  return text.replaceAll("'", "''");
}

String generateHeader() {
  return """-- =============================================================
-- AUTOMATICALY GENERATED CURRICULUM (generate_curriculum.dart)
-- =============================================================
-- 10 Questions per Level, All Grades (-2 to 5)
-- =============================================================

BEGIN;

-- 1. CLEANUP
DELETE FROM student_progress WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM questions WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM challenges WHERE is_exam = FALSE;

""";
}

String generateFooter() {
  return """
COMMIT;
""";
}

class GeneratedChallenge {
  final String id;
  final String sql;
  GeneratedChallenge(this.id, this.sql);
}

GeneratedChallenge generateChallengeSql(
    String gradeKey, int gradeVal, int level) {
  String topic = "Math";

  if (gradeVal < 0) {
    if (level <= 4)
      topic = "Math";
    else if (level <= 7)
      topic = "Science";
    else
      topic = "Social Studies";

    if (gradeVal == -1 && level <= 10)
      topic = "Science"; // Ocean/Nature theme often used
  } else {
    if (level <= 5)
      topic = "Math";
    else if (level <= 8)
      topic = "Science";
    else
      topic = "Social Studies";
  }

  String challengeId = "gen_${gradeVal}_${level}";
  if (gradeVal < 0) {
    challengeId = "gen_neg${gradeVal.abs()}_${level}";
  }

  String sql =
      "INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('$challengeId', '$topic', $gradeVal, $level, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;\n";
  return GeneratedChallenge(challengeId, sql);
}

class Question {
  final String text;
  final String correct;
  final String wrong1;
  final String wrong2;

  Question(this.text, this.correct, this.wrong1, this.wrong2);
}

Question generateMathQuestion(int gradeVal, int level) {
  final rand = Random();
  String qText = "";
  String correct = "";
  List<String> wrongs = [];

  // Difficulty scalars
  int base = 5 + (gradeVal + 3) * 5;
  int modifier = level * (gradeVal + 2);

  List<String> ops = ['+', '-'];
  if (gradeVal >= 2) ops = ['+', '-', 'x'];
  if (gradeVal >= 4) ops = ['+', '-', 'x', '/'];

  String op = ops[rand.nextInt(ops.length)];

  if (op == '+') {
    int a = rand.nextInt(base + modifier) + 1;
    int b = rand.nextInt(base + modifier) + 1;
    int ans = a + b;
    qText = "What is $a + $b?";
    correct = ans.toString();
    wrongs = [
      (ans + rand.nextInt(5) + 1).toString(),
      (ans - rand.nextInt(5) - 1).abs().toString()
    ];
  } else if (op == '-') {
    int a = rand.nextInt(base + modifier + 10) + 5;
    int b = rand.nextInt(a) + 1;
    int ans = a - b;
    qText = "What is $a - $b?";
    correct = ans.toString();
    wrongs = [
      (ans + rand.nextInt(3) + 1).toString(),
      (ans - rand.nextInt(3) - 1).abs().toString()
    ];
  } else if (op == 'x') {
    int rangeLimit = 5 + gradeVal;
    if (rangeLimit > 12) rangeLimit = 12;
    int a = rand.nextInt(rangeLimit + (level ~/ 2)) + 1;
    int b = rand.nextInt(rangeLimit + 1);
    int ans = a * b;
    qText = "What is $a x $b?";
    correct = ans.toString();
    wrongs = [(ans + a).toString(), (ans - b).abs().toString()];
  } else if (op == '/') {
    int b = rand.nextInt(9) + 2; // 2 to 10
    int ans = rand.nextInt(10 + gradeVal) + 1;
    int a = b * ans;
    qText = "What is $a / $b?";
    correct = ans.toString();
    wrongs = [(ans + 1).toString(), (ans - 1 > 0 ? ans - 1 : 2).toString()];
  }

  // Dedupe wrongs
  if (wrongs[0] == correct) wrongs[0] = (int.parse(correct) + 10).toString();
  if (wrongs[1] == correct) wrongs[1] = (int.parse(correct) + 7).toString();
  if (wrongs[0] == wrongs[1]) wrongs[1] = (int.parse(wrongs[0]) + 1).toString();

  return Question(qText, correct, wrongs[0], wrongs[1]);
}

// Static Content Banks
List<List<String>> scienceQuestions = [
  ["What do plants need?", "Sunlight", "Pizza", "Toys"],
  ["Which is a liquid?", "Water", "Ice", "Steam"],
  ["The sun is a...?", "Star", "Planet", "Moon"],
  ["Frogs start as...?", "Tadpoles", "Eggs", "Fish"],
  ["Birds have...?", "Feathers", "Fur", "Scales"],
  ["Fish live in...?", "Water", "Trees", "Dirt"],
  ["Which animal barks?", "Dog", "Cat", "Cow"],
  ["Ice is frozen...?", "Water", "Milk", "Juice"],
  ["Humans breathe...?", "Air", "Water", "Dirt"],
  ["The Earth is...?", "Round", "Flat", "Square"],
  ["What makes day bright?", "Sun", "Moon", "Stars"],
  ["Trees grow from?", "Seeds", "Rocks", "Sand"]
];

List<List<String>> socialQuestions = [
  ["Firefighters drive...?", "Trucks", "Cars", "Boats"],
  ["We learn at...?", "School", "Home", "Park"],
  ["Red light means...?", "Stop", "Go", "Run"],
  ["Green light means...?", "Go", "Stop", "Wait"],
  ["Policemen help...?", "Safe", "Danger", "Run"],
  ["USA flag colors?", "Red White Blue", "Green Yellow", "Pink"],
  ["Mail carriers bring...?", "Mail", "Pizza", "Toys"],
  ["Teachers help us...?", "Learn", "Sleep", "Eat"],
  ["Doctors help when...?", "Sick", "Happy", "Sad"],
  ["We buy food at...?", "Store", "Bank", "Library"],
  ["A library has?", "Books", "Tools", "Pets"],
  ["Veterinarians fix?", "Animals", "Cars", "Computers"]
];

Question generateStaticQuestion(String topic, int i) {
  if (topic == "Science") {
    var q = scienceQuestions[i % scienceQuestions.length];
    return Question(q[0], q[1], q[2], q[3]);
  } else {
    var q = socialQuestions[i % socialQuestions.length];
    return Question(q[0], q[1], q[2], q[3]);
  }
}

void main() async {
  final file = File(outputFile);
  final sink = file.openWrite();

  sink.write(generateHeader());

  int totalQ = 0;

  grades.forEach((gradeName, gradeVal) {
    sink.write("\n-- $gradeName (Grade $gradeVal)\n");

    for (int level = 1; level <= 10; level++) {
      var challenge = generateChallengeSql(gradeName, gradeVal, level);
      sink.write(challenge.sql);

      String topic = "Math";
      if (challenge.sql.contains("'Math'"))
        topic = "Math";
      else if (challenge.sql.contains("'Science'"))
        topic = "Science";
      else
        topic = "Social Studies";

      sink.write(
          "INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES\n");

      List<String> rows = [];
      for (int i = 0; i < questionsPerLevel; i++) {
        String qId = "q_${challenge.id}_${i + 1}";
        Question q;

        if (topic == "Math") {
          q = generateMathQuestion(gradeVal, level);
        } else {
          // Fallback to math if we run out of unique static questions to avoid boredom
          if (i >= 8) {
            q = generateMathQuestion(gradeVal, level);
          } else {
            q = generateStaticQuestion(topic, i);
          }
        }

        rows.add(
            "('$qId', '${challenge.id}', '${escapeSql(q.text)}', '${escapeSql(q.correct)}', '${escapeSql(q.wrong1)}', '${escapeSql(q.wrong2)}')");
        totalQ++;
      }

      sink.write(rows.join(",\n"));
      sink.write(
          " ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;\n");
    }
  });

  sink.write(generateFooter());
  await sink.close();
  print("Generated $outputFile with $totalQ questions.");
}
