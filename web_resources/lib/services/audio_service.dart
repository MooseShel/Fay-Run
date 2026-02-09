import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _bgmPlayer = AudioPlayer();

  // Cache players for overlapping SFX if needed,
  // but for simplicity we'll use a single SFX player or standard mode "low latency"
  // actually AudioPlayer(playerId: 'sfx') might cut off previous.
  // Ideally use a pool for SFX, but let's stick to simple first.

  bool _isMuted = false;

  AudioService._internal() {
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> init() async {
    // Initialize audio settings if needed
    // For now, no-op or load settings
  }

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    String musicAsset = 'audio/music_bayou.mp3'; // Default L1
    switch (level) {
      case 2:
        musicAsset = 'audio/music_hallway.mp3';
        break;
      case 3:
        musicAsset = 'audio/music_lab.mp3';
        break;
      case 4:
        musicAsset = 'audio/music_cafeteria.mp3';
        break;
      case 5:
        musicAsset = 'audio/music_carpool.mp3';
        break;
    }

    try {
      await _bgmPlayer.stop(); // Stop current
      // AssetSource automatically adds 'assets/', so we just need 'audio/...'
      await _bgmPlayer.play(AssetSource(musicAsset), volume: 0.4);
    } catch (e) {
      debugPrint('Error playing BGM: $e');
    }
  }

  Future<void> stopBGM() async {
    await _bgmPlayer.stop();
  }

  Future<void> pauseBGM() async {
    await _bgmPlayer.pause();
  }

  Future<void> resumeBGM() async {
    await _bgmPlayer.resume();
  }

  Future<void> playSFX(String sfxName) async {
    if (_isMuted) return;
    // sfxName e.g. 'audio/jump.mp3'
    try {
      // Create a temporary player for overlapping sounds
      final player = AudioPlayer();
      await player.play(AssetSource(sfxName), mode: PlayerMode.lowLatency);
      // Auto dispose handled by fire-and-forget?
      // AudioPlayers usually need disposal, but for short SFX in simple apps this is often okay
      // or we let them finish. 'lowLatency' is good.
      // Better pattern: keep a pool. But for now new instance per SFX is safest for overlap.
      player.onPlayerComplete.listen((event) {
        player.dispose();
      });
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  // Pre-defined SFX
  // Pre-defined SFX - Remove .mp3 because we might have been adding it twice,
  // OR the user said "bonk.mp3mp3".
  // Let's check playSFX usage.
  // The Strings in playJump etc ARE 'audio/jump.mp3'.
  // playSFX does: await player.play(AssetSource(sfxName));
  // AssetSource ADDS 'assets/'.
  // So 'assets/audio/jump.mp3' is correct if the file is at 'assets/audio/jump.mp3'.
  // Wait, if the error was "assets/assets/audio/bonk.mp3mp3", then:
  // 1. AssetSource added 'assets/' -> 'assets/'
  // 2. I passed 'assets/audio/bonk.mp3' ? No I passed 'audio/bonk.mp3'.
  // 3. Where did the second .mp3 come from?
  // User log: "GET /assets/assets/audio/bonk.mp3mp3"
  // Maybe `AssetSource` doesn't need extension? No, it does.
  // Ah, maybe I was doing something like `playSFX(current + '.mp3')` elsewhere?
  // Checking `playStaffSound`: `asset = 'audio/staff_head.mp3'`.
  // Checking `playSFX`: `AssetSource(sfxName)`.
  // The log "bonk.mp3mp3" implies sfxName was "audio/bonk.mp3.mp3" or "bonk.mp3.mp3".
  // Let's strictly define paths here.

  void playJump() => playSFX('audio/jump.mp3');
  void playBonk() => playSFX('audio/bonk.mp3'); // Collision
  void playCoin() => playSFX('audio/ding.mp3'); // Score/Quiz Correct
  void playPowerup() => playSFX('audio/powerup.mp3'); // Quiz Invincible

  // Staff
  void playStaffSound(String staffType) {
    String asset = '';
    // Map staff event types to audio files
    if (staffType.contains('shoeTie'))
      asset = 'audio/staff_head.mp3';
    else if (staffType.contains('coachWhistle'))
      asset = 'audio/staff_coach.mp3';
    else if (staffType.contains('librarianShush'))
      asset = 'audio/staff_librarian.mp3';
    else if (staffType.contains('scienceSplat'))
      asset = 'audio/staff_science.mp3';
    else if (staffType.contains('deanGlare'))
      asset = 'audio/staff_head.mp3'; // Dean uses head of school voice
    else if (staffType.contains('peDrill'))
      asset = 'audio/staff_coach.mp3'; // PE uses coach voice

    if (asset.isNotEmpty) playSFX(asset);
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      _bgmPlayer.setVolume(0);
    } else {
      _bgmPlayer.setVolume(0.4);
    }
  }
}
