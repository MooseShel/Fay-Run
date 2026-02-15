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
        'assets/images/obstacles/obstacle_apple_2.png',
        'assets/images/${Assets.obsBanana}',
        'assets/images/obstacles/obstacle_banana_2.png',
        'assets/images/${Assets.obsBurger1}',
        'assets/images/${Assets.obsBurger2}',
        'assets/images/${Assets.itemGoldenBook}',
        'assets/images/${Assets.itemHeart}',
        'assets/images/${Assets.obsBucket}',
        'assets/images/${Assets.obsFood}',
        'assets/images/${Assets.obsCone}',
        'assets/images/${Assets.obsBackpack}',
        'assets/images/${Assets.obsTrashCan1}',
        'assets/images/${Assets.obsTrashCan2}',
        'assets/images/${Assets.obsHydrant1}',
        'assets/images/${Assets.obsHydrant2}',
      ];

      final staffAssets = [
        'assets/images/${Assets.staffHead}',
        'assets/images/${Assets.staffCoach}',
        'assets/images/${Assets.staffLibrarian}',
        'assets/images/${Assets.staffScience}',
        'assets/images/${Assets.staffDean}',
        'assets/images/${Assets.staffPe}',
        'assets/images/${Assets.staffEnglish}',
        'assets/images/${Assets.staffFirstG}',
        'assets/images/${Assets.staffPrek2}',
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

    // Staggered loading to prevent UI/Network jitter
    await Future.delayed(Duration(milliseconds: level * 100));
    if (!context.mounted) return;

    try {
      // 1. Background
      final bgFuture = precacheImage(
        AssetImage('assets/images/${Assets.background(level)}'),
        context,
      );

      // 2. Level-specific obstacles (additional variants)
      final List<String> levelObstacles = _getExtraObstaclesForLevel(level);

      // 3. Level-specific scenery
      final List<String> levelScenery = _getSceneryForLevel(level);

      // 4. Bonus Round specific assets
      final List<String> bonusAssets = _getBonusAssetsForLevel(level);

      final List<Future> futures = [bgFuture];
      for (var path in [
        ...levelObstacles,
        ...levelScenery,
        ...bonusAssets,
      ]) {
        futures.add(precacheImage(AssetImage('assets/images/$path'), context));
      }

      await Future.wait(futures);
      _precachedLevels.add(level);
      debugPrint('✅ Precache Level $level Finished');
    } catch (e) {
      debugPrint('⚠️ Error precaching level $level: $e');
    }
  }

  List<String> _getExtraObstaclesForLevel(int level) {
    switch (level) {
      case 1:
      case 3:
      case 5:
        return [
          'obstacles/obstacle_trash_can_1.png',
          'obstacles/obstacle_trash_can_2.png',
          'obstacles/obstacle_hydrant_1.png',
          'obstacles/obstacle_hydrant_2.png',
          'obstacles/obstacle_cone_1.png',
          'obstacles/obstacle_backpack_1.png',
        ];
      case 2:
      case 4:
      case 8:
        return [
          'obstacles/obstacle_log_1.png',
          'obstacles/obstacle_rock_1.png',
          'obstacles/obstacle_puddle_1.png',
        ];
      case 6:
        return [
          'obstacles/obstacle_tire_1.png',
          'obstacles/obstacle_tire_2.png',
          'obstacles/obstacle_cone_1.png',
          'obstacles/obstacle_backpack_1.png',
        ];
      case 7:
        return [
          'obstacles/obstacle_flower_pot_1.png',
          'obstacles/obstacle_flower_pot_2.png',
          'obstacles/obstacle_gnome_1.png',
          'obstacles/obstacle_gnome_2.png',
          'obstacles/obstacle_rock_1.png',
          'obstacles/obstacle_wild_flowers_1.png',
          'obstacles/obstacle_wild_flowers_2.png',
        ];
      case 9:
        return [
          'obstacles/obstacle_basket_ball_1.png',
          'obstacles/obstacle_basket_ball_2.png',
          'obstacles/obstacle_soccer_ball_1.png',
          'obstacles/obstacle_soccer_ball_2.png',
          'obstacles/obstacle_gym_mat_1.png',
          'obstacles/obstacle_gym_mat_2.png',
          'obstacles/obstacle_janitor_bucket_1.png',
        ];
      case 10:
        return [
          'obstacles/obstacle_lunch_tray_1.png',
          'obstacles/obstacle_lunch_tray_2.png',
          'obstacles/obstacle_milk_carton_1.png',
          'obstacles/obstacle_milk_carton_2.png',
          'obstacles/obstacle_milk_carton_3.png',
          'obstacles/obstacle_food_1.png',
          'obstacles/obstacle_food_2.png',
          'obstacles/obstacle_burger_1.png',
          'obstacles/obstacle_burger_2.png',
          'obstacles/obstacle_apple_1.png',
          'obstacles/obstacle_apple_2.png',
          'obstacles/obstacle_banana_1.png',
          'obstacles/obstacle_banana_2.png',
        ];
      default:
        return [];
    }
  }

  List<String> _getSceneryForLevel(int level) {
    final List<String> characters = [];

    // Animation frames for characters
    void addCharacter(String name) {
      characters.add('bg_characters/${name}_1.png');
      characters.add('bg_characters/${name}_2.png');
    }

    switch (level) {
      case 1:
      case 3:
      case 5:
      case 6:
        addCharacter('boy');
        addCharacter('girl');
        addCharacter('bench');
        if (level == 1) addCharacter('dog');
        if (level == 5) addCharacter('janitor');
        characters.add('bg_characters/bird_1.png');
        characters.add('bg_characters/bird_2.png');
        break;
      case 2:
      case 4:
      case 7:
      case 8:
        addCharacter('squirrel');
        addCharacter('butterfly');
        characters.add('bg_characters/bird_1.png');
        characters.add('bg_characters/bird_2.png');
        if (level == 8) addCharacter('dog');
        break;
      case 9:
        addCharacter('janitor');
        break;
      case 10:
        addCharacter('janitor');
        addCharacter('boy');
        addCharacter('girl');
        break;
    }

    return characters;
  }

  List<String> _getBonusAssetsForLevel(int level) {
    switch (level) {
      case 2: // Egg Catch
        return [
          'bonus_rounds/chicken_coop/chicken_coop.webp',
          'bonus_rounds/chicken_coop/chicken_1.png',
          'bonus_rounds/chicken_coop/chicken_2.png',
          'bonus_rounds/chicken_coop/chicken_3.png',
          'bonus_rounds/chicken_coop/chicken_4.png',
          'bonus_rounds/chicken_coop/egg_1.png',
          'bonus_rounds/chicken_coop/egg_2.png',
        ];
      default:
        return [];
    }
  }

  /// Buffers BGM for the specified level.
  Future<void> precacheLevelMusic(int level) async {
    await AudioService().preloadBGM(level);
  }

  /// Trigger audio preloading via AudioService.
  Future<void> preloadMusic() async {
    debugPrint('🎵 Preloading Music...');
    await AudioService().init();
  }
}
