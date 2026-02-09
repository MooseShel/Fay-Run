import 'package:flutter/foundation.dart';
import '../models/staff_event.dart';
import '../models/challenge.dart';
import '../services/supabase_service.dart';

enum GameStatus { menu, playing, paused, levelComplete, gameOver }

class GameState extends ChangeNotifier {
  // Multi-Student Data
  List<Map<String, dynamic>> _students = [];
  Map<String, dynamic>? _currentStudent;
  bool _isLoading = false;
  int _maxLevel = 1;
  List<Map<String, dynamic>> _leaderboard = [];

  // Player Data (Legacy/Fallback)
  String _studentName = '';
  String _generatedNickname = '';

  // Game Session Data
  int _score = 0;
  int _lives = 5; // Increased from 3 to 5 hearts
  int _currentLevel = 1;
  double _runSpeed = 3.0; // Base speed
  GameStatus _status = GameStatus.menu;

  // Events
  StaffEvent? _activeStaffEvent;
  bool _isInvincible = false;

  // Getters
  List<Map<String, dynamic>> get students => _students;
  Map<String, dynamic>? get currentStudent => _currentStudent;
  bool get isLoading => _isLoading;
  int get maxLevel => _maxLevel;
  List<Map<String, dynamic>> get leaderboard => _leaderboard;

  // Legacy Getters (Map to current student if available)
  String get studentName => _currentStudent?['first_name'] ?? _studentName;
  String get generatedNickname =>
      _currentStudent?['nickname'] ?? _generatedNickname;
  int get currentGrade => _currentStudent?['grade'] != null
      ? int.tryParse(
              _currentStudent!['grade'].toString().replaceAll(
                RegExp(r'[^0-9]'),
                '',
              ),
            ) ??
            1
      : 1; // Default to 1st grade if parse fails

  // ... existing getters ...
  int get score => _score;
  int get lives => _lives;
  int get currentLevel => _currentLevel;
  double get runSpeed => _runSpeed;
  GameStatus get status => _status;
  StaffEvent? get activeStaffEvent => _activeStaffEvent;
  bool get isInvincible => _isInvincible;

  Challenge? _currentChallenge;
  Challenge? get currentChallenge => _currentChallenge;

  Future<void> loadChallenge() async {
    _isLoading = true;
    notifyListeners();

    try {
      final service = SupabaseService();
      // Use the current grade, default to 4 if not set
      final grade = currentGrade;

      // Use current game level as week number for progressive difficulty
      // Level 1 → Week 1 (easiest), Level 5 → Week 5 (hardest)
      _currentChallenge = await service.getCurrentChallenge(
        gradeLevel: grade,
        weekNumber: _currentLevel, // Map game level to question week
      );

      if (_currentChallenge != null) {
        debugPrint(
          'Loaded challenge: ${_currentChallenge!.topic} '
          'for Level $_currentLevel (Week $_currentLevel), Grade $grade',
        );
      }
    } catch (e) {
      debugPrint('Error loading challenge: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Multi-Student Actions ---

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();
    try {
      final service = SupabaseService();
      // Also fetch/repair parent profile in background
      service.getProfile();
      _students = await service.getStudents();
    } catch (e) {
      debugPrint('Error loading students: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectStudent(Map<String, dynamic> student) {
    _currentStudent = student;
    _maxLevel = (student['max_level'] as int?) ?? 1;
    _score = 0; // Reset session score
    notifyListeners();
  }

  Future<void> loadLeaderboard({String? grade}) async {
    try {
      final service = SupabaseService();
      // Use provided grade, or fall back to current student's grade if logged in
      final filterGrade = grade ?? currentStudent?['grade'];
      _leaderboard = await service.getLeaderboard(grade: filterGrade);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading leaderboard: $e');
    }
  }

  Future<void> registerStudent(
    String firstName,
    String nickname,
    String grade,
  ) async {
    try {
      final service = SupabaseService();
      // Add student
      await service.addStudent(
        firstName: firstName,
        nickname: nickname,
        grade: grade,
      );

      // Reload students
      await loadStudents();

      // Auto-select the newly created student (most recent one)
      if (_students.isNotEmpty) {
        // Since we order by created_at ascending in getStudents, the last one *should* be the new one.
        // But to be safe, let's find it by nickname/name or just take the last one.
        // Given the low volume, taking the last one is a reasonable heuristic for now.
        final newStudent = _students.last;
        selectStudent(newStudent);
      }
    } catch (e) {
      debugPrint('Error adding student: $e');
    }
  }

  // Legacy/Fallback Profile Load (Parent Profile)
  Future<void> loadStudentProfile() async {
    // ... keep or deprecated ...
  }

  // Setters/Actions
  void setStudentIdentity(String name, String nickname) {
    _studentName = name;
    _generatedNickname = nickname;
    notifyListeners();
  }

  void startGame({int level = 1}) {
    _score = 0;
    _lives = 5; // Increased from 3 based on user feedback
    _currentLevel = level;
    _answeredQuestions.clear(); // Clear history
    _resetLevelPhysics();
    _status = GameStatus.playing;
    notifyListeners();
  }

  void _resetLevelPhysics() {
    // Progressive speed increases - 10% per level for smooth difficulty curve
    switch (_currentLevel) {
      case 1:
        _runSpeed = 2.5; // Base speed
        break;
      case 2:
        _runSpeed = 2.75; // +10% (2.5 * 1.1)
        break;
      case 3:
        _runSpeed = 3.03; // +10% (2.75 * 1.1)
        break;
      case 4:
        _runSpeed = 3.33; // +10% (3.03 * 1.1)
        break;
      case 5:
        _runSpeed = 3.66; // +10% (3.33 * 1.1)
        break;
    }
  }

  void pauseGame() {
    if (_status == GameStatus.playing) {
      _status = GameStatus.paused;
      notifyListeners();
    }
  }

  void resumeGame() {
    if (_status == GameStatus.paused) {
      _status = GameStatus.playing;
      notifyListeners();
    }
  }

  void forfeitGame() {
    _score = 0; // Reset score (Forfeit)
    _status = GameStatus.menu;
    notifyListeners();
  }

  void takeDamage() {
    if (_isInvincible) return;

    _lives--;
    if (_lives <= 0) {
      _status = GameStatus.gameOver;
      checkHighScore();
    }
    notifyListeners();
  }

  void addScore(int points) {
    _score += points;
    notifyListeners();
  }

  void triggerStaffEvent(StaffEventType type) {
    // Staff events now only show visual notification and play sound
    // No gameplay effects (speed, jump power, etc.)
    _activeStaffEvent = StaffEvent.getEvent(type);
    notifyListeners();

    // Auto-clear event after duration (for visual notification)
    Future.delayed(_activeStaffEvent!.duration, () {
      _clearStaffEvent();
    });
  }

  void _clearStaffEvent() {
    if (_activeStaffEvent?.type == StaffEventType.coachWhistle ||
        _activeStaffEvent?.type == StaffEventType.deanGlare) {
      _resetLevelPhysics(); // Reset speed
    }
    _activeStaffEvent = null;
    notifyListeners();
  }

  void setInvincible(bool active) {
    _isInvincible = active;
    notifyListeners();
    if (active) {
      Future.delayed(const Duration(seconds: 5), () {
        _isInvincible = false;
        notifyListeners();
      });
    }
  }

  Future<void> checkHighScore() async {
    if (_score > 0 && _currentStudent != null) {
      try {
        final service = SupabaseService();
        await service.updateStudentScore(_currentStudent!['id'], _score);

        // Also unlock next level if needed (simple logic: score > 0 unlocks next?)
        // Or explicitly called in completeLevel
      } catch (e) {
        debugPrint('Error saving high score: $e');
      }
    }
  }

  Future<void> recordQuizResult(String challengeId, bool correct) async {
    if (_currentStudent == null) return;

    // Don't record progress for fallback/offline challenges (prevent FK errors)
    if (challengeId == 'fallback_math' || challengeId.startsWith('fallback')) {
      debugPrint('Skipping progress save for fallback challenge: $challengeId');
      return;
    }

    try {
      final service = SupabaseService();
      await service.submitQuizResult(
        studentId: _currentStudent!['id'],
        challengeId: challengeId,
        score: correct ? 100 : 0,
      );
    } catch (e) {
      debugPrint('Error recording quiz result: $e');
    }
  }

  Future<void> unlockNextLevel() async {
    if (_currentStudent == null) return;

    // Unlock level + 1
    final nextLevel = _maxLevel + 1;
    if (nextLevel <= 5) {
      // Cap at 5
      _maxLevel = nextLevel;
      notifyListeners(); // Immediate UI update

      try {
        final service = SupabaseService();
        await service.unlockLevel(_currentStudent!['id'], _maxLevel);
      } catch (e) {
        debugPrint('Error unlocking level: $e');
      }
    }
  }

  // Questions
  final Set<String> _answeredQuestions = {};

  void startNextLevel() {
    if (_currentLevel < 5) {
      // Unlock next level logic
      if (_currentLevel >= _maxLevel) {
        unlockNextLevel();
      }

      _currentLevel++;
      _resetLevelPhysics();
      _status = GameStatus.playing; // Directly set to playing
      notifyListeners();
    } else {
      _status = GameStatus.gameOver;
      notifyListeners();
      checkHighScore();
    }
  }

  // Modified completeLevel to just set status
  void completeLevel() {
    _status = GameStatus.levelComplete;
    notifyListeners();
  }

  // Helper to get random unique question
  QuizQuestion getNextQuestion() {
    if (_currentChallenge == null || _currentChallenge!.questions.isEmpty) {
      // Fallback
      return QuizQuestion(
        questionText: 'What is the alligator\'s favorite color?',
        correctOptionIndex: 2,
        options: ['Red', 'Blue', 'Green', 'Orange'],
      );
    }

    // Filter available questions (using questionText as ID since we don't have one on the model yet)
    final available = _currentChallenge!.questions
        .where((q) => !_answeredQuestions.contains(q.questionText))
        .toList();

    if (available.isEmpty) {
      _answeredQuestions.clear(); // Reset if all answered
      final question =
          _currentChallenge!.questions[DateTime.now().microsecond %
              _currentChallenge!.questions.length];
      _answeredQuestions.add(question.questionText);
      return question;
    }

    final question = available[DateTime.now().microsecond % available.length];
    _answeredQuestions.add(question.questionText);
    return question;
  }
}
