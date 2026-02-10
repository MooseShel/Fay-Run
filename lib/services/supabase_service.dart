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
  }) async {
    debugPrint('Supabase: getCurrentChallenge mock (Grade $gradeLevel, Week $weekNumber)');

    // Mock Response Generator (Pre-K to 5th)
    if (gradeLevel <= 0) {
      // Pre-K and K Mock
      return Challenge(
        id: 'mock_prek_k',
        topic: 'Math',
        season: 'Spring 2025',
        weekNumber: 1,
        gradeLevel: gradeLevel,
        questions: [
          QuizQuestion(
            questionText: 'What color is the sun?',
            correctOptionIndex: 0,
            options: ['Yellow', 'Blue', 'Green'],
          ),
          QuizQuestion(
            questionText: 'Count: ⭐️ ⭐️',
            correctOptionIndex: 0,
            options: ['2', '1', '3'],
          ),
        ],
      );
    }
      id: 'mock_g4_w1',
      topic: 'Math',
      season: 'Spring 2025',
      weekNumber: 1,
      gradeLevel: 4,
      questions: [
        QuizQuestion(
          questionText: '500 + 500 = ?',
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
