import 'dart:math';
import 'package:flutter/material.dart';

enum ParticleType {
  firefly, // Level 1 - yellow glow, random movement
  paper, // Level 2 - white rectangles, falling
  bubble, // Level 3 - transparent, upward
  food, // Level 4 - food icons, floating
  exhaust, // Level 5 - gray, horizontal drift
  leaf, // Levels 1-5 - green/brown, fluttering
  petal, // Level 7 - pink/white, drifting
  butterfly, // Level 8 - colorful, jittery
  dust, // Level 9 - light grey, slow suspension
}

class AmbientEffects extends StatefulWidget {
  final int level;

  const AmbientEffects({super.key, required this.level});

  @override
  State<AmbientEffects> createState() => _AmbientEffectsState();
}

class _AmbientEffectsState extends State<AmbientEffects>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _initParticles();
  }

  @override
  void didUpdateWidget(AmbientEffects oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.level != widget.level) {
      _initParticles();
    }
  }

  void _initParticles() {
    _particles.clear();

    // Determine particle type based on level
    ParticleType type;
    switch (widget.level) {
      case 1:
      case 3:
      case 5:
        type = ParticleType.leaf; // Campus Landscape Outside
        break;
      case 2:
      case 4:
      case 6: // Playground
        type = ParticleType.firefly; // Indoor & Playground
        break;
      case 7: // Garden
        type = ParticleType.petal;
        break;
      case 8: // Meadow
        type = ParticleType.butterfly;
        break;
      case 9: // Gym
        type = ParticleType.dust;
        break;
      case 10: // Cafeteria
        type = ParticleType.food;
        break;
      default:
        type = ParticleType.leaf;
    }

    // Create particles
    int count = 20;
    if (type == ParticleType.food) count = 10;
    if (type == ParticleType.firefly) count = 15;
    if (type == ParticleType.dust) count = 30; // More dust for visibility

    for (int i = 0; i < count; i++) {
      _particles.add(
        _Particle(
          type: type,
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speedX: _getSpeedX(type),
          speedY: _getSpeedY(type),
          opacity: _random.nextDouble(),
          pulseSpeed: 0.05 + _random.nextDouble() * 0.05,
          rotation: _random.nextDouble() * 2 * pi,
          rotationSpeed: (_random.nextDouble() - 0.5) * 0.1,
          size: _getSize(type),
          foodIcon: _random.nextInt(3), // 0=pizza, 1=apple, 2=burger
        ),
      );
    }
  }

  double _getSpeedX(ParticleType type) {
    switch (type) {
      case ParticleType.firefly:
        return (_random.nextDouble() - 0.5) * 0.005;
      case ParticleType.paper:
        return (_random.nextDouble() - 0.5) * 0.002; // Gentle sway
      case ParticleType.bubble:
        return (_random.nextDouble() - 0.5) * 0.003; // Wobble
      case ParticleType.food:
        return (_random.nextDouble() - 0.5) * 0.002;
      case ParticleType.exhaust:
        return 0.008 + _random.nextDouble() * 0.004; // Drift right
      case ParticleType.leaf:
        return 0.004 + _random.nextDouble() * 0.003; // Drift left
      case ParticleType.petal:
        return 0.003 + _random.nextDouble() * 0.002;
      case ParticleType.butterfly:
        return (_random.nextDouble() - 0.5) * 0.01; // Erratic
      case ParticleType.dust:
        return (_random.nextDouble() - 0.5) * 0.001;
    }
  }

  double _getSpeedY(ParticleType type) {
    switch (type) {
      case ParticleType.firefly:
        return (_random.nextDouble() - 0.5) * 0.005;
      case ParticleType.paper:
        return 0.003 + _random.nextDouble() * 0.002; // Fall down
      case ParticleType.bubble:
        return -0.004 - _random.nextDouble() * 0.002; // Float up
      case ParticleType.food:
        return (_random.nextDouble() - 0.5) * 0.003; // Gentle float
      case ParticleType.exhaust:
        return (_random.nextDouble() - 0.5) * 0.002; // Slight drift
      case ParticleType.leaf:
        return 0.002 + _random.nextDouble() * 0.002; // Falling
      case ParticleType.petal:
        return 0.004 + _random.nextDouble() * 0.002; // Falling
      case ParticleType.butterfly:
        return (_random.nextDouble() - 0.5) * 0.01; // Erratic
      case ParticleType.dust:
        return (_random.nextDouble() - 0.5) * 0.001;
    }
  }

  double _getSize(ParticleType type) {
    switch (type) {
      case ParticleType.firefly:
        return 4.5;
      case ParticleType.paper:
        return 12.0 + _random.nextDouble() * 6.0;
      case ParticleType.bubble:
        return 6.0 + _random.nextDouble() * 6.0;
      case ParticleType.food:
        return 15.0 + _random.nextDouble() * 7.5;
      case ParticleType.exhaust:
        return 9.0 + _random.nextDouble() * 9.0;
      case ParticleType.leaf:
        return 8.0 + _random.nextDouble() * 6.0;
      case ParticleType.petal:
        return 6.0 + _random.nextDouble() * 4.0;
      case ParticleType.butterfly:
        return 10.0 + _random.nextDouble() * 5.0;
      case ParticleType.dust:
        return 3.0 + _random.nextDouble() * 3.0; // Slightly larger
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update particles
        for (var p in _particles) {
          p.x += p.speedX;
          p.y += p.speedY;
          p.rotation += p.rotationSpeed;

          // Wrap around or bounce based on type
          if (p.type == ParticleType.firefly) {
            // Bounce
            if (p.x < 0 || p.x > 1) p.speedX *= -1;
            if (p.y < 0 || p.y > 1) p.speedY *= -1;
          } else {
            // Wrap around
            if (p.x < -0.1) p.x = 1.1;
            if (p.x > 1.1) p.x = -0.1;
            if (p.y < -0.1) p.y = 1.1;
            if (p.y > 1.1) p.y = -0.1;
          }

          // Pulse opacity for some types
          if (p.type == ParticleType.firefly ||
              p.type == ParticleType.exhaust ||
              p.type == ParticleType.dust) {
            p.opacity += p.pulseSpeed;
            if (p.opacity > 1.0 || p.opacity < 0.2) {
              p.pulseSpeed *= -1;
            }
          }
        }

        return CustomPaint(
          size: Size.infinite,
          painter: _ParticlePainter(_particles),
        );
      },
    );
  }
}

class _Particle {
  final ParticleType type;
  double x;
  double y;
  double speedX;
  double speedY;
  double opacity;
  double pulseSpeed;
  double rotation;
  double rotationSpeed;
  double size;
  int foodIcon; // 0=pizza, 1=apple, 2=burger

  _Particle({
    required this.type,
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.pulseSpeed,
    required this.rotation,
    required this.rotationSpeed,
    required this.size,
    this.foodIcon = 0,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final pos = Offset(p.x * size.width, p.y * size.height);

      switch (p.type) {
        case ParticleType.firefly:
          _drawFirefly(canvas, pos, p);
          break;
        case ParticleType.paper:
          _drawPaper(canvas, pos, p, size);
          break;
        case ParticleType.bubble:
          _drawBubble(canvas, pos, p);
          break;
        case ParticleType.food:
          _drawFood(canvas, pos, p);
          break;
        case ParticleType.exhaust:
          _drawExhaust(canvas, pos, p);
          break;
        case ParticleType.leaf:
          _drawLeaf(canvas, pos, p);
          break;
        case ParticleType.petal:
          _drawPetal(canvas, pos, p);
          break;
        case ParticleType.butterfly:
          _drawButterfly(canvas, pos, p);
          break;
        case ParticleType.dust:
          _drawDust(canvas, pos, p);
          break;
      }
    }
  }

  void _drawFirefly(Canvas canvas, Offset pos, _Particle p) {
    final paint = Paint()
      ..color = Colors.yellowAccent.withValues(alpha: p.opacity.clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pos, p.size, paint);

    // Glow
    final glowPaint = Paint()
      ..color =
          Colors.yellowAccent.withValues(alpha: p.opacity.clamp(0.0, 1.0) * 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(pos, p.size * 2.5, glowPaint);
  }

  void _drawPaper(Canvas canvas, Offset pos, _Particle p, Size size) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(p.rotation);

    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    // Draw "open book" shape (two rects with a gap/spine)
    final double width = p.size * 1.5;
    final double height = p.size;

    // Left page
    final leftPage = Rect.fromCenter(
      center: Offset(-width * 0.25, 0),
      width: width * 0.5,
      height: height,
    );
    canvas.drawRect(leftPage, paint);

    // Right page
    final rightPage = Rect.fromCenter(
      center: Offset(width * 0.25, 0),
      width: width * 0.5,
      height: height,
    );
    canvas.drawRect(rightPage, paint);

    // Spine/Border
    final borderPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(leftPage, borderPaint);
    canvas.drawRect(rightPage, borderPaint);

    // Spine center line
    canvas.drawLine(
      Offset(0, -height / 2),
      Offset(0, height / 2),
      borderPaint..color = Colors.black12,
    );

    canvas.restore();
  }

  void _drawBubble(Canvas canvas, Offset pos, _Particle p) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pos, p.size, paint);

    // Border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(pos, p.size, borderPaint);

    // Shine
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      pos + Offset(-p.size * 0.3, -p.size * 0.3),
      p.size * 0.3,
      shinePaint,
    );
  }

  void _drawFood(Canvas canvas, Offset pos, _Particle p) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(p.rotation);

    final paint = Paint()..style = PaintingStyle.fill;

    // Draw different food icons
    switch (p.foodIcon) {
      case 0: // Pizza slice
        paint.color = Colors.orange;
        final path = Path()
          ..moveTo(0, -p.size)
          ..lineTo(p.size * 0.8, p.size * 0.5)
          ..lineTo(-p.size * 0.8, p.size * 0.5)
          ..close();
        canvas.drawPath(path, paint);
        // Pepperoni
        paint.color = Colors.red;
        canvas.drawCircle(Offset(0, 0), p.size * 0.2, paint);
        break;
      case 1: // Apple
        paint.color = Colors.red;
        canvas.drawCircle(Offset.zero, p.size * 0.5, paint);
        // Leaf
        paint.color = Colors.green;
        canvas.drawCircle(
          Offset(p.size * 0.3, -p.size * 0.4),
          p.size * 0.2,
          paint,
        );
        break;
      case 2: // Burger
        paint.color = Colors.brown;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.6,
          ),
          paint,
        );
        // Cheese
        paint.color = Colors.yellow;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(0, -p.size * 0.2),
            width: p.size * 0.9,
            height: p.size * 0.2,
          ),
          paint,
        );
        break;
    }

    canvas.restore();
  }

  void _drawExhaust(Canvas canvas, Offset pos, _Particle p) {
    final paint = Paint()
      ..color = Colors.grey.shade600.withValues(
        alpha: p.opacity.clamp(0.0, 1.0) * 0.5,
      )
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.5);

    canvas.drawCircle(pos, p.size, paint);
  }

  void _drawLeaf(Canvas canvas, Offset pos, _Particle p) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(p.rotation);

    final paint = Paint()
      ..color = (p.foodIcon % 2 == 0 ? Colors.green[700]! : Colors.orange[800]!)
          .withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, -p.size)
      ..quadraticBezierTo(p.size * 0.5, 0, 0, p.size)
      ..quadraticBezierTo(-p.size * 0.5, 0, 0, -p.size);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawPetal(Canvas canvas, Offset pos, _Particle p) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(p.rotation);

    final paint = Paint()
      ..color = Colors.pink[100]!.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 1.5),
      paint,
    );
    canvas.restore();
  }

  void _drawButterfly(Canvas canvas, Offset pos, _Particle p) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    // Butterfly "flapping" by scaling X
    final flap = 0.5 + 0.5 * sin(DateTime.now().millisecondsSinceEpoch * 0.02);
    canvas.scale(flap, 1.0);
    canvas.rotate(p.rotation);

    final paint = Paint()
      ..color = Colors.orangeAccent.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(-p.size * 0.4, 0), p.size * 0.6, paint);
    canvas.drawCircle(Offset(p.size * 0.4, 0), p.size * 0.6, paint);

    paint.color = Colors.black;
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: p.size * 0.2, height: p.size),
      paint,
    );
    canvas.restore();
  }

  void _drawDust(Canvas canvas, Offset pos, _Particle p) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: p.opacity * 0.6) // More opaque
      ..style = PaintingStyle.fill;

    canvas.drawCircle(pos, p.size, paint);
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
