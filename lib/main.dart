import 'package:flutter/material.dart';

import 'helpers/global_variables.dart';
import 'screens/auth_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Transcaxi",
      theme: AppTheme.primary,
      home: const AuthScreen(),
      navigatorKey: navigationKey,
    );
  }
}
