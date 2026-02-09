import 'package:flutter/material.dart';
import '../../core/constants.dart';

class PlayerCharacter extends StatelessWidget {
  final bool isJumping;
  final bool isInvincible;

  const PlayerCharacter({
    super.key,
    required this.isJumping,
    required this.isInvincible,
  });

  @override
  Widget build(BuildContext context) {
    // Select image based on state
    String assetName = 'assets/images/ernie_run.png';
    if (isJumping) {
      assetName = 'assets/images/ernie_jump.png';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 140, // Doubled size
      height: 140,
      decoration: BoxDecoration(
        // Glow effect only when invincible
        boxShadow: isInvincible
            ? [
                BoxShadow(
                  color: FayColors.gold.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Image.asset(
        assetName,
        fit: BoxFit.contain,
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
