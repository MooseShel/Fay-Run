import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrashReportService {
  static final CrashReportService _instance = CrashReportService._internal();
  factory CrashReportService() => _instance;
  CrashReportService._internal();

  /// Log an error to the debug_log table
  Future<void> logError({
    required String message,
    String? stackTrace,
    String level = 'error',
    String? context,
  }) async {
    // Skip logging in debug mode to avoid noise
    if (kDebugMode) {
      debugPrint('[$level] $message');
      if (stackTrace != null) debugPrint(stackTrace);
      return;
    }

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser?.id;

      // Gather device info
      final deviceInfo = {
        'platform': Platform.operatingSystem,
        'os_version': Platform.operatingSystemVersion,
        'dart_version': Platform.version,
        'is_physical_device': !Platform.environment.containsKey('FLUTTER_TEST'),
      };

      await client.from('debug_log').insert({
        'user_id': userId,
        'level': level,
        'message': message,
        'stack_trace': stackTrace,
        'device_info': deviceInfo.toString(),
        'context': context,
      });
    } catch (e) {
      // Don't throw if logging fails - just print
      debugPrint('Failed to log error to Supabase: $e');
    }
  }

  /// Log a warning
  Future<void> logWarning(String message, {String? context}) async {
    await logError(message: message, level: 'warning', context: context);
  }

  /// Log info
  Future<void> logInfo(String message, {String? context}) async {
    await logError(message: message, level: 'info', context: context);
  }

  /// Log a Flutter error (from FlutterError.onError)
  Future<void> logFlutterError(FlutterErrorDetails details) async {
    await logError(
      message: details.exceptionAsString(),
      stackTrace: details.stack?.toString(),
      context: details.context?.toString(),
    );
  }

  /// Log an uncaught async error (from runZonedGuarded)
  Future<void> logUncaughtError(Object error, StackTrace stackTrace) async {
    await logError(
      message: error.toString(),
      stackTrace: stackTrace.toString(),
      context: 'Uncaught async error',
    );
  }
}
