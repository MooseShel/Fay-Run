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
    final diff = difficultyLevel ?? 1;
    final selectedTopic = topic ?? 'Math';
    final prefix = isExam ? '[EXAM] ' : '';

    debugPrint(
        'Supabase: getCurrentChallenge mock (Grade $gradeLevel, Topic $selectedTopic, Exam $isExam, Diff $diff)');

    List<QuizQuestion> questionPool = [];

    if (selectedTopic == 'Math') {
      if (diff <= 2) {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}What is ${diff + 2} + ${diff + 5}?',
              options: [
                '${2 * diff + 7}',
                '${2 * diff + 8}',
                '${2 * diff + 6}'
              ],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText: '${prefix}What is 10 - $diff?',
              options: ['${10 - diff}', '${11 - diff}', '${9 - diff}'],
              correctOptionIndex: 0),
        ];
      } else if (diff <= 5) {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}What is $diff x 5?',
              options: ['${diff * 5}', '${diff * 4}', '${diff * 6}'],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText: '${prefix}What is 100 / ${10 - diff}?',
              options: ['${100 / (10 - diff)}', '10', '20'],
              correctOptionIndex: 0),
        ];
      } else {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}What is $diff x $diff?',
              options: [
                '${diff * diff}',
                '${diff * diff + 1}',
                '${diff * diff - 1}'
              ],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText: '${prefix}Find X: X + $diff = ${diff * 3}?',
              options: ['${diff * 2}', '$diff', '${diff * 3}'],
              correctOptionIndex: 0),
        ];
      }
    } else if (selectedTopic == 'Science') {
      if (diff <= 4) {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}Which planet is known as the Red Planet?',
              options: ['Mars', 'Venus', 'Jupiter'],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText: '${prefix}What do plants need for photosynthesis?',
              options: ['Sunlight', 'Milk', 'Pizza'],
              correctOptionIndex: 0),
        ];
      } else {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}What is the boiling point of water?',
              options: ['100°C', '0°C', '50°C'],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText:
                  '${prefix}Which part of the cell is the powerhouse?',
              options: ['Mitochondria', 'Nucleus', 'Wall'],
              correctOptionIndex: 0),
        ];
      }
    } else {
      // Social Studies
      if (diff <= 5) {
        questionPool = [
          QuizQuestion(
              questionText: '${prefix}Who was the first U.S. President?',
              options: [
                'George Washington',
                'Abraham Lincoln',
                'Thomas Jefferson'
              ],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText: '${prefix}What is the capital of the USA?',
              options: ['Washington D.C.', 'New York', 'Los Angeles'],
              correctOptionIndex: 0),
        ];
      } else {
        questionPool = [
          QuizQuestion(
              questionText:
                  '${prefix}Which document starts with "We the People"?',
              options: ['Constitution', 'Declaration', 'Bill of Rights'],
              correctOptionIndex: 0),
          QuizQuestion(
              questionText:
                  '${prefix}In which year did the American Revolution end?',
              options: ['1783', '1776', '1812'],
              correctOptionIndex: 0),
        ];
      }
    }

    // Add some random variety
    questionPool.shuffle();

    return Challenge(
      id: 'mock_${isExam ? 'exam' : 'normal'}_${selectedTopic.toLowerCase()}_d$diff',
      topic: selectedTopic,
      gradeLevel: gradeLevel,
      questions: questionPool,
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
