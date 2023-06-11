import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final primary = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(51, 51, 51, 1),
      onPrimary: Color.fromRGBO(185, 182, 182, 1),
      secondary: Color.fromRGBO(185, 182, 182, 1),
      onSecondary: Color.fromRGBO(105, 104, 104, 1),
      error: Color.fromRGBO(255, 0, 0, 1),
      onError: Color.fromRGBO(255, 255, 255, 1),
      background: Color.fromRGBO(36, 36, 36, 1),
      onBackground: Color.fromRGBO(185, 182, 182, 1),
      surface: Color.fromRGBO(51, 51, 51, 1),
      onSurface: Color.fromRGBO(255, 255, 255, 1),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(showSelectedLabels: false, showUnselectedLabels: false, type: BottomNavigationBarType.fixed),
    useMaterial3: true,
  );
}

      // primary: Color.fromRGBO(36, 36, 36,1),
      // onPrimary: Color.fromRGBO(185, 182, 182,1),
      // secondary: Color.fromRGBO(51, 51, 51,1),
      // onSecondary: Color.fromRGBO(105, 104, 104,1),
      // error: Color.fromRGBO(255, 0, 0,1),
      // onError: Color.fromRGBO(255, 255, 255,1),
      // background: Color.fromRGBO(36, 36, 36,1),
      // onBackground: Color.fromRGBO(185, 182, 182,1),
      // surface: Color.fromRGBO(51, 51, 51,1),
      // onSurface: Color.fromRGBO(255, 255, 255,1),