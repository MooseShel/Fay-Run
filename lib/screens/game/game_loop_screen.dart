import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_state.dart';
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
  double _distanceRun = 0;
  // double _chaosTimer = 0;
  final Random _random = Random();

  // Animation State
  bool _isCrashed = false;
  int _runFrame = 0;
  double _runAnimationTimer = 0;

  // Frame-rate Independence
  DateTime? _lastFrameTime;

  // Floating Score Logic
  final List<FloatingScore> _floatingScores = [];

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
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )
      ..addListener(_gameLoop)
      ..repeat();

    // Defers loading until context is ready to safely use precacheImage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAssets();
    });
  }

  // Cache screen dimensions to avoid recalculation every frame
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
      // Normalizing based on Height (which is the stable vertical dimension)
      _cachedPlayerSize = size.height * 0.25; // Sized up for better reach
      _cachedPlayerPadding = _cachedPlayerSize * 0.15;
      _cachedPlayerBaseX = size.width * 0.25;
      debugPrint(
          'Please resize cache: $_cachedScreenWidth x $_cachedScreenHeight');
    }
  }

  Future<void> _loadAssets() async {
    final startTime = DateTime.now();
    debugPrint('🎬 Starting optimized level loading...');

    try {
      final state = context.read<GameState>();
      final level = state.currentLevel;

      // UX goal: 4 seconds "Preparing Level" screen to ensure assets (images/sound) are fully loaded
      final minDelayFuture = Future.delayed(const Duration(milliseconds: 4000));

      // 1. Ensure essential assets are loaded (likely already done in StudentSelect)
      final essentialPreload = AssetManager().precacheEssentialAssets(context);

      // 2. Precache current level background (others preloaded in MainMenu)
      final bgPreload = AssetManager().precacheLevelAssets(context, level);

      // 3. Audio - Play BGM early to mask loading
      AudioService().playBGM(level);

      // 4. Data
      await state.loadChallenge();

      // Wait for visuals to be ready and min delay
      await Future.wait([minDelayFuture, essentialPreload, bgPreload]);

      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      debugPrint('🏁 Optimized loading finished in ${elapsed}ms');
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
    AudioService().stopBGM(); // Stop music on exit
    super.dispose();
  }

  void _gameLoop() {
    if (_isLoading) return;

    try {
      final gameState = context.read<GameState>();
      final screenSize = MediaQuery.sizeOf(context);

      // Stability Fix: Prevent layout crashes if context/screen is not ready
      if (screenSize.width <= 0 || screenSize.height <= 0) return;

      // Level Transition Logic: Clear obstacles when the level changes
      if (_lastLevel != null && _lastLevel != gameState.currentLevel) {
        _obstacleManager.clear();
        _sceneryManager.clear();
        _distanceRun = 0;
      }
      _lastLevel = gameState.currentLevel;

      if (gameState.status != GameStatus.playing) {
        _lastFrameTime = null; // Reset when not playing
        return;
      }

      // 0. Timers & Progression - Calculate Delta Time
      // 0. Timers & Progression - Calculate Delta Time
      final now = DateTime.now();
      double dt = 0.016;
      if (_lastFrameTime != null) {
        dt = now.difference(_lastFrameTime!).inMicroseconds / 1000000.0;
      }
      _lastFrameTime = now;

      if (gameState.status == GameStatus.playing) {
        // NORMALIZATION: Speed is logical units per second relative to Height
        // Convert to relative X units (as a fraction of screen width)
        double logicalWidth = _cachedScreenWidth / _cachedScreenHeight;
        double speedX = (gameState.runSpeed * 1.5 * dt) / logicalWidth;
        _distanceRun += speedX * 100; // Multiplier for progress tracking scale
      }

      // Score based on distance
      if (gameState.status == GameStatus.playing) {
        // Add roughly 60 points per second if runSpeed is ~3.0
        gameState.addScore(
            ((gameState.runSpeed / 3.0) * 60 * dt).round().clamp(0, 10));

        // Update Floating Scores
        for (var fs in _floatingScores) {
          fs.animationTime += dt * 2.0; // Speed of animation
        }
        _floatingScores.removeWhere((fs) => fs.animationTime >= 1.0);
      }

      // _chaosTimer += dt;

      // Run Animation
      _runAnimationTimer += dt;
      if (_runAnimationTimer > 0.15) {
        // Back to 0.15 for better feel at 3.0 speed
        _runAnimationTimer = 0;
        _runFrame = (_runFrame + 1) % 3;
      }

      // Level Completion
      // Fix: Use BASE speed for target calculation so temporary speed changes don't shorten/lengthen the level dynamically.
      // Base Speed Formula matches GameState._resetLevelPhysics: (4.0 + (level * 0.2)) * 1.1
      final double baseSpeed = (4.0 + (gameState.currentLevel * 0.2)) * 1.1;

      // Target 120 seconds duration: BaseSpeed * 1200 (since distance is Speed * 10 * Time)
      // Calculation matches the new scaled _distanceRun logic
      final targetDistance = baseSpeed * 12000;

      if (_distanceRun > targetDistance) {
        _distanceRun = 0;
        gameState.completeLevel();
        AudioService().stopBGM();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Level ${gameState.currentLevel} Complete!'),
            duration: const Duration(seconds: 1),
          ),
        );
      }

      // Chaos Threshold
      /*
      // Chaos Threshold
      final double chaosThreshold = kDebugMode
          ? 10.0
          : (gameState.currentLevel >= 6
              ? 35.0 + _random.nextInt(15)
              : 20.0 + _random.nextInt(10));
      */

      /*
      if (_chaosTimer > chaosThreshold) {
        _chaosTimer = 0;
        if (gameState.activeStaffEvent == null) {
          gameState.triggerStaffChaos();
        }
      }
      */

      // 1. Physics Update (Applying dt to gravity and velocity)
      if (_isJumping || _playerY > 0) {
        // NORMALIZATION: Gravity relative to ScreenHeight
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

      // Performance Optimization: Consolidate state updates into one setState call
      try {
        setState(() {
          // 2. Obstacle Update
          _obstacleManager.update(
            dt,
            gameState.runSpeed,
            gameState.currentLevel,
            gameState.status == GameStatus.bonusRound,
            (obs) => _handleCollision(obs, gameState),
            screenSize: screenSize,
          );

          // 3. Scenery Update
          _sceneryManager.update(
            dt,
            gameState.runSpeed,
            gameState.currentLevel,
          );

          // 4. Floating Scores
          _updateFloatingScores(dt);
        });
      } catch (e, stack) {
        debugPrint('Error in GameLoop update: $e');
        // Prevent flooding logs
        if (_random.nextDouble() < 0.01) {
          debugPrint(stack.toString());
        }
      }

      /*
      final screenSize = MediaQuery.sizeOf(context);

      // Stability Fix: Prevent layout crashes if context/screen is not ready
      if (screenSize.width <= 0 || screenSize.height <= 0) return;
      */

      for (var obs in _obstacleManager.obstacles) {
        bool isGoldenBook = obs.type == ObstacleType.goldenBook;

        // Convert relative coordinates to pixels for accurate collision
        // All dimensions (width/height) are now relative to Screen Height
        // Use cached pixel values
        double obsPixelWidth = obs.width * _cachedScreenHeight;
        double obsPixelHeight = obs.height * _cachedScreenHeight;
        double obsPixelX = obs.x * _cachedScreenWidth;
        double obsPixelY = obs.y * _cachedScreenHeight;

        double verticalOffset =
            _getObstacleVerticalOffset(obs, _cachedScreenHeight);

        double obsPaddingX =
            isGoldenBook ? obsPixelWidth * 0.15 : obsPixelWidth * 0.20;
        double obsPaddingY =
            isGoldenBook ? obsPixelHeight * 0.15 : obsPixelHeight * 0.20;

        double obsLeft = obsPixelX + obsPaddingX;
        double obsRight = obsPixelX + obsPixelWidth - obsPaddingX;
        double obsBottom = obsPixelY - verticalOffset + obsPaddingY;
        double obsTop =
            obsPixelY - verticalOffset + obsPixelHeight - obsPaddingY;

        // Player Hitbox (Cached)
        double playerLeft = _cachedPlayerBaseX + _cachedPlayerPadding;
        double playerRight =
            _cachedPlayerBaseX + _cachedPlayerSize - _cachedPlayerPadding;

        double playerBottom =
            _playerY + (_cachedPlayerSize * 0.1); // Slightly lower
        double playerTop =
            _playerY + _cachedPlayerSize - (_cachedPlayerSize * 0.2);

        // X overlap
        bool xOverlap = (obsLeft < playerRight) && (obsRight > playerLeft);

        // Y overlap
        bool yOverlap = (playerBottom < obsTop) && (playerTop > obsBottom);

        if (xOverlap && yOverlap && !obs.hasEngaged) {
          _handleCollision(obs, gameState);
          // CRITICAL: Stop processing other collisions if the first one triggers a quiz
          if (gameState.status == GameStatus.quiz) {
            break;
          }
        }
      }
    } catch (e, stack) {
      CrashReportService().logError(
        message: 'GameLoopCrash: $e',
        stackTrace: stack.toString(),
        level: 'critical',
        context: 'GameLoopScreen',
      );
    }
  }

  void _handleCollision(Obstacle obs, GameState gameState) {
    obs.hasEngaged = true; // Prevent multi-trigger

    if (obs.type == ObstacleType.goldenBook) {
      gameState.startQuiz();
      _showQuiz(gameState, obs,
          obstacleType: obs.type, reward: 200); // Double Reward
    } else if (obs.type == ObstacleType.burger ||
        obs.type == ObstacleType.apple ||
        obs.type == ObstacleType.banana) {
      gameState.startQuiz();
      _showQuiz(gameState, obs,
          obstacleType: obs.type, reward: 100); // Standard Reward
    } else {
      // obs.isCollected = true; // Regular obstacles no longer disappear on hit
      if (!gameState.isInvincible) {
        AudioService().playBonk();
        gameState.takeDamage();

        // Trigger crash animation
        setState(() {
          _isCrashed = true;
        });

        // Reset crash state after 500ms
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _isCrashed = false;
            });
          }
        });
      }
    }
  }

  void _showQuiz(GameState gameState, Obstacle obs,
      {required ObstacleType obstacleType, int reward = 100}) {
    // Use loaded challenge or fallback to a default one
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
              correctOptionIndex: 0,
            ),
            QuizQuestion(
              id: 'q_fallback_2',
              questionText: 'What is 10 - 3?',
              options: ['7', '6', '5', '4'],
              correctOptionIndex: 0,
            ),
            QuizQuestion(
              id: 'q_fallback_3',
              questionText: 'What is 3 x 3?',
              options: ['9', '6', '12', '15'],
              correctOptionIndex: 0,
            ),
          ],
        );

    // Get Unique Question or Random from fallback
    final question = gameState.getNextQuestion();

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.7), // Darker overlay
      builder: (context) => QuizOverlay(
        challenge: challenge,
        question: question,
        onAnswered: (isCorrect) {
          Navigator.pop(context); // Close dialog
          if (isCorrect) {
            AudioService().playPowerup();
            gameState.addScore(reward);

            // Only grant invincibility for Golden Books
            if (obstacleType == ObstacleType.goldenBook) {
              gameState.setInvincible(true);
            }

            obs.isCollected = true; // Disappear ONLY if correct

            // Spawn Floating Text
            _spawnFloatingScore(reward);
          }
          // No haptic feedback or penalties for incorrect answers

          // submit result to backend
          gameState.recordQuizResult(challenge.id, isCorrect);

          gameState.resumeGame();
        },
      ),
    );
  }

  void _jump() {
    final gameState = context.read<GameState>();

    // Fix: Block jump input if not playing (exactly playing)
    if (gameState.status != GameStatus.playing) {
      return;
    }

    if (_jumpCount < _maxJumps) {
      if (gameState.status == GameStatus.playing) {
        AudioService().playJump();
      }
      setState(() {
        // NORMALIZATION: Jump velocity relative to Height
        _verticalVelocity = _cachedScreenHeight * 1.95;
        _isJumping = true;
        _jumpCount++;
      });
    }
  }

  double _getObstacleVerticalOffset(Obstacle obs, double screenHeight) {
    // Regular obstacles should sit exactly on the ground line
    double offset = 0.0;

    if (obs.type == ObstacleType.car && obs.direction == 1.0) {
      // Left-to-Right cars are in the nearer lane (closer to camera), need more drop
      offset = screenHeight * 0.06;
    } else if (obs.type == ObstacleType.bench) {
      // Benches were floating, lowering them by 3% of screen height
      offset = screenHeight * 0.03;
    } else if (obs.type == ObstacleType.log) {
      // Logs have grass decoration at bottom of sprite, need offset to ground the log body
      offset = screenHeight * 0.03;
    }

    return offset;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final screenSize = MediaQuery.sizeOf(context);
    _groundHeight = screenSize.height *
        FayColors.kGroundHeightRatio; // Dynamic ground height
    final double baseSpeed = (4.0 + (gameState.currentLevel * 0.2)) * 1.1;
    final double targetDistance = baseSpeed * 12000;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ernie_run.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 32),
              const SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Color(0xFFE3F2FD),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "PREPARING LEVEL...",
                style: TextStyle(
                  fontFamily: 'BubblegumSans',
                  color: Colors.blue,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: _jump,
        child: Stack(
          children: [
            ParallaxBackground(
              runSpeed: gameState.runSpeed,
              isPaused: gameState.status != GameStatus.playing,
              screenHeight: screenSize.height,
              level: gameState.currentLevel,
            ),

            // Background Scenery
            ..._sceneryManager.objects.map((obj) {
              String assetName = '';
              String baseName = '';
              switch (obj.type) {
                case SceneryType.boy:
                  baseName = 'boy';
                  break;
                case SceneryType.girl:
                  baseName = 'girl';
                  break;
                case SceneryType.dogSitting:
                  baseName = 'dog';
                  // dog_1 and dog_2 are sitting/blinking
                  break;
                case SceneryType.dogStanding:
                  baseName = 'dog';
                  // dog_3 and dog_4 are standing/blinking
                  break;
                case SceneryType.squirrel:
                  baseName = 'squirrel';
                  break;
                case SceneryType.janitor:
                  baseName = 'janitor';
                  break;
                case SceneryType.butterfly:
                  baseName = 'butterfly';
                  break;
                case SceneryType.bird:
                  baseName = 'bird';
                  break;
                case SceneryType.chicken:
                  baseName = 'chicken';
                  break;
              }

              int frame = obj.currentFrame;
              if (obj.type == SceneryType.dogStanding) {
                frame += 2; // dog_3, dog_4
              }

              assetName = Assets.bgCharacter(baseName, frame);

              // Dynamic scaling based on type
              double charSize = screenSize.height * 0.19; // Increased from 0.16
              if (obj.type == SceneryType.boy ||
                  obj.type == SceneryType.girl ||
                  obj.type == SceneryType.janitor) {
                charSize = screenSize.height * 0.34; // Increased from 0.28
              }

              // Vertical Offset for specific characters (Horizon alignment)
              // They should sit exactly on the ground line now that it is synchronized
              double verticalOffset = 0.0;

              return Positioned(
                left: obj.x * screenSize.width,
                // Align to top edge of walking area (Horizon)
                bottom: _groundHeight -
                    FayColors.kHorizonOverlap +
                    verticalOffset +
                    (obj.y * screenSize.height),
                width: charSize,
                height: charSize,
                child: RepaintBoundary(
                  child: Image.asset(
                    'assets/images/$assetName',
                    fit: BoxFit.contain,
                    cacheHeight: charSize.toInt(), // Memory Optimization
                  ),
                ),
              );
            }),

            // 4. Ambient Effects (Level-specific particles)
            AmbientEffects(level: gameState.currentLevel),

            ..._obstacleManager.obstacles.map(
              (obs) {
                // Background perspective correction
                // Road lanes require objects to be slightly lower to look grounded
                double verticalOffset =
                    _getObstacleVerticalOffset(obs, screenSize.height);

                return Positioned(
                  left: obs.x * screenSize.width,
                  bottom: _groundHeight -
                      FayColors.kHorizonOverlap +
                      (obs.y * screenSize.height) -
                      verticalOffset,
                  width: obs.width * screenSize.height, // Use Height as base
                  height: obs.height * screenSize.height,
                  child: RepaintBoundary(
                    child: _buildObstacleWidget(obs),
                  ),
                );
              },
            ),

            Positioned(
              left: screenSize.width * 0.30,
              bottom: _groundHeight - FayColors.kHorizonOverlap + _playerY,
              child: PlayerCharacter(
                isJumping: _isJumping,
                isInvincible: gameState.isInvincible,
                isCrashed: _isCrashed,
                runFrame: _runFrame,
                size: screenSize.height * 0.21, // Increased from 0.18
              ),
            ),

            // Floating Scores
            ..._floatingScores.map((fs) => Positioned(
                  left: fs.x,
                  bottom: fs.y + (fs.animationTime * 100), // Float up
                  child: Text(
                    '+${fs.amount}',
                    style: TextStyle(
                      fontFamily: 'BubblegumSans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: FayColors.gold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                )),

            // Staff Chaos - Animated center screen appearance
            if (gameState.activeStaffEvent != null)
              AnimatedStaffChaos(event: gameState.activeStaffEvent!),

            // Premium Game HUD
            Positioned(
              top: MediaQuery.paddingOf(context).top + 10,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lives Display
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          children: List.generate(5, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                index < gameState.lives
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: FayColors.brickRed,
                                size: 24,
                              ),
                            );
                          }),
                        ),
                      ),
                      // Level Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: FayColors.navy.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: FayColors.gold, width: 2),
                        ),
                        child: Text(
                          'LEVEL ${gameState.currentLevel}',
                          style: const TextStyle(
                            color: FayColors.gold,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      // Score Display
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: TweenAnimationBuilder<int>(
                          duration: const Duration(milliseconds: 500),
                          tween: IntTween(begin: 0, end: gameState.score),
                          builder: (context, value, child) {
                            return Text(
                              value.toString().padLeft(6, '0'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'BubblegumSans',
                                fontSize: 24,
                                letterSpacing: 2,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Progress Bar
                  Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      // Track
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white10),
                        ),
                      ),
                      // Progress Fill
                      FractionallySizedBox(
                        widthFactor:
                            (_distanceRun / targetDistance).clamp(0.001, 1.0),
                        child: Container(
                          height: 16,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [FayColors.gold, Color(0xFFFFD54F)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: FayColors.gold.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animated Gator Marker
                      Positioned(
                        left: (screenSize.width - 40) *
                                (_distanceRun / targetDistance)
                                    .clamp(0.0, 1.0) -
                            20,
                        top: -12,
                        child: Image.asset(
                          'assets/images/ernie_run.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(top: 40, left: 20, child: _buildHUD(gameState)),

            // Pause Button
            if (gameState.status == GameStatus.playing)
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.pause,
                    color: FayColors.navy,
                    size: 32,
                  ),
                  onPressed: () => context.read<GameState>().pauseGame(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),

            // 6. Pause/Menu Overlay
            if (gameState.status == GameStatus.paused)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'PAUSED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<GameState>().resumeGame(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FayColors.gold,
                          foregroundColor: FayColors.navy,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('RESUME'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Stop music
                          AudioService().stopBGM();
                          // Forfeit score and return to menu
                          context.read<GameState>().forfeitGame();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('EXIT LEVEL'),
                      ),
                    ],
                  ),
                ),
              ),

            // 7. Level Complete Overlay
            if (gameState.status == GameStatus.levelComplete)
              Container(
                color: FayColors.navy.withValues(alpha: 0.9),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school, size: 80, color: FayColors.gold),
                      const SizedBox(height: 20),
                      Text(
                        'Level ${gameState.currentLevel - 1} Complete!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Class Dismissed!',
                        style: TextStyle(color: Colors.white70, fontSize: 20),
                      ),
                      const SizedBox(height: 40),
                      if (gameState.isBonusRoundEarned) ...[
                        Text(
                          'GOLDEN DASH UNLOCKED!',
                          style: TextStyle(
                            color: FayColors.gold,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            _obstacleManager.clear();
                            _sceneryManager.clear();
                            setState(() => _isLoading = true);
                            gameState.startBonusRound();
                            _loadAssets();
                          },
                          icon: const Icon(Icons.flash_on),
                          label: const Text('START GOLDEN DASH'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: FayColors.gold,
                            foregroundColor: FayColors.navy,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            _obstacleManager.clear();
                            _sceneryManager.clear();
                            setState(() => _isLoading = true);
                            gameState.startNextLevel();
                            _loadAssets();
                          },
                          child: const Text(
                            'SKIP TO NEXT CLASS',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ] else
                        ElevatedButton.icon(
                          onPressed: () {
                            _obstacleManager.clear();
                            _sceneryManager.clear();
                            setState(() => _isLoading = true);
                            gameState.startNextLevel();
                            _loadAssets();
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('GO TO NEXT CLASS'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: FayColors.gold,
                            foregroundColor: FayColors.navy,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            // 8. Bonus Round Overlay (HUD)
            if (gameState.status == GameStatus.bonusRound)
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'GOLDEN DASH',
                        style: TextStyle(
                          color: FayColors.gold,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(4, 4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // We can add a progress bar here for the 15s timer
                    ],
                  ),
                ),
              ),

            // 9. Game Over Overlay (HUD)
            if (gameState.status == GameStatus.gameOver)
              Container(
                color: Colors.black87,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Stop music when returning to menu
                          AudioService().stopBGM();
                          Navigator.pop(context); // Go back to menu
                        },
                        child: const Text('RETURN TO MENU'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildObstacleWidget(Obstacle obs) {
    if (obs.isCollected) return const SizedBox.shrink();
    String assetName = '';
    // New assets have _1 and _2, old have nothing and _2.
    // We'll try to build a path and handle fallbacks in the errorBuilder.
    String baseName = '';
    bool useNumericVariant = false;

    switch (obs.type) {
      case ObstacleType.log:
        baseName = 'obstacle_log';
        break;
      case ObstacleType.puddle:
        baseName = 'obstacle_puddle';
        break;
      case ObstacleType.rock:
        baseName = 'obstacle_rock';
        break;
      case ObstacleType.janitorBucket:
        baseName = 'obstacle_bucket';
        break;
      case ObstacleType.books:
        baseName = 'obstacle_books';
        break;
      case ObstacleType.beaker:
        baseName = 'obstacle_bucket';
        break;
      case ObstacleType.flyingPizza:
      case ObstacleType.food:
        baseName = 'obstacle_food';
        break;
      case ObstacleType.car:
        baseName = obs.direction == 1.0 ? 'obstacle_suv_2' : 'obstacle_suv';
        break;
      case ObstacleType.cone:
        baseName = 'obstacle_cone';
        break;
      case ObstacleType.backpack:
        baseName = 'obstacle_backpack';
        break;
      case ObstacleType.trashCan:
        baseName = 'obstacle_trash_can';
        useNumericVariant = true;
        break;
      case ObstacleType.hydrant:
        baseName = 'obstacle_hydrant';
        useNumericVariant = true;
        break;
      case ObstacleType.bench:
        baseName = 'obstacle_bench';
        useNumericVariant = true;
        break;
      case ObstacleType.tire:
        baseName = 'obstacle_tire';
        useNumericVariant = true;
        break;
      case ObstacleType.flowerPot:
        baseName = 'obstacle_flower_pot';
        useNumericVariant = true;
        break;
      case ObstacleType.gnome:
        baseName = 'obstacle_gnome';
        useNumericVariant = true;
        break;
      case ObstacleType.basketBall:
        baseName = 'obstacle_basket_ball';
        useNumericVariant = true;
        break;
      case ObstacleType.soccerBall:
        baseName = 'obstacle_soccer_ball';
        useNumericVariant = true;
        break;
      case ObstacleType.gymMat:
        baseName = 'obstacle_gym_mat';
        useNumericVariant = true;
        break;
      case ObstacleType.apple:
        baseName = 'obstacle_apple';
        break;
      case ObstacleType.banana:
        baseName = 'obstacle_banana';
        break;
      case ObstacleType.burger:
        baseName = 'obstacle_burger';
        useNumericVariant = true;
        break;
      case ObstacleType.lunchTray:
        baseName = 'obstacle_lunch_tray';
        useNumericVariant = true;
        break;
      case ObstacleType.milkCarton:
        baseName = 'obstacle_milk_cart';
        useNumericVariant = true;
        break;
      case ObstacleType.wildFlowers:
        baseName = 'obstacle_wild_flowers';
        useNumericVariant = true;
        break;
      case ObstacleType.goldenBook:
        return Image.asset(
          'assets/images/${Assets.itemGoldenBook}',
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        );
    }

    if (baseName.isEmpty) return const SizedBox();

    String variantSuffix = '';
    if (useNumericVariant) {
      variantSuffix = '_${obs.variant}';
    } else if (obs.variant == 2) {
      variantSuffix = '_2';
    }

    // Try current themed folder first
    assetName = 'assets/images/obstacles/$baseName$variantSuffix.png';

    // Debug print for rewards to ensure path is correct
    if (obs.type == ObstacleType.apple || obs.type == ObstacleType.burger) {
      // debugPrint('Loading asset: $assetName');
    }

    return Image.asset(
      assetName,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Failed to load asset: $assetName, error: $error');
        // Fallback 1: try without variant
        return Image.asset(
          'assets/images/obstacles/$baseName.png',
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          errorBuilder: (c, e, s) {
            debugPrint(
                'Failed to load fallback: assets/images/obstacles/$baseName.png');
            return const SizedBox();
          },
        );
      },
    );
  }

  Widget _buildHUD(GameState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: FayColors.brickRed),
            const SizedBox(width: 8),
            Text(
              'x ${state.lives}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: FayColors.navy,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Score: ${state.score}',
          style: TextStyle(
            fontSize: 20,
            color: FayColors.navy,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.white),
            ],
          ),
        ),
        Text(
          'Level: ${state.currentLevel}',
          style: TextStyle(
            fontSize: 16,
            color: FayColors.navy,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.white),
            ],
          ),
        ),
        if (state.comboCount >= 5)
          Text(
            'COMBO x${(state.comboCount ~/ 5) + 1}',
            style: TextStyle(
              fontSize: 18,
              color: FayColors.gold,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              shadows: const [
                Shadow(
                    offset: Offset(1, 1), blurRadius: 4, color: Colors.black),
              ],
            ),
          ),
      ],
    );
  }
}

class FloatingScore {
  final int amount;
  final double x;
  final double y;
  double animationTime = 0; // 0.0 to 1.0

  FloatingScore({required this.amount, required this.x, required this.y});
}
