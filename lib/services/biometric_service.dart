import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  factory BiometricService() => _instance;
  BiometricService._internal();

  final LocalAuthentication _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _keyEmail = 'biometric_email';
  static const String _keyPassword = 'biometric_password';
  static const String _keyEnabled = 'biometric_enabled';

  Future<bool> isBiometricAvailable() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
      return false;
    }
  }

  Future<void> enableBiometric(String email, String password) async {
    try {
      await _storage.write(key: _keyEmail, value: email);
      await _storage.write(key: _keyPassword, value: password);
      await _storage.write(key: _keyEnabled, value: 'true');
    } catch (e) {
      debugPrint('Error enabling biometrics: $e');
    }
  }

  Future<void> disableBiometric() async {
    try {
      await _storage.delete(key: _keyEmail);
      await _storage.delete(key: _keyPassword);
      await _storage.write(key: _keyEnabled, value: 'false');
    } catch (e) {
      debugPrint('Error disabling biometrics: $e');
    }
  }

  Future<bool> isBiometricEnabled() async {
    final enabled = await _storage.read(key: _keyEnabled);
    return enabled == 'true';
  }

  Future<Map<String, String>?> getStoredCredentials() async {
    try {
      final email = await _storage.read(key: _keyEmail);
      final password = await _storage.read(key: _keyPassword);
      if (email != null && password != null) {
        return {'email': email, 'password': password};
      }
    } catch (e) {
      debugPrint('Error reading credentials: $e');
    }
    return null;
  }

  Future<Map<String, String>?> authenticateAndGetCredentials() async {
    try {
      // 1. Check if enabled
      if (!await isBiometricEnabled()) return null;

      // 2. Authenticate
      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to log in',
      );

      if (didAuthenticate) {
        return await getStoredCredentials();
      }
    } on PlatformException catch (e) {
      debugPrint('Error during authentication: $e');
    }
    return null;
  }
}
