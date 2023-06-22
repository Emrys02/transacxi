import 'package:flutter/material.dart';

import 'helpers/global_variables.dart';
import 'screens/auth_screen.dart';
import 'theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
