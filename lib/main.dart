import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/onboarding_screen.dart';

import 'theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;
  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskProvider>(
      create: (_) => TaskProvider(storage: localStorage),
      child: MaterialApp(
        title: 'Flutter Tody',
        theme: AppTheme.lightTheme,
        home: const OnboardingScreen(),
      ),
    );
  }
}
