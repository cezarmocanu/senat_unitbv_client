import 'package:flutter/material.dart';

class AppPalette {
  static Color primaryColor = Colors.black;
  static Color primaryContrastColor = const Color.fromRGBO(255, 255, 255, 1.0);
  static Color mutedColor = const Color.fromRGBO(173, 173, 173, 1.0);
  static Color textWhite = const Color.fromRGBO(255, 255, 255, 1.0);

  // static Color primaryColor = Color.fromRGBO(165, 83, 255, 1.0);
  // static Color primaryContrastColor = const Color.fromRGBO(255, 255, 255, 1.0);
  // static Color mutedColor = const Color.fromRGBO(173, 173, 173, 1.0);
  // static Color textWhite = const Color.fromRGBO(255, 255, 255, 1.0);
}

class AppTheme {
  static final themeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppPalette.primaryColor,
    ),
    fontFamily: 'Domine',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppPalette.primaryColor,
      unselectedItemColor: AppPalette.mutedColor,
      unselectedLabelStyle: TextStyle(
        color: AppPalette.mutedColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppPalette.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(),
    textTheme: TextTheme(
        // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
  );
}
