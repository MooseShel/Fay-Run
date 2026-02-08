import 'package:flutter/material.dart';
import 'constants.dart';

class FayTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: FayColors.navy,
      scaffoldBackgroundColor: FayColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: FayColors.navy,
        foregroundColor: FayColors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: FayColors.navy,
        secondary: FayColors.gold,
        surface: FayColors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FayColors.navy,
          foregroundColor: FayColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      fontFamily:
          'Roboto', // Using default for now, can perform google_fonts later if needed
    );
  }
}
