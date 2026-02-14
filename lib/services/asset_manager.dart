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
      // Split into batches to avoid blocking UI thread on web with many large decodes
      final ernieAssets = [
        'assets/images/${Assets.ernieRun}',
        'assets/images/${Assets.ernieRun2}',
        'assets/images/${Assets.ernieRun3}',
        'assets/images/${Assets.ernieJump}',
        'assets/images/${Assets.ernieCrash}',
      ];

      final obstacleAssets = [
        'assets/images/${Assets.obsLog}',
        'assets/images/${Assets.obsRock}',
        'assets/images/${Assets.obsApple}',
        'assets/images/${Assets.obsBanana}',
        'assets/images/${Assets.obsBurger1}',
        'assets/images/${Assets.obsBurger2}',
        'assets/images/${Assets.itemGoldenBook}',
      ];

      final staffAssets = [
        'assets/images/${Assets.staffHead}',
        'assets/images/${Assets.staffCoach}',
        'assets/images/${Assets.staffLibrarian}',
        'assets/images/${Assets.staffScience}',
        'assets/images/${Assets.staffDean}',
      ];

      debugPrint('🏃 Preloading Ernie...');
      if (!context.mounted) return;
      await _precacheBatch(ernieAssets, context);

      debugPrint('🍎 Preloading Obstacles...');
      if (!context.mounted) return;
      await _precacheBatch(obstacleAssets, context);

      debugPrint('🎓 Preloading Staff...');
      if (!context.mounted) return;
      await _precacheBatch(staffAssets, context);

      // Background characters can be last and lazier
      final otherAssets = [
        ...['boy', 'girl', 'janitor', 'butterfly', 'bench'].expand((name) => [
              'assets/images/${Assets.bgCharacter(name, 1)}',
              'assets/images/${Assets.bgCharacter(name, 2)}',
            ]),
        ...['dog', 'squirrel'].expand((name) => [
              'assets/images/${Assets.bgCharacter(name, 1)}',
              'assets/images/${Assets.bgCharacter(name, 2)}',
              'assets/images/${Assets.bgCharacter(name, 3)}',
              'assets/images/${Assets.bgCharacter(name, 4)}',
            ]),
        'assets/images/${Assets.chickenCoopBg}',
        ...['', 'c', 'b', 'w'].expand((v) => [
              'assets/images/${Assets.chickenSprite(v, 1)}',
              'assets/images/${Assets.chickenSprite(v, 2)}',
            ]),
        'assets/images/${Assets.bgCharacter("bird", 1)}',
        'assets/images/${Assets.bgCharacter("bird", 2)}',
        ...[1, 2].map((f) => 'assets/images/${Assets.eggSprite(f == 2)}'),
      ];
      if (!context.mounted) return;
      await _precacheBatch(otherAssets, context);

      _essentialAssetsPrecached = true;
      debugPrint('✅ Precache Essential Assets Finished');
    } catch (e) {
      debugPrint('⚠️ Error precaching essential assets: $e');
    }
  }

  Future<void> _precacheBatch(List<String> paths, BuildContext context) async {
    for (final path in paths) {
      try {
        await precacheImage(AssetImage(path), context);
      } catch (e) {
        debugPrint('❌ Failed to precache: $path - $e');
      }
      // Tiny delay to let the event loop breathe, especially on web
      await Future.delayed(const Duration(milliseconds: 10));
      if (!context.mounted) return;
    }
  }

  /// Precache level-specific background images.
  Future<void> precacheLevelAssets(BuildContext context, int level) async {
    if (_precachedLevels.contains(level)) return;

    debugPrint('🎨 Precache Level $level Assets Started...');
    if (!context.mounted) return;
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
