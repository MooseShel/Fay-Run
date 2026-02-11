import 'package:flutter/foundation.dart';
import '../models/staff_event.dart';
import '../models/challenge.dart';
import '../services/supabase_service.dart';
import '../services/audio_service.dart';

enum GameStatus { menu, playing, paused, levelComplete, gameOver, bonusRound }

class GameState extends ChangeNotifier {
  // Multi-Student Data
  List<Map<String, dynamic>> _students = [];
  Map<String, dynamic>? _currentStudent;
  bool _isLoading = false;
  int _maxLevel = kDebugMode ? 10 : 1;
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
  int _goldenBooksCollectedCurrentLevel = 0;
  int _comboCount = 0;
  int get comboCount => _comboCount;

  // Exam Mode
  bool _isExamMode = false;
  String? _examTopic;
  bool get isExamMode => _isExamMode;
  String? get examTopic => _examTopic;

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
  int get currentGrade {
    final gradeStr = _currentStudent?['grade']?.toString() ?? '1st';

    if (gradeStr == 'Pre-K (3yo)') return -2;
    if (gradeStr == 'Pre-K (4yo)') return -1;
    if (gradeStr == 'Kindergarten' || gradeStr == 'K') return 0;

    return int.tryParse(gradeStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
  }

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

  bool get isBonusRoundEarned {
    // Disabled for now - assets pending
    return false;
    /*
    bool isBonusLevel = [3, 6, 9].contains(_currentLevel);
    bool hitThreshold = _goldenBooksCollectedCurrentLevel >= 5;
    return isBonusLevel && hitThreshold;
    */
  }

  Future<void> loadChallenge() async {
    _isLoading = true;
    notifyListeners();

    try {
      final service = SupabaseService();
      final grade = currentGrade;

      // Map level 1-10 to difficulty 1-5
      final difficulty = ((_currentLevel - 1) / 2).floor() + 1;

      _currentChallenge = await service.getCurrentChallenge(
        gradeLevel: grade,
        weekNumber: _currentLevel, // Keep for backward compatibility
        topic: _isExamMode ? _examTopic : null,
        isExam: _isExamMode,
        difficultyLevel: difficulty,
      );

      if (_currentChallenge != null) {
        debugPrint(
          'Loaded challenge: ${_currentChallenge!.topic} '
          'for Level $_currentLevel (Diff $difficulty), Grade $grade, Exam: $_isExamMode',
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
    _maxLevel = kDebugMode ? 10 : ((student['max_level'] as int?) ?? 1);
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

  void setExamMode(bool active, {String? topic}) {
    _isExamMode = active;
    _examTopic = topic;
    notifyListeners();
    // Reload challenge if we are in a state where it matters (e.g., menu)
    loadChallenge();
  }

  void startGame({int level = 1}) {
    _score = 0;
    _lives = 5; // Increased from 3 based on user feedback
    _currentLevel = level;
    _goldenBooksCollectedCurrentLevel = 0; // Reset counter
    _comboCount = 0;
    _answeredQuestions.clear(); // Clear history
    _resetLevelPhysics();
    _status = GameStatus.playing;
    notifyListeners();
  }

  void _resetLevelPhysics() {
    // Progressive speed increases - approx 5-8% per level for smooth curve
    // Base speed at Level 1 = 2.5
    // Level 10 speed target ~4.5 to 5.0
    final double baseSpeed = 2.5;
    final double increment = 0.25; // Linear increment for predictability

    _runSpeed = baseSpeed + ((_currentLevel - 1) * increment);

    debugPrint('Level $_currentLevel Physics Reset: Speed = $_runSpeed');
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
    if (_status != GameStatus.playing && _status != GameStatus.bonusRound)
      return;
    // Apply combo multiplier (max x5)
    int multiplier = (_comboCount ~/ 5) + 1;
    if (multiplier > 5) multiplier = 5;
    _score += points * multiplier;
    notifyListeners();
  }

  void triggerStaffEvent(StaffEventType type) {
    // Staff events now only show visual notification and play sound
    _activeStaffEvent = StaffEvent.getEvent(type);
    AudioService().playStaffSound(type); // Play staff voice
    notifyListeners();

    // Auto-clear event after duration
    Future.delayed(_activeStaffEvent!.duration, () {
      _clearStaffEvent();
    });
  }

  Future<void> triggerStaffChaos() async {
    // Trigger a sequence of 3 different staff events for real chaos
    final types = StaffEventType.values.toList()..shuffle();
    final sequence = types.take(3).toList();

    for (var type in sequence) {
      if (_status != GameStatus.playing) break;

      triggerStaffEvent(type);
      // Play sound immediately when triggered via this method manually
      // though GameLoopScreen also calls it. To avoid double sound,
      // let's rely on GameLoopScreen for individual calls and
      // triggerStaffEvent for the visual.

      await Future.delayed(
          const Duration(milliseconds: 2500)); // wait for duration + buffer
    }
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

      if (correct) {
        if (challengeId.contains('golden')) {
          _goldenBooksCollectedCurrentLevel++;
        }
        _comboCount++; // Increment combo on any correct answer
        notifyListeners();
      } else {
        _comboCount = 0; // Reset combo on wrong answer
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error recording quiz result: $e');
    }
  }

  Future<void> unlockNextLevel() async {
    if (_currentStudent == null) return;

    // Unlock level + 1
    final nextLevel = _maxLevel + 1;
    if (nextLevel <= 10) {
      // Cap at 10 levels
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

  Future<void> startNextLevel() async {
    if (_currentLevel < 10) {
      // Unlock next level logic
      if (_currentLevel >= _maxLevel) {
        unlockNextLevel();
      }

      _currentLevel++;
      _resetLevelPhysics();

      // Reload challenge for the new level (new questions)
      await loadChallenge();

      _status = GameStatus.playing; // Directly set to playing
      _goldenBooksCollectedCurrentLevel = 0; // Reset for next level
      notifyListeners();
    } else {
      _status = GameStatus.gameOver;
      notifyListeners();
      checkHighScore();
    }
  }

  void completeLevel() {
    _status = GameStatus.levelComplete;
    notifyListeners();
  }

  void startBonusRound() {
    _status = GameStatus.bonusRound;
    _isInvincible = true; // No damage in bonus round
    notifyListeners();

    // Bonus round lasts 15 seconds
    Future.delayed(const Duration(seconds: 15), () {
      endBonusRound();
    });
  }

  void endBonusRound() {
    if (_status == GameStatus.bonusRound) {
      _isInvincible = false;
      _status = GameStatus
          .levelComplete; // Go back to level complete screen to proceed
      notifyListeners();
    }
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
      final question = _currentChallenge!.questions[
          DateTime.now().microsecond % _currentChallenge!.questions.length];
      _answeredQuestions.add(question.questionText);
      return question;
    }

    final question = available[DateTime.now().microsecond % available.length];
    _answeredQuestions.add(question.questionText);
    return question;
  }
}
