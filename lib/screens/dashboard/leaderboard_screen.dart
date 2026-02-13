import 'package:flutter/material.dart';
import '../../core/constants.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboard;
  final String? grade;

  const LeaderboardScreen({super.key, required this.leaderboard, this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FayColors.navy,
      appBar: AppBar(
        title: Text(grade != null ? '$grade Leaderboard' : 'Top Gators'),
        centerTitle: true,
        backgroundColor: FayColors.navyDark,
        elevation: 0,
      ),
      body: leaderboard.isEmpty
          ? const Center(
              child: Text(
                'No scores yet. Be the first!',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: leaderboard.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white24, height: 1),
              itemBuilder: (context, index) {
                final entry = leaderboard[index];
                final rank = index + 1;
                final isTop3 = rank <= 3;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isTop3 ? FayColors.gold : Colors.white24,
                    foregroundColor: FayColors.navy,
                    child: Text(
                      '#$rank',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    entry['nickname'] ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    entry['grade'] ?? 'Grade ?',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: FayColors.gold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: FayColors.gold),
                    ),
                    child: Text(
                      '${entry['high_score']} PTS',
                      style: const TextStyle(
                        color: FayColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
