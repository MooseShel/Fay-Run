import 'package:flutter/material.dart';

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
    String assetPath;
    switch (widget.level) {
      case 2:
        assetPath = 'assets/images/bg_layer_lockers.png';
        break;
      case 3:
        assetPath = 'assets/images/bg_science_lab.png';
        break;
      case 4:
        assetPath = 'assets/images/bg_cafeteria.png';
        break;
      case 5:
        assetPath = 'assets/images/bg_carpool.png';
        break;
      default:
        assetPath = 'assets/images/bg_layer_trees.png';
    }

    return Stack(
      children: [
        // 1. Sky / Gradient Base (Using CustomPainter for complex gradients)
        Positioned.fill(
          child: CustomPaint(painter: _SkyPainter(level: widget.level)),
        ),

        // 2. Far Layer (Images for all levels)
        Positioned.fill(child: _buildScrollingImage(assetPath, 0.2)),

        // 3. Near Layer / Ground (Image-based)
        _buildScrollingGround(),
      ],
    );
  }

  Widget _buildScrollingImage(String assetPath, double speedMultiplier) {
    // Basic infinite scroll using two images
    // We assume the image width is roughly screen width or we tile it.
    // For simplicity, we'll use a LayoutBuilder and tile 3 times to be safe.
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        // Calculate offset based on scroll
        final totalScroll = _scrollOffset * speedMultiplier;
        final imageWidth =
            screenWidth; // Assuming image fits width, or we scale it
        // We want: position = -(totalScroll % imageWidth)
        final double xPos = -(totalScroll % imageWidth);

        return Stack(
          children: [
            Positioned(
              left: xPos,
              top: 0,
              bottom: 0, // Cover height
              width: imageWidth + 2, // Slight overlap
              child: Image.asset(
                assetPath,
                fit: BoxFit.fitHeight, // Prevents zooming/cropping
                alignment: Alignment.bottomCenter, // Align to ground
              ),
            ),
            Positioned(
              left: xPos + imageWidth, // Next tile
              top: 0,
              bottom: 0,
              width: imageWidth + 2,
              child: Image.asset(
                assetPath,
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScrollingGround() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 100, // Ground height
      child: Container(color: Colors.white),
    );
  }
}

class _SkyPainter extends CustomPainter {
  final int level;
  _SkyPainter({required this.level});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colors;
    switch (level) {
      case 1: // Bayou
        colors = [Colors.lightBlue[300]!, Colors.lightBlue[50]!];
        break;
      case 2: // Hallway
        colors = [const Color(0xFFE0E0E0), const Color(0xFFFAFAFA)];
        break;
      case 3: // Lab
        colors = [const Color(0xFFF5F5F5), Colors.white];
        break;
      case 4: // Cafeteria
        colors = [const Color(0xFFFFE0B2), const Color(0xFFFFF3E0)];
        break;
      case 5: // Carpool
        colors = [const Color(0xFF455A64), const Color(0xFFFFCC80)];
        break;
      default:
        colors = [Colors.lightBlue, Colors.white];
    }
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _SkyPainter old) => old.level != level;
}
