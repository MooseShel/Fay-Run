import 'package:flutter/material.dart';
import '../core/assets.dart';
import '../core/constants.dart';

class ParallaxBackground extends StatefulWidget {
  final double runSpeed;
  final bool isPaused;
  final int level;
  final double screenHeight;
  final double scrollOffset; // Now driven by parent game loop

  const ParallaxBackground({
    super.key,
    required this.runSpeed,
    required this.isPaused,
    required this.screenHeight,
    required this.scrollOffset,
    this.level = 1,
  });

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> {
  double? _aspectRatio;
  String? _lastAssetPath;

  @override
  Widget build(BuildContext context) {
    final String assetPath = 'assets/images/${Assets.background(widget.level)}';

    if (_lastAssetPath != assetPath) {
      _lastAssetPath = assetPath;
      _aspectRatio = null; // Reset on level change
      _resolveAspectRatio(assetPath);
    }

    return Stack(
      children: [
        // 1. Sky / Gradient Base
        Positioned.fill(
          child: CustomPaint(painter: _SkyPainter(level: widget.level)),
        ),

        // 2. Far Layer (Images with seamless tiling)
        _buildScrollingImage(assetPath, 0.2),

        // 3. Near Layer / Ground
        _buildScrollingGround(),
      ],
    );
  }

  void _resolveAspectRatio(String assetPath) {
    final image = AssetImage(assetPath);
    final stream = image.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((info, synchronousCall) {
      if (mounted) {
        setState(() {
          _aspectRatio = info.image.width / info.image.height;
        });
      }
    }));
  }

  Widget _buildScrollingImage(String assetPath, double speedMultiplier) {
    if (_aspectRatio == null) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;
        if (screenWidth <= 0 || screenHeight <= 0) {
          return const SizedBox.shrink();
        }

        // Calculate tile width based on screen height and image aspect ratio
        final double tileWidth = screenHeight * _aspectRatio!;

        final double totalScroll = widget.scrollOffset * speedMultiplier;

        // Infinite Carousel Logic:
        final double exactIndex = totalScroll / tileWidth;
        final int baseIndex = exactIndex.floor();
        final double offsetInTile = totalScroll % tileWidth;

        return Stack(
          children: [
            // Current / Left tile (Index)
            _buildCarouselTile(
                assetPath, baseIndex, -offsetInTile, tileWidth, screenHeight),
            // Next / Right tile (Index + 1)
            _buildCarouselTile(assetPath, baseIndex + 1,
                tileWidth - offsetInTile, tileWidth, screenHeight),
            // If the tile is narrower than half the screen, we might need a third tile
            if (tileWidth - offsetInTile < screenWidth)
              _buildCarouselTile(assetPath, baseIndex + 2,
                  2 * tileWidth - offsetInTile, tileWidth, screenHeight),
          ],
        );
      },
    );
  }

  Widget _buildCarouselTile(String assetPath, int index, double xPos,
      double width, double screenHeight) {
    // Mirroring logic removed as per user request
    final double groundHeight = screenHeight * FayColors.kGroundHeightRatio;
    final double backgroundHeight =
        screenHeight - groundHeight; // Background fills from top to ground
    return Positioned(
      left: xPos,
      top: 0,
      height: backgroundHeight, // Fill from top to where ground starts
      width: width +
          2.0, // Increased overlap to prevent sub-pixel gaps (flickering)
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        alignment: Alignment
            .bottomCenter, // Ensure house/ground in image sits on the bottom
        cacheHeight: screenHeight.toInt(), // Memory Optimization
      ),
    );
  }

  Widget _buildScrollingGround() {
    final double groundHeight =
        widget.screenHeight * FayColors.kGroundHeightRatio;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: groundHeight, // Dynamic ground height (15% of screen)
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _GroundPainter(
            level: widget.level,
            scrollOffset: widget.scrollOffset,
          ),
          size: Size.infinite,
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
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        basePaint.color =
            const Color(0xFF558B2F); // Grass Landscape (Levels 1-5)
        break;
      case 6: // Playground
        basePaint.color = const Color(0xFFD7CCC8); // Tan/Mulch
        break;
      case 7: // Garden
        basePaint.color = const Color(0xFF795548); // Brown (Dirt/Garden)
        break;
      case 8: // Meadow
        basePaint.color = const Color(0xFF8BC34A); // Brighter Green
        break;
      case 9: // Gym
        basePaint.color = const Color(0xFFBBDEFB); // Polished Blue Floor
        break;
      case 10: // Cafeteria
        basePaint.color = const Color(0xFFFFE0B2); // Peach Tile
        break;
      default:
        basePaint.color = const Color(0xFF558B2F);
    }
    canvas.drawRect(Rect.fromLTWH(0, 0, width, groundHeight), basePaint);

    // Detail Patterns (Scrolling)

    // Unsed but kept for reference if needed
    // final double offset = scrollOffset % 50.0;

    if (level == 2 || level == 3 || level == 4) {
      // Indoor: Terrazzo / Speckled look instead of Grid
      // This avoids the "treadmill" strobing effect

      Paint scuffPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.25)
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
        ..color = const Color(0xFF33691E).withValues(alpha: 0.3);
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
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        colors = [Colors.lightBlue[300]!, Colors.lightBlue[50]!]; // Nature
        break;
      case 6: // Playground
        colors = [Colors.orange[100]!, Colors.white];
        break;
      case 7: // Garden
        colors = [Colors.green[100]!, Colors.white];
        break;
      case 8: // Meadow
        colors = [Colors.teal[100]!, Colors.white];
        break;
      case 9: // Gym
        colors = [Colors.blue[100]!, Colors.white];
        break;
      case 10: // Cafeteria
        colors = [Colors.amber[50]!, Colors.white];
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
