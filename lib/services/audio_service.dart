import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'settings_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer(); // Shared SFX player
  // For rapid overlapping SFX (like coins), we might need a pool, but shared is okay for now.

  bool _isMuted = false;

  Future<void> init() async {
    try {
      await SettingsService().init();
      _isMuted = SettingsService().isMuted;

      // Configure AudioContext for iOS/Android if needed
      await AudioPlayer.global.setAudioContext(AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.ambient, // Respect silent switch
        ),
        android: AudioContextAndroid(
          // audioMode: AudioMode.normal, // Removed invalid property
          usageType: AndroidUsageType.game,
          contentType: AndroidContentType.sonification,
        ),
      ));

      // Preload critical assets
      await _preloadAssets();
    } catch (e) {
      debugPrint('Error initializing AudioService: $e');
    }
  }

  Future<void> _preloadAssets() async {
    // List of critical SFX
    final sfx = [
      'jump.mp3',
      'bonk.mp3',
      'coin.mp3',
      'powerup.mp3',
      'whistle.mp3',
      'shush.mp3',
    ];

    for (var s in sfx) {
      // Preload by creating a temporary player and setting source
      try {
        final player = AudioPlayer();
        await player.setSource(AssetSource('audio/$s'));
        await player.dispose();
      } catch (e) {
        debugPrint('Error preloading $s: $e');
      }
    }
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted);
    if (_isMuted) {
      _bgmPlayer.setVolume(0);
      _sfxPlayer.setVolume(0);
    } else {
      _bgmPlayer.setVolume(0.5); // BGM lower volume
      _sfxPlayer.setVolume(1.0);
    }
  }

  bool get isMuted => _isMuted;

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    String bgmFile = 'music_bayou.mp3';
    switch (level) {
      case 2:
        bgmFile = 'music_hallway.mp3';
        break;
      case 3:
        bgmFile = 'music_lab.mp3';
        break;
      case 4:
        bgmFile = 'music_cafeteria.mp3';
        break;
      case 5:
        bgmFile = 'music_carpool.mp3';
        break;
    }

    try {
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.play(AssetSource('audio/$bgmFile'));
      await _bgmPlayer.setVolume(_isMuted ? 0 : 0.5);
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
    if (!_isMuted) {
      await _bgmPlayer.resume();
    }
  }

  Future<void> playSFX(String sfxName) async {
    if (_isMuted) return;
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/$sfxName'));
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  void playJump() => playSFX('jump.mp3');
  void playBonk() => playSFX('bonk.mp3');
  void playCoin() => playSFX('ding.mp3'); // Was coin.mp3, likely ding.mp3
  void playPowerup() => playSFX('powerup.mp3');
  void playStaffSound(String staffType) {
    // Map staff type to sound
    if (staffType == 'coach')
      playSFX('whistle.mp3');
    else if (staffType == 'librarian') playSFX('shush.mp3');
  }

  Future<void> dispose() async {
    await _bgmPlayer.dispose();
    await _sfxPlayer.dispose();
  }
}
