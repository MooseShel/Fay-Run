import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_state.dart';
import '../../models/staff_event.dart';
import '../../core/constants.dart';
import '../../models/challenge.dart'; // Needed for fallback
import '../../widgets/parallax_background.dart';
import '../../widgets/player_character.dart';
import '../../widgets/game/ambient_effects.dart';
import '../../widgets/game/quiz_overlay.dart';
import '../../widgets/game/animated_staff_chaos.dart';
import '../../game/obstacle_manager.dart';
import '../../game/scenery_manager.dart';
import '../../services/audio_service.dart';
import '../../services/asset_manager.dart';
import '../../services/crash_report_service.dart';
import '../../core/assets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GameLoopScreen extends StatefulWidget {
  const GameLoopScreen({super.key});

  @override
  State<GameLoopScreen> createState() => _GameLoopScreenState();
}

class _GameLoopScreenState extends State<GameLoopScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _gameLoopController;
  final ObstacleManager _obstacleManager = ObstacleManager();
  final SceneryManager _sceneryManager = SceneryManager();

  // Game Physics State
  double _playerY = 0; // 0 = ground, positive = up
  double _verticalVelocity = 0;
  late double _groundHeight; // Calculated dynamically in build method

  bool _isJumping = false;
  int _jumpCount = 0;
  final int _maxJumps = 2;

  // Progression & Chaos
  int? _lastLevel;
  double _chaosTimer = 0;
  final Random _random = Random();

  // Animation State
  bool _isCrashed = false;
  int _runFrame = 0;
  double _runAnimationTimer = 0;

  // Frame-rate Independence
  DateTime? _lastFrameTime;

  // Floating Score Logic
  final List<FloatingScore> _floatingScores = [];

  // Horizontal Movement (for Egg Catch)
  double _playerXOffset = 0; // 0 = default (0.3 of screen width)
  double _horizontalVelocity = 0;
  int _moveDirection = 0; // -1 for left, 1 for right, 0 for none

  // Chicken Surprise Timers (Level 2 Bonus)
  // Chicken Surprise Timers (Level 2 Bonus)
  final List<double> _chickenSurpriseTimers = [0, 0, 0, 0, 0];
  final List<String> _chickenLastEggIds = ["", "", "", "", ""];

  // Bonus Animation State
  double _bgAnimTimer = 0;
  int _bgAnimFrameDog = 1;
  int _bgAnimFrameChicken = 1;
  int _bgAnimFrameBird = 1;
  double _bird1X = -0.2;
  double _bird2X = 1.2;
  double _bonusRoundTimer = 0;

  void _spawnFloatingScore(int amount) {
    if (!mounted) return;
    setState(() {
      _floatingScores.add(
        FloatingScore(
          amount: amount,
          x: MediaQuery.sizeOf(context).width * 0.35, // Near player
          y: MediaQuery.sizeOf(context).height * 0.4, // Mid-screen
        ),
      );
    });
  }

  void _updateFloatingScores(double dt) {
    for (int i = _floatingScores.length - 1; i >= 0; i--) {
      final fs = _floatingScores[i];
      fs.animationTime += dt;
      if (fs.animationTime > 1.0) {
        // 1 second lifetime
        _floatingScores.removeAt(i);
      }
    }
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _gameLoopController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 16))
      ..addListener(_gameLoop)
      ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAssets();
    });
  }

  // Cache screen dimensions
  double _cachedScreenWidth = 0;
  double _cachedScreenHeight = 0;
  double _cachedPlayerSize = 0;
  double _cachedPlayerPadding = 0;
  double _cachedPlayerBaseX = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    if (size.width != _cachedScreenWidth ||
        size.height != _cachedScreenHeight) {
      _cachedScreenWidth = size.width;
      _cachedScreenHeight = size.height;
      _cachedPlayerSize = size.height * 0.21;
      _cachedPlayerPadding = _cachedPlayerSize * 0.25;
      _cachedPlayerBaseX = size.width * 0.30;
    }
  }

  Future<void> _loadAssets() async {
    try {
      final state = context.read<GameState>();
      final level = state.currentLevel;
      final minDelayFuture = Future.delayed(const Duration(milliseconds: 4000));
      final essentialPreload = AssetManager().precacheEssentialAssets(context);
      final bgPreload = AssetManager().precacheLevelAssets(context, level);

      if (state.status == GameStatus.bonusRound &&
          state.currentBonusType == BonusRoundType.eggCatch) {
        AudioService().playCustomBGM(Assets.chickenCoopMusic);
      } else {
        AudioService().playBGM(level);
      }

      await state.loadChallenge();
      await Future.wait([minDelayFuture, essentialPreload, bgPreload]);
    } catch (e) {
      debugPrint('⚠️ Error during loading: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    AudioService().stopBGM();
    super.dispose();
  }

  void _gameLoop() {
    if (_isLoading) return;

    try {
      final gameState = context.read<GameState>();
      final screenSize = (gameState.status == GameStatus.bonusRound &&
              gameState.currentBonusType == BonusRoundType.eggCatch)
          ? const Size(1600, 900)
          : MediaQuery.sizeOf(context);

      if (screenSize.width <= 0 || screenSize.height <= 0) return;

      if (_lastLevel != null && _lastLevel != gameState.currentLevel) {
        _obstacleManager.clear();
        _sceneryManager.clear();
      }
      _lastLevel = gameState.currentLevel;

      if (gameState.status == GameStatus.paused ||
          gameState.status == GameStatus.quiz) {
        _lastFrameTime = null;
        return;
      }

      final now = DateTime.now();
      double dt = 0.016;
      if (_lastFrameTime != null) {
        dt = now.difference(_lastFrameTime!).inMicroseconds / 1000000.0;
      }
      _lastFrameTime = now;

      if (gameState.status == GameStatus.playing) {
        gameState.updateProgress(dt);
      }

      _runAnimationTimer += dt;
      if (_runAnimationTimer > 0.15) {
        _runAnimationTimer = 0;
        _runFrame = (_runFrame + 1) % 3;
      }

      _chaosTimer += dt;
      final double chaosThreshold = 15.0 + _random.nextInt(5);
      if (_chaosTimer > chaosThreshold) {
        _chaosTimer = 0;
        // ONLY trigger chaos in normal play
        if (gameState.status == GameStatus.playing &&
            gameState.activeStaffEvent == null) {
          final type = StaffEventType
              .values[_random.nextInt(StaffEventType.values.length)];
          gameState.triggerStaffEvent(type);
        }
      }

      if (_isJumping || _playerY > 0) {
        double gravityAccel = -_cachedScreenHeight * 4.5;
        _playerY += _verticalVelocity * dt;
        _verticalVelocity += gravityAccel * dt;
        if (_playerY <= 0) {
          _playerY = 0;
          _verticalVelocity = 0;
          _isJumping = false;
          _jumpCount = 0;
        }
      }

      if (gameState.status == GameStatus.bonusRound &&
          gameState.currentBonusType == BonusRoundType.eggCatch) {
        _bonusRoundTimer += dt;

        // Background Character & Bird Animations
        _bgAnimTimer += dt;
        if (_bgAnimTimer > 0.2) {
          _bgAnimTimer = 0;
          _bgAnimFrameDog = (_bgAnimFrameDog % 4) + 1;
          _bgAnimFrameChicken = (_bgAnimFrameChicken % 2) + 1;
          _bgAnimFrameBird = (_bgAnimFrameBird % 2) + 1;
        }

        // Bird movement
        _bird1X += 0.4 * dt; // L-to-R
        if (_bird1X > 1.2) _bird1X = -0.2;
        _bird2X -= 0.35 * dt; // R-to-L
        if (_bird2X < -0.2) _bird2X = 1.2;

        // Apply hold-to-move acceleration
        if (_moveDirection != 0) {
          double accel = screenSize.width * 8.0;
          _horizontalVelocity += _moveDirection * accel * dt;
          // Clamp velocity
          double maxVel = screenSize.width * 1.5;
          if (_horizontalVelocity.abs() > maxVel) {
            _horizontalVelocity = _horizontalVelocity.sign * maxVel;
          }
        } else {
          // Friction/Deceleration
          _horizontalVelocity *= 0.85;
        }

        _playerXOffset += _horizontalVelocity * dt;
        double minX = -0.2 * screenSize.width;
        double maxX = 0.6 * screenSize.width;
        if (_playerXOffset < minX) {
          _playerXOffset = minX;
          _horizontalVelocity = 0;
        } else if (_playerXOffset > maxX) {
          _playerXOffset = maxX;
          _horizontalVelocity = 0;
        }
      } else {
        _playerXOffset = 0;
        _bonusRoundTimer = 0; // Reset timer when NOT in bonus round
      }

      // Update Chicken Surprise Timers
      for (int i = 0; i < 5; i++) {
        if (_chickenSurpriseTimers[i] > 0) {
          _chickenSurpriseTimers[i] -= dt;
        }
      }

      // Check for new eggs to trigger surprise
      for (var obs in _obstacleManager.obstacles) {
        if (obs.type == ObstacleType.egg && obs.y > 0.8) {
          int idx = obs.variant;
          if (idx >= 0 && idx < 5 && _chickenLastEggIds[idx] != obs.id) {
            _chickenSurpriseTimers[idx] = 0.5; // Show surprise for 0.5s
            _chickenLastEggIds[idx] = obs.id;
          }
        }
      }

      setState(() {
        double currentRunSpeed = (gameState.status == GameStatus.bonusRound &&
                gameState.currentBonusType == BonusRoundType.eggCatch)
            ? 0.0
            : gameState.runSpeed;

        _obstacleManager.update(
          dt,
          currentRunSpeed,
          gameState.currentLevel,
          gameState.status == GameStatus.bonusRound,
          (obs) => _handleCollision(obs, gameState),
          screenSize: screenSize,
          bonusTimeElapsed: _bonusRoundTimer,
        );
        _sceneryManager.update(
          dt,
          currentRunSpeed,
          gameState.currentLevel,
        );
        _updateFloatingScores(dt);
      });

      for (var obs in _obstacleManager.obstacles) {
        double obsPixelWidth = obs.width * _cachedScreenHeight;
        double obsPixelHeight = obs.height * _cachedScreenHeight;
        double obsPixelX = obs.x * _cachedScreenWidth;
        double obsPixelY = obs.y * _cachedScreenHeight;
        double verticalOffset =
            _getObstacleVerticalOffset(obs, _cachedScreenHeight);
        double obsPaddingX = _getObstaclePaddingX(obs, obsPixelWidth);
        double obsPaddingY = _getObstaclePaddingY(obs, obsPixelHeight);

        double obsLeft = obsPixelX + obsPaddingX;
        double obsRight = obsPixelX + obsPixelWidth - obsPaddingX;
        double obsBottom = obsPixelY - verticalOffset + obsPaddingY;
        double obsTop =
            obsPixelY - verticalOffset + obsPixelHeight - obsPaddingY;

        double playerLeft =
            (_cachedPlayerBaseX + _playerXOffset) + _cachedPlayerPadding;
        double playerRight = (_cachedPlayerBaseX + _playerXOffset) +
            _cachedPlayerSize -
            _cachedPlayerPadding;
        double playerBottom = _playerY + (_cachedPlayerSize * 0.1);
        double playerTop =
            _playerY + _cachedPlayerSize - (_cachedPlayerSize * 0.2);

        bool xOverlap = (obsLeft < playerRight) && (obsRight > playerLeft);
        bool yOverlap = (playerBottom < obsTop) && (playerTop > obsBottom);

        if (xOverlap && yOverlap && !obs.hasEngaged) {
          _handleCollision(obs, gameState);
          if (gameState.status == GameStatus.quiz) break;
        }
      }
    } catch (e, stack) {
      CrashReportService().logError(
          message: 'GameLoopCrash: $e',
          stackTrace: stack.toString(),
          level: 'critical',
          context: 'GameLoopScreen');
    }
  }

  void _handleCollision(Obstacle obs, GameState gameState) {
    if (obs.type == ObstacleType.bench) return;
    obs.hasEngaged = true;

    if (obs.type == ObstacleType.goldenBook) {
      if (gameState.status == GameStatus.bonusRound) {
        // Immediate collection in bonus round
        obs.isCollected = true;
        AudioService().playPowerup();
        gameState.addScore(50);
        _spawnFloatingScore(50);
      } else {
        gameState.startQuiz();
        _showQuiz(gameState, obs, obstacleType: obs.type, reward: 50);
      }
    } else if (obs.type == ObstacleType.burger ||
        obs.type == ObstacleType.apple ||
        obs.type == ObstacleType.banana) {
      if (gameState.status == GameStatus.bonusRound) {
        // Immediate collection in bonus round
        obs.isCollected = true;
        AudioService().playPowerup();
        gameState.addScore(10);
        _spawnFloatingScore(10);
      } else {
        gameState.startQuiz();
        _showQuiz(gameState, obs, obstacleType: obs.type, reward: 10);
      }
    } else if (obs.type == ObstacleType.egg) {
      obs.isCollected = true;
      AudioService().playPowerup();
      gameState.addScore(10);
      _spawnFloatingScore(10);
    } else {
      if (!gameState.isInvincible) {
        AudioService().playBonk();
        gameState.takeDamage();
        setState(() => _isCrashed = true);
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() => _isCrashed = false);
        });
      }
    }
  }

  void _showQuiz(GameState gameState, Obstacle obs,
      {required ObstacleType obstacleType, int reward = 10}) {
    final challenge = gameState.currentChallenge ??
        Challenge(
            id: 'fallback_math',
            topic: 'Math',
            gradeLevel: 1,
            questions: [
              QuizQuestion(
                  id: 'q_fallback_1',
                  questionText: 'What is 5 + 5?',
                  options: ['10', '12', '8', '20'],
                  correctOptionIndex: 0)
            ]);
    final question = gameState.getNextQuestion();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => QuizOverlay(
        challenge: challenge,
        question: question,
        onAnswered: (isCorrect) {
          Navigator.pop(context);
          if (isCorrect) {
            AudioService().playPowerup();
            gameState.addScore(reward);
            if (obstacleType == ObstacleType.goldenBook) {
              gameState.setInvincible(true);
            }
            obs.isCollected = true;
            _spawnFloatingScore(reward);
          } else {
            AudioService().playBonk();
          }
          gameState.recordQuizResult(challenge.id, isCorrect);
          gameState.resumeGame();
        },
      ),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    final gameState = context.read<GameState>();
    final screenSize = MediaQuery.sizeOf(context);
    if (gameState.status == GameStatus.bonusRound &&
        gameState.currentBonusType == BonusRoundType.eggCatch) {
      if (details.localPosition.dx < screenSize.width / 2) {
        _moveDirection = -1;
      } else {
        _moveDirection = 1;
      }
    } else {
      _jump();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _moveDirection = 0;
  }

  void _handleTapCancel() {
    _moveDirection = 0;
  }

  void _jump() {
    final gameState = context.read<GameState>();
    if (gameState.status != GameStatus.playing) return;
    if (_jumpCount < _maxJumps) {
      AudioService().playJump();
      setState(() {
        _verticalVelocity = _cachedScreenHeight * 1.95;
        _isJumping = true;
        _jumpCount++;
      });
    }
  }

  double _getObstaclePaddingX(Obstacle obs, double width) {
    if (obs.type == ObstacleType.goldenBook) return width * 0.15;
    switch (obs.type) {
      case ObstacleType.puddle:
      case ObstacleType.gymMat:
      case ObstacleType.wildFlowers:
        return width * 0.05;
      case ObstacleType.apple:
      case ObstacleType.banana:
      case ObstacleType.burger:
        return width * 0.05;
      default:
        return width * 0.25;
    }
  }

  double _getObstaclePaddingY(Obstacle obs, double height) {
    if (obs.type == ObstacleType.goldenBook) return height * 0.15;
    switch (obs.type) {
      case ObstacleType.puddle:
      case ObstacleType.gymMat:
        return height * 0.05;
      case ObstacleType.apple:
      case ObstacleType.banana:
      case ObstacleType.burger:
        return height * 0.05;
      default:
        return height * 0.20;
    }
  }

  double _getObstacleVerticalOffset(Obstacle obs, double screenHeight) {
    if (obs.type == ObstacleType.bench) return screenHeight * 0.03;
    if (obs.type == ObstacleType.log) return screenHeight * 0.03;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final screenSize = MediaQuery.sizeOf(context);
    _groundHeight = screenSize.height * FayColors.kGroundHeightRatio;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ernie_run.png', width: 120),
              const SizedBox(height: 32),
              const Text("PREPARING LEVEL...",
                  style: TextStyle(color: Colors.blue, fontSize: 18)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Stack(
            children: [
              GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: Stack(
                  children: [
                    if (gameState.status == GameStatus.bonusRound &&
                        gameState.currentBonusType == BonusRoundType.eggCatch)
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/${Assets.chickenCoopBg}',
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      ParallaxBackground(
                        runSpeed: gameState.runSpeed,
                        isPaused: gameState.status != GameStatus.playing,
                        screenHeight: screenSize.height,
                        level: gameState.currentLevel,
                      ),

                    // Eggs rendered behind characters
                    ..._obstacleManager.obstacles.map((obs) {
                      double verticalOffset =
                          _getObstacleVerticalOffset(obs, screenSize.height);
                      return Positioned(
                        left: obs.x * screenSize.width,
                        bottom: _groundHeight -
                            FayColors.kHorizonOverlap +
                            (obs.y * screenSize.height) -
                            verticalOffset,
                        width: obs.width * screenSize.height,
                        height: obs.height * screenSize.height,
                        child: _buildObstacleWidget(obs),
                      );
                    }),

                    if (gameState.status == GameStatus.bonusRound &&
                        gameState.currentBonusType ==
                            BonusRoundType.eggCatch) ...[
                      // Stationary Background Chickens (Animated, Spread on ground)
                      Positioned(
                        bottom: _groundHeight - FayColors.kHorizonOverlap - 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: screenSize.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(5, (index) {
                                final variants = ["", "c", "b", "w", ""];
                                String variant =
                                    variants[index % variants.length];
                                int frame =
                                    _chickenSurpriseTimers[index] > 0 ? 2 : 1;
                                return Image.asset(
                                  'assets/images/${Assets.chickenSprite(variant, frame)}',
                                  height: 80,
                                  fit: BoxFit.contain,
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      // Stationary Background Dog (Animated, Left)
                      Positioned(
                        left: screenSize.width * 0.05,
                        bottom: _groundHeight - FayColors.kHorizonOverlap - 15,
                        child: Image.asset(
                          'assets/images/${Assets.bgCharacter("dog", _bgAnimFrameDog)}',
                          height: 80,
                        ),
                      ),
                      // Flying Bird 1 (L-to-R)
                      Positioned(
                        left: _bird1X * screenSize.width,
                        top: screenSize.height * 0.25,
                        child: Image.asset(
                          'assets/images/${Assets.bgCharacter("bird", _bgAnimFrameBird)}',
                          height: 40,
                        ),
                      ),
                      // Flying Bird 2 (R-to-L)
                      Positioned(
                        left: _bird2X * screenSize.width,
                        top: screenSize.height * 0.40,
                        child: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            'assets/images/${Assets.bgCharacter("bird", _bgAnimFrameBird)}',
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                    ..._sceneryManager.objects.map((obj) {
                      String baseName = obj.type.name;
                      int frame = obj.currentFrame;
                      if (obj.type == SceneryType.dogStanding) frame += 2;
                      String assetName = Assets.bgCharacter(baseName, frame);
                      double charSize = (obj.type == SceneryType.boy ||
                              obj.type == SceneryType.girl ||
                              obj.type == SceneryType.janitor)
                          ? screenSize.height * 0.34
                          : screenSize.height * 0.19;
                      return Positioned(
                        left: obj.x * screenSize.width,
                        bottom: _groundHeight -
                            FayColors.kHorizonOverlap +
                            (obj.y * screenSize.height),
                        width: charSize,
                        height: charSize,
                        child: Image.asset('assets/images/$assetName',
                            fit: BoxFit.contain),
                      );
                    }),
                    AmbientEffects(level: gameState.currentLevel),
                    Positioned(
                      left: screenSize.width * 0.30 + _playerXOffset,
                      bottom: _groundHeight -
                          FayColors.kHorizonOverlap -
                          15 +
                          _playerY, // Lowered
                      child: PlayerCharacter(
                        isJumping: _isJumping,
                        isInvincible: gameState.isInvincible,
                        isCrashed: _isCrashed,
                        runFrame: _runFrame,
                        size: screenSize.height * 0.21,
                      ),
                    ),
                    ..._floatingScores.map((fs) => Positioned(
                          left: fs.x,
                          bottom: fs.y + (fs.animationTime * 100),
                          child: Text('+${fs.amount}',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold)),
                        )),
                    if (gameState.activeStaffEvent != null &&
                        gameState.status != GameStatus.bonusRound)
                      AnimatedStaffChaos(event: gameState.activeStaffEvent!),

                    // RESTORED HUD
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Score
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Score: ${gameState.score}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              // Lives
                              Row(
                                children: List.generate(
                                    5,
                                    (i) => Icon(
                                          i < gameState.lives
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 18, // Compact hearts
                                        )),
                              ),
                              // Pause Button
                              IconButton(
                                icon: const Icon(Icons.pause_circle,
                                    color: Colors.white, size: 36),
                                onPressed: () => gameState.pauseGame(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: gameState.levelProgress,
                              minHeight: 12,
                              backgroundColor: Colors.white24,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (gameState.status == GameStatus.paused)
                      Container(
                          color: Colors.black54,
                          child: Center(
                              child: ElevatedButton(
                                  onPressed: () =>
                                      context.read<GameState>().resumeGame(),
                                  child: const Text("RESUME")))),
                    if (gameState.status == GameStatus.levelComplete)
                      Container(
                        color: Colors.black87,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("LEVEL COMPLETE!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () {
                                  _obstacleManager.clear();
                                  _sceneryManager.clear();
                                  setState(() => _isLoading = true);
                                  gameState.startNextLevel();
                                  _loadAssets();
                                },
                                child: const Text("CONTINUE GAME",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("EXIT LEVEL",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (gameState.status == GameStatus.gameOver)
                      Container(
                          color: Colors.black87,
                          child: Center(
                              child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("GAME OVER - RETURN")))),
                  ],
                ),
              ),

              // Orientation Warning Overlay
              if (isPortrait && kIsWeb)
                Positioned.fill(
                  child: Material(
                    color: FayColors.navy,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ernie_run.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'PLEASE ROTATE YOUR DEVICE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'BubblegumSans',
                              fontSize: 28,
                              color: FayColors.gold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'ERNIE RUNS BEST IN LANDSCAPE!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'BubblegumSans',
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 48),
                          const Icon(
                            Icons.screen_rotation,
                            color: Colors.white54,
                            size: 64,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildObstacleWidget(Obstacle obs) {
    if (obs.isCollected) return const SizedBox.shrink();

    // Use Assets class more consistently
    if (obs.type == ObstacleType.egg) {
      return Image.asset('assets/images/${Assets.eggSprite(obs.isCracked)}',
          errorBuilder: (c, e, s) =>
              const Icon(Icons.egg, color: Colors.white));
    }
    if (obs.type == ObstacleType.goldenBook) {
      return Image.asset('assets/images/${Assets.itemGoldenBook}');
    }

    // Handle generic obstacles with possible variants
    String assetName;
    switch (obs.type) {
      case ObstacleType.burger:
        assetName =
            'obstacles/obstacle_burger_${obs.variant == 0 ? 1 : obs.variant}.png';
        break;
      case ObstacleType.apple:
        assetName = 'obstacles/obstacle_apple.png';
        break;
      case ObstacleType.banana:
        assetName = 'obstacles/obstacle_banana.png';
        break;
      case ObstacleType.food:
        assetName = 'obstacles/obstacle_food.png';
        break;
      case ObstacleType.hydrant:
      case ObstacleType.trashCan:
      case ObstacleType.bench:
      case ObstacleType.tire:
      case ObstacleType.flowerPot:
      case ObstacleType.gnome:
      case ObstacleType.basketBall:
      case ObstacleType.soccerBall:
      case ObstacleType.gymMat:
      case ObstacleType.lunchTray:
      case ObstacleType.milkCarton:
      case ObstacleType.wildFlowers:
        // Proper multi-variant loading
        String base = obs.type.name;
        // Convert camelCase to snake_case for filename if needed?
        // No, current filenames are obstacle_hydrant_1.png etc.
        // obs.type.name is 'hydrant'.
        // We need 'obstacle_hydrant_1.png'
        String snakeName = base.replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => '_${match.group(1)!.toLowerCase()}');
        int v = (obs.variant == 0) ? 1 : (obs.variant > 2 ? 1 : obs.variant);
        assetName = 'obstacles/obstacle_$snakeName' + '_' + '$v.png';
        break;
      default:
        assetName = 'obstacles/obstacle_${obs.type.name}.png';
    }

    return Image.asset('assets/images/$assetName',
        errorBuilder: (c, e, s) => const SizedBox());
  }
}

class FloatingScore {
  final int amount;
  final double x;
  final double y;
  double animationTime = 0;
  FloatingScore({required this.amount, required this.x, required this.y});
}
