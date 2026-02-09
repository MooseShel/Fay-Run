import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../core/assets.dart';
import 'settings_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioPlayer? _bgmPlayer;
  bool _isMuted = false;

  AudioService._internal();

  // Initialize with settings
  Future<void> init() async {
    await SettingsService().init();
    _isMuted = SettingsService().isMuted;
  }

  // Create BGM player lazily only when needed
  Future<AudioPlayer?> _getBGMPlayer() async {
    if (_bgmPlayer != null) return _bgmPlayer;

    try {
      _bgmPlayer = AudioPlayer();
      await _bgmPlayer!.setReleaseMode(ReleaseMode.loop);

      // Apply initial volume based on settings
      if (_isMuted) {
        await _bgmPlayer!.setVolume(0);
      }

      return _bgmPlayer;
    } catch (e) {
      debugPrint('Error creating BGM player: $e');
      return null;
    }
  }

  // ... existing methods ...

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted); // Persist

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

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    final player = await _getBGMPlayer();
    if (player == null) {
      debugPrint('BGM player not available');
      return;
    }

    String musicAsset = Assets.musicBayou; // Default L1
    switch (level) {
      case 2:
        musicAsset = Assets.musicHallway;
        break;
      case 3:
        musicAsset = Assets.musicLab;
        break;
      case 4:
        musicAsset = Assets.musicCafeteria;
        break;
      case 5:
        musicAsset = Assets.musicCarpool;
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

  AudioPlayer? _voicePlayer;

  Future<void> playVoice(String assetPath) async {
    if (_isMuted) return;

    try {
      // Create player if needed
      _voicePlayer ??= AudioPlayer();

      // Stop any existing voice line to prevent overlapping voices
      await _voicePlayer!.stop();

      // Play new voice line
      await _voicePlayer!.play(
        AssetSource(assetPath),
        volume: 1.0,
      ); // Max volume for voices
    } catch (e) {
      debugPrint('Error playing voice: $e');
    }
  }

  void playJump() => playSFX(Assets.sfxJump);
  void playBonk() => playSFX(Assets.sfxBonk);
  void playCoin() => playSFX(Assets.sfxCoin);
  void playPowerup() => playSFX(Assets.sfxPowerup);

  void playStaffSound(String staffType) {
    String asset = '';
    if (staffType.contains('shoeTie')) {
      asset = Assets.voiceHead;
    } else if (staffType.contains('coachWhistle')) {
      asset = Assets.voiceCoach;
    } else if (staffType.contains('librarianShush')) {
      asset = Assets.voiceLibrarian;
    } else if (staffType.contains('scienceSplat')) {
      asset = Assets.voiceScience;
    } else if (staffType.contains('deanGlare')) {
      asset = Assets.voiceDean;
    } else if (staffType.contains('peDrill')) {
      asset = Assets.voicePe;
    }

    if (asset.isNotEmpty) {
      // Use dedicated voice player
      playVoice(asset);
    }
  }

  Future<void> dispose() async {
    try {
      await _bgmPlayer?.dispose();
      _bgmPlayer = null;
      await _voicePlayer?.dispose();
      _voicePlayer = null;
    } catch (e) {
      debugPrint('Error disposing audio service: $e');
    }
  }
}
