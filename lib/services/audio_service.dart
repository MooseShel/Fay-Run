import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../core/assets.dart';
import 'settings_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioPlayer? _bgmPlayer;
  AudioPlayer? _voicePlayer;
  bool _isMuted = false;
  bool _isInitialized = false;

  AudioService._internal();

  // SFX Pool - lazily initialized
  final List<AudioPlayer> _sfxPool = [];
  final int _poolSize = 5;
  int _poolIndex = 0;

  // Initialize settings only - no audio players yet!
  Future<void> init() async {
    try {
      await SettingsService().init();
      _isMuted = SettingsService().isMuted;
      debugPrint('AudioService: Settings loaded (muted: $_isMuted)');
    } catch (e) {
      debugPrint('Error initializing AudioService settings: $e');
    }
  }

  // Lazy initialization of SFX pool - called on first sound play
  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    _isInitialized = true;

    debugPrint('AudioService: Lazy initializing SFX pool...');

    for (int i = 0; i < _poolSize; i++) {
      try {
        final player = AudioPlayer();
        // Skip setPlayerMode on iOS to avoid native crashes
        // The default mode works fine for SFX
        _sfxPool.add(player);
      } catch (e) {
        debugPrint('Error creating SFX player $i: $e');
      }
    }

    debugPrint('AudioService: Initialized ${_sfxPool.length} SFX players');
  }

  // Create BGM player lazily only when needed
  Future<AudioPlayer?> _getBGMPlayer() async {
    if (_bgmPlayer != null) return _bgmPlayer;

    try {
      _bgmPlayer = AudioPlayer();
      await _bgmPlayer!.setReleaseMode(ReleaseMode.loop);

      if (_isMuted) {
        await _bgmPlayer!.setVolume(0);
      }

      return _bgmPlayer;
    } catch (e) {
      debugPrint('Error creating BGM player: $e');
      return null;
    }
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted);

    if (_bgmPlayer != null) {
      try {
        _bgmPlayer!.setVolume(_isMuted ? 0 : 0.4);
      } catch (e) {
        debugPrint('Error toggling BGM mute: $e');
      }
    }

    if (_voicePlayer != null) {
      try {
        _voicePlayer!.setVolume(_isMuted ? 0 : 1.0);
      } catch (e) {
        debugPrint('Error toggling Voice mute: $e');
      }
    }
  }

  bool get isMuted => _isMuted;

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    try {
      final player = await _getBGMPlayer();
      if (player == null) return;

      String asset;
      switch (level) {
        case 1:
          asset = Assets.musicBayou;
          break;
        case 2:
          asset = Assets.musicHallway;
          break;
        case 3:
          asset = Assets.musicLab;
          break;
        case 4:
          asset = Assets.musicCafeteria;
          break;
        case 5:
          asset = Assets.musicCarpool;
          break;
        default:
          asset = Assets.musicBayou;
      }

      await player.stop();
      await player.play(AssetSource(asset), volume: 0.4);
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

    // Lazy init on first SFX play
    await _ensureInitialized();

    if (_sfxPool.isEmpty) return;

    try {
      final player = _sfxPool[_poolIndex];
      _poolIndex = (_poolIndex + 1) % _sfxPool.length;

      if (player.state == PlayerState.playing) {
        await player.stop();
      }

      await player.play(AssetSource(sfxName), volume: 0.6);
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  Future<void> playVoice(String assetPath) async {
    if (_isMuted) return;

    try {
      _voicePlayer ??= AudioPlayer();
      await _voicePlayer!.stop();
      await _voicePlayer!.play(AssetSource(assetPath), volume: 1.0);
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
      playVoice(asset);
    }
  }

  Future<void> dispose() async {
    try {
      await _bgmPlayer?.dispose();
      _bgmPlayer = null;

      await _voicePlayer?.dispose();
      _voicePlayer = null;

      for (var player in _sfxPool) {
        await player.dispose();
      }
      _sfxPool.clear();
      _isInitialized = false;
    } catch (e) {
      debugPrint('Error disposing audio service: $e');
    }
  }
}
