import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_state.dart';
import '../../core/constants.dart';
import '../../models/staff_event.dart';
import '../../services/mock_sql_service.dart';
import '../../widgets/parallax_background.dart';
import '../../widgets/player_character.dart';
import '../../widgets/game/ambient_effects.dart';
import '../../widgets/game/quiz_overlay.dart';
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

  @override
  void initState() {
    super.initState();
    _gameLoopController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 16),
          )
          ..addListener(_gameLoop)
          ..repeat();

    // Load challenge from Supabase
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

    // Level Completion (e.g., every 1000 meters)
    if (_distanceRun > 1000) {
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

    // Random Staff Appearances (Every 5-10s for fun sounds/visuals only)
    if (_chaosTimer > 5 + _random.nextInt(5)) {
      _chaosTimer = 0;
      final eventType =
          StaffEventType.values[_random.nextInt(StaffEventType.values.length)];

      // Show staff event notification (visual only, no gameplay effects)
      gameState.triggerStaffEvent(eventType);

      // Play Staff Sound
      AudioService().playStaffSound(eventType.toString());
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
        // Special collision handling for Golden Books (collectibles)
        // Use tighter padding for better collection detection
        bool isGoldenBook = obs.type == ObstacleType.goldenBook;

        // AABB Collision with tightened hitbox for more precise detection
        // Golden Books: 15% padding (easier to collect)
        // Obstacles: 35% padding (more forgiving)
        double obsPaddingX = isGoldenBook ? obs.width * 0.15 : obs.width * 0.35;
        double obsPaddingY = isGoldenBook
            ? obs.height * 0.15
            : obs.height * 0.35;

        double obsLeft = obs.x + obsPaddingX;
        double obsRight = obs.x + obs.width - obsPaddingX;
        double obsBottom = obs.y + obsPaddingY;
        double obsTop = obs.y + obs.height - obsPaddingY;

        // Player Hitbox (Relative)
        // Player Width ~50px. Visual is wider.
        // Make the hurtbox very central for fair gameplay.
        double playerVisualWidth = 50.0 / screenSize.width;
        double playerPadding =
            playerVisualWidth * 0.4; // 40% padding (increased from 30%)

        double playerLeft = (50.0 / screenSize.width) + playerPadding;
        double playerRight = ((50.0 + 40.0) / screenSize.width) - playerPadding;

        // Player Height
        double playerVisualHeight = 100.0 / screenSize.height;
        double playerHeightPadding =
            playerVisualHeight * 0.3; // 30% padding (increased from 20%)

        double playerBottom =
            (_playerY / screenSize.height) + playerHeightPadding;
        double playerTop =
            ((_playerY + 100.0) / screenSize.height) - playerHeightPadding;

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
        gameState.triggerStaffEvent(StaffEventType.shoeTie);
      }
    }
  }

  void _showQuiz(GameState gameState) {
    // Use loaded challenge or fallback to mock
    final challenge =
        gameState.currentChallenge ?? MockSQLService.getWeeklyChallenge();

    // Get Unique Question
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
            gameState.addScore(100);
            gameState.setInvincible(true);
          } else {
            AudioService().playBonk();
            gameState.takeDamage();
            gameState.triggerStaffEvent(StaffEventType.scienceSplat);
          }
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

            // Obstacles
            ..._obstacleManager.obstacles.map(
              (obs) => Positioned(
                left: obs.x * screenSize.width,
                bottom:
                    _groundHeight + (obs.y * screenSize.height), // Use obs.y
                width: obs.width * screenSize.width,
                height: obs.height * screenSize.height,
                child: _buildObstacleWidget(obs),
              ),
            ),

            Positioned(
              left: 50,
              bottom: _groundHeight + _playerY,
              child: PlayerCharacter(
                isJumping: _isJumping,
                isInvincible: gameState.isInvincible,
              ),
            ),

            // Ink Splat Overlay (Science Event)
            if (gameState.activeStaffEvent?.type == StaffEventType.scienceSplat)
              Center(
                child: Icon(
                  Icons.blur_on,
                  size: 300,
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ), // Placeholder for Splat visual

            if (gameState.activeStaffEvent != null)
              Positioned(
                top: 100,
                right: 20,
                child: _StaffEventCard(event: gameState.activeStaffEvent!),
              ),

            Positioned(top: 40, left: 20, child: _buildHUD(gameState)),

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
                        child: const Text('RESUME'),
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

    switch (obs.type) {
      case ObstacleType.log:
        assetName = 'assets/images/obstacle_log.png';
        break;
      case ObstacleType.puddle:
        assetName = 'assets/images/obstacle_puddle.png';
        break;
      case ObstacleType.rock:
        assetName = 'assets/images/obstacle_rock.png';
        break;
      case ObstacleType.janitorBucket:
        assetName = 'assets/images/obstacle_bucket.png';
        break;
      case ObstacleType.books:
        assetName = 'assets/images/obstacle_books.png';
        break;
      case ObstacleType.beaker:
        assetName = 'assets/images/obstacle_bucket.png';
        break;
      case ObstacleType.flyingPizza:
        assetName = 'assets/images/obstacle_food.png';
        break;
      case ObstacleType.food:
        assetName = 'assets/images/obstacle_food.png';
        break;
      case ObstacleType.car:
        assetName = 'assets/images/obstacle_suv.png';
        break;
      case ObstacleType.cone:
        assetName = 'assets/images/obstacle_cone.png';
        break;
      case ObstacleType.goldenBook:
        assetName = 'assets/images/item_golden_book.png';
        break;
    }

    if (assetName.isEmpty) return const SizedBox();

    return Image.asset(
      assetName,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error, color: Colors.red),
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

class _StaffEventCard extends StatelessWidget {
  final StaffEvent event;
  const _StaffEventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    switch (event.type) {
      case StaffEventType.shoeTie:
        imagePath = 'assets/images/staff_head_school.jpg';
        break;
      case StaffEventType.coachWhistle:
        imagePath = 'assets/images/staff_coach.jpg';
        break;
      case StaffEventType.librarianShush:
        imagePath = 'assets/images/staff_librarian.jpg';
        break;
      case StaffEventType.scienceSplat:
        imagePath = 'assets/images/staff_science.jpg';
        break;
      case StaffEventType.deanGlare:
        imagePath = 'assets/images/staff_dean.jpg';
        break;
      case StaffEventType.peDrill:
        imagePath = 'assets/images/staff_pe.png';
        break;
    }

    return Card(
      color: FayColors.navy,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    color: FayColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
