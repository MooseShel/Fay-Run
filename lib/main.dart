import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'providers/game_state.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/onboarding/student_setup_screen.dart';
import 'screens/auth/student_select_screen.dart'; // Import
import 'screens/dashboard/main_menu_screen.dart';
import 'screens/game/game_loop_screen.dart';
import 'services/audio_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppStrings.supabaseUrl,
    anonKey: AppStrings.supabaseAnonKey,
  );

  await AudioService().init();

  final session = Supabase.instance.client.auth.currentSession;
  final initialRoute = session != null ? '/select_student' : '/';

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GameState())],
      child: FayGatorRunApp(initialRoute: initialRoute),
    ),
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
