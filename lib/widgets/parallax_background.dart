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
    _controller = AnimationController(
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Calculate rendered width based on image aspect ratio to avoid clipping.
        // Assuming portrait images range from 9:16 (~0.56) to 9:20.
        // If we use fitHeight, the width = height * aspect.
        // Using a fixed aspect ratio estimate (e.g., 1080/1920 = 0.5625)
        // This ensures that we tile based on the *actual* visible width.
        // Even if the asset is different, fitHeight ensures no vertical cropping.
        // The key is that the tile width matches the rendered image width.

        final double imageAspectRatio = 0.5625; // 9:16 standard portrait
        final double imageWidth = screenHeight * imageAspectRatio;

        final totalScroll = _scrollOffset * speedMultiplier;
        final double xPos = -(totalScroll % imageWidth);

        // We need enough tiles to cover screenWidth.
        final int tileCount = (screenWidth / imageWidth).ceil() + 1;

        return Stack(
          children: [
            for (int i = 0; i <= tileCount; i++)
              Positioned(
                left: xPos + (imageWidth * i),
                top: 0,
                bottom: 0,
                width: imageWidth + 1, // Slight overlap to prevent lines
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
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
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _GroundPainter(
                level: widget.level,
                scrollOffset: _scrollOffset,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _GroundPainter extends CustomPainter {
  final int level;
  final double scrollOffset;

  _GroundPainter({required this.level, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final double groundHeight = size.height;
    final double width = size.width;

    // Base Ground Color
    Paint basePaint = Paint();
    switch (level) {
      case 2: // Hallway
        basePaint.color = const Color(0xFFD7CCC8); // Beige
        break;
      case 3: // Lab
        basePaint.color = const Color(0xFFE1F5FE); // Light Blue
        break;
      case 4: // Cafeteria
        basePaint.color = const Color(0xFFFFE0B2); // Orange/Peach
        break;
      case 5: // Carpool
        basePaint.color = const Color(0xFF616161); // Dark Gray (Road)
        break;
      default: // Bayou
        basePaint.color = const Color(0xFF558B2F); // Grass Green
    }
    canvas.drawRect(Rect.fromLTWH(0, 0, width, groundHeight), basePaint);

    // Detail Patterns (Scrolling)

    // Unsed but kept for reference if needed
    // final double offset = scrollOffset % 50.0;

    if (level == 2 || level == 3 || level == 4) {
      // Indoor: Terrazzo / Speckled look instead of Grid
      // This avoids the "treadmill" strobing effect

      Paint scuffPaint = Paint()
        ..color = Colors.white.withOpacity(0.25)
        ..style = PaintingStyle.fill;

      // Draw repeating texture chunks
      double chunkWidth = 200.0;
      double chunkOffset = scrollOffset % chunkWidth;

      // Draw enough chunks to cover width + 1 extra
      for (double x = -chunkOffset; x < width; x += chunkWidth) {
        // Draw a few "details" in this 200px chunk ensuring disjoint placement
        // to look like random floor markings/reflection

        // Detail 1: Small circle
        canvas.drawCircle(Offset(x + 40, 30), 4, scuffPaint);

        // Detail 2: Thin horizontal "reflection" line
        canvas.drawRect(Rect.fromLTWH(x + 100, 60, 50, 4), scuffPaint);

        // Detail 3: Tiny dot
        canvas.drawCircle(Offset(x + 180, 20), 2, scuffPaint);

        // Detail 4: Another small rect
        canvas.drawRect(Rect.fromLTWH(x + 150, 80, 20, 3), scuffPaint);
      }
    } else if (level == 5) {
      // Road Markings (Dashed Line)
      Paint linePaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      // Increase dash spacing to look less fast/busy
      double dashWidth = 40;
      double dashSpace = 80; // Doubled spacing from 40 to 80
      double startX = -(scrollOffset % (dashWidth + dashSpace));

      Path dashPath = Path();
      for (double x = startX; x < width; x += dashWidth + dashSpace) {
        dashPath.moveTo(x, groundHeight / 2); // Center of lane
        dashPath.lineTo(x + dashWidth, groundHeight / 2);
      }
      canvas.drawPath(dashPath, linePaint);

      // Curb
      Paint curbPaint = Paint()..color = const Color(0xFFE0E0E0);
      canvas.drawRect(Rect.fromLTWH(0, 0, width, 10), curbPaint);
    } else {
      // Grass Details (Bayou)
      // Simple darker top edge for depth
      Paint edgePaint = Paint()..color = const Color(0xFF33691E);
      canvas.drawRect(Rect.fromLTWH(0, 0, width, 10), edgePaint);

      Paint grassPaint = Paint()
        ..color = const Color(0xFF33691E).withOpacity(0.3);
      // Occasional grass tufts
      double chunkWidth = 150.0;
      double chunkOffset = scrollOffset % chunkWidth;

      for (double x = -chunkOffset; x < width; x += chunkWidth) {
        canvas.drawCircle(Offset(x + 30, 40), 3, grassPaint);
        canvas.drawCircle(Offset(x + 100, 70), 5, grassPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GroundPainter old) {
    return old.level != level || old.scrollOffset != scrollOffset;
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
