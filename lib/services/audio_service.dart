import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioPlayer? _bgmPlayer;
  bool _isMuted = false;

  AudioService._internal();

  // Create BGM player lazily only when needed
  Future<AudioPlayer?> _getBGMPlayer() async {
    if (_bgmPlayer != null) return _bgmPlayer;

    try {
      _bgmPlayer = AudioPlayer();
      await _bgmPlayer!.setReleaseMode(ReleaseMode.loop);
      return _bgmPlayer;
    } catch (e) {
      debugPrint('Error creating BGM player: $e');
      return null;
    }
  }

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    final player = await _getBGMPlayer();
    if (player == null) {
      debugPrint('BGM player not available');
      return;
    }

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
      await player.stop();
      await player.play(AssetSource(musicAsset), volume: 0.4);
    } catch (e) {
      debugPrint('Error playing BGM: $e');
    }
  }

  Future<void> stopBGM() async {
    if (_bgmPlayer == null) return;
    try {
      await _bgmPlayer!.stop();
    } catch (e) {
      debugPrint('Error stopping BGM: $e');
    }
  }

  Future<void> pauseBGM() async {
    if (_bgmPlayer == null) return;
    try {
      await _bgmPlayer!.pause();
    } catch (e) {
      debugPrint('Error pausing BGM: $e');
    }
  }

  Future<void> resumeBGM() async {
    if (_bgmPlayer == null) return;
    try {
      await _bgmPlayer!.resume();
    } catch (e) {
      debugPrint('Error resuming BGM: $e');
    }
  }

  Future<void> playSFX(String sfxName) async {
    if (_isMuted) return;

    try {
      final player = AudioPlayer();
      await player.play(AssetSource(sfxName), mode: PlayerMode.lowLatency);
      player.onPlayerComplete.listen((event) {
        player.dispose();
      });
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  void playJump() => playSFX('audio/jump.mp3');
  void playBonk() => playSFX('audio/bonk.mp3');
  void playCoin() => playSFX('audio/ding.mp3');
  void playPowerup() => playSFX('audio/powerup.mp3');

  void playStaffSound(String staffType) {
    String asset = '';
    if (staffType.contains('shoeTie')) {
      asset = 'audio/staff_head.mp3';
    } else if (staffType.contains('coachWhistle')) {
      asset = 'audio/staff_coach.mp3';
    } else if (staffType.contains('librarianShush')) {
      asset = 'audio/staff_librarian.mp3';
    } else if (staffType.contains('scienceSplat')) {
      asset = 'audio/staff_science.mp3';
    } else if (staffType.contains('deanGlare')) {
      asset = 'audio/staff_head.mp3';
    } else if (staffType.contains('peDrill')) {
      asset = 'audio/staff_coach.mp3';
    }

    if (asset.isNotEmpty) playSFX(asset);
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    if (_bgmPlayer == null) return;

    try {
      if (_isMuted) {
        _bgmPlayer!.setVolume(0);
      } else {
        _bgmPlayer!.setVolume(0.4);
      }
    } catch (e) {
      debugPrint('Error toggling mute: $e');
    }
  }

  Future<void> dispose() async {
    try {
      await _bgmPlayer?.dispose();
      _bgmPlayer = null;
    } catch (e) {
      debugPrint('Error disposing audio service: $e');
    }
  }
}
