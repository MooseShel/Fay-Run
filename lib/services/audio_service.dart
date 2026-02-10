import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../models/staff_event.dart';
import 'settings_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  final AudioPlayer _voicePlayer =
      AudioPlayer(); // Dedicated player for Staff voices

  // SFX Pool
  final List<AudioPlayer> _sfxPool = [];
  final int _poolSize = 5;

  bool _isMuted = false;

  Future<void> init() async {
    try {
      await SettingsService().init();
      _isMuted = SettingsService().isMuted;

      // Configure AudioContext
      await AudioPlayer.global.setAudioContext(AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.ambient,
        ),
        android: AudioContextAndroid(
          usageType: AndroidUsageType.game,
          contentType: AndroidContentType.sonification,
        ),
      ));

      // Initialize SFX Pool
      for (int i = 0; i < _poolSize; i++) {
        final player = AudioPlayer();
        await player.setReleaseMode(ReleaseMode.stop);
        _sfxPool.add(player);
      }

      await _preloadAssets();
    } catch (e) {
      debugPrint('Error initializing AudioService: $e');
    }
  }

  Future<void> _preloadAssets() async {
    final sfx = [
      'jump.mp3',
      'bonk.mp3',
      'ding.mp3',
      'powerup.mp3',
      'staff_coach.mp3',
      'staff_librarian.mp3',
      'staff_dean.mp3',
      'staff_head.mp3',
      'staff_pe.mp3',
      'staff_science.mp3',
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

  // ... (Toggle Mute, BGM methods same, just ensure _voicePlayer is handled)

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted);
    if (_isMuted) {
      _bgmPlayer.setVolume(0);
      _voicePlayer.setVolume(0);
      for (var p in _sfxPool) {
        p.setVolume(0);
      }
    } else {
      _bgmPlayer.setVolume(0.5);
      _voicePlayer.setVolume(1.0);
      for (var p in _sfxPool) {
        p.setVolume(1.0);
      }
    }
  }

  // ... (BGM methods)

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    String bgmFile = 'music_bayou_1.mp3';
    switch (level) {
      case 1:
        bgmFile = 'music_bayou_1.mp3';
        break;
      case 2:
        bgmFile = 'music_bayou_2.mp3';
        break;
      case 3:
        bgmFile = 'music_bayou_3.mp3';
        break;
      case 4:
        bgmFile = 'music_bayou_4.mp3';
        break;
      case 5:
        bgmFile = 'music_bayou_5.mp3';
        break;
      case 6:
        bgmFile = 'music_bayou_6.mp3';
        break;
      case 7:
        bgmFile = 'music_garden.mp3';
        break;
      case 8:
        bgmFile = 'music_medow.mp3';
        break;
      case 9:
        bgmFile = 'music_playground.mp3';
        break;
      case 10:
        bgmFile = 'music_cafeteria.mp3';
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
      // Find an idle player in the pool
      AudioPlayer? player;
      for (var p in _sfxPool) {
        if (p.state != PlayerState.playing) {
          player = p;
          break;
        }
      }

      // If all busy, reuse the first one
      player ??= _sfxPool.first;

      await player.stop();
      await player.play(AssetSource('audio/$sfxName'));
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  Future<void> playVoice(String voiceFile) async {
    if (_isMuted) return;
    try {
      // Stop previous voice to prevent overlapping chaos
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource('audio/$voiceFile'));
    } catch (e) {
      debugPrint('Error playing Voice: $e');
    }
  }

  void playJump() => playSFX('jump.mp3');
  void playBonk() => playSFX('bonk.mp3');
  void playCoin() => playSFX('ding.mp3');
  void playPowerup() => playSFX('powerup.mp3');

  void playStaffSound(StaffEventType staffType) {
    // Map staff type to sound file
    String? soundFile;
    switch (staffType) {
      case StaffEventType.coachWhistle:
        soundFile = 'staff_coach.mp3';
        break;
      case StaffEventType.librarianShush:
        soundFile = 'staff_librarian.mp3';
        break;
      case StaffEventType.deanGlare:
        soundFile = 'staff_dean.mp3';
        break;
      case StaffEventType.scienceSplat:
        soundFile = 'staff_science.mp3';
        break;
      case StaffEventType.shoeTie:
        soundFile = 'staff_head.mp3';
        break;
      case StaffEventType.peDrill:
        soundFile = 'staff_pe.mp3';
        break;
    }

    playVoice(soundFile);
  }

  Future<void> dispose() async {
    await _bgmPlayer.dispose();
    await _voicePlayer.dispose();
    for (var p in _sfxPool) {
      await p.dispose();
    }
  }
}
