import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_state.dart';
import '../../core/constants.dart';
import '../../models/staff_event.dart';
import '../../models/challenge.dart'; // Needed for fallback
import '../../widgets/parallax_background.dart';
import '../../widgets/player_character.dart';
import '../../widgets/game/ambient_effects.dart';
import '../../widgets/game/quiz_overlay.dart';
import '../../widgets/game/animated_staff_chaos.dart';
import '../../game/obstacle_manager.dart';
import '../../services/audio_service.dart';

class GameLoopScreen extends StatefulWidget {
  const GameLoopScreen({super.key});

  @override
  State<GameLoopScreen> createState() => _GameLoopScreenState();
}

class _GameLoopScreenState extends State<GameLoopScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _gameLoopController;
  final ObstacleManager _obstacleManager = ObstacleManager();

  // Game Physics State
  double _playerY = 0; // 0 = ground, positive = up
  double _verticalVelocity = 0;
  final double _gravity = -0.5; // Floatier
  final double _jumpForce = 13.0; // Balanced
  final double _groundHeight =
      50.0; // Adjusted from 40.0 for better visual alignment on ground

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

  @override
  void initState() {
    super.initState();
    _gameLoopController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )
      ..addListener(_gameLoop)
      ..repeat();

    // Load challenge from Supabase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Precache Sprites for smooth start
      precacheImage(const AssetImage('assets/images/ernie_run.png'), context);
      precacheImage(const AssetImage('assets/images/ernie_run_2.png'), context);
      precacheImage(const AssetImage('assets/images/ernie_run_3.png'), context);
      precacheImage(const AssetImage('assets/images/ernie_jump.png'), context);
      precacheImage(const AssetImage('assets/images/ernie_crash.png'), context);
      // Precache Common Obstacles
      precacheImage(
          const AssetImage('assets/images/obstacle_log.png'), context);
      precacheImage(
          const AssetImage('assets/images/obstacle_rock.png'), context);

      final state = context.read<GameState>();
      state.loadChallenge();

      // Start BGM
      AudioService().playBGM(state.currentLevel);
    });
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    AudioService().stopBGM(); // Stop music on exit
    super.dispose();
  }

  void _gameLoop() {
    final gameState = context.read<GameState>();

    if (gameState.status != GameStatus.playing) return;

    // 0. Timers & Progression
    const double dt = 0.016;
    _distanceRun += gameState.runSpeed * dt * 10; // Scale up

    // Score based on distance (approx 1 point per unit run)
    // RunSpeed 3.0 * 0.016 * 10 = 0.48 units per frame.
    // Let's add 1 point every few frames? Or just use a timer accumulator?
    // Let's just add 1 point every frame the user is moving?
    // Simple: gameState.addScore(1); runs 60 times a second -> 60 points/sec.
    // Maybe too fast? Let's add (runSpeed / 10).round()
    if (gameState.status == GameStatus.playing) {
      gameState.addScore(1);
    }

    _chaosTimer += dt;

    // Run Animation (Slower speed: approx 6-7 fps for smoother look)
    _runAnimationTimer += dt;
    if (_runAnimationTimer > 0.15) {
      // Increased frame time from ~0.1 to 0.15
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

    // Random Staff Appearances (Every 10-15s for fun sounds/visuals only)
    if (_chaosTimer > 10 + _random.nextInt(5)) {
      _chaosTimer = 0;

      // Only trigger if no staff event is currently active
      if (gameState.activeStaffEvent == null) {
        final eventType = StaffEventType
            .values[_random.nextInt(StaffEventType.values.length)];

        // Show staff event notification (visual only, no gameplay effects)
        gameState.triggerStaffEvent(eventType);

        // Play Staff Sound
        AudioService().playStaffSound(eventType.toString());
      }
    }

    // 1. Physics Update
    if (_isJumping || _playerY > 0) {
      setState(() {
        _playerY += _verticalVelocity;
        _verticalVelocity += _gravity;

        if (_playerY <= 0) {
          _playerY = 0;
          _verticalVelocity = 0;
          _isJumping = false;
          _jumpCount = 0; // Reset jumps
        }
      });
    }

    // 2. Obstacle Update
    // dt = 0.016s roughly
    final screenSize = MediaQuery.of(context).size;

    setState(() {
      _obstacleManager.update(
        0.016,
        gameState.runSpeed,
        gameState.currentLevel,
        (obs) {
          // Collision Callback (Not used directly yet, manual check below)
        },
      );

      for (var obs in _obstacleManager.obstacles) {
        bool isGoldenBook = obs.type == ObstacleType.goldenBook;

        // Convert relative coordinates to pixels for accurate collision
        // All dimensions (width/height) are now relative to Screen Height
        double obsPixelWidth = obs.width * screenSize.height;
        double obsPixelHeight = obs.height * screenSize.height;
        double obsPixelX = obs.x * screenSize.width;
        double obsPixelY = obs.y * screenSize.height;

        double obsPaddingX =
            isGoldenBook ? obsPixelWidth * 0.10 : obsPixelWidth * 0.20;
        double obsPaddingY =
            isGoldenBook ? obsPixelHeight * 0.10 : obsPixelHeight * 0.20;

        double obsLeft = obsPixelX + obsPaddingX;
        double obsRight = obsPixelX + obsPixelWidth - obsPaddingX;
        double obsBottom = obsPixelY + obsPaddingY;
        double obsTop = obsPixelY + obsPixelHeight - obsPaddingY;

        // Player Hitbox (Responsive)
        double playerPixelSize = screenSize.height * 0.18;
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

        if (xOverlap && yOverlap && !obs.isCollected) {
          _handleCollision(obs, gameState);
        }
      }
    });
  }

  void _handleCollision(Obstacle obs, GameState gameState) {
    obs.isCollected = true; // Prevent multi-trigger

    if (obs.type == ObstacleType.goldenBook) {
      gameState.pauseGame();
      _showQuiz(gameState);
    } else {
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

  void _showQuiz(GameState gameState) {
    // Use loaded challenge or fallback to a default one
    final challenge = gameState.currentChallenge ??
        Challenge(
          id: 'fallback_math',
          topic: 'Math',
          gradeLevel: 4,
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
      barrierColor: Colors.black.withOpacity(0.7), // Darker overlay
      builder: (context) => QuizOverlay(
        challenge: challenge,
        question: question,
        onAnswered: (isCorrect) {
          Navigator.pop(context); // Close dialog
          if (isCorrect) {
            AudioService().playPowerup();
            gameState.addScore(100);
            gameState.setInvincible(true);
          } else {
            AudioService().playBonk();
            gameState.takeDamage();
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

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final screenSize = MediaQuery.sizeOf(context);

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

            // 4. Ambient Effects (Level-specific particles)
            AmbientEffects(level: gameState.currentLevel),

            ..._obstacleManager.obstacles.map(
              (obs) {
                return Positioned(
                  left: obs.x * screenSize.width,
                  bottom: _groundHeight + (obs.y * screenSize.height),
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
                size: screenSize.height * 0.18, // Responsive size
              ),
            ),

            // Staff Chaos - Animated center screen appearance
            if (gameState.activeStaffEvent != null)
              AnimatedStaffChaos(event: gameState.activeStaffEvent!),

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
                    backgroundColor: Colors.white.withOpacity(0.5),
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
                color: FayColors.navy.withOpacity(0.9),
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
                      ElevatedButton.icon(
                        onPressed: () {
                          _obstacleManager.clear();
                          final nextLevel =
                              context.read<GameState>().currentLevel + 1;
                          context.read<GameState>().startNextLevel();
                          // Start music for next level
                          AudioService().playBGM(nextLevel);
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

            // 8. Game Over Overlay
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
    String assetName = '';
    String suffix = obs.variant == 2 ? '_2' : '';

    switch (obs.type) {
      case ObstacleType.log:
        assetName = 'assets/images/obstacle_log$suffix.png';
        break;
      case ObstacleType.puddle:
        assetName = 'assets/images/obstacle_puddle$suffix.png';
        break;
      case ObstacleType.rock:
        assetName = 'assets/images/obstacle_rock$suffix.png';
        break;
      case ObstacleType.janitorBucket:
        assetName = 'assets/images/obstacle_bucket$suffix.png';
        break;
      case ObstacleType.books:
        assetName = 'assets/images/obstacle_books$suffix.png';
        break;
      case ObstacleType.beaker:
        // No variant 2 for beaker known, fallback to original if needed or assume exists
        // Checking file list: no beaker_2. Just bucket_2.
        // Let's use bucket for now as per original code, or just keep original.
        assetName = 'assets/images/obstacle_bucket.png';
        break;
      case ObstacleType.flyingPizza:
        assetName = 'assets/images/obstacle_food$suffix.png';
        break;
      case ObstacleType.food:
        assetName = 'assets/images/obstacle_food$suffix.png';
        break;
      case ObstacleType.car:
        // Custom logic for cars based on direction (Level 5)
        if (obs.direction == 1.0) {
          // Moving Right (Left-to-Right) -> New Variant (Suv 2)
          assetName = 'assets/images/obstacle_suv_2.png';
        } else {
          // Moving Left (Right-to-Left) -> Original (Suv)
          assetName = 'assets/images/obstacle_suv.png';
        }
        break;
      case ObstacleType.cone:
        assetName = 'assets/images/obstacle_cone$suffix.png';
        break;
      case ObstacleType.goldenBook:
        assetName = 'assets/images/item_golden_book.png';
        break;
    }

    if (assetName.isEmpty) return const SizedBox();

    return Image.asset(
      assetName,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter, // Ensure sprite sits at bottom of box
      errorBuilder: (context, error, stackTrace) {
        // Fallback to original if variant missing
        return Image.asset(
          assetName.replaceFirst('_2', ''),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          errorBuilder: (c, e, s) => const SizedBox(),
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
      ],
    );
  }
}
