import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'supabase_service.dart';

/// Service to handle crash reporting and diagnostic logging
class CrashReportService {
  static final CrashReportService _instance = CrashReportService._internal();
  factory CrashReportService() => _instance;
  CrashReportService._internal();

  final SupabaseService _supabase = SupabaseService();

  Future<void> logError({
    required String message,
    String? stackTrace,
    String level = 'error',
    String? context,
  }) async {
    debugPrint('[$level] $message');
    await _supabase.logDebug(
      message: message,
      level: level,
      stackTrace: stackTrace,
      context: context,
    );
  }

  void logFlutterError(FlutterErrorDetails details) {
    debugPrint('Flutter Error: ${details.exception}');
    logError(
      message: details.exception.toString(),
      stackTrace: details.stack.toString(),
      level: 'critical',
      context: 'FlutterFrameworkError',
    );
  }

  void logUncaughtError(Object error, StackTrace stackTrace) {
    debugPrint('Uncaught Error: $error');
    logError(
      message: error.toString(),
      stackTrace: stackTrace.toString(),
      level: 'critical',
      context: 'UncaughtError',
    );
  }

  Future<void> logInfo(String message, {String? context}) async {
    debugPrint('[info] $message');
    await _supabase.logDebug(
      message: message,
      level: 'info',
      context: context,
    );
  }

  Future<void> logWarning(String message, {String? context}) async {
    debugPrint('[warning] $message');
    await _supabase.logDebug(
      message: message,
      level: 'warning',
      context: context,
    );
  }
}
