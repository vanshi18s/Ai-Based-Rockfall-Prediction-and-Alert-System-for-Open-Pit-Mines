import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/start_screen.dart';

void main() {
  runApp(const RockfallDetectApp());
}

class RockfallDetectApp extends StatelessWidget {
  const RockfallDetectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rockfall Detect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const StartScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const StartScreen(),
        // '/signup': (context) => const SignupScreen(), (create later)
        // '/dashboard': (context) => const DashboardScreen(), (create later)
      },
    );
  }
}
