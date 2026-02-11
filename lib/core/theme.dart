import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class FayTheme {
  static ThemeData get themeData {
    final baseTheme = ThemeData(
      primaryColor: FayColors.navy,
      scaffoldBackgroundColor: const Color(0xFFF5F9FF), // Light blue tint
      // fontFamily will be set by GoogleFonts.bubblegumSansTextTheme
    );

    return baseTheme.copyWith(
      // Use GoogleFonts for the entire text theme
      textTheme:
          GoogleFonts.bubblegumSansTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.bubblegumSans(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: FayColors.navy,
          letterSpacing: 1.2,
        ),
        displayMedium: GoogleFonts.bubblegumSans(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: FayColors.navy,
        ),
        bodyLarge: GoogleFonts.bubblegumSans(
          fontSize: 18,
          color: FayColors.text,
          fontWeight: FontWeight.w600,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: FayColors.navy,
        foregroundColor: FayColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'BubblegumSans',
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: FayColors.white,
          letterSpacing: 1.5,
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
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
    );
  }
}
