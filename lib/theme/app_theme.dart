import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Colors.deepPurple;
  static const Color _lightBg = Color(0xFFF8F9FA);
  static const Color _lightCard = Colors.white;

  static const Color _darkBg = Color(0xFF0F0E17);
  static const Color _darkCard = Color(0xFF161522);
  static const Color _darkPrimary = Color(0xFFBB86FC);

  /// ☀️ Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _lightBg,
      cardColor: _lightCard,

      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
        surface: _lightCard,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        shape: StadiumBorder(),
      ),

      cardTheme: const CardThemeData(elevation: 1),
    );
  }

  /// 🌙 Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _darkPrimary,
      scaffoldBackgroundColor: _darkBg,
      cardColor: _darkCard,

      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.dark,
        surface: _darkCard,
        surfaceTint: Colors.transparent,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: _darkCard,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkPrimary,
        foregroundColor: Colors.black,
        shape: StadiumBorder(),
      ),

      cardTheme: CardThemeData(
        color: _darkCard,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha:0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha:0.05), width: 1),
        ),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: Color(0xFFE1E1E6)),
        bodyMedium: TextStyle(color: Color(0xFFA1A1AA)),
      ),
    );
  }
}
