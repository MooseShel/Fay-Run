import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _keyMute = 'is_muted';

  // Cache the preference to avoid async reads everywhere
  bool _isMuted = false;
  bool get isMuted => _isMuted;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isMuted = prefs.getBool(_keyMute) ?? false;
    } catch (e) {
      // Default to unmuted if settings fail to load
      _isMuted = false;
    }
  }

  Future<void> setMute(bool muted) async {
    _isMuted = muted;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyMute, muted);
  }
}
