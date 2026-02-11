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
    return 'bgs/bg_fay_$level.webp';
  }

  static const String itemGoldenBook = 'obstacles/item_golden_book.png';

  // Audio - Background Music
  static const String musicBayou1 = 'audio/music_bayou_1.mp3';
  static const String musicBayou2 = 'audio/music_bayou_2.mp3';
  static const String musicBayou3 = 'audio/music_bayou_3.mp3';
  static const String musicBayou4 = 'audio/music_bayou_4.mp3';
  static const String musicBayou5 = 'audio/music_bayou_5.mp3';
  static const String musicBayou6 = 'audio/music_bayou_6.mp3';
  static const String musicGarden = 'audio/music_garden.mp3';
  static const String musicMedow = 'audio/music_medow.mp3';
  static const String musicPlayground = 'audio/music_playground.mp3';
  static const String musicCafeteria = 'audio/music_cafeteria.mp3';

  // Images - Obstacles
  static const String obsLog = 'obstacles/obstacle_log.png';
  static const String obsRock = 'obstacles/obstacle_rock.png';
  static const String obsApple = 'obstacles/obstacle_apple.png';
  static const String obsBanana = 'obstacles/obstacle_banana.png';
  static const String obsBurger1 = 'obstacles/obstacle_burger_1.png';
  static const String obsBurger2 = 'obstacles/obstacle_burger_2.png';
  static const String obsBucket = 'obstacles/obstacle_bucket.png';
  static const String obsFood = 'obstacles/obstacle_food.png';
  static const String obsSuv = 'obstacles/obstacle_suv.png';
  static const String obsSuv2 = 'obstacles/obstacle_suv_2.png';
  static const String obsCone = 'obstacles/obstacle_cone.png';
  static const String obsBackpack = 'obstacles/obstacle_backpack.png';

  static const String obsTrashCan1 = 'obstacles/obstacle_trash_can_1.png';
  static const String obsTrashCan2 = 'obstacles/obstacle_trash_can_2.png';
  static const String obsHydrant1 = 'obstacles/obstacle_hydrant_1.png';
  static const String obsHydrant2 = 'obstacles/obstacle_hydrant_2.png';
  static const String obsBench1 = 'obstacles/obstacle_bench_1.png';
  static const String obsBench2 = 'obstacles/obstacle_bench_2.png';
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
  static const String obsMilkCart1 = 'obstacles/obstacle_milk_cart_1.png';
  static const String obsMilkCart2 = 'obstacles/obstacle_milk_cart_2.png';
  static const String obsMilkCart3 = 'obstacles/obstacle_milk_cart_3.png';
  static const String obsWildFlowers1 = 'obstacles/obstacle_wild_flowers_1.png';
  static const String obsWildFlowers2 = 'obstacles/obstacle_wild_flowers_2.png';

  // Audio - SFX
  static const String sfxJump = 'audio/jump.mp3';
  static const String sfxBonk = 'audio/bonk.mp3';
  static const String sfxCoin = 'audio/ding.mp3';
  static const String sfxPowerup = 'audio/powerup.mp3';

  // Audio - Staff Voices
  static const String voiceHead = 'audio/staff_head.mp3';
  static const String voiceCoach = 'audio/staff_coach.mp3';
  static const String voiceLibrarian = 'audio/staff_librarian.mp3';
  static const String voiceScience = 'audio/staff_science.mp3';
  static const String voiceDean = 'audio/staff_dean.mp3';
  static const String voicePe = 'audio/staff_pe.mp3';

  // Background Characters
  static String bgCharacter(String name, int frame) {
    return 'bg_characters/${name}_$frame.png';
  }
}
