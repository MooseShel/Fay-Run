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
    // Barney Gator Representation
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: FayColors.bayouGreen,
        borderRadius: BorderRadius.circular(8),
        border: isInvincible
            ? Border.all(color: FayColors.gold, width: 4)
            : null,
        boxShadow: isInvincible
            ? [
                BoxShadow(
                  color: FayColors.gold.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          // Eyes
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [_buildEye(), const SizedBox(width: 4), _buildEye()],
            ),
          ),
          // Snout
          Positioned(
            bottom: 10,
            right: -5,
            child: Container(
              width: 15,
              height: 20,
              decoration: BoxDecoration(
                color: FayColors.bayouGreen,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Legs (Simple animation based on jump?)
          if (!isJumping)
            Positioned(
              bottom: 0,
              left: 10,
              child: Container(width: 10, height: 10, color: Colors.green[900]),
            ),
        ],
      ),
    );
  }

  Widget _buildEye() {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
