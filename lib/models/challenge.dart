class Challenge {
  final String id;
  final String topic; // e.g., "Geometry", "Fractions"
  final int gradeLevel;
  final List<QuizQuestion> questions;

  Challenge({
    required this.id,
    required this.topic,
    required this.gradeLevel,
    required this.questions,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      topic: json['topic'] as String,
      gradeLevel: json['grade_level'] != null ? json['grade_level'] as int : 4,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class QuizQuestion {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    // Supabase returns specific fields: correct_option, wrong_option_1, etc.
    // We need to mix them and find the correct index.
    final correct = json['correct_option'] as String;
    final wrongs = [
      json['wrong_option_1'] as String,
      json['wrong_option_2'] as String,
      if (json['wrong_option_3'] != null &&
          json['wrong_option_3'].toString().isNotEmpty)
        json['wrong_option_3'] as String,
    ];

    final allOptions = [correct, ...wrongs]..shuffle();
    final correctIndex = allOptions.indexOf(correct);

    return QuizQuestion(
      questionText: json['question_text'] as String,
      options: allOptions,
      correctOptionIndex: correctIndex,
    );
  }
}
