import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge.dart';
import '../core/constants.dart';

/// SupabaseService - Handles authentication, data fetching, and progression logic
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient? _client;

  Future<void> init() async {
    try {
      await Supabase.initialize(
        url: AppStrings.supabaseUrl,
        anonKey: AppStrings.supabaseAnonKey,
      );
      _client = Supabase.instance.client;
      debugPrint('Supabase: Initialized successfully');
    } catch (e) {
      debugPrint('Supabase: Init error: $e');
    }
  }

  /// Logs diagnostic information or errors to the Supabase debug_log table
  Future<void> logDebug({
    required String message,
    String level = 'error',
    String? stackTrace,
    String? context,
  }) async {
    if (_client == null) {
      debugPrint('Supabase: Client not initialized. Log: $message');
      return;
    }

    try {
      await _client!.from('debug_log').insert({
        'message': message,
        'level': level,
        'stack_trace': stackTrace,
        'context': context,
        'device_info': {
          'platform': defaultTargetPlatform.toString(),
          'isWeb': kIsWeb,
        },
      });
    } catch (e) {
      debugPrint('Supabase: Critical logging error: $e');
    }
  }

  // --- Auth ---

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await _client!.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'last_name': lastName,
      },
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client!.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client?.auth.signOut();
  }

  Future<void> deleteAccount() async {
    // Note: User deletion usually requires admin privileges or an RPC/Edge function.
    // Standard client signOut + local wipe is what we can do here.
    await signOut();
  }

  User? get currentUser => _client?.auth.currentUser;

  // --- Data & Progression ---

  Future<Challenge?> getCurrentChallenge({
    int gradeLevel = 4,
    int? weekNumber,
    String? topic,
    bool isExam = false,
    int? difficultyLevel,
  }) async {
    if (_client == null) {
      debugPrint('Supabase: Client not initialized');
      return null;
    }

    try {
      if (isExam) {
        // --- EXAM MODE LOGIC ---
        // Fetch questions for this grade and specific topic that are EXPRESSLY exams
        var query = _client!
            .from('questions')
            .select('*, challenges!inner(*)')
            .eq('challenges.grade_level', gradeLevel)
            .eq('challenges.is_exam', true); // STRICT FILTER

        if (topic != null && topic.isNotEmpty) {
          query = query.eq('challenges.topic', topic);
        }

        final response = await query;
        final data = response as List<dynamic>;

        if (data.isEmpty) {
          debugPrint(
              'Supabase: No exam questions found for Grade $gradeLevel, Topic $topic');
          return null;
        }

        final questions =
            data.map((json) => QuizQuestion.fromJson(json)).toList();
        questions.shuffle();

        return Challenge(
          id: 'exam_${gradeLevel}_${topic ?? "all"}',
          topic: topic ?? 'All Subjects',
          gradeLevel: gradeLevel,
          questions: questions,
        );
      } else {
        // NORMAL MODE LOGIC
        // We must create fresh queries for fallback to avoid accumulating filters (OR logic)

        // 1. Try difficulty_level first
        if (difficultyLevel != null) {
          final diffResponse = await _client!
              .from('challenges')
              .select('*, questions(*)')
              .eq('grade_level', gradeLevel)
              .eq('difficulty_level', difficultyLevel)
              .maybeSingle(); // Try to get the specific difficulty level

          if (diffResponse != null) {
            return Challenge.fromJson(diffResponse);
          }
        }

        // 2. Fallback to week_number
        final weekToUse = weekNumber ?? difficultyLevel ?? 1;
        var weekQuery = _client!
            .from('challenges')
            .select('*, questions(*)')
            .eq('grade_level', gradeLevel);

        if (topic != null && topic.isNotEmpty) {
          weekQuery = weekQuery.eq('topic', topic);
        }

        final weekResponse = await weekQuery.eq('week_number', weekToUse);
        final List<dynamic> challenges = weekResponse as List;

        if (challenges.isEmpty) {
          debugPrint(
              'Supabase: No challenge found for Grade $gradeLevel, Diff $difficultyLevel, Week $weekNumber');
          return null;
        }

        return _processChallenges(
            challenges, gradeLevel, weekToUse, difficultyLevel, topic);
      }
    } catch (e) {
      debugPrint('Supabase: Error fetching challenge: $e');
      return null;
    }
  }

  Challenge? _processChallenges(List<dynamic> challenges, int gradeLevel,
      int? weekNumber, int? difficultyLevel, String? topic) {
    if (challenges.length == 1 && topic != null && topic.isNotEmpty) {
      // Single specific topic challenge
      return Challenge.fromJson(challenges.first as Map<String, dynamic>);
    } else {
      // Aggregate questions from multiple challenges (e.g., all topics for the level/week)
      final List<QuizQuestion> allQuestions = [];
      for (var c in challenges) {
        final challengeData = c as Map<String, dynamic>;
        if (challengeData['questions'] != null) {
          final questionsData = challengeData['questions'] as List<dynamic>;
          allQuestions.addAll(
              questionsData.map((q) => QuizQuestion.fromJson(q)).toList());
        }
      }

      if (allQuestions.isEmpty) return null;
      allQuestions.shuffle();

      return Challenge(
        id: 'challenge_${gradeLevel}_${difficultyLevel ?? weekNumber}_all',
        topic: topic ?? 'All Subjects',
        gradeLevel: gradeLevel,
        difficultyLevel: difficultyLevel,
        questions: allQuestions,
      );
    }
  }

  Future<void> submitQuizResult({
    required String studentId,
    required String challengeId,
    required int score,
  }) async {
    if (_client == null) return;
    try {
      // Check if this is an "aggregate" ID (doesn't exist in DB)
      bool isAggregate = challengeId.endsWith('_all');

      Map<String, dynamic> insertData = {
        'student_id': studentId,
        'score': score,
        'completed_at': DateTime.now().toIso8601String(),
      };

      if (!isAggregate) {
        insertData['challenge_id'] = challengeId;
      }

      await _client!.from('student_progress').insert(insertData);
    } catch (e) {
      debugPrint('Supabase: submitQuizResult error: $e');
      // If we failed due to FK constraint even with non-aggregate, try one last time without ID
      if (e.toString().contains('23503')) {
        try {
          await _client!.from('student_progress').insert({
            'student_id': studentId,
            'score': score,
            'completed_at': DateTime.now().toIso8601String(),
          });
        } catch (inner) {
          debugPrint('Supabase: submitQuizResult fallback failed: $inner');
        }
      }
    }
  }

  // --- Students ---

  Future<List<Map<String, dynamic>>> getStudents() async {
    if (_client == null) return [];
    try {
      final response = await _client!
          .from('students')
          .select('*')
          .order('created_at', ascending: true);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Supabase: getStudents error: $e');
      return [];
    }
  }

  Future<void> addStudent({
    required String firstName,
    required String nickname,
    required String grade,
  }) async {
    if (_client == null) return;
    try {
      final userId = _client!.auth.currentUser?.id;
      if (userId == null) return;

      await _client!.from('students').insert({
        'parent_id': userId,
        'first_name': firstName,
        'nickname': nickname,
        'grade': grade,
      });
    } catch (e) {
      debugPrint('Supabase: addStudent error: $e');
    }
  }

  Future<void> updateStudentScore(String studentId, int newScore) async {
    if (_client == null) return;
    try {
      // Get current high score first or update if new is higher
      final response = await _client!
          .from('students')
          .select('high_score')
          .eq('id', studentId)
          .maybeSingle();

      final currentHigh = (response?['high_score'] as int?) ?? 0;
      if (newScore > currentHigh) {
        await _client!
            .from('students')
            .update({'high_score': newScore}).eq('id', studentId);
      }
    } catch (e) {
      debugPrint('Supabase: updateStudentScore error: $e');
    }
  }

  Future<void> unlockLevel(String studentId, int level) async {
    if (_client == null) return;
    try {
      await _client!
          .from('students')
          .update({'max_level': level}).eq('id', studentId);
    } catch (e) {
      debugPrint('Supabase: unlockLevel error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getLeaderboard({String? grade}) async {
    if (_client == null) return [];
    try {
      var query = _client!
          .from('students')
          .select('first_name, nickname, grade, high_score');

      if (grade != null) {
        query = query.eq('grade', grade);
      }

      final response =
          await query.order('high_score', ascending: false).limit(10);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Supabase: getLeaderboard error: $e');
      return [];
    }
  }

  // --- Parent Profile ---

  Future<void> upsertProfile({
    required String firstName,
    required String lastName,
  }) async {
    if (_client == null) return;
    final userId = _client!.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await _client!.from('profiles').upsert({
        'id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Supabase: upsertProfile error: $e');
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    if (_client == null) return null;
    final userId = _client!.auth.currentUser?.id;
    if (userId == null) return null;

    try {
      final response = await _client!
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Supabase: getProfile error: $e');
      return null;
    }
  }

  Future<void> updateHighScore(int newScore) async {
    // Usually handled via updateStudentScore, keeping for legacy compatibility
  }
}
