import 'package:flutter/foundation.dart';
import '../models/challenge.dart';

/// Stub SupabaseService - all network features disabled to avoid native plugin crashes on iOS 18.2
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  Future<void> init() async {}

  // --- Auth ---

  Future<dynamic> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    debugPrint('Supabase: signUp mock');
    return null; // This might cause issues if caller expects a real AuthResponse
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    debugPrint('Supabase: signIn mock');
    return null;
  }

  Future<void> signOut() async {
    debugPrint('Supabase: signOut mock');
  }

  Future<void> deleteAccount() async {
    debugPrint('Supabase: deleteAccount mock');
  }

  dynamic get currentUser => null;

  // --- Data ---

  Future<Challenge?> getCurrentChallenge({
    int gradeLevel = 4,
    int? weekNumber,
    String? topic,
    bool isExam = false,
    int? difficultyLevel,
  }) async {
    debugPrint(
        'Supabase: getCurrentChallenge mock (Grade $gradeLevel, Week $weekNumber, Exam $isExam, Diff $difficultyLevel)');

    if (isExam) {
      // Mock Exam Challenges
      return Challenge(
        id: 'mock_exam_${topic ?? 'Mixed'}_d${difficultyLevel ?? 1}',
        topic: topic ?? 'Mixed',
        gradeLevel: gradeLevel,
        questions: [
          QuizQuestion(
            questionText: '[EXAM] What is the capital of Louisiana?',
            correctOptionIndex: 0,
            options: ['Baton Rouge', 'New Orleans', 'Shreveport'],
          ),
          QuizQuestion(
            questionText:
                '[EXAM] $gradeLevel Grade ${topic ?? 'General'} Question',
            correctOptionIndex: 0,
            options: ['Correct Answer', 'Wrong 1', 'Wrong 2'],
          ),
        ],
      );
    }

    // Default Mock (Grade 4)
    return Challenge(
      id: 'mock_g4_d${difficultyLevel ?? 1}',
      topic: topic ?? 'Math',
      gradeLevel: 4,
      questions: [
        QuizQuestion(
          questionText: 'Difficulty $difficultyLevel Question: 500 + 500 = ?',
          correctOptionIndex: 0,
          options: ['1000', '500', '2000'],
        ),
        QuizQuestion(
          questionText: '12 x 2 = ?',
          correctOptionIndex: 0,
          options: ['24', '14', '22'],
        ),
      ],
    );
  }

  Future<void> submitQuizResult({
    required String studentId,
    required String challengeId,
    required int score,
  }) async {
    debugPrint('Supabase: submitQuizResult mock');
  }

  // --- Students ---

  Future<List<Map<String, dynamic>>> getStudents() async {
    debugPrint('Supabase: getStudents mock');
    return [
      {
        'id': 'mock-id',
        'first_name': 'Offline',
        'nickname': 'Runner',
        'grade': '4',
        'high_score': 0,
        'max_level': 1,
      },
    ];
  }

  Future<void> addStudent({
    required String firstName,
    required String nickname,
    required String grade,
  }) async {
    debugPrint('Supabase: addStudent mock');
  }

  Future<void> updateStudentScore(String studentId, int newScore) async {
    debugPrint('Supabase: updateStudentScore mock');
  }

  Future<void> unlockLevel(String studentId, int level) async {
    debugPrint('Supabase: unlockLevel mock');
  }

  Future<List<Map<String, dynamic>>> getLeaderboard({String? grade}) async {
    debugPrint('Supabase: getLeaderboard mock');
    return [];
  }

  // --- Parent Profile ---

  Future<void> upsertProfile({
    required String firstName,
    required String lastName,
  }) async {
    debugPrint('Supabase: upsertProfile mock');
  }

  Future<Map<String, dynamic>?> getProfile() async {
    debugPrint('Supabase: getProfile mock');
    return {'first_name': 'Offline', 'last_name': 'Mode'};
  }

  Future<void> updateHighScore(int newScore) async {}
}
