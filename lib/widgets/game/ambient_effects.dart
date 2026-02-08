import 'dart:math';
import 'package:flutter/material.dart';

class AmbientEffects extends StatefulWidget {
  final bool enableFireflies;
  final bool enableDragonflies;

  const AmbientEffects({
    super.key,
    this.enableFireflies = true,
    this.enableDragonflies = true,
  });

  @override
  State<AmbientEffects> createState() => _AmbientEffectsState();
}

class _AmbientEffectsState extends State<AmbientEffects>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Firefly> _fireflies = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Init fireflies
    for (int i = 0; i < 20; i++) {
      _fireflies.add(
        _Firefly(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          speedX: (_random.nextDouble() - 0.5) * 0.005,
          speedY: (_random.nextDouble() - 0.5) * 0.005,
          opacity: _random.nextDouble(),
          pulseSpeed: 0.05 + _random.nextDouble() * 0.05,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableFireflies) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update fireflies
        for (var f in _fireflies) {
          f.x += f.speedX;
          f.y += f.speedY;
          // Bounce
          if (f.x < 0 || f.x > 1) f.speedX *= -1;
          if (f.y < 0 || f.y > 1) f.speedY *= -1;

          // Pulse
          f.opacity += f.pulseSpeed;
          if (f.opacity > 1.0 || f.opacity < 0.2) {
            f.pulseSpeed *= -1;
          }
        }

        return CustomPaint(
          size: Size.infinite,
          painter: _FireflyPainter(_fireflies),
        );
      },
    );
  }
}

class _Firefly {
  double x;
  double y;
  double speedX;
  double speedY;
  double opacity;
  double pulseSpeed;

  _Firefly({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.pulseSpeed,
  });
}

class _FireflyPainter extends CustomPainter {
  final List<_Firefly> fireflies;

  _FireflyPainter(this.fireflies);

  @override
  void paint(Canvas canvas, Size size) {
    for (var f in fireflies) {
      final paint = Paint()
        ..color = Colors.yellowAccent.withOpacity(f.opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(f.x * size.width, f.y * size.height),
        3.0,
        paint,
      );

      // Glow
      final glowPaint = Paint()
        ..color = Colors.yellowAccent.withOpacity(
          f.opacity.clamp(0.0, 1.0) * 0.3,
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      canvas.drawCircle(
        Offset(f.x * size.width, f.y * size.height),
        8.0,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FireflyPainter oldDelegate) => true;
}
