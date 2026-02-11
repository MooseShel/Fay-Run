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
  apple,
  banana,
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
  bool isCollected; // For Golden Book (to disappear)
  bool
      hasEngaged; // To prevent double-collision while potentially staying on screen

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
    this.hasEngaged = false,
  });
}

class ObstacleManager {
  final List<Obstacle> obstacles = [];
  final Random _random = Random();
  double _spawnTimer = 0;

  void update(double dt, double runSpeed, int level, bool isBonusRound,
      Function(Obstacle) onHit) {
    // Spawn Logic
    _spawnTimer += dt;

    double spawnInterval;
    if (isBonusRound) {
      spawnInterval = 0.4; // Rapid spawning
    } else {
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
    }

    if (_spawnTimer > spawnInterval) {
      _spawnObstacle(level, isBonusRound);
      _spawnTimer = 0;
    }

    // Move & Cleanup
    double moveAmt = (runSpeed * 0.002);

    for (var i = obstacles.length - 1; i >= 0; i--) {
      var obs = obstacles[i];
      obs.x += moveAmt * obs.direction;

      // Cleanup: Use wide bounds to support bidirectional movement (Left spawn starts at -0.6)
      if (obs.x < -1.5 || obs.x > 2.5) {
        // Remove off-screen obstacles
        obstacles.removeAt(i);
      }
    }
  }

  void _spawnObstacle(int level, bool isBonusRound) {
    // Obstacle pools for each level (2-3 types per level for variety)
    List<ObstacleType> obstaclePool = [];

    if (isBonusRound) {
      // Bonus round themes
      switch (level) {
        case 3: // Honor Roll
          obstaclePool = [ObstacleType.goldenBook, ObstacleType.books];
          break;
        case 6: // Recess Rush
          obstaclePool = [
            ObstacleType.burger,
            ObstacleType.banana,
            ObstacleType.apple
          ];
          break;
        case 9: // Victory Lap
          obstaclePool = [ObstacleType.goldenBook, ObstacleType.burger];
          break;
        default:
          obstaclePool = [ObstacleType.apple];
      }
    } else {
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
    }

    // Determine if we should spawn a Global Reward instead of a local obstacle
    ObstacleType type;

    if (isBonusRound) {
      type = obstaclePool[_random.nextInt(obstaclePool.length)];
    } else if (_random.nextDouble() < 0.15) {
      // Pick a reward
      if (_random.nextDouble() < 0.20) {
        type = ObstacleType.goldenBook;
      } else {
        List<ObstacleType> commonRewards = [
          ObstacleType.burger,
          ObstacleType.apple,
          ObstacleType.banana
        ];
        type = commonRewards[_random.nextInt(commonRewards.length)];
      }
    } else {
      type = obstaclePool[_random.nextInt(obstaclePool.length)];
    }

    // Realistic sizing based on screen Height
    double width = 0.1;
    double height = 0.1;

    switch (type) {
      case ObstacleType.log:
        width = 0.27;
        height = 0.12;
        break;
      case ObstacleType.puddle:
        width = 0.27;
        height = 0.1125;
        break;
      case ObstacleType.rock:
        width = 0.15;
        height = 0.12;
        break;
      case ObstacleType.janitorBucket:
      case ObstacleType.beaker:
        width = 0.15;
        height = 0.18;
        break;
      case ObstacleType.books:
        width = 0.18;
        height = 0.15;
        break;
      case ObstacleType.flyingPizza:
      case ObstacleType.food:
        width = 0.18;
        height = 0.18;
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
        width = 0.375;
        height = 0.225;
        break;
      case ObstacleType.tire:
        width = 0.225;
        height = 0.225;
        break;
      case ObstacleType.flowerPot:
        width = 0.225;
        height = 0.225;
        break;
      case ObstacleType.gnome:
        width = 0.18;
        height = 0.225;
        break;
      case ObstacleType.basketBall:
      case ObstacleType.soccerBall:
        width = 0.12;
        height = 0.12;
        break;
      case ObstacleType.gymMat:
        width = 0.375;
        height = 0.12;
        break;
      case ObstacleType.apple:
      case ObstacleType.banana:
      case ObstacleType.burger:
        width = 0.07;
        height = 0.07;
        break;
      case ObstacleType.lunchTray:
        width = 0.27;
        height = 0.15;
        break;
      case ObstacleType.milkCarton:
        width = 0.12;
        height = 0.15;
        break;
      case ObstacleType.wildFlowers:
        width = 0.15;
        height = 0.15;
        break;
      case ObstacleType.car:
        width = 0.50;
        height = 0.25;
        break;
      case ObstacleType.backpack:
        width = 0.15;
        height = 0.18;
        break;
      case ObstacleType.goldenBook:
        width = 0.18;
        height = 0.18;
        break;
    }

    double y = 0.0;
    if (type == ObstacleType.goldenBook ||
        type == ObstacleType.apple ||
        type == ObstacleType.banana ||
        type == ObstacleType.burger) {
      y = 0.25;
    }

    double startX = 1.1;
    double direction = -1.0;

    if (level >= 4 && type != ObstacleType.goldenBook && !isBonusRound) {
      if (_random.nextBool()) {
        startX = -0.6;
        direction = 1.0;
      }
    }

    int variant = _random.nextBool() ? 1 : 2;

    obstacles.add(
      Obstacle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: startX,
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
