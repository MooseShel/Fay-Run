import 'dart:math';

enum ObstacleType {
  log, // Level 1 (Bayou)
  puddle, // Level 1 (Bayou)
  rock, // Level 1 (Bayou)
  janitorBucket, // Level 2 (Hallway)
  books, // Level 2 & 3 (Hallway/Lab)
  beaker, // Level 3 (Scientific)
  flyingPizza, // Level 4 (Cafeteria)
  food, // Level 4 (Cafeteria)
  car, // Level 5 (Car Pool - SUV)
  cone, // Level 5 (Car Pool - Traffic Cone)
  goldenBook, // Quiz Gate (Special)
}

class Obstacle {
  final String id;
  final ObstacleType type;
  double x; // 0.0 to 1.0 (relative to screen width? or absolute pixels?)
  // Let's use absolute pixels for game loop simplicity?
  // Or relative to allow resizing.
  // Let's use relative 1.0 (right) -> -0.1 (left offscreen).
  double y; // Relative 0.0 (bottom) to 1.0 (top)
  double width;
  double height;
  bool isCollected; // For Golden Book

  Obstacle({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.isCollected = false,
  });
}

class ObstacleManager {
  final List<Obstacle> obstacles = [];
  final Random _random = Random();
  double _spawnTimer = 0;

  void update(double dt, double runSpeed, int level, Function(Obstacle) onHit) {
    // Spawn Logic
    _spawnTimer += dt;
    // Progressive spawn rate increases with level for smooth difficulty curve
    double spawnInterval;
    switch (level) {
      case 1:
        spawnInterval = 6.0; // Very easy - learn mechanics
        break;
      case 2:
        spawnInterval = 4.5; // Easy - comfortable
        break;
      case 3:
        spawnInterval = 3.5; // Medium - engaging
        break;
      case 4:
        spawnInterval = 2.8; // Hard - challenging
        break;
      case 5:
        spawnInterval = 2.2; // Very hard - intense
        break;
      default:
        spawnInterval = 6.0;
    }

    if (_spawnTimer > spawnInterval) {
      _spawnObstacle(level);
      _spawnTimer = 0;
    }

    // Move & Cleanup
    // runSpeed is e.g. 5.0. Need to map to screen relative.
    // Assuming screen width ~400px. speed 5.0/frame @ 60fps = 300px/sec.
    // relative speed = runSpeed / 400.0?
    // Let's settle on a coordinate system. X=1.0 is right edge.
    // dx = - (speed * dt * 0.01) ?
    double moveAmt = (runSpeed * 0.002);

    for (var i = obstacles.length - 1; i >= 0; i--) {
      var obs = obstacles[i];
      obs.x -= moveAmt;

      // Hit detection (Very simple AABB)
      // Player is @ Left 50px (~0.15), Bottom 100px.
      // Player Box: x: 0.1 to 0.25, y: 0.0 to 0.15 (jumping affects y)
      // We check collision in GameLoopScreen really, but here for cleanup.

      if (obs.x < -0.2) {
        obs.isCollected = false; // Reset
        obs.x = 1.5 + _random.nextDouble(); // Recycle to far right
      }
    }
  }

  void _spawnObstacle(int level) {
    // Obstacle pools for each level (2-3 types per level for variety)
    List<ObstacleType> obstaclePool = [];

    switch (level) {
      case 1: // Bayou
        obstaclePool = [
          ObstacleType.log,
          ObstacleType.puddle,
          ObstacleType.rock,
        ];
        break;
      case 2: // Hallway
        obstaclePool = [ObstacleType.janitorBucket, ObstacleType.books];
        break;
      case 3: // Science Lab
        obstaclePool = [ObstacleType.beaker, ObstacleType.books];
        break;
      case 4: // Cafeteria
        obstaclePool = [ObstacleType.flyingPizza, ObstacleType.food];
        break;
      case 5: // Car Pool
        obstaclePool = [ObstacleType.car, ObstacleType.cone];
        break;
      default:
        obstaclePool = [ObstacleType.log];
    }

    // Randomly select obstacle type from pool
    ObstacleType type = obstaclePool[_random.nextInt(obstaclePool.length)];

    // Double size for visibility
    double width = 0.30; // Was 0.15
    double height = 0.20; // Was 0.1

    // All obstacles spawn at ground level for consistent gameplay
    double y = 0.0;

    // Chance for Golden Book (Quiz)
    if (_random.nextDouble() < 0.2) {
      // 20% chance
      type = ObstacleType.goldenBook;
      // Golden Book spawns in the air (Mario Coin style)
      // Player jumps ~170px. Screen height ~800?
      // 0.2 * 800 = 160. So 0.2 is high.
      y = 0.25; // In the air
      width = 0.15; // Keep books smaller/normal
      height = 0.15;
    }

    obstacles.add(
      Obstacle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: 1.1, // Start off-screen right
        y: y,
        width: width,
        height: height,
      ),
    );
  }

  void clear() {
    obstacles.clear();
  }
}
