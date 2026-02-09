import 'package:flutter/foundation.dart';
import 'settings_service.dart';

/// Stub AudioService - audio disabled until audioplayers iOS crash is fixed
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  bool _isMuted = false;

  Future<void> init() async {
    try {
      await SettingsService().init();
      _isMuted = SettingsService().isMuted;
      debugPrint('AudioService: Disabled (audioplayers iOS crash workaround)');
    } catch (e) {
      debugPrint('Error initializing AudioService: $e');
    }
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    SettingsService().setMute(_isMuted);
  }

  bool get isMuted => _isMuted;

  // All audio methods are no-ops until we find a working iOS audio solution
  Future<void> playBGM(int level) async {}
  Future<void> stopBGM() async {}
  Future<void> pauseBGM() async {}
  Future<void> resumeBGM() async {}
  Future<void> playSFX(String sfxName) async {}
  Future<void> playVoice(String assetPath) async {}

  void playJump() {}
  void playBonk() {}
  void playCoin() {}
  void playPowerup() {}
  void playStaffSound(String staffType) {}

  Future<void> dispose() async {}
}
