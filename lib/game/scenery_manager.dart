import 'dart:math';

enum SceneryType {
  boy,
  girl,
  dogSitting,
  dogStanding,
  squirrel,
  janitor,
  butterfly,
  bird,
  bench
}

class SceneryObject {
  String id;
  SceneryType type;
  double x;
  double y;
  double speedMultiplier;
  int totalFrames;
  int currentFrame;
  double animationTimer;
  double animationSpeed;

  SceneryObject({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    this.speedMultiplier = 1.0,
    this.totalFrames = 2,
    this.currentFrame = 1,
    this.animationTimer = 0,
    this.animationSpeed = 0.35,
  });

  void reset({
    required String id,
    required SceneryType type,
    required double x,
    required double y,
    required double speedMultiplier,
    required int totalFrames,
    required double animationSpeed,
  }) {
    this.id = id;
    this.type = type;
    this.x = x;
    this.y = y;
    this.speedMultiplier = speedMultiplier;
    this.totalFrames = totalFrames;
    this.animationSpeed = animationSpeed;
    currentFrame = 1;
    animationTimer = 0;
  }
}

class SceneryManager {
  final List<SceneryObject> objects = [];
  final Random _random = Random();
  double _spawnTimer = 0;

  void update(double dt, double runSpeed, int level) {
    _spawnTimer += dt;

    // Spawn more frequently in nature levels (Butterfly/Squirrel/Bird)
    // Less frequently in school levels (Boy/Girl/Janitor)
    double spawnInterval =
        7.0 + _random.nextDouble() * 5.0; // 7-12 seconds (Less Clutter)
    if (_spawnTimer > spawnInterval) {
      _spawnObject(level);
      _spawnTimer = 0;
    }

    // Move and animate
    for (int i = objects.length - 1; i >= 0; i--) {
      final obj = objects[i];

      // Scenery moves relative to player runSpeed
      // 0.12 * dt * runSpeed is the base move amount (equivalent to 0.002 per frame at 60fps)
      // We apply a multiplier for parallax effect
      obj.x -= (runSpeed * 0.12 * dt) * obj.speedMultiplier;

      // Animate
      obj.animationTimer += dt;
      if (obj.animationTimer >= obj.animationSpeed) {
        obj.animationTimer = 0;
        obj.currentFrame = (obj.currentFrame % obj.totalFrames) + 1;
      }

      // Cleanup
      // Handle both directions:
      // Normal (Right to Left): x < -0.5
      // Reverse (Left to Right, like Bird): x > 1.5
      if (obj.x < -0.5 || obj.x > 1.5) {
        objects.removeAt(i);
      }
    }
  }

  final List<SceneryObject> _sceneryPool = [];

  void _spawnObject(int level) {
    SceneryType? type;
    double y = 0.0;
    double speedMult = 1.0;
    int frames = 2;

    // Level-specific pools
    List<SceneryType> pool = [];

    if (level == 1) {
      // Primary House: Kids and pets
      pool = [
        SceneryType.boy,
        SceneryType.girl,
        SceneryType.dogSitting,
        SceneryType.bird,
        SceneryType.bench
      ];
    } else if (level == 2) {
      // Forest: Animals
      pool = [SceneryType.squirrel, SceneryType.bird];
    } else if (level == 3) {
      // Fay House: Kids and butterflies
      pool = [
        SceneryType.boy,
        SceneryType.girl,
        SceneryType.butterfly,
        SceneryType.bird,
        SceneryType.bench
      ];
    } else if (level == 4) {
      // Cabin: More animals
      pool = [SceneryType.squirrel, SceneryType.butterfly, SceneryType.bird];
    } else if (level == 5) {
      // Higher Grade House: Janitor and older vibe?
      pool = [
        SceneryType.janitor,
        SceneryType.dogStanding,
        SceneryType.boy,
        SceneryType.girl
      ];
    } else if (level == 6) {
      // Playground: Kids and animals
      pool = [
        SceneryType.boy,
        SceneryType.girl,
        SceneryType.squirrel,
        SceneryType.butterfly
      ];
    } else if (level == 7) {
      // Garden: Butterflies and birds
      pool = [SceneryType.butterfly, SceneryType.bird, SceneryType.squirrel];
    } else if (level == 8) {
      // Meadow: Butterflies and dogs
      pool = [
        SceneryType.butterfly,
        SceneryType.dogSitting,
        SceneryType.bird,
        SceneryType.squirrel
      ];
    } else if (level == 9) {
      // Gym: Kids and janitor (mopping?)
      pool = [SceneryType.boy, SceneryType.girl, SceneryType.janitor];
    } else {
      // Cafeteria etc (None for now as per user request)
      return;
    }

    if (pool.isEmpty) return;
    type = pool[_random.nextInt(pool.length)];

    double animSpeed = 0.35;
    double startX = 1.2; // Default spawn right

    // Configuration
    switch (type) {
      case SceneryType.boy:
      case SceneryType.girl:
        y = 0.0; // Reverted to ground level
        speedMult = 0.2; // Stationary relative to background
        frames = 2;
        animSpeed = 2.0;
        break;
      case SceneryType.dogSitting:
      case SceneryType.dogStanding:
        y = 0.0;
        speedMult = 0.2;
        frames = 2;
        animSpeed = 2.0;
        break;
      case SceneryType.squirrel:
        y = 0.0;
        speedMult = 0.2;
        frames = 4;
        animSpeed = 2.0;
        break;
      case SceneryType.janitor:
        y = 0.0;
        speedMult = 0.2;
        frames = 2;
        animSpeed = 2.0;
        break;
      case SceneryType.bench:
        y = 0.0;
        speedMult = 0.2;
        frames = 1;
        animSpeed = 100.0; // Static
        break;
      case SceneryType.bird:
        y = 0.25 +
            _random.nextDouble() * 0.1; // Lower than butterfly (0.25-0.35)
        // Negative speed to move Right against the scroll
        speedMult = -0.8;
        frames = 2;
        animSpeed = 0.2; // Flapping fast
        startX = -0.2; // Spawn left
        break;
      case SceneryType.butterfly:
        y = 0.4 + _random.nextDouble() * 0.3; // Sky
        speedMult = 0.5; // Very far background relative movement
        frames = 2;
        animSpeed = 0.35; // Fluttering
        break;
    }

    SceneryObject obj;
    if (_sceneryPool.isNotEmpty) {
      obj = _sceneryPool.removeLast();
      obj.reset(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: type,
        x: startX,
        y: y,
        speedMultiplier: speedMult,
        totalFrames: frames,
        animationSpeed: animSpeed,
      );
    } else {
      obj = SceneryObject(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: type,
        x: startX,
        y: y,
        speedMultiplier: speedMult,
        totalFrames: frames,
        animationSpeed: animSpeed,
      );
    }
    objects.add(obj);
  }

  void clear() {
    _sceneryPool.addAll(objects);
    objects.clear();
  }
}
