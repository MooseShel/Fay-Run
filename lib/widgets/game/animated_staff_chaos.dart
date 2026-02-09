import 'package:flutter/material.dart';
import '../../models/staff_event.dart';
import '../../core/constants.dart';

class AnimatedStaffChaos extends StatefulWidget {
  final StaffEvent event;

  const AnimatedStaffChaos({super.key, required this.event});

  @override
  State<AnimatedStaffChaos> createState() => _AnimatedStaffChaosState();
}

class _AnimatedStaffChaosState extends State<AnimatedStaffChaos>
    with TickerProviderStateMixin {
  late AnimationController _flyInController;
  late AnimationController _shakeController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fly-in animation (0.5 seconds)
    _flyInController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Shake animation (continuous while visible)
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // Scale from 0 to 1.2 then settle to 1
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.3,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_flyInController);

    // Slide from bottom to center
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _flyInController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _flyInController.forward();
    _flyInController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Start shaking after fly-in completes
        _shakeController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _flyInController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  String _getStaffImagePath() {
    switch (widget.event.type) {
      case StaffEventType.shoeTie:
        return 'assets/images/staff_head.jpg';
      case StaffEventType.coachWhistle:
        return 'assets/images/staff_coach.jpg';
      case StaffEventType.librarianShush:
        return 'assets/images/staff_librarian.jpg';
      case StaffEventType.scienceSplat:
        return 'assets/images/staff_science.jpg';
      case StaffEventType.deanGlare:
        return 'assets/images/staff_dean.jpg';
      case StaffEventType.peDrill:
        return 'assets/images/staff_pe.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) {
              // Wacky shake effect - rotate and translate
              final shakeValue = _shakeController.value;
              final rotation = (shakeValue - 0.5) * 0.1; // Rotate ±5 degrees
              final offsetX = (shakeValue - 0.5) * 10; // Shake horizontally
              final offsetY = (shakeValue - 0.5) * 5; // Shake vertically

              return Transform.translate(
                offset: Offset(offsetX, offsetY),
                child: Transform.rotate(angle: rotation, child: child),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: FayColors.navy,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: FayColors.gold, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Large headshot
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: FayColors.gold, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: FayColors.gold.withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _getStaffImagePath(),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title with glow effect
                  Text(
                    widget.event.title.toUpperCase(),
                    style: TextStyle(
                      color: FayColors.gold,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: FayColors.gold.withValues(alpha: 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Message
                  Text(
                    widget.event.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
