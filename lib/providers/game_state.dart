import 'package:flutter/foundation.dart';
import '../models/staff_event.dart';

enum GameStatus { menu, playing, paused, levelComplete, gameOver }

class GameState extends ChangeNotifier {
  // Player Data
  String _studentName = '';
  String _generatedNickname = '';

  // Game Session Data
  int _score = 0;
  int _lives = 3;
  int _currentLevel = 1;
  double _runSpeed = 5.0; // Base speed
  GameStatus _status = GameStatus.menu;

  // Events
  StaffEvent? _activeStaffEvent;
  bool _isInvincible = false;

  // Getters
  String get studentName => _studentName;
  String get generatedNickname => _generatedNickname;
  int get score => _score;
  int get lives => _lives;
  int get currentLevel => _currentLevel;
  double get runSpeed => _runSpeed;
  GameStatus get status => _status;
  StaffEvent? get activeStaffEvent => _activeStaffEvent;
  bool get isInvincible => _isInvincible;

  // Setters/Actions
  void setStudentIdentity(String name, String nickname) {
    _studentName = name;
    _generatedNickname = nickname;
    notifyListeners();
  }

  void startGame() {
    _score = 0;
    _lives = 3;
    _currentLevel = 1;
    _resetLevelPhysics();
    _status = GameStatus.playing;
    notifyListeners();
  }

  void _resetLevelPhysics() {
    // Reset speed/physics based on level
    switch (_currentLevel) {
      case 1:
        _runSpeed = 5.0;
        break;
      case 2:
        _runSpeed = 8.0;
        break; // Faster
      case 3:
        _runSpeed = 5.0;
        break; // Foggy (Visual only, speed normal)
      case 4:
        _runSpeed = 6.0;
        break; // Ice (Slide handled in player controller)
      case 5:
        _runSpeed = 10.0;
        break; // Carpool
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

  void takeDamage() {
    if (_isInvincible) return;

    _lives--;
    if (_lives <= 0) {
      _status = GameStatus.gameOver;
    }
    notifyListeners();
  }

  void addScore(int points) {
    _score += points;
    notifyListeners();
  }

  void triggerStaffEvent(StaffEventType type) {
    _activeStaffEvent = StaffEvent.getEvent(type);

    // Apply immediate effects
    if (type == StaffEventType.coachWhistle) {
      _runSpeed *= 2;
    }

    notifyListeners();

    // Auto-clear event after duration
    Future.delayed(_activeStaffEvent!.duration, () {
      _clearStaffEvent();
    });
  }

  void _clearStaffEvent() {
    if (_activeStaffEvent?.type == StaffEventType.coachWhistle) {
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

  void completeLevel() {
    if (_currentLevel < 5) {
      _currentLevel++;
      _resetLevelPhysics();
      _status = GameStatus.levelComplete; // Show page view transition?
      // For prototype, maybe just auto-transition or wait for user input
      // Let's keep it playing but notify listeners to update background
      notifyListeners();
    } else {
      _status = GameStatus.gameOver; // Win state?
      notifyListeners();
    }
  }
}
