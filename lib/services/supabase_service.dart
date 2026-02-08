import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // --- Auth ---

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String grade,
  }) async {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName, 'grade': grade},
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;

  // --- Data ---

  // Calculate current week number (1-52 based on school year)
  int _getCurrentWeekNumber() {
    final now = DateTime.now();
    // School year starts January 6, 2025
    final schoolYearStart = DateTime(2025, 1, 6);
    final diff = now.difference(schoolYearStart);
    final weekNum = (diff.inDays / 7).floor() + 1;
    return weekNum.clamp(1, 52); // Keep within 1-52 range
  }

  // Get topic for week (rotates Math → Science → Social Studies)
  String _getTopicForWeek(int week) {
    final topics = ['Math', 'Science', 'Social Studies'];
    return topics[(week - 1) % 3];
  }

  // Fetch the current weekly challenge with week-based selection and topic rotation
  Future<Challenge?> getCurrentChallenge({
    int gradeLevel = 4,
    int? weekNumber,
    String? topic,
  }) async {
    try {
      // Use provided week or calculate current
      final currentWeek = weekNumber ?? _getCurrentWeekNumber();

      // Use provided topic or calculate from week
      final selectedTopic = topic ?? _getTopicForWeek(currentWeek);

      // Try to get challenge for current week and topic
      var response = await _client
          .from('challenges')
          .select('*, questions(*)')
          .eq('grade_level', gradeLevel)
          .eq('week_number', currentWeek)
          .eq('topic', selectedTopic)
          .maybeSingle();

      // Fallback 1: Try current week with any topic
      if (response == null) {
        response = await _client
            .from('challenges')
            .select('*, questions(*)')
            .eq('grade_level', gradeLevel)
            .eq('week_number', currentWeek)
            .limit(1)
            .maybeSingle();
      }

      // Fallback 2: Try Week 1 with rotated topic
      if (response == null) {
        response = await _client
            .from('challenges')
            .select('*, questions(*)')
            .eq('grade_level', gradeLevel)
            .eq('week_number', 1)
            .eq('topic', selectedTopic)
            .maybeSingle();
      }

      // Fallback 3: Week 1 Math (guaranteed to exist)
      if (response == null) {
        response = await _client
            .from('challenges')
            .select('*, questions(*)')
            .eq('grade_level', gradeLevel)
            .eq('week_number', 1)
            .eq('topic', 'Math')
            .maybeSingle();
      }

      if (response == null) return null;
      return Challenge.fromJson(response);
    } catch (e) {
      debugPrint('Error loading challenge: $e');
      return null;
    }
  }

  // Submit a quiz result
  Future<void> submitQuizResult({
    required String challengeId,
    required int score,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('student_progress').upsert({
      'student_id': user.id,
      'challenge_id': challengeId,
      'score': score,
      'completed_at': DateTime.now().toIso8601String(),
    });
  }
  // --- Students (Multi-Profile) ---

  Future<List<Map<String, dynamic>>> getStudents() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];

    try {
      final response = await _client
          .from('students')
          .select()
          .eq('parent_id', user.id)
          .order('created_at', ascending: true);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return []; // Return empty if error or no table yet
    }
  }

  Future<void> addStudent({
    required String firstName,
    required String nickname,
    required String grade,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('students').insert({
      'parent_id': user.id,
      'first_name': firstName,
      'nickname': nickname,
      'grade': grade,
    });
  }

  Future<void> updateStudentScore(String studentId, int newScore) async {
    try {
      // Fetch current score
      final response = await _client
          .from('students')
          .select('high_score')
          .eq('id', studentId)
          .maybeSingle();

      if (response != null) {
        final currentHigh = (response['high_score'] as int?) ?? 0;
        if (newScore > currentHigh) {
          await _client
              .from('students')
              .update({
                'high_score': newScore,
                'updated_at': DateTime.now().toIso8601String(),
              })
              .eq('id', studentId);
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> unlockLevel(String studentId, int level) async {
    try {
      // Fetch current max_level
      final response = await _client
          .from('students')
          .select('max_level')
          .eq('id', studentId)
          .maybeSingle();

      if (response != null) {
        final currentMax = (response['max_level'] as int?) ?? 1;
        if (level > currentMax) {
          await _client
              .from('students')
              .update({
                'max_level': level,
                'updated_at': DateTime.now().toIso8601String(),
              })
              .eq('id', studentId);
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    try {
      final response = await _client
          .from('students')
          .select('nickname, grade, high_score')
          .order('high_score', ascending: false)
          .limit(10);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  // --- Legacy Single-Profile (Keep for backward compat/parent profile) ---

  Future<void> upsertProfile({
    required String firstName,
    required String nickname,
    required String grade,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('profiles').upsert({
      'id': user.id,
      'first_name': firstName,
      'nickname': nickname,
      'grade': grade,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      return response;
    } catch (e) {
      return null;
    }
  }

  // Deprecated: Use updateStudentScore for multi-student
  Future<void> updateHighScore(int newScore) async {
    // ... legacy implementation if needed, or redirect
  }
}
