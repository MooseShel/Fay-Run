import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/staff_event.dart';
import '../models/challenge.dart';
import '../services/supabase_service.dart';
import '../services/audio_service.dart';

enum GameStatus {
  menu,
  playing,
  paused,
  levelComplete,
  gameOver,
  bonusRound,
  quiz,
  celebration
}

enum BonusRoundType {
  none,
  goldenDash, // Existing high-speed run
  eggCatch, // Level 2 Chicken Coop
}

class GameState extends ChangeNotifier {
  // Multi-Student Data
  List<Map<String, dynamic>> _students = [];
  Map<String, dynamic>? _currentStudent;
  bool _isLoading = false;
  int _maxLevel = kDebugMode ? 10 : 1;
  List<Map<String, dynamic>> _leaderboard = [];

  // Level Timing
  static const double kLevelDurationSeconds = 60.0;
  double _levelProgress = 0.0; // 0.0 to 1.0
  double get levelProgress => _levelProgress;

  // Player Data (Legacy/Fallback)
  String _studentName = '';
  String _generatedNickname = '';

  // Game Session Data
  int _totalScore = 0; // Confirmed score from completed levels
  int _currentLevelScore = 0; // Temporary score in current level
  int _initialHighScore = 0; // High score at session start
  bool _newHighScoreCelebrated = false; // Track celebration
  int _studentRealMaxLevel = 1; // Actual progression without debug overrides

  // int _score = 0; // DEPRECATED
  int _lives = 5; // Increased from 3 to 5 hearts
  int _currentLevel = 1;
  double _runSpeed = 4.0; // Increased base speed
  GameStatus _status = GameStatus.menu;
  BonusRoundType _currentBonusType = BonusRoundType.none;

  BonusRoundType get currentBonusType => _currentBonusType;

  // Events
  StaffEvent? _activeStaffEvent;
  bool _isInvincible = false;
  int _goldenBooksCollectedCurrentLevel = 0;
  int get goldenBooksCollectedCurrentLevel => _goldenBooksCollectedCurrentLevel;
  int _comboCount = 0;
  int get comboCount => _comboCount;
  bool _playedBonusInCurrentLevel = false;
  Timer? _invincibilityTimer;
  bool _hasHeartSpawnedThisLevel = false;
  double _heartSpawnProgress = 0.0;

  // Exam Mode
  bool _isExamMode = false;
  String? _examTopic;
  String? _selectedExamId;
  List<Map<String, dynamic>> _availableExams = [];

  bool get isExamMode => _isExamMode;
  String? get examTopic => _examTopic;
  String? get selectedExamId => _selectedExamId;
  List<Map<String, dynamic>> get availableExams => _availableExams;

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

  int get score => _totalScore + _currentLevelScore;
  bool get newHighScoreCelebrated => _newHighScoreCelebrated;
  int get lives => _lives;
  int get currentLevel => _currentLevel;
  double get runSpeed => _runSpeed;
  GameStatus get status => _status;
  StaffEvent? get activeStaffEvent => _activeStaffEvent;
  bool get isInvincible => _isInvincible;

  Challenge? _currentChallenge;
  Challenge? get currentChallenge => _currentChallenge;

  bool get hasHeartSpawnedThisLevel => _hasHeartSpawnedThisLevel;
  double get heartSpawnProgress => _heartSpawnProgress;

  bool get isBonusRoundEarned {
    // Enabled for level 2 as requested, others keep disabled for now
    if (_currentLevel == 2 &&
        !_playedBonusInCurrentLevel &&
        _status == GameStatus.levelComplete) return true;
    return false;
  }

  Future<void> loadChallenge() async {
    _isLoading = true;
    notifyListeners();

    try {
      final service = SupabaseService();
      final grade = currentGrade;

      // Map level 1-10 to difficulty 1-10 (Linear)
      final difficulty = _currentLevel;

      _currentChallenge = await service.getCurrentChallenge(
        gradeLevel: grade,
        topic: _isExamMode ? _examTopic : null,
        isExam: _isExamMode,
        difficultyLevel: difficulty,
        examId: _isExamMode ? _selectedExamId : null,
      );

      if (_currentChallenge != null) {
        debugPrint(
          'Loaded challenge: ${_currentChallenge!.topic} '
          'for Level $_currentLevel (Diff $difficulty), Grade $grade, Exam: $_isExamMode, ExamID: $_selectedExamId',
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
    debugPrint('GameState: loadStudents() started');
    _isLoading = true;
    notifyListeners();
    try {
      final service = SupabaseService();
      debugPrint('GameState: Fetching profile (background)...');
      service.getProfile(); // Don't block student loading on profile repair
      debugPrint('GameState: Fetching students...');
      _students = await service.getStudents();
      debugPrint('GameState: Loaded ${_students.length} students');
    } catch (e) {
      debugPrint('GameState: Error loading students: $e');
    } finally {
      _isLoading = false;
      debugPrint('GameState: loadStudents() finished, isLoading = false');
      notifyListeners();
    }
  }

  void selectStudent(Map<String, dynamic> student) {
    _currentStudent = student;
    int studentLevel = (student['max_level'] as int?) ?? 1;
    if (studentLevel < 1) studentLevel = 1;
    _studentRealMaxLevel = studentLevel;
    // In debug mode, unlock at least to 10, but allow 11 (game complete) if achieved
    _maxLevel = kDebugMode ? math.max(10, studentLevel) : studentLevel;

    // Load high score
    _initialHighScore = (student['high_score'] as int?) ?? 0;
    _totalScore = 0;
    _currentLevelScore = 0;
    _currentLevelScore = 0;

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
      final userId = service.currentUser?.id;
      if (userId == null) {
        debugPrint('GameState: Cannot add student, no user logged in.');
        return;
      }

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
        final newStudent = _students.last;
        selectStudent(newStudent);
      }
    } catch (e) {
      debugPrint('Error adding student: $e');
    }
  }

  // Setters/Actions
  void setStudentIdentity(String name, String nickname) {
    _studentName = name;
    _generatedNickname = nickname;
    notifyListeners();
  }

  void setExamMode(bool active, {String? topic, String? examId}) async {
    _isExamMode = active;
    _examTopic = topic;
    _selectedExamId = examId;

    if (active && topic != null) {
      _isLoading = true;
      notifyListeners();
      try {
        final service = SupabaseService();
        _availableExams = await service.getAvailableExams(currentGrade, topic);

        // Auto-select first exam if none selected and list not empty
        if (_selectedExamId == null && _availableExams.isNotEmpty) {
          _selectedExamId = _availableExams.first['id'];
        }
      } catch (e) {
        debugPrint('Error fetching available exams: $e');
      } finally {
        _isLoading = false;
      }
    } else if (!active) {
      _selectedExamId = null;
      _availableExams = [];
    }

    notifyListeners();
    loadChallenge();
  }

  void startGame({int level = 1}) {
    debugPrint(
        'GameState: startGame level=$level, realMax=$_studentRealMaxLevel, debugMax=$_maxLevel, initHigh=$_initialHighScore');

    // Only reset total score if starting from level 1
    if (level == 1) {
      debugPrint('GameState: Resetting score (Level 1)');
      _totalScore = 0;
      _newHighScoreCelebrated = false;
    } else if ((level >= _studentRealMaxLevel && _studentRealMaxLevel > 1) ||
        (level == 10 && _studentRealMaxLevel >= 11)) {
      debugPrint(
          'GameState: Inheriting score $_initialHighScore (Resuming/Frontier/VictoryLap)');
      // Resuming at the latest frontier OR replaying Level 10 after beating game.
      // This allows "Victory Lap" score accumulation.
      _totalScore = _initialHighScore;
      _newHighScoreCelebrated = false;
    } else {
      debugPrint('GameState: Resetting score (Replay/Old Level)');
      // Replaying a past level: Start fresh (or technically 0 for this run)
      // to avoid stacking scores infinitely by replaying easy levels.
      _totalScore = 0;
      _newHighScoreCelebrated = false;
    }

    _currentLevelScore = 0;
    _currentLevelScore = 0;
    _lives = 5; // Increased from 3 based on user feedback
    _currentLevel = level;
    _goldenBooksCollectedCurrentLevel = 0; // Reset counter
    _comboCount = 0;
    _levelProgress = 0.0; // Reset progress
    _answeredQuestions.clear(); // Clear history
    _resetLevelPhysics();
    _currentBonusType = BonusRoundType.none;
    _isInvincible = false;
    _playedBonusInCurrentLevel = false;
    _hasHeartSpawnedThisLevel = false;
    _heartSpawnProgress =
        0.4 + (math.Random().nextDouble() * 0.5); // Random between 40% and 90%
    _status = GameStatus.playing; // Ensure game starts in playing state
    notifyListeners();
  }

  void updateProgress(double dt) {
    if (_status == GameStatus.playing) {
      _levelProgress += dt / kLevelDurationSeconds;
      if (_levelProgress >= 1.0) {
        _levelProgress = 1.0;
        completeLevel();
      }
      notifyListeners();
    }
  }

  void _resetLevelPhysics() {
    // Increase speed with level scaling: Base 4.0 + 0.1 per level
    // Increased by 10% per user request
    // Balanced speed curve: Steady manageable growth (1.05x multiplier)
    _runSpeed = (4.0 + (_currentLevel * 0.10)) * 1.05;

    debugPrint('Level $_currentLevel Physics Reset: Speed = $_runSpeed');
  }

  void startQuiz() {
    if (_status == GameStatus.playing) {
      _status = GameStatus.quiz;
      notifyListeners();
    }
  }

  void pauseGame() {
    if (_status == GameStatus.playing || _status == GameStatus.bonusRound) {
      _status = GameStatus.paused;
      AudioService().pauseBGM();
      notifyListeners();
    }
  }

  void resumeGame() {
    if (_status == GameStatus.paused || _status == GameStatus.quiz) {
      bool wasPaused = _status == GameStatus.paused;
      _status = GameStatus.playing;
      if (wasPaused) {
        AudioService().resumeBGM();
      }
      notifyListeners();
    }
  }

  void forfeitGame() {
    _totalScore = 0;
    _currentLevelScore = 0;
    _currentLevelScore = 0;
    _levelProgress = 0.0;
    _comboCount = 0;
    _isInvincible = false;
    _invincibilityTimer?.cancel();
    _playedBonusInCurrentLevel = false;
    _currentBonusType = BonusRoundType.none;
    _status = GameStatus.menu;
    notifyListeners();
  }

  void takeDamage() {
    if (_isInvincible ||
        _status == GameStatus.gameOver ||
        _status == GameStatus.levelComplete) return;

    _lives--;
    if (_lives <= 0) {
      _status = GameStatus.gameOver;
      checkHighScore();
    }
    notifyListeners();
  }

  void addLife() {
    if (_lives < 5) {
      _lives++;
      notifyListeners();
    }
  }

  void markHeartAsSpawned() {
    _hasHeartSpawnedThisLevel = true;
    notifyListeners();
  }

  void addScore(int points) {
    if (_status != GameStatus.playing &&
        _status != GameStatus.bonusRound &&
        _status != GameStatus.quiz) {
      return;
    }
    // Simplified scoring for children: No multipliers, just add points
    // Add to current level score ONLY
    _currentLevelScore += points;

    // Check for real-time high score celebration
    if (!_newHighScoreCelebrated &&
        (_totalScore + _currentLevelScore) > _initialHighScore &&
        _initialHighScore > 0) {
      _newHighScoreCelebrated = true;
      // We can trigger a one-time event or just let the UI bind to this
    }

    notifyListeners();
  }

  void triggerStaffEvent(StaffEventType type) {
    // Staff events now only show visual notification and play sound
    _activeStaffEvent = StaffEvent.getEvent(type);
    AudioService().playStaffSound(type); // Play staff voice

    notifyListeners();

    // Auto-clear event after duration
    final duration = _activeStaffEvent?.duration ?? const Duration(seconds: 4);
    Future.delayed(duration, () {
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
    _activeStaffEvent = null;
    notifyListeners();
  }

  void setInvincible(bool active) {
    _invincibilityTimer?.cancel();
    _isInvincible = active;
    notifyListeners();

    if (active) {
      // 4 seconds power-up version (extendable)
      _invincibilityTimer = Timer(const Duration(seconds: 4), () {
        _isInvincible = false;
        notifyListeners();
      });
    }
  }

  Future<void> checkHighScore() async {
    final studentId = _currentStudent?['id'];
    // ONLY count fully secured points (from completed levels)
    final finalScore = _totalScore;

    // Update local high score if beaten (for immediate UI feedback)
    if (finalScore > _initialHighScore) {
      _initialHighScore = finalScore;
    }

    if (finalScore > 0 && studentId != null) {
      try {
        final service = SupabaseService();
        await service.updateStudentScore(studentId, finalScore);
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
      final studentId = _currentStudent?['id'];
      if (studentId == null) return;

      await service.submitQuizResult(
        studentId: studentId,
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

    // Determine next level based on current level completion
    final nextLevel = _currentLevel + 1;

    // Only update if we are pushing the frontier
    if (nextLevel > _studentRealMaxLevel && nextLevel <= 11) {
      _studentRealMaxLevel = nextLevel;

      // Update public max level if we surpassed it (or to sync in non-debug)
      if (_studentRealMaxLevel > _maxLevel) {
        _maxLevel = _studentRealMaxLevel;
      }

      // If we finished level 10, trigger celebration status
      if (_currentLevel >= 10) {
        _status = GameStatus.celebration;
      }

      notifyListeners();

      try {
        final service = SupabaseService();
        final studentId = _currentStudent?['id'];
        if (studentId != null) {
          await service.unlockLevel(studentId, _studentRealMaxLevel);
        }
      } catch (e) {
        debugPrint('Error unlocking level: $e');
      }
    } else if (_currentLevel >= 10) {
      // Even if we didn't unlock a new level (already at max),
      // completing level 10 should trigger celebration
      _status = GameStatus.celebration;
      notifyListeners();
    }
  }

  // Questions
  final Set<String> _answeredQuestions = {};

  Future<void> startNextLevel() async {
    // Check if we are completing the final level (10)
    if (_currentLevel >= 10) {
      await unlockNextLevel();
      return;
    }

    if (_currentLevel < 10) {
      // Unlock next level logic
      if (_currentLevel >= _studentRealMaxLevel) {
        await unlockNextLevel();
      }

      _currentLevel++;
      _resetLevelPhysics();
      _currentLevelScore = 0; // Reset for next level
      _levelProgress = 0.0; // Reset for next level

      // Reload challenge for the new level (new questions)
      await loadChallenge();
      _comboCount = 0;
      _status = GameStatus.playing; // Directly set to playing
      _isInvincible = false;
      _invincibilityTimer?.cancel();
      _goldenBooksCollectedCurrentLevel = 0; // Reset for next level
      _playedBonusInCurrentLevel = false; // Reset for next level
      _hasHeartSpawnedThisLevel = false;
      _heartSpawnProgress = 0.4 + (math.Random().nextDouble() * 0.5);
      notifyListeners();
    }
  }

  void completeLevel() {
    // Commit level score to total score
    _totalScore += _currentLevelScore;
    _currentLevelScore = 0;

    // Check high score on level completion as a checkpoint
    checkHighScore();

    _status = GameStatus.levelComplete;
    notifyListeners();
  }

  void startBonusRound() {
    _status = GameStatus.bonusRound;
    _isInvincible = true; // No damage in bonus round
    _playedBonusInCurrentLevel = true;

    // Select bonus round type based on level
    if (_currentLevel == 2) {
      _currentBonusType = BonusRoundType.eggCatch;
    } else {
      _currentBonusType = BonusRoundType.goldenDash;
    }

    notifyListeners();

    // Bonus round lasts 20 seconds
    Future.delayed(const Duration(seconds: 20), () {
      endBonusRound();
    });
  }

  void startBonusTest(BonusRoundType type, {int level = 2}) {
    _status = GameStatus.bonusRound;
    _isInvincible = true;
    _currentBonusType = type;
    _currentLevel = level;
    _currentLevelScore = 0; // Reset for test
    _lives = 5;
    notifyListeners();

    Future.delayed(const Duration(seconds: 20), () {
      endBonusRound();
    });
  }

  void endBonusRound() {
    if (_status == GameStatus.bonusRound) {
      _isInvincible = false;
      _currentBonusType = BonusRoundType.none;
      _playedBonusInCurrentLevel = true; // Ensure it's set even on end
      _status = GameStatus
          .levelComplete; // Go back to level complete screen to proceed
      notifyListeners();
    }
  }

  // Helper to get random unique question
  QuizQuestion getNextQuestion() {
    if (_currentChallenge == null || _currentChallenge!.questions.isEmpty) {
      // Fallback variety (Ernie themed)
      final List<QuizQuestion> fallbacks = [
        QuizQuestion(
          id: 'fallback_ernie_1',
          questionText: 'What is Ernie\'s favorite color?',
          correctOptionIndex: 2,
          options: ['Red', 'Blue', 'Green', 'Orange'],
        ),
        QuizQuestion(
          id: 'fallback_ernie_2',
          questionText: 'Which school does Ernie go to?',
          correctOptionIndex: 0,
          options: [
            'The Fay School',
            'Green Bayou Academy',
            'Lush Forest High'
          ],
        ),
        QuizQuestion(
          id: 'fallback_ernie_3',
          questionText: 'What is 5 + 7?',
          correctOptionIndex: 1,
          options: ['10', '12', '13', '15'],
        ),
        QuizQuestion(
          id: 'fallback_ernie_4',
          questionText: 'Ernie is a Gator. Where do gators live?',
          correctOptionIndex: 3,
          options: ['Desert', 'Mountains', 'Arctic', 'Bayou'],
        ),
      ];

      final random = math.Random();
      return fallbacks[random.nextInt(fallbacks.length)];
    }

    // Filter available questions (using ID for deterministic tracking)
    final available = _currentChallenge!.questions
        .where((q) => !_answeredQuestions.contains(q.id))
        .toList();

    if (available.isEmpty) {
      _answeredQuestions.clear(); // Reset if all answered
      final random = math.Random();
      final question = _currentChallenge!
          .questions[random.nextInt(_currentChallenge!.questions.length)];
      _answeredQuestions.add(question.id);
      return question;
    }

    final random = math.Random();
    final question = available[random.nextInt(available.length)];
    _answeredQuestions.add(question.id);
    return question;
  }

  @override
  void dispose() {
    _invincibilityTimer?.cancel();
    super.dispose();
  }
}
