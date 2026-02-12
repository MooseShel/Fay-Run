import 'dart:math';

enum SceneryType {
  boy,
  girl,
  dogSitting,
  dogStanding,
  squirrel,
  janitor,
  butterfly
}

class SceneryObject {
  final String id;
  final SceneryType type;
  double x;
  double y;
  final double speedMultiplier;
  final int totalFrames;
  int currentFrame;
  double animationTimer;
  final double animationSpeed;

  SceneryObject({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    this.speedMultiplier = 1.0,
    this.totalFrames = 2,
    this.currentFrame = 1,
    this.animationTimer = 0,
    this.animationSpeed = 0.35, // Seconds per frame (Slower for smoother look)
  });
}

class SceneryManager {
  final List<SceneryObject> objects = [];
  final Random _random = Random();
  double _spawnTimer = 0;

  void update(double dt, double runSpeed, int level) {
    _spawnTimer += dt;

    // Spawn more frequently in nature levels (Butterfly/Squirrel)
    // Less frequently in school levels (Boy/Girl/Janitor)
    double spawnInterval = 3.0 + _random.nextDouble() * 3.0; // 3-6 seconds
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
      if (obj.x < -0.5) {
        objects.removeAt(i);
      }
    }
  }

  void _spawnObject(int level) {
    SceneryType? type;
    double y = 0.0;
    double speedMult = 1.0;
    int frames = 2;

    // Level-specific pools
    List<SceneryType> pool = [];
    if (level <= 5) {
      // Campus Grounds
      pool = [
        SceneryType.dogSitting,
        SceneryType.dogStanding,
        SceneryType.squirrel
      ];
      if (level == 3) pool.add(SceneryType.janitor);
    } else if (level == 6) {
      // Playground
      pool = [SceneryType.boy, SceneryType.girl, SceneryType.squirrel];
    } else if (level == 7 || level == 8) {
      // Garden/Meadow
      pool = [
        SceneryType.butterfly,
        SceneryType.squirrel,
        SceneryType.dogSitting
      ];
    } else if (level == 9) {
      // Gym
      pool = [SceneryType.boy, SceneryType.girl, SceneryType.janitor];
    } else {
      // Cafeteria etc (None for now as per user request)
      return;
    }

    if (pool.isEmpty) return;
    type = pool[_random.nextInt(pool.length)];

    double animSpeed = 0.35;

    // Configuration
    switch (type) {
      case SceneryType.boy:
      case SceneryType.girl:
        y = 0.08; // Moved up/back
        speedMult = 0.2; // Stationary relative to background
        frames = 2;
        animSpeed = 0.6; // Slower animation for standing/idle look
        break;
      case SceneryType.dogSitting:
      case SceneryType.dogStanding:
        y = 0.08;
        speedMult = 0.2;
        frames = 2;
        animSpeed = 0.6;
        break;
      case SceneryType.squirrel:
        y = 0.08;
        speedMult = 0.2;
        frames = 4;
        animSpeed = 0.6;
        break;
      case SceneryType.janitor:
        y = 0.08;
        speedMult = 0.2;
        frames = 2;
        animSpeed = 0.6;
        break;
      case SceneryType.butterfly:
        y = 0.4 + _random.nextDouble() * 0.3; // Sky
        speedMult = 0.5; // Very far background
        frames = 2;
        animSpeed = 0.35; // Fluttering
        break;
    }

    objects.add(SceneryObject(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      x: 1.2, // Spawn off-screen
      y: y,
      speedMultiplier: speedMult,
      totalFrames: frames,
      animationSpeed: animSpeed,
    ));
  }

  void clear() {
    objects.clear();
  }
}
