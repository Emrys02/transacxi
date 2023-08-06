import 'package:flutter/material.dart';
import 'package:transacxi/constants/managers/text_style_manager.dart';

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
    buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
    dialogTheme: const DialogTheme(
      backgroundColor: Color.fromRGBO(185, 182, 182, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    ),
    textButtonTheme: const TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 0, 0, 1)))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(showSelectedLabels: false, showUnselectedLabels: false, type: BottomNavigationBarType.fixed),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFB9B6B6),
        filled: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        prefixStyle: TextStyle(),
        hintStyle: TextStyles.w400s9.copyWith(color: const Color(0xFF888888))),
    useMaterial3: true,
  );
}
