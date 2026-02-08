import 'dart:io';
import 'question_bank.dart';

/// A helper class to generate SQL insert statements for weekly challenges.
/// This can be run as a script to populate the backend database.
class ContentGenerator {
  String generateWeeklySQL(int weekNum, String season) {
    final sb = StringBuffer();
    sb.writeln("-- Generated Content for Week $weekNum ($season)");

    final grades = [1, 4];

    for (var grade in grades) {
      final topics = QuestionBank.gradeContent[grade];
      if (topics == null) continue;

      topics.forEach((topic, questions) {
        // Create a challenge for each topic for this grade
        final challengeId =
            'ch_${season.replaceAll(' ', '_')}_w${weekNum}_g${grade}_${topic.replaceAll(' ', '')}';

        sb.writeln(
          "INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('$challengeId', '$topic', '$season', $weekNum, $grade);",
        );

        // Insert questions
        int qIndex = 1;
        for (var q in questions) {
          final qId = '${challengeId}_q$qIndex';
          final qText = q['question_text'];
          final correct = q['correct_option'];
          final w1 = q['wrong_option_1'];
          final w2 = q['wrong_option_2'];

          // Handle potential single quotes in text
          final safeText = qText.replaceAll("'", "''");
          final safeCorrect = correct.replaceAll("'", "''");
          final safeW1 = w1.replaceAll("'", "''");
          final safeW2 = w2.replaceAll("'", "''");

          sb.writeln(
            "INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) "
            "VALUES ('$qId', '$challengeId', '$safeText', '$safeCorrect', '$safeW1', '$safeW2');",
          );
          qIndex++;
        }
      });
    }

    return sb.toString();
  }
}

void main() async {
  final generator = ContentGenerator();
  final sql = generator.generateWeeklySQL(1, 'Spring 2025');
  final file = File('lib/services/generated_content.sql');
  await file.writeAsString(sql);
  print('Generated SQL written to ${file.absolute.path}');
}
