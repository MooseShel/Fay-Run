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

  // SFX Pool
  final List<AudioPlayer> _sfxPool = [];
  final int _poolSize = 5;
  int _poolIndex = 0;

  // Initialize with settings and pool
  Future<void> init() async {
    try {
      await SettingsService().init();
      _isMuted = SettingsService().isMuted;

      // Initialize SFX Pool with defensive error handling
      for (int i = 0; i < _poolSize; i++) {
        try {
          final player = AudioPlayer();
          // Give the player time to initialize before setting mode
          await Future.delayed(const Duration(milliseconds: 50));
          await player.setPlayerMode(PlayerMode.lowLatency);
          _sfxPool.add(player);
        } catch (e) {
          debugPrint('Error initializing SFX player $i: $e');
          // Continue with remaining players even if one fails
        }
      }

      debugPrint(
        'AudioService initialized with ${_sfxPool.length} SFX players',
      );
    } catch (e) {
      debugPrint('Error initializing AudioService: $e');
    }
  }

  // ... (BGM methods remain same) ...

  // Create BGM player lazily only when needed
  Future<AudioPlayer?> _getBGMPlayer() async {
    if (_bgmPlayer != null) return _bgmPlayer;

    try {
      _bgmPlayer = AudioPlayer();
      await _bgmPlayer!.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer!.setPlayerMode(
        PlayerMode.mediaPlayer,
      ); // BGM uses media player

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

  // ... (toggleMute, playBGM, stopBGM, pauseBGM, resumeBGM remain same) ...

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted); // Persist

    if (_bgmPlayer != null) {
      try {
        _bgmPlayer!.setVolume(_isMuted ? 0 : 0.4);
      } catch (e) {
        debugPrint('Error toggling BGM mute: $e');
      }
    }

    // Also mute any active voice
    if (_voicePlayer != null) {
      try {
        _voicePlayer!.setVolume(_isMuted ? 0 : 1.0);
      } catch (e) {
        debugPrint('Error toggling Voice mute: $e');
      }
    }
  }

  Future<void> playBGM(int level) async {
    if (_isMuted) return;

    final player = await _getBGMPlayer();
    if (player == null) return;

    String musicAsset = Assets.musicBayou;
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
      if (player.state == PlayerState.playing) {
        await player.stop();
      }
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
    if (_sfxPool.isEmpty) return; // Should not happen if init called

    try {
      // Round-robin pool selection
      final player = _sfxPool[_poolIndex];
      _poolIndex = (_poolIndex + 1) % _poolSize;

      // Reset layer/state if needed, though stop() usually enough
      if (player.state == PlayerState.playing) {
        await player.stop();
      }

      await player.play(
        AssetSource(sfxName),
        volume: 0.6,
        mode: PlayerMode.lowLatency,
      );
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }

  AudioPlayer? _voicePlayer;

  Future<void> playVoice(String assetPath) async {
    if (_isMuted) return;

    try {
      _voicePlayer ??= AudioPlayer();

      // Ensure clean state
      await _voicePlayer!.stop();

      await _voicePlayer!.play(
        AssetSource(assetPath),
        volume: 1.0,
        mode: PlayerMode.mediaPlayer, // Voices are longer, use media player
      );
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
    } catch (e) {
      debugPrint('Error disposing audio service: $e');
    }
  }
}
