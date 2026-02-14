import 'dart:math';
import 'package:flutter/material.dart' show Size;

enum ObstacleType {
  log, // Level 1 (Bayou)
  puddle, // Level 1 (Bayou)
  rock, // Level 1 (Bayou)
  janitorBucket, // Level 2 (Hallway)
  books, // Level 2 & 3 (Hallway/Lab)
  beaker, // Level 3 (Scientific)
  flyingPizza, // Level 4 (Cafeteria)
  food, // Level 4 (Cafeteria)
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
  egg,
}

class Obstacle {
  String id;
  ObstacleType type;
  double x;
  double y;
  double width;
  double height;
  double direction;
  double dy; // Vertical velocity
  int variant;
  bool isCollected;
  bool hasEngaged;
  bool isCracked;

  Obstacle({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.direction = -1.0,
    this.dy = 0.0,
    this.variant = 1,
    this.isCollected = false,
    this.hasEngaged = false,
    this.isCracked = false,
  });

  void reset({
    required String id,
    required ObstacleType type,
    required double x,
    required double y,
    required double width,
    required double height,
    required double direction,
    double dy = 0.0,
    required int variant,
  }) {
    this.id = id;
    this.type = type;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.direction = direction;
    this.dy = dy;
    this.variant = variant;
    isCollected = false;
    hasEngaged = false;
    isCracked = false;
  }
}

class ObstacleManager {
  final List<Obstacle> obstacles = [];
  final Random _random = Random();
  double _spawnTimer = 0;
  double _rewardTimer = 0; // Independent timer for academic rewards
  double _rewardInterval = 0; // Dynamic interval for rewards

  ObstacleManager() {
    _rewardInterval = 3.75 +
        _random.nextDouble() *
            3.75; // Increased by 25% to reduce frequency by 20%
  }

  void update(double dt, double runSpeed, int level, bool isBonusRound,
      Function(Obstacle) onHit,
      {required Size screenSize, double bonusTimeElapsed = 0}) {
    // 1. Regular Obstacle Spawn Logic
    _spawnTimer += dt;

    double spawnInterval;
    if (isBonusRound) {
      // Rapid spawning in bonus rounds
      if (level == 2) {
        // Start at 0.8s, decrease to 0.4s over 15 seconds
        spawnInterval = 0.8 - (bonusTimeElapsed / 15.0) * 0.4;
        if (spawnInterval < 0.4) spawnInterval = 0.4;
      } else {
        spawnInterval = 0.4;
      }
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
      // Check if space is clear offscreen (startX is roughly 1.1 to 1.5 usually)
      if (isBonusRound && level == 2) {
        // Chicken Coop: Always spawn if timer allows, horizontal space check
        _spawnObstacle(level, isBonusRound,
            isReward: false, bonusTimeElapsed: bonusTimeElapsed);
        _spawnTimer = 0;
      } else if (_isPositionClear(1.1, 0.4)) {
        _spawnObstacle(level, isBonusRound, isReward: false);
        _spawnTimer = 0;
      }
    }

    // 2. Independent Reward Spawn Logic (Academic plenty)
    if (!isBonusRound) {
      _rewardTimer += dt;
      if (_rewardTimer > _rewardInterval) {
        // Reward priority: Try harder to spawn rewards
        // We use a smaller clearance for rewards to ensure they appear
        if (_isPositionClear(1.1, 0.25)) {
          _spawnObstacle(level, false, isReward: true);
          _rewardTimer = 0;
          // Education First: Balanced rewards (Further reduced by 20% per user request)
          _rewardInterval = 2.5 + _random.nextDouble() * 3.125;
        }
      }
    }

    // 3. Move & Cleanup
    // PHYSICS NORMALIZATION:
    // runSpeed (e.g. 4.0) represents logical "widths per second" relative to ScreenHeight.
    // Convert this to a relative X shift (fraction of ScreenWidth).
    double logicalWidth = screenSize.width / screenSize.height;
    double moveAmt = (runSpeed * 0.15 * dt) / logicalWidth;

    for (var i = obstacles.length - 1; i >= 0; i--) {
      var obs = obstacles[i];

      if (obs.type == ObstacleType.egg) {
        if (!obs.isCracked) {
          // Eggs fall downwards with acceleration
          // Even slower acceleration
          obs.dy += 0.4 * dt; // Slowed down from 0.6
          obs.y -= obs.dy * dt;

          // Check for ground hit
          if (obs.y <= 0) {
            obs.y = 0;
            obs.dy = 0;
            obs.isCracked = true;
            obs.hasEngaged = true; // Prevent collision now

            // Start removal timer (1 second)
            Future.delayed(const Duration(seconds: 1), () {
              obs.isCollected = true;
            });
          }
        }
      } else {
        obs.x += moveAmt * obs.direction;
      }

      if (obs.x < -1.5 || obs.x > 2.5 || (obs.y < -0.2 && !obs.isCracked)) {
        obstacles.removeAt(i);
      } else if (obs.isCollected) {
        // Collectible vanished
        obstacles.removeAt(i);
      }
    }
  }

  // Object Pooling
  final List<Obstacle> _obstaclePool = [];

  void _spawnObstacle(int level, bool isBonusRound,
      {bool isReward = false, double bonusTimeElapsed = 0}) {
    List<ObstacleType> obstaclePool = [];

    if (isBonusRound) {
      switch (level) {
        case 2:
          obstaclePool = [ObstacleType.egg];
          break;
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
      // Regular floor obstacle pools
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
        width = 0.17;
        height = 0.17;
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
        width = 0.37;
        height = 0.20;
        break;
      case ObstacleType.milkCarton:
        width = 0.17;
        height = 0.20;
        break;
      case ObstacleType.wildFlowers:
        width = 0.17;
        height = 0.17;
        break;
      case ObstacleType.backpack:
        width = 0.17;
        height = 0.207;
        break;
      case ObstacleType.goldenBook:
        width = 0.207;
        height = 0.207;
        break;
      case ObstacleType.egg:
        width = 0.12;
        height = 0.12;
        break;
    }

    double y = 0.0;
    double dy = 0.0;
    double startX = 1.1; // Offscreen Right
    double direction = -1.0;
    int variant = _random.nextBool() ? 1 : 2;

    if (isBonusRound) {
      if (type == ObstacleType.egg) {
        y = 0.82; // Lowered to matching chickens' bodies
        // Tighter fixed chicken positions to match steel cover
        const chickenXs = [0.28, 0.39, 0.5, 0.61, 0.72];
        int chickenIdx = _random.nextInt(5);
        startX = chickenXs[chickenIdx];
        variant = chickenIdx; // Store which chicken spawned it (0-4)
        // Even slower initial fall speed (will accelerate in update)
        dy = 0.12 + (bonusTimeElapsed / 20.0) * 0.15;
        direction = 0.0; // Stationary horizontally
      } else {
        final heights = [0.0, 0.25, 0.5];
        y = heights[_random.nextInt(heights.length)];
      }
    } else if (type == ObstacleType.goldenBook) {
      y = 0.25; // Only Golden Book floats now
    }

    if (level >= 4 && type != ObstacleType.goldenBook && !isBonusRound) {
      if (_random.nextBool()) {
        startX = -0.6; // Offscreen Left
        direction = 1.0;
      }
    }

    // POOLING
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
        dy: dy,
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
        dy: dy,
        variant: variant,
      );
    }

    obstacles.add(obs);
  }

  bool _isPositionClear(double x, double safeDistance) {
    for (var obs in obstacles) {
      if ((obs.x - x).abs() < safeDistance) {
        return false;
      }
    }
    return true;
  }

  void clear() {
    _obstaclePool.addAll(obstacles);
    obstacles.clear();
  }
}
