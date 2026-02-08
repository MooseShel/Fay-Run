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
import '../../game/obstacle_manager.dart';

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
  final double _gravity = -0.8;
  final double _jumpForce = 15.0;
  final double _groundHeight = 100.0;

  bool _isJumping = false;

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
  }

  void _gameLoop() {
    final gameState = context.read<GameState>();

    if (gameState.status != GameStatus.playing) return;

    // 0. Timers & Progression
    const double dt = 0.016;
    _distanceRun += gameState.runSpeed * dt * 10; // Scale up
    _chaosTimer += dt;

    // Level Completion (e.g., every 1000 meters)
    if (_distanceRun > 1000) {
      _distanceRun = 0;
      gameState.completeLevel();
      // Show Level Up toast or overlay?
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Level ${gameState.currentLevel}! Speed Up!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    // Random Chaos (Every 30-45s)
    if (_chaosTimer > 30 + _random.nextInt(15)) {
      _chaosTimer = 0;
      final eventType =
          StaffEventType.values[_random.nextInt(StaffEventType.values.length)];
      gameState.triggerStaffEvent(eventType);
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
        }
      });
    }

    // 2. Obstacle Update
    // dt = 0.016s roughly
    setState(() {
      _obstacleManager.update(
        0.016,
        gameState.runSpeed,
        gameState.currentLevel,
        (obs) {
          // Collision Callback (Not used directly yet, manual check below)
        },
      );

      // Check Collisions
      // Player rect (simplified relative coords):
      // X: 50px / screenWidth (approx 0.12)
      // Y: _playerY
      // Obstacle rect: obs.x, obs.y

      final playerXRatio = 50.0 / MediaQuery.of(context).size.width;
      final playerWidthRatio = 60.0 / MediaQuery.of(context).size.width;

      for (var obs in _obstacleManager.obstacles) {
        // AABB Collision
        // X overlap
        bool xOverlap =
            (obs.x < playerXRatio + playerWidthRatio) &&
            (obs.x + obs.width > playerXRatio);
        // Y overlap (Obstacles are on ground y=0, Player y=0 is ground)
        // If jumping high enough, safe.
        double jumpClearance = obs.height * 500; // Arbitrary pixel height
        bool yOverlap = _playerY < jumpClearance;

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
        gameState.takeDamage();
        gameState.triggerStaffEvent(
          StaffEventType.shoeTie,
        ); // Random or specific?
        // User said: "Wrong Answer -> Staff Chaos".
        // Hitting obstacle -> Just damage? Or staff event too?
        // Let's stick to damage for obstacle, Staff Event for Quiz Fail.
        // But users request: "Trigger a random event ... on a 'Wrong Answer'."
        // Also "Staff Chaos (Whoopsie) System... Trigger a random event every 30-45 seconds".
        // Let's implement timer in GameState for that separately.
      }
    }
  }

  void _showQuiz(GameState gameState) {
    final challenge = MockSQLService.getWeeklyChallenge();
    final question = challenge.questions.first; // Pick first for now

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Weekly Challenge: ${challenge.topic}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(question.questionText),
            const SizedBox(height: 20),
            ...question.options.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    bool correct = e.key == question.correctOptionIndex;
                    if (correct) {
                      gameState.addScore(100);
                      gameState.setInvincible(true);
                    } else {
                      gameState.takeDamage();
                      gameState.triggerStaffEvent(
                        StaffEventType.scienceSplat,
                      ); // Randomize later
                    }
                    gameState.resumeGame();
                  },
                  child: Text(e.value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _jump() {
    final gameState = context.read<GameState>();
    if (gameState.activeStaffEvent?.type == StaffEventType.shoeTie) return;

    if (!_isJumping) {
      setState(() {
        _verticalVelocity = _jumpForce;
        _isJumping = true;
      });
    }
  }

  @override
  void dispose() {
    _gameLoopController.dispose();
    super.dispose();
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

            const AmbientEffects(),

            // Obstacles
            ..._obstacleManager.obstacles.map(
              (obs) => Positioned(
                left: obs.x * screenSize.width,
                bottom: _groundHeight, // They are on ground
                width: obs.width * screenSize.width,
                height: obs.height * screenSize.height, // Scale height
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

            // Fog Overlay (Level 3)
            if (gameState.currentLevel == 3)
              Positioned.fill(
                child: Container(color: Colors.white.withOpacity(0.4)),
              ),

            // Ink Splat Overlay (Science Event)
            if (gameState.activeStaffEvent?.type == StaffEventType.scienceSplat)
              Center(
                child: Icon(
                  Icons.blur_on,
                  size: 300,
                  color: Colors.black.withOpacity(0.8),
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
                        onPressed: () => context.read<GameState>().resumeGame(),
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
    IconData icon = Icons.warning;
    Color color = Colors.red;

    switch (obs.type) {
      case ObstacleType.janitorBucket:
        icon = Icons.cleaning_services;
        color = Colors.blueGrey;
        break;
      case ObstacleType.beaker:
        icon = Icons.science;
        color = Colors.purple;
        break;
      case ObstacleType.flyingPizza:
        icon = Icons.local_pizza;
        color = Colors.orange;
        break;
      case ObstacleType.car:
        icon = Icons.directions_car;
        color = Colors.redAccent;
        break;
      case ObstacleType.goldenBook:
        icon = Icons.menu_book;
        color = FayColors.gold;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 30),
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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          'Score: ${state.score}',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        Text(
          'Level: ${state.currentLevel}',
          style: const TextStyle(fontSize: 16, color: Colors.white),
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
    return Card(
      color: FayColors.navy,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              event.title,
              style: TextStyle(
                color: FayColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(event.message, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
