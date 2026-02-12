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
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Lock to Landscape Mode
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // Optional: Hide status bars for more immersive game feel
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
      builder: (context, child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return Stack(
              children: [
                if (child != null) child,
                if (isPortrait && kIsWeb)
                  Material(
                    color: FayColors.navy,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ernie_run.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'PLEASE ROTATE YOUR DEVICE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'BubblegumSans',
                              fontSize: 28,
                              color: FayColors.gold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'THE GATOR RUNS BEST IN LANDSCAPE!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'BubblegumSans',
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 48),
                          const Icon(
                            Icons.screen_rotation,
                            color: Colors.white54,
                            size: 64,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
