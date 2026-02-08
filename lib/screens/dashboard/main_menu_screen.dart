import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants.dart';

import '../../providers/game_state.dart';
import 'leaderboard_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    // Student should already be selected by Login/SelectScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameState>().loadChallenge();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    final student = gameState.currentStudent;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [FayColors.navyDark, FayColors.navy],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Grade Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: FayColors.gold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: FayColors.gold),
                      ),
                      child: Text(
                        student != null
                            ? (student['grade'] ?? 'Grade ?')
                            : 'Guest',
                        style: GoogleFonts.nunito(
                          color: FayColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white70),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/select_student',
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Welcome
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome Back,',
                      style: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      gameState.generatedNickname.isNotEmpty
                          ? gameState.generatedNickname
                          : 'Future Gator',
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Level Selector Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Select Level',
                  style: GoogleFonts.fredoka(
                    color: FayColors.gold,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Level List
              SizedBox(
                height: 220,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // 5 Levels
                  itemBuilder: (context, index) {
                    final level = index + 1;
                    final isUnlocked = level <= gameState.maxLevel;

                    return Container(
                      width: 160,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        border: isUnlocked
                            ? Border.all(color: FayColors.gold, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isUnlocked ? Icons.lock_open : Icons.lock,
                            size: 40,
                            color: isUnlocked ? FayColors.gold : Colors.white24,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Level $level',
                            style: GoogleFonts.fredoka(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (isUnlocked)
                            ElevatedButton(
                              onPressed: () {
                                context.read<GameState>().startGame(
                                  level: level,
                                );
                                Navigator.pushNamed(context, '/game');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: FayColors.gold,
                                foregroundColor: FayColors.navy,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text('Play'),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              // Leaderboard Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<GameState>().loadLeaderboard();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaderboardScreen(
                            leaderboard: context.watch<GameState>().leaderboard,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.leaderboard, color: FayColors.gold),
                    label: const Text('View Leaderboard'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: FayColors.gold),
                      foregroundColor: FayColors.gold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
