class Assets {
  // Images
  static const String staffHead = 'staff/staff_head.webp';
  static const String staffCoach = 'staff/staff_coach.webp';
  static const String staffLibrarian = 'staff/staff_librarian.webp';
  static const String staffScience = 'staff/staff_science.webp';
  static const String staffDean = 'staff/staff_dean.webp';
  static const String staffPe = 'staff/staff_pe.webp';
  static const String staffEnglish = 'staff/staff_english.webp';
  static const String staffFirstG = 'staff/staff_firstg.webp';
  static const String staffPrek2 = 'staff/staff_prek2.webp';
  static const String ernie = 'ernie.png';
  static const String ernieRun = 'ernie_run.png';
  static const String ernieRun2 = 'ernie_run_2.png';
  static const String ernieRun3 = 'ernie_run_3.png';
  static const String ernieJump = 'ernie_jump.png';
  static const String ernieCrash = 'ernie_crash.png';

  static String background(int level) {
    // Safety check for invalid levels
    if (level < 1) level = 1;
    return 'bgs/bg_fay_$level.webp';
  }

  static const String chickenCoopBg =
      'bonus_rounds/chicken_coop/chicken_coop.webp';
  static const String chickenCoopMusic = 'audio/chicken_coop.aac';

  static const String celebrationBg = 'bgs/celebration_Screen.webp';
  static const String celebrationMusic = 'audio/hallway_heroes.aac';

  static String chickenSprite(String variant, int frame) {
    // Safe clamp for animation frames (we only have 1 and 2)
    final f = frame.clamp(1, 2);
    if (variant.isEmpty) return 'bonus_rounds/chicken_coop/chicken_$f.png';
    // Handle the double underscore issue for variant 'c' if that's what's on disk
    String prefix = variant == "c" ? "chicken__" : "chicken_";
    return 'bonus_rounds/chicken_coop/$prefix${variant}_$f.png';
  }

  static String eggSprite(bool isCracked) {
    return 'bonus_rounds/chicken_coop/egg_${isCracked ? 2 : 1}.png';
  }

  static const String itemGoldenBook = 'obstacles/item_golden_book.png';
  static const String itemHeart = 'heart.png';

  // Audio - Background Music
  static const String musicBayou1 = 'audio/music_bayou_1.aac';
  static const String musicBayou2 = 'audio/music_bayou_2.aac';
  static const String musicBayou3 = 'audio/music_bayou_3.aac';
  static const String musicBayou4 = 'audio/music_bayou_4.aac';
  static const String musicBayou5 = 'audio/music_bayou_5.aac';
  static const String musicBayou6 = 'audio/music_bayou_6.aac';
  static const String musicGarden = 'audio/music_garden.aac';
  static const String musicMedow = 'audio/music_medow.aac';
  static const String musicPlayground = 'audio/music_playground.aac';
  static const String musicCafeteria = 'audio/music_cafeteria.aac';

  // Images - Obstacles
  static const String obsLog = 'obstacles/obstacle_log_1.png';
  static const String obsRock = 'obstacles/obstacle_rock_1.png';
  static const String obsApple = 'obstacles/obstacle_apple_1.png';
  static const String obsBanana = 'obstacles/obstacle_banana_1.png';
  static const String obsBurger1 = 'obstacles/obstacle_burger_1.png';
  static const String obsBurger2 = 'obstacles/obstacle_burger_2.png';
  static const String obsBucket = 'obstacles/obstacle_janitor_bucket_1.png';
  static const String obsFood = 'obstacles/obstacle_food_1.png';
  static const String obsCone = 'obstacles/obstacle_cone_1.png';
  static const String obsBackpack = 'obstacles/obstacle_backpack_1.png';

  static const String obsTrashCan1 = 'obstacles/obstacle_trash_can_1.png';
  static const String obsTrashCan2 = 'obstacles/obstacle_trash_can_2.png';
  static const String obsHydrant1 = 'obstacles/obstacle_hydrant_1.png';
  static const String obsHydrant2 = 'obstacles/obstacle_hydrant_2.png';
  static const String obsTire1 = 'obstacles/obstacle_tire_1.png';
  static const String obsTire2 = 'obstacles/obstacle_tire_2.png';
  static const String obsFlowerPot1 = 'obstacles/obstacle_flower_pot_1.png';
  static const String obsFlowerPot2 = 'obstacles/obstacle_flower_pot_2.png';
  static const String obsGnome1 = 'obstacles/obstacle_gnome_1.png';
  static const String obsGnome2 = 'obstacles/obstacle_gnome_2.png';
  static const String obsBasketBall1 = 'obstacles/obstacle_basket_ball_1.png';
  static const String obsBasketBall2 = 'obstacles/obstacle_basket_ball_2.png';
  static const String obsSoccerBall1 = 'obstacles/obstacle_soccer_ball_1.png';
  static const String obsSoccerBall2 = 'obstacles/obstacle_soccer_ball_2.png';
  static const String obsGymMat1 = 'obstacles/obstacle_gym_mat_1.png';
  static const String obsGymMat2 = 'obstacles/obstacle_gym_mat_2.png';
  static const String obsLunchTray1 = 'obstacles/obstacle_lunch_tray_1.png';
  static const String obsLunchTray2 = 'obstacles/obstacle_lunch_tray_2.png';
  static const String obsMilkCarton1 = 'obstacles/obstacle_milk_carton_1.png';
  static const String obsMilkCarton2 = 'obstacles/obstacle_milk_carton_2.png';
  static const String obsMilkCarton3 = 'obstacles/obstacle_milk_carton_3.png';
  static const String obsWildFlowers1 = 'obstacles/obstacle_wild_flowers_1.png';
  static const String obsWildFlowers2 = 'obstacles/obstacle_wild_flowers_2.png';

  // Audio - SFX
  static const String sfxJump = 'audio/jump.aac';
  static const String sfxBonk = 'audio/bonk.aac';
  static const String sfxCoin = 'audio/ding.aac';
  static const String sfxPowerup = 'audio/powerup.aac';
  static const String sfxWrong = 'audio/wrong.aac';

  // Audio - Staff Voices
  static const String voiceHead = 'audio/staff_head.aac';
  static const String voiceCoach = 'audio/staff_coach.aac';
  static const String voiceLibrarian = 'audio/staff_librarian.aac';
  static const String voiceScience = 'audio/staff_science.aac';
  static const String voiceDean = 'audio/staff_dean.aac';
  static const String voicePe = 'audio/staff_pe.aac';

  // Background Characters
  static String bgCharacter(String name, int frame) {
    // Map dogStanding/dogSitting to base dog asset
    String baseName = name.startsWith('dog') ? 'dog' : name;
    return 'bg_characters/${baseName}_$frame.png';
  }
}
