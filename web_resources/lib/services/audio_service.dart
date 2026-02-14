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
      'jump.aac',
      'bonk.aac',
      'ding.aac',
      'powerup.aac',
      'staff_coach.aac',
      'staff_librarian.aac',
      'staff_dean.aac',
      'staff_head.aac',
      'staff_pe.aac',
      'staff_science.aac',
      'staff_english.aac',
      'staff_firstg.aac',
      'staff_prek2.aac',
    ];

    // Use the SFX pool to "warm up" the players with the most common sounds
    // This avoids rapid allocation/deallocation which triggers EXC_BAD_ACCESS
    for (int i = 0; i < _sfxPool.length && i < sfx.length; i++) {
      try {
        await _sfxPool[i].setSource(AssetSource('audio/${sfx[i]}'));
      } catch (e) {
        debugPrint('Error preloading ${sfx[i]}: $e');
      }
    }
  }

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

  String? _currentBgmFile;
  bool _isChangingBgm = false;

  Future<void> playBGM(int level) async {
    if (_isMuted || _isChangingBgm) return;

    String bgmFile = 'music_bayou_1.aac';
    switch (level) {
      case 1:
        bgmFile = 'music_bayou_1.aac';
        break;
      case 2:
        bgmFile = 'music_bayou_2.aac';
        break;
      case 3:
        bgmFile = 'music_bayou_3.aac';
        break;
      case 4:
        bgmFile = 'music_bayou_4.aac';
        break;
      case 5:
        bgmFile = 'music_bayou_5.aac';
        break;
      case 6:
        bgmFile = 'music_bayou_6.aac';
        break;
      case 7:
        bgmFile = 'music_garden.aac';
        break;
      case 8:
        bgmFile = 'music_medow.aac';
        break;
      case 9:
        bgmFile = 'music_playground.aac';
        break;
      case 10:
        bgmFile = 'music_cafeteria.aac';
        break;
    }

    // Don't restart if already playing the same file
    if (_currentBgmFile == bgmFile && _bgmPlayer.state == PlayerState.playing) {
      return;
    }

    _isChangingBgm = true;
    try {
      _currentBgmFile = bgmFile;
      await _bgmPlayer.stop();
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(_isMuted ? 0 : 0.5);
      await _bgmPlayer.play(AssetSource('audio/$bgmFile'));
    } catch (e) {
      if (e.toString().contains('NotAllowedError')) {
        debugPrint(
            'BGM playback blocked by browser/platform. Waiting for user interaction.');
      } else {
        debugPrint('Error playing BGM: $e');
      }
      _currentBgmFile = null;
    } finally {
      _isChangingBgm = false;
    }
  }

  Future<void> stopBGM() async {
    await _bgmPlayer.stop();
    _currentBgmFile = null;
  }

  Future<void> playCustomBGM(String assetPath) async {
    if (_isMuted || _isChangingBgm) return;

    if (_currentBgmFile == assetPath &&
        _bgmPlayer.state == PlayerState.playing) {
      return;
    }

    _isChangingBgm = true;
    try {
      _currentBgmFile = assetPath;
      await _bgmPlayer.stop();
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(_isMuted ? 0 : 0.5);
      await _bgmPlayer.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Error playing custom BGM: $e');
      _currentBgmFile = null;
    } finally {
      _isChangingBgm = false;
    }
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
    if (_isMuted || _sfxPool.isEmpty) return;
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

      final p = player;
      await p.stop();
      await p.play(AssetSource('audio/$sfxName'));
    } catch (e) {
      // Silently catch audio errors (e.g. NotAllowedError on web)
      // These are non-critical and shouldn't crash or report as uncaught
      debugPrint(
          'AudioService: Non-critical SFX playback error ($sfxName): $e');
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

  void playJump() => playSFX('jump.aac');
  void playBonk() => playSFX('bonk.aac');
  void playCoin() => playSFX('ding.aac');
  void playPowerup() => playSFX('powerup.aac');

  void playStaffSound(StaffEventType staffType) {
    // Map staff type to sound file
    String? soundFile;
    switch (staffType) {
      case StaffEventType.coachWhistle:
        soundFile = 'staff_coach.aac';
        break;
      case StaffEventType.librarianShush:
        soundFile = 'staff_librarian.aac';
        break;
      case StaffEventType.deanGlare:
        soundFile = 'staff_dean.aac';
        break;
      case StaffEventType.scienceSplat:
        soundFile = 'staff_science.aac';
        break;
      case StaffEventType.shoeTie:
        soundFile = 'staff_head.aac';
        break;
      case StaffEventType.peDrill:
        soundFile = 'staff_pe.aac';
        break;
      case StaffEventType.englishTeacher:
        soundFile = 'staff_english.aac';
        break;
      case StaffEventType.firstGradeTeacher:
        soundFile = 'staff_firstg.aac';
        break;
      case StaffEventType.prekTeacher:
        soundFile = 'staff_prek2.aac';
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
