class Challenge {
  final String id;
  final String topic; // e.g., "Geometry", "Fractions"
  final List<QuizQuestion> questions;

  Challenge({required this.id, required this.topic, required this.questions});
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
}
