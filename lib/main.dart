import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'services/supabase_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () async {
      // Initialize Services
      await SupabaseService().init();
      await AudioService().init(); // Audio stub (no native code)

      // Error handlers
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        CrashReportService().logFlutterError(details);
      };

      // Force login route in offline mock mode
      const initialRoute = '/';

      runApp(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => GameState())],
          child: const FayGatorRunApp(initialRoute: initialRoute),
        ),
      );
    },
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
