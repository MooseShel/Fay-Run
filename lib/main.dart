import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'providers/game_state.dart';
import 'screens/auth/login_screen.dart';
import 'screens/onboarding/student_setup_screen.dart';
import 'screens/dashboard/main_menu_screen.dart';
import 'screens/game/game_loop_screen.dart';

void main() {
  runApp(const FayGatorRunApp());
}

class FayGatorRunApp extends StatelessWidget {
  const FayGatorRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GameState())],
      child: MaterialApp(
        title: FayStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: FayTheme.themeData,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/setup': (context) => const StudentSetupScreen(),
          '/menu': (context) => const MainMenuScreen(),
          '/game': (context) => const GameLoopScreen(),
        },
      ),
    );
  }
}

class PlaceholderHome extends StatelessWidget {
  const PlaceholderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(FayStrings.appTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: FayColors.navy),
            const SizedBox(height: 20),
            Text(
              'Welcome to ${FayStrings.appTitle}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Initializing Project Structure...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
