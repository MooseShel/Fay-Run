import 'dart:math';
import 'package:flutter/foundation.dart'; // For debugPrint

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
  backpack, // Level 6 (Playground)
  trashCan, // New Campus Grounds
  hydrant, // New Campus Grounds
  bench, // New Campus Grounds
  tire, // New Playground
  flowerPot, // New Garden
  gnome, // New Garden
  basketBall, // New Gym
  soccerBall, // New Gym
  gymMat, // New Gym
  burger, // New Cafeteria
  lunchTray, // New Cafeteria
  milkCarton, // New Cafeteria
  wildFlowers, // New Meadow
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
  double direction; // -1.0 for Left (default), 1.0 for Right
  int variant; // 1 or 2
  bool isCollected; // For Golden Book

  Obstacle({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.direction = -1.0,
    this.variant = 1,
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
    // Rebalanced for more linear progression (less gap between 3 and 4)
    double spawnInterval;
    switch (level) {
      case 1:
        spawnInterval = 3.0; // Faster start
        break;
      case 2:
        spawnInterval = 2.5;
        break;
      case 3:
        spawnInterval = 2.1;
        break;
      case 4:
        spawnInterval = 1.7;
        break;
      case 5:
        spawnInterval = 1.4; // Intense
        break;
      case 6:
      case 7:
        spawnInterval = 1.3;
        break;
      case 8:
      case 9:
        spawnInterval = 1.2;
        break;
      case 10:
        spawnInterval = 1.0; // Maximum Chaos
        break;
      default:
        spawnInterval = 3.0;
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
      obs.x += moveAmt * obs.direction;

      // Hit detection (Very simple AABB)
      // Player is @ Left 50px (~0.15), Bottom 100px.
      // Player Box: x: 0.1 to 0.25, y: 0.0 to 0.15 (jumping affects y)
      // We check collision in GameLoopScreen really, but here for cleanup.

      // Cleanup: Use wide bounds to support bidirectional movement (Left spawn starts at -0.6)
      if (obs.x < -1.5 || obs.x > 2.5) {
        // Remove off-screen obstacles
        obstacles.removeAt(i);
      }
    }
  }

  void _spawnObstacle(int level) {
    // Obstacle pools for each level (2-3 types per level for variety)
    List<ObstacleType> obstaclePool = [];

    switch (level) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5: // Campus Grounds
        obstaclePool = [
          ObstacleType.log,
          ObstacleType.puddle,
          ObstacleType.rock,
          ObstacleType.trashCan,
          ObstacleType.hydrant,
          ObstacleType.bench,
          ObstacleType.cone,
        ];
        break;
      case 6: // Playground
        obstaclePool = [
          ObstacleType.tire,
          ObstacleType.cone,
          ObstacleType.backpack
        ];
        break;
      case 7: // Garden
        obstaclePool = [
          ObstacleType.flowerPot,
          ObstacleType.gnome,
          ObstacleType.puddle,
          ObstacleType.rock
        ];
        break;
      case 8: // Meadow
        obstaclePool = [
          ObstacleType.wildFlowers,
          ObstacleType.log,
          ObstacleType.rock
        ];
        break;
      case 9: // Gym
        obstaclePool = [
          ObstacleType.basketBall,
          ObstacleType.soccerBall,
          ObstacleType.gymMat,
          ObstacleType.janitorBucket,
          ObstacleType.cone,
        ];
        break;
      case 10: // Cafeteria
        obstaclePool = [
          ObstacleType.lunchTray,
          ObstacleType.milkCarton,
          ObstacleType.burger,
          ObstacleType.flyingPizza,
          ObstacleType.food,
        ];
        break;
      default:
        obstaclePool = [ObstacleType.log];
    }

    // Randomly select obstacle type from pool
    ObstacleType type = obstaclePool[_random.nextInt(obstaclePool.length)];

    // Realistic sizing based on screen Height
    double width = 0.1;
    double height = 0.1;

    switch (type) {
      case ObstacleType.log:
        width = 0.27; // 0.18 * 1.5
        height = 0.12; // 0.08 * 1.5
        break;
      case ObstacleType.puddle:
        width = 0.18; // 0.12 * 1.5
        height = 0.075; // 0.05 * 1.5
        break;
      case ObstacleType.rock:
        width = 0.15; // 0.10 * 1.5
        height = 0.12; // 0.08 * 1.5
        break;
      case ObstacleType.janitorBucket:
      case ObstacleType.beaker:
        width = 0.15; // 0.10 * 1.5
        height = 0.18; // 0.12 * 1.5
        break;
      case ObstacleType.books:
        width = 0.18; // 0.12 * 1.5
        height = 0.15; // 0.10 * 1.5
        break;
      case ObstacleType.flyingPizza:
      case ObstacleType.food:
        width = 0.12; // 0.08 * 1.5
        height = 0.12; // 0.08 * 1.5
        break;
      case ObstacleType.cone:
        width = 0.12;
        height = 0.15;
        break;
      case ObstacleType.trashCan:
        width = 0.15;
        height = 0.20;
        break;
      case ObstacleType.hydrant:
        width = 0.12;
        height = 0.18;
        break;
      case ObstacleType.bench:
        width = 0.25;
        height = 0.15;
        break;
      case ObstacleType.tire:
        width = 0.15;
        height = 0.15;
        break;
      case ObstacleType.flowerPot:
        width = 0.15;
        height = 0.15;
        break;
      case ObstacleType.gnome:
        width = 0.12;
        height = 0.15;
        break;
      case ObstacleType.basketBall:
      case ObstacleType.soccerBall:
        width = 0.08;
        height = 0.08;
        break;
      case ObstacleType.gymMat:
        width = 0.25;
        height = 0.08;
        break;
      case ObstacleType.burger:
        width = 0.07;
        height = 0.07;
        break;
      case ObstacleType.lunchTray:
        width = 0.18;
        height = 0.10;
        break;
      case ObstacleType.milkCarton:
        width = 0.08;
        height = 0.10;
        break;
      case ObstacleType.wildFlowers:
        width = 0.15;
        height = 0.15;
        break;
      case ObstacleType.car:
        width = 0.50; // More proportional (down from 0.675)
        height = 0.25; // More proportional (down from 0.45)
        break;
      case ObstacleType.backpack:
        width = 0.15;
        height = 0.18;
        break;
      case ObstacleType.goldenBook:
        width = 0.18; // 0.12 * 1.5
        height = 0.18; // 0.12 * 1.5
        break;
    }

    // All obstacles spawn at ground level for consistent gameplay
    double y = 0.0;

    if (type == ObstacleType.goldenBook) {
      y = 0.25; // In the air
      width = 0.18; // 0.12 * 1.5
      height = 0.18; // 0.12 * 1.5
    }

    // Determine spawn side and direction
    double startX = 1.1; // Default right off-screen
    double direction = -1.0; // Default move left

    // Levels 4 & 5: Bi-directional traffic
    if (level >= 4 && type != ObstacleType.goldenBook) {
      if (_random.nextBool()) {
        // 50% chance to spawn from Left
        // Start further back (-0.5) to give reaction time since player is at 0.3
        startX = -0.6; // Moved even further back to be safe
        direction = 1.0; // Move Right
        debugPrint('SPAWN LEFT: Level $level, Type $type');
      } else {
        debugPrint('SPAWN RIGHT: Level $level, Type $type');
      }
    }

    // Randomize obstacle variant (1 or 2)
    int variant = _random.nextBool() ? 1 : 2;

    obstacles.add(
      Obstacle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: startX, // Start off-screen
        y: y,
        width: width,
        height: height,
        direction: direction,
        variant: variant,
      ),
    );
  }

  void clear() {
    obstacles.clear();
  }
}
