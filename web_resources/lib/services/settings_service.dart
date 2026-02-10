import 'package:flutter/foundation.dart';

/// Stub SettingsService - no persistence until iOS crash is fixed
class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  // In-memory only - no SharedPreferences
  bool _isMuted = false;
  bool get isMuted => _isMuted;

  Future<void> init() async {
    // No-op - settings disabled to avoid shared_preferences iOS crash
    debugPrint('SettingsService: Persistence disabled (iOS crash workaround)');
  }

  Future<void> setMute(bool muted) async {
    _isMuted = muted;
    // Not persisted
  }
}
