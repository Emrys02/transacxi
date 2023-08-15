import 'package:flutter/material.dart';
import 'package:transacxi/constants/managers/text_style_manager.dart';

class AppTheme {
  AppTheme._();

  static final primary = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF333333),
      onPrimary: Color(0xFFB9B6B6),
      secondary: Color(0xFFB9B6B6),
      onSecondary: Color(0xFF696868),
      error: Color(0xFFFF0000),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFF242424),
      onBackground: Color(0xFFB9B6B6),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFFFFFFF),
    ),
    buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFB9B6B6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    ),
    textButtonTheme: const TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Color(0xFFFF0000)))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(showSelectedLabels: false, showUnselectedLabels: false, type: BottomNavigationBarType.fixed),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFB9B6B6),
        filled: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        hintStyle: TextStyles.w400s9.copyWith(color: const Color(0xFF888888))),
    useMaterial3: true,
  );
}
