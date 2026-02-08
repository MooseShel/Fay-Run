import 'dart:math';

enum ObstacleType {
  janitorBucket, // Level 2
  beaker, // Level 3 (Scientific)
  flyingPizza, // Level 4
  car, // Level 5
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
    // Spawn rate increases with level?
    double spawnInterval = 3.0 - (level * 0.3); // Level 1: 2.7s, Level 5: 1.5s
    if (spawnInterval < 0.8) spawnInterval = 0.8;

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
        obstacles.removeAt(i);
      }
    }
  }

  void _spawnObstacle(int level) {
    // Determine type based on level
    ObstacleType type = ObstacleType.janitorBucket;
    if (level == 2)
      type = ObstacleType.janitorBucket;
    else if (level == 3)
      type = ObstacleType.beaker;
    else if (level == 4)
      type = ObstacleType.flyingPizza;
    else if (level == 5)
      type = ObstacleType.car;

    // Chance for Golden Book (Quiz)
    if (_random.nextDouble() < 0.2) {
      // 20% chance
      type = ObstacleType.goldenBook;
    }

    obstacles.add(
      Obstacle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: 1.1, // Start off-screen right
        y: 0.0, // Ground level
        width: 0.15, // Relative width
        height: 0.1, // Relative height
      ),
    );
  }
}
