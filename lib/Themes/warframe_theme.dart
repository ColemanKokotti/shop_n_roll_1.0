import 'package:flutter/material.dart';

/// ⚔️ WARFRAME THEME
final ThemeData warframeTheme = ThemeData(
  primaryColor: Color(0xFF00A8CC), // Energy Blue
  secondaryHeaderColor: Color(0xFFC8A2C8),
  scaffoldBackgroundColor: Color(0xFFA8C3A5),

  appBarTheme: AppBarTheme(
    color: Color(0xFF00A8CC),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.3,
      fontFamily: 'Orbitron',
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  cardColor: Color(0xFFC8A2C8),
  cardTheme: CardTheme(
    elevation: 6,
    shadowColor: Color(0xFF00A8CC),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF00A8CC),
        width: 1.5,
      ),
    ),
  ),

  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF00A8CC),
    secondary: Color(0xFFD9D9D9),
    surface: Color(0xFF1B1F2B),
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF00A8CC),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.3,
      fontFamily: 'Orbitron',
    ),
    bodyMedium: TextStyle(
      color: Colors.white70,
      fontSize: 16,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF00A8CC),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontFamily: 'Orbitron',
      ),
      elevation: 6,
      shadowColor: Color(0xFFD9D9D9).withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);
