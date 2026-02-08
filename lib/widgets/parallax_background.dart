import 'package:flutter/material.dart';
import '../../core/constants.dart';

class ParallaxBackground extends StatefulWidget {
  final double runSpeed;
  final bool isPaused;
  final int level;

  const ParallaxBackground({
    super.key,
    required this.runSpeed,
    required this.isPaused,
    this.level = 1,
  });

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 16),
          )
          ..addListener(_updateScroll)
          ..repeat();
  }

  void _updateScroll() {
    if (widget.isPaused) return;
    setState(() {
      _scrollOffset += widget.runSpeed;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParallaxPainter(
        scrollOffset: _scrollOffset,
        level: widget.level,
      ),
      size: Size.infinite,
    );
  }
}

class ParallaxPainter extends CustomPainter {
  final double scrollOffset;
  final int level;

  ParallaxPainter({required this.scrollOffset, required this.level});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Sky / Background Base
    _drawSky(canvas, size, level);

    // 2. Far Layer (Slow)
    _drawFarLayer(canvas, size, scrollOffset * 0.2, level);

    // 3. Near Layer (Fast)
    _drawNearLayer(canvas, size, scrollOffset, level);
  }

  void _drawSky(Canvas canvas, Size size, int level) {
    Color color;
    switch (level) {
      case 1:
        color = Colors.lightBlueAccent;
        break; // Bayou Sky
      case 2:
        color = const Color(0xFFE0E0E0);
        break; // Hallway Wall (Grey)
      case 3:
        color = const Color(0xFFF0F0F0);
        break; // Lab Wall (White)
      case 4:
        color = const Color(0xFFFFE0B2);
        break; // Cafeteria Wall (Orange tint)
      case 5:
        color = Colors.blueGrey;
        break; // Outside Sky
      default:
        color = Colors.lightBlueAccent;
    }

    final paint = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  void _drawFarLayer(Canvas canvas, Size size, double offset, int level) {
    final paint = Paint();
    double width = 100.0; // Pattern width

    // Draw repeating pattern
    double startX = -(offset % width);

    for (double x = startX; x < size.width; x += width) {
      if (level == 1) {
        // Trees
        paint.color = Colors.green[800]!;
        canvas.drawRect(
          Rect.fromLTWH(x + 20, size.height * 0.4, 40, size.height * 0.6),
          paint,
        );
        canvas.drawCircle(Offset(x + 40, size.height * 0.4), 30, paint);
      } else if (level == 2) {
        // Lockers
        paint.color = FayColors.navy;
        canvas.drawRect(
          Rect.fromLTWH(x + 10, size.height * 0.3, 80, size.height * 0.7),
          paint,
        );
        // Vents
        paint.color = Colors.grey;
        canvas.drawRect(
          Rect.fromLTWH(x + 20, size.height * 0.35, 60, 10),
          paint,
        );
      } else if (level == 3) {
        // Lab Shelves
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromLTWH(x, size.height * 0.4, 90, 10), paint);
        // Beakers on shelf
        paint.color = Colors.purple.withOpacity(0.5);
        canvas.drawRect(
          Rect.fromLTWH(x + 20, size.height * 0.35, 10, 15),
          paint,
        );
      } else if (level == 4) {
        // Posters / Windows
        paint.color = Colors.blue.withOpacity(0.3);
        canvas.drawRect(
          Rect.fromLTWH(x + 10, size.height * 0.2, 50, 50),
          paint,
        );
      } else if (level == 5) {
        // Buildings / Fence
        paint.color = FayColors.brickRed;
        canvas.drawRect(
          Rect.fromLTWH(x, size.height * 0.5, 90, size.height * 0.5),
          paint,
        );
      }
    }
  }

  void _drawNearLayer(Canvas canvas, Size size, double offset, int level) {
    final paint = Paint();

    // Ground / Floor
    switch (level) {
      case 1:
        paint.color = const Color(0xFF5D4037);
        break; // Mud
      case 2:
        paint.color = const Color(0xFFBCAAA4);
        break; // Tile
      case 3:
        paint.color = const Color(0xFFEEEEEE);
        break; // Clean Tile
      case 4:
        paint.color = const Color(0xFFFFCC80);
        break; // Wood/Linoleum
      case 5:
        paint.color = const Color(0xFF424242);
        break; // Asphalt
      default:
        paint.color = const Color(0xFF5D4037);
    }

    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 100, size.width, 100),
      paint,
    );

    // Road strips for Carpool
    if (level == 5) {
      paint.color = Colors.yellow;
      double dashWidth = 40;
      double startX = -(offset % (dashWidth * 2));
      for (double x = startX; x < size.width; x += dashWidth * 2) {
        canvas.drawRect(
          Rect.fromLTWH(x, size.height - 50, dashWidth, 5),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParallaxPainter oldDelegate) {
    return oldDelegate.scrollOffset != scrollOffset ||
        oldDelegate.level != level;
  }
}
