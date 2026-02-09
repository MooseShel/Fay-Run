import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Stub CrashReportService - all network features disabled to avoid native plugin crashes on iOS 18.2
class CrashReportService {
  static final CrashReportService _instance = CrashReportService._internal();
  factory CrashReportService() => _instance;
  CrashReportService._internal();

  Future<void> logError({
    required String message,
    String? stackTrace,
    String level = 'error',
    String? context,
  }) async {
    debugPrint('[$level] $message');
  }

  void logFlutterError(FlutterErrorDetails details) {
    debugPrint('Flutter Error: ${details.exception}');
  }

  void logUncaughtError(Object error, StackTrace stackTrace) {
    debugPrint('Uncaught Error: $error');
  }

  Future<void> logInfo(String message, {String? context}) async {
    debugPrint('[info] $message');
  }

  Future<void> logWarning(String message, {String? context}) async {
    debugPrint('[warning] $message');
  }
}
