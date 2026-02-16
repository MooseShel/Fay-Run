import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/assets.dart';
import '../../providers/game_state.dart';
import 'package:provider/provider.dart';
import '../../services/audio_service.dart';

class CelebrationOverlay extends StatefulWidget {
  const CelebrationOverlay({super.key});

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay> {
  @override
  void initState() {
    super.initState();
    // Play music when overlay appears
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("🎉 CelebrationOverlay: Attempting to play music...");
      final audio = AudioService();
      // Force stop previous BGM to ensure clean state
      await audio.stopBGM();
      await Future.delayed(const Duration(milliseconds: 100)); // Short buffer
      await audio.playCustomBGM(Assets.celebrationMusic);
      debugPrint("🎉 CelebrationOverlay: Music play command sent.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image (Full Screen)
        Image.asset(
          'assets/images/${Assets.celebrationBg}',
          fit: BoxFit.cover,
          color: Colors.black54, // Dim it slightly for text legibility
          colorBlendMode: BlendMode.darken,
        ),

        // Content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "CONGRATULATIONS!",
                style: TextStyle(
                  fontFamily: 'BubblegumSans',
                  fontSize: 48,
                  color: FayColors.gold,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "You've Completed Fay Run!",
                style: TextStyle(
                  fontFamily: 'BubblegumSans',
                  fontSize: 32,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // Reset game via provider and go to menu
                  context
                      .read<GameState>()
                      .forfeitGame(); // Resets state to menu
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FayColors.navy,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "RETURN TO SCHOOL",
                  style: TextStyle(
                    fontFamily: 'BubblegumSans',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
