// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/screens/onboarding_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a mock or actual instance of localStorage
    WidgetsFlutterBinding.ensureInitialized();
    await initLocalStorage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(localStorage: localStorage));

    // Verify that our counter starts at 0.
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
