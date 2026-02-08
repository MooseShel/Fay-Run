import 'package:flutter/material.dart';
import '../../core/constants.dart';

class ParallaxBackground extends StatefulWidget {
  final double runSpeed;
  final bool isPaused;

  const ParallaxBackground({
    super.key,
    required this.runSpeed,
    required this.isPaused,
  });

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _offset = 0;

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
      _offset -= widget.runSpeed;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Layer 0: Sky
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[300]!,
                Colors.yellow[100]!, // Day/Dusk feel
              ],
            ),
          ),
        ),

        // Layer 1: Far Trees (Slow)
        _ScrollingLayer(
          offset: _offset * 0.2, // Parallax factor
          child: CustomPaint(
            size: Size.infinite,
            painter: _TreePainter(color: FayColors.bayouGreen.withOpacity(0.5)),
          ),
        ),

        // Layer 2: Mid Trees + Moss (Medium)
        _ScrollingLayer(
          offset: _offset * 0.5,
          child: CustomPaint(
            size: Size.infinite,
            painter: _TreePainter(color: FayColors.bayouGreen),
          ),
        ),

        // Layer 3: Ground/Path (Fast/Normal) - This matches player speed usually
        // But for visual effect, let's say ground is the reference frame.
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            color: Colors.brown[400], // Dirt path
            child: _ScrollingStrip(
              offset: _offset,
              itemWidth: 50,
              itemBuilder: (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 46,
                height: 10, // Stones or texture
                color: Colors.brown[600],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScrollingLayer extends StatelessWidget {
  final double offset;
  final Widget child;

  const _ScrollingLayer({required this.offset, required this.child});

  @override
  Widget build(BuildContext context) {
    // Infinite scroll logic would normally use a texture or repeating pattern.
    // Since we use CustomPaint, we can pass offset to painter.
    // Or for simple widgets, we translate.
    // For this prototype, let's assume the child fills height and repeats width.
    // Using a simplified approach: wrapping in a Stack with 2 copies?
    // Actually, passing offset to CustomPainter is most performant.
    // But child is generic here.

    // Let's change strategy: The CHILD determines how it draws based on offset.
    // But standard Widget can't unless it knows offset.
    // Let's assume child is a LayoutBuilder that keys off the offset? No.

    // Simplest: Use a Stack of 2 copies translating.
    return Stack(
      children: [
        Positioned.fill(
          left: offset % MediaQuery.of(context).size.width,
          child: child,
        ),
        Positioned.fill(
          left:
              (offset % MediaQuery.of(context).size.width) -
              MediaQuery.of(context).size.width,
          child: child,
        ),
      ],
    );
  }
}

// A simple strip of repeating items
class _ScrollingStrip extends StatelessWidget {
  final double offset;
  final double itemWidth;
  final Widget Function(int index) itemBuilder;

  const _ScrollingStrip({
    required this.offset,
    required this.itemWidth,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Just draw a pattern using a Row?
        // Not efficient for infinite, but okay for prototype.
        // Better: CustomPaint.
        return CustomPaint(
          painter: _StripPainter(
            offset: offset,
            itemWidth: itemWidth,
            color: Colors.brown[600]!,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _StripPainter extends CustomPainter {
  final double offset;
  final double itemWidth;
  final Color color;

  _StripPainter({
    required this.offset,
    required this.itemWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    double effectiveOffset = offset % itemWidth;

    // Draw items across width
    for (double i = effectiveOffset; i < size.width; i += itemWidth) {
      canvas.drawRect(Rect.fromLTWH(i, 20, itemWidth * 0.8, 10), paint);
    }
    // Handle leading edge if offset is positive/negative logic
    for (double i = effectiveOffset - itemWidth; i < 0; i += itemWidth) {
      canvas.drawRect(Rect.fromLTWH(i, 20, itemWidth * 0.8, 10), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StripPainter oldDelegate) => true;
}

class _TreePainter extends CustomPainter {
  final Color color;

  _TreePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // Draw generic trees
    // We just draw a few distinct shapes and let the parent stack handle the repetition?
    // Parent _ScrollingLayer stacks 2 copies of this child.
    // So we just need to fill 'size' (which is screen size) with a pattern that TILES seamlessly.

    // Draw 3 trees distributed across width
    final w = size.width;
    final h = size.height;

    _drawTree(canvas, paint, w * 0.2, h);
    _drawTree(canvas, paint, w * 0.5, h);
    _drawTree(canvas, paint, w * 0.8, h);
  }

  void _drawTree(Canvas canvas, Paint paint, double x, double h) {
    // Trunk
    canvas.drawRect(Rect.fromLTWH(x - 10, h - 200, 20, 200), paint);
    // Leaves (Circle)
    canvas.drawCircle(Offset(x, h - 200), 60, paint);
  }

  @override
  bool shouldRepaint(_TreePainter oldDelegate) => false;
}
