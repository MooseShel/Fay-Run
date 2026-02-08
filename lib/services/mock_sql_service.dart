import '../models/challenge.dart';

class MockSQLService {
  // Simulates fetching the current season based on the actual month
  static String getCurrentSeason() {
    final now = DateTime.now();
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[now.month - 1];
  }

  // Simulates fetching the weekly challenge
  static Challenge getWeeklyChallenge() {
    // In a real app, we'd check the week number.
    // Logic: Week 6 = "Fractions", etc.
    // For prototype, we strictly return "Geometry" as requested for the demo or randomized.

    return Challenge(
      id: 'week_06_geometry',
      topic: 'Geometry',
      questions: [
        QuizQuestion(
          questionText: 'What is the perimeter of a square with side 4?',
          options: ['12', '16', '8', '20'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          questionText: 'How many degrees in a right angle?',
          options: ['90°', '45°', '180°', '360°'],
          correctOptionIndex: 0,
        ),
        QuizQuestion(
          questionText: 'Name a shape with 3 sides.',
          options: ['Square', 'Hexagon', 'Triangle', 'Circle'],
          correctOptionIndex: 2,
        ),
      ],
    );
  }

  // Simulate updating leaderboard
  static Future<void> submitScore(String studentName, int score) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    print('MOCK DB: Score submitted for $studentName: $score');
    // Logic: If month changes -> reset leaderboard (omitted for simple prototype persistence)
  }
}
