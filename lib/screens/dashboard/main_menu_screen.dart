import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';

import '../../services/mock_sql_service.dart';
import '../../providers/game_state.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final season = MockSQLService.getCurrentSeason();
    final challenge = MockSQLService.getWeeklyChallenge();
    final gameState = context.watch<GameState>();

    return Scaffold(
      backgroundColor: FayColors.white,
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings implementation
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [FayColors.navy, Colors.blue[800]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    gameState.generatedNickname.isNotEmpty
                        ? gameState.generatedNickname
                        : 'Student', // Fallback
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info Cards
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    title: 'Current Season',
                    value: season,
                    icon: Icons.calendar_today,
                    color: FayColors.brickRed,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _InfoCard(
                    title: 'Weekly Challenge',
                    value: challenge.topic,
                    icon: Icons.lightbulb,
                    color: FayColors.gold,
                    textColor: FayColors.navy,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Start Game Button
            SizedBox(
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Reset game state and start
                  context.read<GameState>().startGame();
                  Navigator.pushNamed(context, '/game');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FayColors.bayouGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.play_arrow, size: 32),
                label: const Text(
                  'START GATOR RUN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color textColor;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
