import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

      // Background preload for ALL levels (1-10)
      for (int i = 1; i <= 10; i++) {
        AssetManager().precacheLevelAssets(context, i);
        AssetManager().precacheLevelMusic(i);
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
        child: Stack(
          children: [
            // Ambient Floating Background Icons
            ...List.generate(6, (index) {
              final icons = [
                Icons.functions_rounded,
                Icons.biotech_rounded,
                Icons.history_edu_rounded,
                Icons.translate_rounded,
                Icons.science_rounded,
                Icons.calculate_rounded
              ];
              return Positioned(
                left: (index * 60.0) % MediaQuery.of(context).size.width,
                top: (index * 130.0) % MediaQuery.of(context).size.height,
                child: TweenAnimationBuilder<double>(
                  duration: Duration(seconds: 10 + index * 2),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        15 * math.sin(value * 2 * math.pi + index),
                      ),
                      child: Opacity(
                        opacity: 0.05,
                        child: Icon(
                          icons[index % icons.length],
                          size: 100 + (index * 20.0) % 50,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SafeArea(
              child: SingleChildScrollView(
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
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.leaderboard,
                                    color: FayColors.gold),
                                tooltip: 'Leaderboard',
                                onPressed: () {
                                  final grade = student?['grade'];
                                  context
                                      .read<GameState>()
                                      .loadLeaderboard(grade: grade);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LeaderboardScreen(
                                        leaderboard: context
                                            .read<GameState>()
                                            .leaderboard,
                                        grade: grade,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout,
                                    color: Colors.white70),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/select_student',
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.white70),
                                onPressed: () {
                                  _showSettings(context);
                                },
                              ),
                            ],
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
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
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
                            'Top Score: ${student?['high_score'] ?? 0} PTS',
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

                    // Exam Mode Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: gameState.isExamMode
                              ? FayColors.gold.withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: gameState.isExamMode
                                ? FayColors.gold
                                : Colors.white10,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: gameState.isExamMode
                                          ? FayColors.gold
                                          : Colors.white70,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Exam Mode',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: gameState.isExamMode,
                                  activeThumbColor: FayColors.gold,
                                  inactiveThumbColor:
                                      FayColors.gold.withValues(alpha: 0.8),
                                  inactiveTrackColor: Colors.white10,
                                  onChanged: (val) {
                                    gameState.setExamMode(val,
                                        topic: val
                                            ? (gameState.examTopic ?? 'Math')
                                            : null);
                                  },
                                ),
                              ],
                            ),
                            if (gameState.isExamMode) ...[
                              const Divider(color: Colors.white10, height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Topic:',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  DropdownButton<String>(
                                    value: gameState.examTopic ?? 'Math',
                                    dropdownColor: FayColors.navy,
                                    style: const TextStyle(
                                        color: FayColors.gold,
                                        fontWeight: FontWeight.bold),
                                    underline: Container(),
                                    items: [
                                      'Math',
                                      'Science',
                                      'Social Studies',
                                      'English'
                                    ].map((t) {
                                      return DropdownMenuItem(
                                        value: t,
                                        child: Text(t),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      gameState.setExamMode(true, topic: val);
                                    },
                                  ),
                                ],
                              ),
                              if (gameState.availableExams.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Select Exam:',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    DropdownButton<String>(
                                      value: gameState.selectedExamId,
                                      dropdownColor: FayColors.navy,
                                      style: const TextStyle(
                                          color: FayColors.gold,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      underline: Container(),
                                      items: gameState.availableExams
                                          .map<DropdownMenuItem<String>>(
                                              (exam) {
                                        final name =
                                            exam['exam_name'] ?? 'Unnamed Exam';
                                        final date = exam['due_date'] != null
                                            ? ' (Due: ${DateTime.parse(exam['due_date']).month}/${DateTime.parse(exam['due_date']).day})'
                                            : '';
                                        return DropdownMenuItem<String>(
                                          value: exam['id'] as String?,
                                          child: Text('$name$date'),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        gameState.setExamMode(true,
                                            topic: gameState.examTopic,
                                            examId: val);
                                      },
                                    ),
                                  ],
                                ),
                              ] else if (gameState.isLoading) ...[
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                      child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: FayColors.gold))),
                                ),
                              ] else ...[
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'No specific exams found for this topic.',
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 12),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Level Selector Title
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Text(
                            'Select Level',
                            style: TextStyle(
                              color: FayColors.gold,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Responsive Level Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 280, // Wider cards
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1.6, // Landscape ratio
                      ),
                      itemCount: kDebugMode ? 11 : 10,
                      itemBuilder: (context, index) {
                        int level;
                        bool isBonusTest = false;

                        if (kDebugMode) {
                          if (index == 2) {
                            isBonusTest = true;
                            level = 2; // Reference level for theme/icons
                          } else {
                            level = index < 2 ? index + 1 : index;
                          }
                        } else {
                          level = index + 1;
                        }

                        final isUnlocked =
                            isBonusTest || level <= gameState.maxLevel;
                        final isCurrentLevel =
                            !isBonusTest && level == gameState.maxLevel;
                        final String assetPath = isBonusTest
                            ? 'assets/images/${Assets.chickenCoopBg}'
                            : 'assets/images/${Assets.background(level)}';

                        return TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween(begin: 1.0, end: 1.0),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: InkWell(
                                onTap: isUnlocked
                                    ? () {
                                        if (isBonusTest) {
                                          context
                                              .read<GameState>()
                                              .startBonusTest(
                                                  BonusRoundType.eggCatch);
                                        } else {
                                          context
                                              .read<GameState>()
                                              .startGame(level: level);
                                        }
                                        Navigator.pushNamed(context, '/game');
                                      }
                                    : null,
                                borderRadius: BorderRadius.circular(24),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    image: DecorationImage(
                                      image: AssetImage(assetPath),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        isUnlocked
                                            ? Colors.black
                                                .withValues(alpha: 0.3)
                                            : Colors.black
                                                .withValues(alpha: 0.7),
                                        BlendMode.darken,
                                      ),
                                    ),
                                    border: Border.all(
                                      color: isCurrentLevel
                                          ? FayColors.gold
                                          : (isUnlocked
                                              ? Colors.white24
                                              : Colors.transparent),
                                      width: isCurrentLevel ? 3 : 1,
                                    ),
                                    boxShadow: isCurrentLevel
                                        ? [
                                            BoxShadow(
                                              color: FayColors.gold
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: isUnlocked
                                                    ? Colors.black26
                                                    : Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                isUnlocked
                                                    ? (isCurrentLevel
                                                        ? Icons
                                                            .play_arrow_rounded
                                                        : Icons
                                                            .check_circle_rounded)
                                                    : Icons
                                                        .lock_outline_rounded,
                                                size: 32,
                                                color: isUnlocked
                                                    ? (isCurrentLevel
                                                        ? FayColors.gold
                                                        : Colors.greenAccent)
                                                    : Colors.white24,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              isBonusTest
                                                  ? 'BONUS TEST'
                                                  : 'LEVEL $level',
                                              style: TextStyle(
                                                color: isUnlocked
                                                    ? Colors.white
                                                    : Colors.white38,
                                                fontWeight: FontWeight.w900,
                                                fontSize: isBonusTest ? 14 : 18,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            if (isUnlocked &&
                                                gameState.isExamMode)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: FayColors.gold,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Text(
                                                  'EXAM',
                                                  style: TextStyle(
                                                    color: FayColors.navy,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (!isUnlocked)
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.4),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
