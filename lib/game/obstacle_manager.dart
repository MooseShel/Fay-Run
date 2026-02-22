import 'dart:math';
import 'package:flutter/material.dart' show Size;

enum ObstacleType {
  log, // Levels 2 (Forest), 4 (Cabin), 8 (Meadow)
  puddle, // Levels 2, 4, 8
  rock, // Levels 2, 4, 7, 8
  janitorBucket, // Level 9 (Gym)
  books, // Level 2 & 3 (Pre-refine leftover, kept for variety)
  beaker, // Level 3 (Scientific leftover)
  food, // Level 10 (Cafeteria)
  cone, // Levels 1, 5, 6, 9
  backpack, // Levels 1, 3, 6 (School Houses)
  trashCan, // Levels 1, 3, 5 (School Grounds)
  hydrant, // Levels 1, 3, 5 (School Grounds)
  tire, // Level 6 (Playground)
  flowerPot, // Level 7 (Garden)
  gnome, // Level 7 (Garden)
  basketBall, // Level 9 (Gym)
  soccerBall, // Level 9 (Gym)
  gymMat, // Level 9 (Gym)
  burger, // Rewards / Level 10
  lunchTray, // Level 10 (Cafeteria)
  milkCarton, // Level 10 (Cafeteria)
  wildFlowers, // Levels 7, 8 (Garden/Meadow)
  goldenBook, // Quiz Gate (Special)
  apple,
  banana,
  egg,
  heart,
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
  double crackedTime; // Time since egg cracked (replaces Future.delayed)

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
    this.crackedTime = 0,
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
    crackedTime = 0;
  }
}

class ObstacleManager {
  static const int maxObstacles = 25; // Prevent unbounded growth on web
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
      {required Size screenSize,
      double bonusTimeElapsed = 0,
      double levelProgress = 0,
      double heartSpawnProgress = 1.0,
      bool hasHeartSpawned = true,
      Function()? onHeartSpawned}) {
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

    // Check if an obstacle SHOULD spawn (with cap to prevent unbounded growth)
    if (_spawnTimer > spawnInterval && obstacles.length < maxObstacles) {
      // Check if space is clear offscreen (startX is roughly 1.1 to 1.5 usually)
      if (isBonusRound && level == 2) {
        // Chicken Coop: Always spawn if timer allows
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
        if (_isPositionClear(1.1, 0.25)) {
          _spawnObstacle(level, false, isReward: true);
          _rewardTimer = 0;
          _rewardInterval = 2.5 + _random.nextDouble() * 3.125;
        }
      }
    }

    // 3. Heart Spawn Logic (Once per level at random time)
    if (!isBonusRound &&
        !hasHeartSpawned &&
        levelProgress >= heartSpawnProgress) {
      if (_isPositionClear(1.1, 0.4)) {
        _spawnObstacle(level, false, isHeart: true);
        onHeartSpawned?.call();
      }
    }

    // 4. Move & Cleanup
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
          // Standard fall physics
          obs.dy += 0.4 * dt;
          obs.y -= obs.dy * dt;

          // Check for ground hit
          if (obs.y <= 0) {
            obs.y = 0;
            obs.dy = 0;
            obs.isCracked = true;
            obs.hasEngaged = true; // Prevent collision now
            obs.crackedTime = 0; // Start removal countdown
          }
        } else {
          // Egg is cracked on ground — count up and remove after 1s
          obs.crackedTime += dt;
          if (obs.crackedTime >= 1.0) {
            obs.isCollected = true;
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
      {bool isReward = false,
      bool isHeart = false,
      double bonusTimeElapsed = 0}) {
    List<ObstacleType> obstaclePool = [];

    if (isHeart) {
      obstaclePool = [ObstacleType.heart];
    } else if (isBonusRound) {
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
        case 1: // Primary House
          obstaclePool = [
            ObstacleType.trashCan,
            ObstacleType.hydrant,
            ObstacleType.cone,
            ObstacleType.backpack,
          ];
          break;
        case 2: // Forest
          obstaclePool = [
            ObstacleType.log,
            ObstacleType.puddle,
            ObstacleType.rock,
          ];
          break;
        case 3: // Fay House
          obstaclePool = [
            ObstacleType.trashCan,
            ObstacleType.hydrant,
            ObstacleType.backpack,
          ];
          break;
        case 4: // Cabin
          obstaclePool = [
            ObstacleType.log,
            ObstacleType.puddle,
            ObstacleType.rock,
          ];
          break;
        case 5: // Higher Grade House
          obstaclePool = [
            ObstacleType.trashCan,
            ObstacleType.hydrant,
            ObstacleType.cone,
          ];
          break;
        case 6: // Playground
          obstaclePool = [
            ObstacleType.tire,
            ObstacleType.cone,
            ObstacleType.backpack,
          ];
          break;
        case 7: // Garden
          obstaclePool = [
            ObstacleType.flowerPot,
            ObstacleType.gnome,
            ObstacleType.wildFlowers,
            ObstacleType.rock,
          ];
          break;
        case 8: // Meadow
          obstaclePool = [
            ObstacleType.wildFlowers,
            ObstacleType.puddle,
            ObstacleType.log,
          ];
          break;
        case 9: // Gym
          obstaclePool = [
            ObstacleType.basketBall,
            ObstacleType.soccerBall,
            ObstacleType.gymMat,
            ObstacleType.janitorBucket,
          ];
          break;
        case 10: // Cafeteria
          obstaclePool = [
            ObstacleType.lunchTray,
            ObstacleType.milkCarton,
            ObstacleType.food,
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

    if (isHeart) type = ObstacleType.heart;

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
      case ObstacleType.heart:
        width = 0.3; // Easily recognized size
        height = 0.3;
        break;
    }

    double y = 0.0;
    double dy = 0.0;
    double startX = 1.1; // Offscreen Right
    double direction = -1.0;
    int variant = _random.nextBool() ? 1 : 2;
    if (type == ObstacleType.milkCarton) {
      variant = _random.nextInt(3) + 1; // 1, 2, or 3
    }

    if (isBonusRound) {
      if (type == ObstacleType.egg) {
        // Eggs now fall from the top of the screen (sky)
        y = 1.0;
        // Random horizontal position across the full play area (0.1 to 0.9)
        startX = 0.1 + _random.nextDouble() * 0.8;
        variant = _random.nextInt(5); // Random chicken flavor
        dy = 0.15 + (bonusTimeElapsed / 20.0) * 0.15;
        direction = 0.0; // Straight down
      } else {
        final heights = [0.0, 0.25, 0.5];
        y = heights[_random.nextInt(heights.length)];
      }
    } else if (type == ObstacleType.goldenBook) {
      y = 0.25; // Only Golden Book floats now
    } else if (type == ObstacleType.heart) {
      y = 0.45; // High enough to require a jump
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
