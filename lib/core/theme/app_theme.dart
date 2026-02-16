import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Colors.indigoAccent;
  static const background = Colors.white;
  static const textPrimary = Colors.black;
  static const textSecondary = Colors.grey;
  static const cardTextColor = Colors.black;
  static const fvrtCardTextColor = Colors.white;



  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    primaryColor: primary,

    colorScheme: const ColorScheme.light(
      primary: primary,
      background: background,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
  );
}
