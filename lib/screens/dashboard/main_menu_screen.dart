import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../services/supabase_service.dart';
import '../../providers/game_state.dart';
import '../../services/audio_service.dart';
import '../../services/settings_service.dart';
import '../../core/assets.dart';
import 'leaderboard_screen.dart';
import '../../services/asset_manager.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final _supabaseService = SupabaseService();
  @override
  void initState() {
    super.initState();
    // Student should already be selected by Login/SelectScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<GameState>();
      state.loadChallenge();

      // Background preload for current and next levels
      for (int i = 0; i < 3; i++) {
        final levelToPreload = state.maxLevel + i;
        if (levelToPreload <= 10) {
          AssetManager().precacheLevelAssets(context, levelToPreload);
        }
      }
    });
  }

  void _showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FayColors.navy,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        content: StatefulBuilder(
          builder: (context, setState) {
            final isMuted = SettingsService().isMuted;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text(
                    'Mute Audio',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: isMuted,
                  activeThumbColor: FayColors.gold,
                  onChanged: (val) {
                    setState(() {
                      AudioService().toggleMute();
                    });
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Close settings dialog first
                    Navigator.pop(context);
                    _showDeleteConfirmation(context);
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: FayColors.gold)),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FayColors.navy,
        title: const Text(
          'Delete Account?',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
          'Are you sure you want to delete your account? This will permanently delete all student profiles, scores, and data. This action cannot be undone.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(color: FayColors.gold),
                  ),
                );

                await _supabaseService.deleteAccount();

                if (context.mounted) {
                  // Pop loading
                  Navigator.pop(context);
                  // Pop dialog
                  Navigator.pop(context);
                  // Go to Login
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context); // Pop loading
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
                        color: FayColors.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: FayColors.gold),
                      ),
                      child: Text(
                        student != null
                            ? (student['grade'] ?? 'Grade ?')
                            : 'Guest',
                        style: const TextStyle(
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
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white70),
                      onPressed: () {
                        _showSettings(context);
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
                    const Text(
                      'Welcome Back,',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      gameState.generatedNickname.isNotEmpty
                          ? gameState.generatedNickname
                          : 'Future Gator',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Top Score
                    Text(
                      'Top Score: ${student?['high_score'] ?? 0}',
                      style: const TextStyle(
                        color: FayColors.gold,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Reminder Note
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.white70, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Remember: Finish the level for your score to count!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Level Selector Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Select Level',
                  style: TextStyle(
                    color: FayColors.gold,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Responsive Level Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280, // Wider cards
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.6, // Landscape ratio
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final level = index + 1;
                    final isUnlocked = level <= gameState.maxLevel;
                    final String assetPath =
                        'assets/images/${Assets.background(level)}';

                    return InkWell(
                      onTap: isUnlocked
                          ? () {
                              context.read<GameState>().startGame(level: level);
                              Navigator.pushNamed(context, '/game');
                            }
                          : null,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(assetPath),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              isUnlocked
                                  ? Colors.black.withValues(alpha: 0.4)
                                  : Colors.black.withValues(alpha: 0.8),
                              BlendMode.darken,
                            ),
                          ),
                          border: isUnlocked
                              ? Border.all(color: FayColors.gold, width: 2)
                              : null,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isUnlocked
                                        ? Icons.play_circle_fill
                                        : Icons.lock,
                                    size: 48,
                                    color: isUnlocked
                                        ? FayColors.gold
                                        : Colors.white24,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Level $level',
                                    style: TextStyle(
                                      color: isUnlocked
                                          ? Colors.white
                                          : Colors.white38,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isUnlocked)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Leaderboard Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final grade = student?['grade'];
                      context.read<GameState>().loadLeaderboard(grade: grade);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaderboardScreen(
                            leaderboard: context.watch<GameState>().leaderboard,
                            grade: grade,
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
