import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'providers/game_state.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/onboarding/student_setup_screen.dart';
import 'screens/auth/student_select_screen.dart';
import 'screens/dashboard/main_menu_screen.dart';
import 'screens/game/game_loop_screen.dart';
import 'services/audio_service.dart';
import 'services/crash_report_service.dart';

void main() {
  // Wrap entire app in error handling zone
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize Supabase first (needed for crash reporting)
      try {
        await Supabase.initialize(
          url: AppStrings.supabaseUrl,
          anonKey: AppStrings.supabaseAnonKey,
        );
      } catch (e) {
        debugPrint('Supabase init failed: $e');
        // Can't log to Supabase if it failed to init!
      }

      // Initialize audio (with internal error handling)
      await AudioService().init();

      // Set up Flutter error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details); // Show red error screen in debug
        CrashReportService().logFlutterError(details);
      };

      // Determine initial route
      final session = Supabase.instance.client.auth.currentSession;
      final initialRoute = session != null ? '/select_student' : '/';

      runApp(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => GameState())],
          child: FayGatorRunApp(initialRoute: initialRoute),
        ),
      );
    },
    // Handle uncaught async errors
    (error, stackTrace) {
      debugPrint('Uncaught error: $error');
      CrashReportService().logUncaughtError(error, stackTrace);
    },
  );
}

class FayGatorRunApp extends StatelessWidget {
  final String initialRoute;
  const FayGatorRunApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: FayTheme.themeData,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/setup': (context) => const StudentSetupScreen(),
        '/select_student': (context) => const StudentSelectScreen(),
        '/menu': (context) => const MainMenuScreen(),
        '/game': (context) => const GameLoopScreen(),
      },
    );
  }
}
