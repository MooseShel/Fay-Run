import 'dart:math';

/// A helper class to generate SQL insert statements for weekly challenges.
/// This can be run as a script to populate the backend database.
class ContentGenerator {
  final Random _random = Random();

  String generateWeeklySQL(int weekNum, String season) {
    final challengeId = 'ch_${season.replaceAll(' ', '_')}_w$weekNum';
    final topics = ['Math', 'Science', 'History', 'Grammar'];
    final topic = topics[_random.nextInt(topics.length)];

    final sb = StringBuffer();
    sb.writeln("-- Generated Content for Week $weekNum ($season)");
    sb.writeln(
      "INSERT INTO challenges (id, topic, season, week_number) VALUES ('$challengeId', '$topic', '$season', $weekNum);",
    );

    // Generate 5 questions
    for (int i = 1; i <= 5; i++) {
      final qId = '${challengeId}_q$i';
      sb.writeln(_generateQuestionSQL(qId, challengeId, topic));
    }

    return sb.toString();
  }

  String _generateQuestionSQL(String id, String challengeId, String topic) {
    // In a real AI implementation, this would call an LLM to generate specific questions.
    // Here we return a template.
    return "INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) "
        "VALUES ('$id', '$challengeId', 'Question about $topic?', 'Correct Answer', 'Wrong A', 'Wrong B');";
  }
}

void main() {
  final generator = ContentGenerator();
  print(generator.generateWeeklySQL(1, 'Spring 2025'));
}
