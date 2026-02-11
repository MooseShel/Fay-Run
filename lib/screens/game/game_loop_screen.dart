import 'dart:math';
import 'package:flutter/foundation.dart';
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
  final double _gravity = -0.5; // Floatier
  final double _jumpForce = 13.0; // Balanced
  final double _groundHeight =
      20.0; // Lowered from 50.0 to shift everything down towards the "walking way"

  bool _isJumping = false;
  int _jumpCount = 0;
  final int _maxJumps = 2;

  // Progression & Chaos
  double _distanceRun = 0;
  double _chaosTimer = 0;
  final Random _random = Random();

  // Animation State
  bool _isCrashed = false;
  int _runFrame = 0;
  double _runAnimationTimer = 0;

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

  Future<void> _loadAssets() async {
    final startTime = DateTime.now();
    debugPrint('🎬 Starting optimized level loading...');

    try {
      final state = context.read<GameState>();
      final level = state.currentLevel;

      // UX goal: ~800ms "Preparing Level" screen
      final minDelayFuture = Future.delayed(const Duration(milliseconds: 800));

      // 1. Ensure essential assets are loaded (likely already done in StudentSelect)
      final essentialPreload = AssetManager().precacheEssentialAssets(context);

      // 2. Precache current level background (others preloaded in MainMenu)
      final bgPreload = AssetManager().precacheLevelAssets(context, level);

      // 3. Data & Music
      await state.loadChallenge();
      AudioService().playBGM(level);

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
    final gameState = context.read<GameState>();

    if (gameState.status != GameStatus.playing &&
        gameState.status != GameStatus.bonusRound) return;

    // 0. Timers & Progression
    const double dt = 0.016;
    if (gameState.status == GameStatus.playing) {
      _distanceRun += gameState.runSpeed * dt * 10; // Scale up
    }

    // Score based on distance (approx 1 point per unit run)
    // RunSpeed 3.0 * 0.016 * 10 = 0.48 units per frame.
    // Let's add 1 point every few frames? Or just use a timer accumulator?
    // Let's just add 1 point every frame the user is moving?
    // Simple: gameState.addScore(1); runs 60 times a second -> 60 points/sec.
    // Maybe too fast? Let's add (runSpeed / 10).round()
    if (gameState.status == GameStatus.playing) {
      gameState.addScore(1);

      // Update Floating Scores
      for (var fs in _floatingScores) {
        fs.animationTime += dt * 2; // Speed of animation
      }
      _floatingScores.removeWhere((fs) => fs.animationTime >= 1.0);
    }

    _chaosTimer += dt;

    // Run Animation (Slower speed: approx 6-7 fps for smoother look)
    _runAnimationTimer += dt;
    if (_runAnimationTimer > 0.25) {
      // Increased frame time from 0.15 to 0.25 for smoother, slower look
      _runAnimationTimer = 0;
      // Cycle through 3 frames (0, 1, 2)
      _runFrame = (_runFrame + 1) % 3;
    }

    // Level Completion (e.g., Target = Speed * 600 for ~60s playtime)
    // Speed 2.5 * 600 = 1500 units
    // Speed 3.6 * 600 = 2160 units
    // Calculation: Distance/Frame = Speed * 0.16. Frame/Sec = 60. Distance/Sec = Speed * 9.6.
    // Target for 60s = Speed * 9.6 * 60 = Speed * 576. Let's round to 600 for simplicity.
    final targetDistance = gameState.runSpeed * 600;

    if (_distanceRun > targetDistance) {
      _distanceRun = 0;
      gameState.completeLevel();
      // Stop music when level completes
      AudioService().stopBGM();
      // Show Level Up toast or overlay?
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Level ${gameState.currentLevel}! Speed Up!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    // Level-based threshold for chaos (Less frequent in later levels to reduce overwhelming feel)
    final double chaosThreshold = kDebugMode
        ? 10.0
        : (gameState.currentLevel >= 6
            ? 35.0 + _random.nextInt(15) // Level 6-10: 35-50s
            : 20.0 + _random.nextInt(10)); // Level 1-5: 20-30s

    if (_chaosTimer > chaosThreshold) {
      _chaosTimer = 0;

      // Only trigger if no staff event is currently active
      if (gameState.activeStaffEvent == null) {
        gameState.triggerStaffChaos();
      }
    }

    // Performance Optimization: Consolidate state updates into one setState call
    setState(() {
      // 1. Physics Update
      if (_isJumping || _playerY > 0) {
        _playerY += _verticalVelocity;
        _verticalVelocity += _gravity;

        if (_playerY <= 0) {
          _playerY = 0;
          _verticalVelocity = 0;
          _isJumping = false;
          _jumpCount = 0; // Reset jumps
        }
      }

      // 2. Obstacle Update
      _obstacleManager.update(
        0.016,
        gameState.runSpeed,
        gameState.currentLevel,
        gameState.status == GameStatus.bonusRound,
        (obs) {},
      );

      // 3. Scenery Update
      _sceneryManager.update(
        0.016,
        gameState.runSpeed,
        gameState.currentLevel,
      );
    });

    final screenSize = MediaQuery.sizeOf(context);

    for (var obs in _obstacleManager.obstacles) {
      bool isGoldenBook = obs.type == ObstacleType.goldenBook;

      // Convert relative coordinates to pixels for accurate collision
      // All dimensions (width/height) are now relative to Screen Height
      double obsPixelWidth = obs.width * screenSize.height;
      double obsPixelHeight = obs.height * screenSize.height;
      double obsPixelX = obs.x * screenSize.width;
      double obsPixelY = obs.y * screenSize.height;

      double verticalOffset =
          _getObstacleVerticalOffset(obs, screenSize.height);

      double obsPaddingX =
          isGoldenBook ? obsPixelWidth * 0.10 : obsPixelWidth * 0.20;
      double obsPaddingY =
          isGoldenBook ? obsPixelHeight * 0.10 : obsPixelHeight * 0.20;

      double obsLeft = obsPixelX + obsPaddingX;
      double obsRight = obsPixelX + obsPixelWidth - obsPaddingX;
      double obsBottom = obsPixelY - verticalOffset + obsPaddingY;
      double obsTop = obsPixelY - verticalOffset + obsPixelHeight - obsPaddingY;

      // Player Hitbox (Responsive)
      double playerPixelSize = screenSize.height * 0.21; // Increased from 0.18
      double playerPadding = playerPixelSize * 0.4;
      double playerBaseX = screenSize.width * 0.30;

      double playerLeft = playerBaseX + playerPadding;
      double playerRight = playerBaseX + playerPixelSize - playerPadding;

      double playerBottom = _playerY + (playerPixelSize * 0.3); // 30% padding
      double playerTop = _playerY + playerPixelSize - (playerPixelSize * 0.3);

      // X overlap
      bool xOverlap = (obsLeft < playerRight) && (obsRight > playerLeft);

      // Y overlap
      bool yOverlap = (playerBottom < obsTop) && (playerTop > obsBottom);

      if (xOverlap && yOverlap && !obs.hasEngaged) {
        _handleCollision(obs, gameState);
      }
    }
  }

  void _handleCollision(Obstacle obs, GameState gameState) {
    obs.hasEngaged = true; // Prevent multi-trigger

    if (obs.type == ObstacleType.goldenBook) {
      gameState.pauseGame();
      _showQuiz(gameState, obs, reward: 200); // Double Reward
    } else if (obs.type == ObstacleType.burger ||
        obs.type == ObstacleType.apple ||
        obs.type == ObstacleType.banana) {
      gameState.pauseGame();
      _showQuiz(gameState, obs, reward: 100); // Standard Reward
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

  void _showQuiz(GameState gameState, Obstacle obs, {int reward = 100}) {
    // Use loaded challenge or fallback to a default one
    final challenge = gameState.currentChallenge ??
        Challenge(
          id: 'fallback_math',
          topic: 'Math',
          gradeLevel: 1,
          questions: [
            QuizQuestion(
              questionText: 'What is 5 + 5?',
              options: ['10', '12', '8', '20'],
              correctOptionIndex: 0,
            ),
            QuizQuestion(
              questionText: 'What is 10 - 3?',
              options: ['7', '6', '5', '4'],
              correctOptionIndex: 0,
            ),
            QuizQuestion(
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
            gameState.setInvincible(true);
            obs.isCollected = true; // Disappear ONLY if correct

            // Spawn Floating Text
            _spawnFloatingScore(reward);
          } else {
            AudioService().playBonk();
            // User requested to remove punishment for missing a question
            // gameState.takeDamage();
          }

          // submit result to backend
          gameState.recordQuizResult(challenge.id, isCorrect);

          gameState.resumeGame();
        },
      ),
    );
  }

  void _jump() {
    final gameState = context.read<GameState>();

    if (_jumpCount < _maxJumps) {
      if (gameState.status == GameStatus.playing) {
        AudioService().playJump();
      }
      setState(() {
        // Normal jump power (no staff modifications)
        _verticalVelocity = _jumpForce;
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
    }

    return offset;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final screenSize = MediaQuery.sizeOf(context);

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
              }

              int frame = obj.currentFrame;
              if (obj.type == SceneryType.dogStanding) {
                frame += 2; // dog_3, dog_4
              }

              assetName = Assets.bgCharacter(baseName, frame);

              // Dynamic scaling based on type
              double charSize =
                  screenSize.height * 0.16; // Default for animals (scaled up)
              if (obj.type == SceneryType.boy ||
                  obj.type == SceneryType.girl ||
                  obj.type == SceneryType.janitor) {
                charSize = screenSize.height * 0.21; // Match new player size
              }

              return Positioned(
                left: obj.x * screenSize.width,
                // Minimal bottom offset (0.01) to keep them grounded but slightly "behind"
                bottom: _groundHeight +
                    (obj.y * screenSize.height) +
                    (screenSize.height * 0.01),
                width: charSize,
                height: charSize,
                child: Image.asset(
                  'assets/images/$assetName',
                  fit: BoxFit.contain,
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
                  bottom: _groundHeight +
                      (obs.y * screenSize.height) -
                      verticalOffset,
                  width: obs.width * screenSize.height, // Use Height as base
                  height: obs.height * screenSize.height,
                  child: _buildObstacleWidget(obs),
                );
              },
            ),

            Positioned(
              left: screenSize.width * 0.30,
              bottom: _groundHeight + _playerY,
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

            // Level Progress Bar
            Positioned(
              top: 50,
              left: screenSize.width * 0.25,
              right: screenSize.width * 0.25,
              child: Column(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: FayColors.navy.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          LinearProgressIndicator(
                            value: (_distanceRun / (gameState.runSpeed * 600))
                                .clamp(0.0, 1.0),
                            backgroundColor: Colors.transparent,
                            color: FayColors.gold,
                            minHeight: 12,
                          ),
                          // Subtle Gloss Effect
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.directions_run,
                          size: 14, color: FayColors.gold),
                      Icon(Icons.flag, size: 14, color: FayColors.gold),
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
                            gameState.startBonusRound();
                            // Optional: play special music?
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
                            gameState.startNextLevel();
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
                            gameState.startNextLevel();
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

    return Image.asset(
      assetName,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      errorBuilder: (context, error, stackTrace) {
        // Fallback 1: try without variant
        return Image.asset(
          'assets/images/obstacles/$baseName.png',
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          errorBuilder: (c, e, s) {
            // Fallback 2: try base images folder
            return Image.asset(
              'assets/images/$baseName.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (c, e, s) => const SizedBox(),
            );
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
