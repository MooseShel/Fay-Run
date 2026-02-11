import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/assets.dart';

class PlayerCharacter extends StatelessWidget {
  final bool isJumping;
  final bool isInvincible;
  final bool isCrashed;
  final int runFrame;

  final double size;

  const PlayerCharacter({
    super.key,
    required this.isJumping,
    required this.isInvincible,
    this.isCrashed = false,
    this.runFrame = 0,
    this.size = 210.0,
  });

  @override
  Widget build(BuildContext context) {
    // Select image based on state
    String assetName;

    if (isCrashed) {
      assetName = 'assets/images/${Assets.ernieCrash}';
    } else if (isJumping) {
      assetName = 'assets/images/${Assets.ernieJump}';
    } else {
      // Run animation
      if (runFrame == 0) {
        assetName = 'assets/images/${Assets.ernieRun}';
      } else if (runFrame == 1) {
        assetName = 'assets/images/${Assets.ernieRun2}';
      } else {
        assetName = 'assets/images/${Assets.ernieRun3}';
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: size,
      height: size,
      decoration: BoxDecoration(
        // Glow effect only when invincible
        boxShadow: isInvincible
            ? [
                BoxShadow(
                  color: FayColors.gold.withValues(alpha: 0.6),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Image.asset(
        assetName,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
        errorBuilder: (context, error, stackTrace) {
          // Fallback if image fails - keeping the old green box look as backup
          return Container(
            decoration: BoxDecoration(
              color: FayColors.bayouGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: FayColors.navy, width: 2),
            ),
            child: const Center(child: Icon(Icons.person, color: Colors.white)),
          );
        },
      ),
    );
  }
}
