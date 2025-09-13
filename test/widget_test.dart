


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rockfall_detect/main.dart';
import 'package:rockfall_detect/screens/login/login_screen.dart';

void main() {
  testWidgets('Start screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RockfallDetectApp());

    // Verify that the start screen is displayed
    expect(find.text('Smart Rockfall Prediction for Open-Pit Mines'), findsOneWidget);
    expect(find.text('View Dashboard'), findsOneWidget);
    expect(find.text('Learn More'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build the login screen directly
    await tester.pumpWidget(
      MaterialApp(
        home: const LoginScreen(),
      ),
    );

    // Verify that the login screen is displayed
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Demo Login'), findsOneWidget);
  });
}
