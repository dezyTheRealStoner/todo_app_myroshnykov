import 'package:flutter/material.dart';

class Themes {
  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
    ),
    headline2: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w100,
    ),
    headline5: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    bodyText1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
    ),
    bodyText2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
    ),
  );

  static final lightBlackOrange = ThemeData(
    colorScheme: ColorScheme(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: const Color.fromRGBO(255, 105, 0, 1),
      onSecondary: const Color.fromRGBO(196, 196, 196, 1),
      surface: const Color.fromRGBO(134, 115, 225, 1),
      onSurface: const Color.fromRGBO(156, 255, 93, 1),
      background: Colors.white,
      onBackground: const Color.fromRGBO(0, 0, 0, 1),
      brightness: Brightness.dark,
      error: Colors.grey.shade900,
      onError: const Color.fromRGBO(255, 0, 0, 1.0),
    ),
    textTheme: _textTheme,
  );

  static final darkBlackOrange = ThemeData(
    colorScheme: ColorScheme(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: const Color.fromRGBO(255, 105, 0, 1),
      onSecondary: const Color.fromRGBO(196, 196, 196, 1),
      surface: const Color.fromRGBO(134, 115, 225, 1),
      onSurface: const Color.fromRGBO(156, 255, 93, 1),
      background: const Color.fromRGBO(9, 5, 51, 1),
      onBackground: const Color.fromRGBO(0, 0, 0, 1),
      brightness: Brightness.dark,
      error: Colors.grey.shade900,
      onError: const Color.fromRGBO(255, 0, 0, 1.0),
    ),
    textTheme: _textTheme,
  );

  static final purpleBlackOrange = ThemeData(
    colorScheme: ColorScheme(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: const Color.fromRGBO(255, 105, 0, 1),
      onSecondary: const Color.fromRGBO(196, 196, 196, 1),
      surface: const Color.fromRGBO(134, 115, 225, 1),
      onSurface: const Color.fromRGBO(156, 255, 93, 1),
      background: const Color.fromRGBO(69, 39, 107, 1),
      onBackground: const Color.fromRGBO(103, 32, 96, 1),
      brightness: Brightness.dark,
      error: Colors.grey.shade900,
      onError: const Color.fromRGBO(255, 0, 0, 1.0),
    ),
    textTheme: _textTheme,
  );
}
