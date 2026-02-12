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
  String id;
  ObstacleType type;
  double x;
  double y;
  double width;
  double height;
  double direction;
  int variant;
  bool isCollected;
  bool hasEngaged;

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

  void reset({
    required String id,
    required ObstacleType type,
    required double x,
    required double y,
    required double width,
    required double height,
    required double direction,
    required int variant,
  }) {
    this.id = id;
    this.type = type;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.direction = direction;
    this.variant = variant;
    isCollected = false;
    hasEngaged = false;
  }
}

class ObstacleManager {
  final List<Obstacle> obstacles = [];
  final Random _random = Random();
  double _spawnTimer = 0;
  double _rewardTimer = 0; // Independent timer for academic rewards
  double _rewardInterval = 0; // Dynamic interval for rewards

  ObstacleManager() {
    _rewardInterval = 3.0 + _random.nextDouble() * 3.0; // 3-6 seconds start
  }

  void update(double dt, double runSpeed, int level, bool isBonusRound,
      Function(Obstacle) onHit) {
    // 1. Regular Obstacle Spawn Logic
    _spawnTimer += dt;

    double spawnInterval;
    if (isBonusRound) {
      spawnInterval = 0.4; // Rapid spawning
    } else {
      switch (level) {
        case 1:
        case 2:
          spawnInterval = 3.8;
          break;
        case 3:
          spawnInterval = 3.2;
          break;
        case 4:
          spawnInterval = 2.9;
          break;
        case 5:
          spawnInterval = 2.6;
          break;
        case 6:
          spawnInterval = 2.4;
          break;
        case 7:
          spawnInterval = 2.3;
          break;
        case 8:
          spawnInterval = 2.2;
          break;
        case 9:
          spawnInterval = 2.2;
          break;
        case 10:
          spawnInterval = 2.0;
          break;
        default:
          spawnInterval = 2.0;
      }
    }

    // Check if an obstacle SHOULD spawn
    if (_spawnTimer > spawnInterval) {
      // Logic to prevent overlap:
      // If a reward recently spawned (rewardTimer is low), delay this obstacle
      // Or if a reward is ABOUT to spawn (rewardTimer is high), push the reward back

      // If reward just spawned (< 1.5s ago), delay obstacle
      if (_rewardTimer < 1.5 && !isBonusRound) {
        _spawnTimer = spawnInterval - 0.5; // Wait a bit more
      } else {
        _spawnObstacle(level, isBonusRound, isReward: false);
        _spawnTimer = 0;

        // Push back reward if it was about to spawn to prevent clutter
        if (!isBonusRound && _rewardTimer > _rewardInterval - 1.5) {
          _rewardTimer = _rewardInterval - 1.5;
        }
      }
    }

    // 2. Independent Reward Spawn Logic (Academic plenty)
    if (!isBonusRound) {
      _rewardTimer += dt;
      if (_rewardTimer > _rewardInterval) {
        // Mutual exclusion: Don't spawn if obstacle is about to spawn
        if (_spawnTimer > spawnInterval - 1.5) {
          _rewardTimer = _rewardInterval - 0.5; // Wait for obstacle to clear
        } else {
          _spawnObstacle(level, false, isReward: true);
          _rewardTimer = 0;
          // More frequent rewards: 2 to 5 seconds
          _rewardInterval = 2.0 + _random.nextDouble() * 3.0;
        }
      }
    }

    // 3. Move & Cleanup
    double moveAmt = runSpeed * 0.12 * dt;

    for (var i = obstacles.length - 1; i >= 0; i--) {
      var obs = obstacles[i];
      obs.x += moveAmt * obs.direction;

      if (obs.x < -1.5 || obs.x > 2.5) {
        obstacles.removeAt(i);
      }
    }
  }

  // Object Pooling
  final List<Obstacle> _obstaclePool = [];

  void _spawnObstacle(int level, bool isBonusRound, {bool isReward = false}) {
    List<ObstacleType> obstaclePool = [];

    if (isBonusRound) {
      // Bonus round themes remains unchanged
      switch (level) {
        case 3:
          obstaclePool = [ObstacleType.goldenBook, ObstacleType.books];
          break;
        case 6:
          obstaclePool = [
            ObstacleType.burger,
            ObstacleType.banana,
            ObstacleType.apple
          ];
          break;
        case 9:
          obstaclePool = [ObstacleType.goldenBook, ObstacleType.burger];
          break;
        default:
          obstaclePool = [ObstacleType.apple];
      }
    } else {
      // Regular floor obstacle pools (All rewards removed from here)
      switch (level) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
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
        case 6:
          obstaclePool = [
            ObstacleType.tire,
            ObstacleType.cone,
            ObstacleType.backpack
          ];
          break;
        case 7:
          obstaclePool = [
            ObstacleType.flowerPot,
            ObstacleType.gnome,
            ObstacleType.puddle,
            ObstacleType.rock
          ];
          break;
        case 8:
          obstaclePool = [
            ObstacleType.wildFlowers,
            ObstacleType.log,
            ObstacleType.rock
          ];
          break;
        case 9:
          obstaclePool = [
            ObstacleType.basketBall,
            ObstacleType.soccerBall,
            ObstacleType.gymMat,
            ObstacleType.janitorBucket,
            ObstacleType.cone,
          ];
          break;
        case 10:
          obstaclePool = [
            ObstacleType.lunchTray,
            ObstacleType.milkCarton,
            ObstacleType.flyingPizza,
          ];
          break;
        default:
          obstaclePool = [ObstacleType.log];
      }
    }

    ObstacleType type;

    if (isReward) {
      // Pick a reward specifically
      if (_random.nextDouble() < 0.25) {
        type = ObstacleType.goldenBook;
      } else {
        const rewards = [
          ObstacleType.burger,
          ObstacleType.apple,
          ObstacleType.banana
        ];
        type = rewards[_random.nextInt(rewards.length)];
      }
    } else {
      // Pick a floor obstacle
      type = obstaclePool[_random.nextInt(obstaclePool.length)];
    }

    // Realistic sizing logic remains same ...
    double width = 0.1;
    double height = 0.1;

    switch (type) {
      case ObstacleType.log:
        width = 0.465;
        height = 0.207;
        break;
      case ObstacleType.puddle:
        width = 0.31;
        height = 0.13;
        break;
      case ObstacleType.rock:
        width = 0.17;
        height = 0.14;
        break;
      case ObstacleType.janitorBucket:
      case ObstacleType.beaker:
        width = 0.17;
        height = 0.207;
        break;
      case ObstacleType.books:
        width = 0.207;
        height = 0.17;
        break;
      case ObstacleType.flyingPizza:
      case ObstacleType.food:
        width = 0.207;
        height = 0.207;
        break;
      case ObstacleType.cone:
        width = 0.207;
        height = 0.26;
        break;
      case ObstacleType.trashCan:
        width = 0.17;
        height = 0.23;
        break;
      case ObstacleType.hydrant:
        width = 0.207;
        height = 0.31;
        break;
      case ObstacleType.bench:
        width = 0.43;
        height = 0.26;
        break;
      case ObstacleType.tire:
        width = 0.26;
        height = 0.26;
        break;
      case ObstacleType.flowerPot:
        width = 0.26;
        height = 0.26;
        break;
      case ObstacleType.gnome:
        width = 0.207;
        height = 0.26;
        break;
      case ObstacleType.basketBall:
      case ObstacleType.soccerBall:
        width = 0.14;
        height = 0.14;
        break;
      case ObstacleType.gymMat:
        width = 0.43;
        height = 0.14;
        break;
      case ObstacleType.apple:
      case ObstacleType.banana:
      case ObstacleType.burger:
        width = 0.12;
        height = 0.12;
        break;
      case ObstacleType.lunchTray:
        width = 0.31;
        height = 0.17;
        break;
      case ObstacleType.milkCarton:
        width = 0.14;
        height = 0.17;
        break;
      case ObstacleType.wildFlowers:
        width = 0.17;
        height = 0.17;
        break;
      case ObstacleType.car:
        width = 0.575;
        height = 0.29;
        break;
      case ObstacleType.backpack:
        width = 0.17;
        height = 0.207;
        break;
      case ObstacleType.goldenBook:
        width = 0.207;
        height = 0.207;
        break;
    }

    double y = 0.0;
    if (isBonusRound) {
      final heights = [0.0, 0.25, 0.5];
      y = heights[_random.nextInt(heights.length)];
    } else if (type == ObstacleType.goldenBook) {
      y = 0.25; // Only Golden Book floats now
    }

    double startX = 1.1; // Offscreen Right
    double direction = -1.0;

    if (level >= 4 && type != ObstacleType.goldenBook && !isBonusRound) {
      if (_random.nextBool()) {
        startX = -0.6; // Offscreen Left
        direction = 1.0;
      }
    }

    int variant = _random.nextBool() ? 1 : 2;

    // POOLING: Get from pool or create new
    Obstacle obs;
    if (_obstaclePool.isNotEmpty) {
      obs = _obstaclePool.removeLast();
      obs.reset(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: startX,
        y: y,
        width: width,
        height: height,
        direction: direction,
        variant: variant,
      );
    } else {
      obs = Obstacle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        x: startX,
        y: y,
        width: width,
        height: height,
        direction: direction,
        variant: variant,
      );
    }

    obstacles.add(obs);
  }

  void clear() {
    // Return all active obstacles to pool
    _obstaclePool.addAll(obstacles);
    obstacles.clear();
  }
}
