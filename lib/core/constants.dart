import 'package:flutter/material.dart';

class FayColors {
  static const double kGroundHeight = 120.0; // Default/fallback value
  static const double kGroundHeightRatio =
      0.15; // Ground is 15% of screen height
  static const double kHorizonOverlap =
      40.0; // Overlap with ground for perspective
  static const Color navy = Color(0xFF1565C0); // Brighter Navy (Blue 800)
  static const Color navyDark = Color(0xFF0D47A1); // Deep Navy background
  static const Color gold = Color(0xFFFFC107); // Amber 500 (Vibrant Gold)
  static const Color white = Colors.white;
  static const Color bayouGreen = Color(0xFF43A047); // Green 600 (Lush)
  static const Color brickRed = Color(0xFFE53935); // Red 600 (Vibrant)
  static const Color text = Color(0xFF263238); // Blue Grey 900
}

class AppStrings {
  static const String appTitle = 'Fay Gator Run';
  static const String supabaseUrl = 'https://jywaeueuzislxcyrossu.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_9bLhuthhrhqQBuRL_5kziQ_fKz1lcbG'; // Provided by user
  static const String schoolName = 'The Fay School';
}
