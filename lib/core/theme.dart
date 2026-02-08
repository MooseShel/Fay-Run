import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class FayTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: FayColors.navy,
      scaffoldBackgroundColor: const Color(0xFFF5F9FF), // Light blue tint
      // Text Theme (Google Fonts)
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.fredoka(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: FayColors.navy,
        ),
        displayMedium: GoogleFonts.fredoka(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: FayColors.navy,
        ),
        bodyLarge: GoogleFonts.nunito(fontSize: 18, color: FayColors.text),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: FayColors.navy,
        foregroundColor: FayColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.fredoka(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: FayColors.white,
        ),
      ),

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: FayColors.navy,
        secondary: FayColors.gold,
        surface: FayColors.white,
      ),

      // Modern Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: FayColors.navy,
          foregroundColor: FayColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded cartoon look
          ),
          textStyle: GoogleFonts.fredoka(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          elevation: 4,
          shadowColor: FayColors.navyDark.withValues(alpha: 0.4),
        ),
      ),

      // Input Decoration (Rounded)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: FayColors.navy.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: FayColors.navy, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),

      /*
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),
      */
    );
  }
}
