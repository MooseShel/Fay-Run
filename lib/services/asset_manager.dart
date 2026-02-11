import 'package:flutter/material.dart';
import '../core/assets.dart';
import 'audio_service.dart';

class AssetManager {
  static final AssetManager _instance = AssetManager._internal();
  factory AssetManager() => _instance;
  AssetManager._internal();

  bool _essentialAssetsPrecached = false;
  final Set<int> _precachedLevels = {};

  /// Precache common sprites, UI elements, and essential obstacles.
  Future<void> precacheEssentialAssets(BuildContext context) async {
    if (_essentialAssetsPrecached) return;

    debugPrint('🚀 Precache Essential Assets Started...');
    try {
      await Future.wait([
        // Ernie Sprites
        precacheImage(const AssetImage('assets/images/ernie_run.png'), context),
        precacheImage(
            const AssetImage('assets/images/ernie_run_2.png'), context),
        precacheImage(AssetImage('assets/images/${Assets.ernieRun}'), context),
        precacheImage(AssetImage('assets/images/${Assets.ernieRun2}'), context),
        precacheImage(AssetImage('assets/images/${Assets.ernieRun3}'), context),
        precacheImage(AssetImage('assets/images/${Assets.ernieJump}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.ernieCrash}'), context),

        // Common Obstacles
        precacheImage(AssetImage('assets/images/${Assets.obsLog}'), context),
        precacheImage(AssetImage('assets/images/${Assets.obsRock}'), context),
        precacheImage(AssetImage('assets/images/${Assets.obsApple}'), context),
        precacheImage(AssetImage('assets/images/${Assets.obsBanana}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.obsBurger1}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.obsBurger2}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.itemGoldenBook}'), context),

        // Staff Heads
        precacheImage(AssetImage('assets/images/${Assets.staffHead}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.staffCoach}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.staffLibrarian}'), context),
        precacheImage(
            AssetImage('assets/images/${Assets.staffScience}'), context),
        precacheImage(AssetImage('assets/images/${Assets.staffDean}'), context),

        // Background Characters
        ...['boy', 'girl', 'janitor', 'butterfly'].expand((name) => [
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 1)}'),
                  context),
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 2)}'),
                  context),
            ]),
        ...['dog', 'squirrel'].expand((name) => [
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 1)}'),
                  context),
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 2)}'),
                  context),
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 3)}'),
                  context),
              precacheImage(
                  AssetImage('assets/images/${Assets.bgCharacter(name, 4)}'),
                  context),
            ]),
      ]);
      _essentialAssetsPrecached = true;
      debugPrint('✅ Precache Essential Assets Finished');
    } catch (e) {
      debugPrint('⚠️ Error precaching essential assets: $e');
    }
  }

  /// Precache level-specific background images.
  Future<void> precacheLevelAssets(BuildContext context, int level) async {
    if (_precachedLevels.contains(level)) return;

    debugPrint('🎨 Precache Level $level Assets Started...');
    try {
      await precacheImage(
        AssetImage('assets/images/${Assets.background(level)}'),
        context,
      );
      _precachedLevels.add(level);
      debugPrint('✅ Precache Level $level Finished');
    } catch (e) {
      debugPrint('⚠️ Error precaching level $level: $e');
    }
  }

  /// Trigger audio preloading via AudioService.
  Future<void> preloadMusic() async {
    debugPrint('🎵 Preloading Music...');
    await AudioService().init();
  }
}
