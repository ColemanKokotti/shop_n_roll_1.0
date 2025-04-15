import 'package:flutter/material.dart';

/// 🌟 HONKAI STAR RAIL THEME
final ThemeData honkaiStarRailTheme = ThemeData(
  primaryColor: Color(0xFF7B68EE), // Stellar Purple
  secondaryHeaderColor: Color(0xFF00BFFF), // Cosmic Blue
  scaffoldBackgroundColor: Color(0xFF0A0A1F),
  
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF7B68EE),
    secondary: Color(0xFF00BFFF),
    surface: Color(0xFF1A1A2F),
    background: Color(0xFF0A0A1F),
    error: Color(0xFFFF4081),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1A1A2F),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  cardTheme: CardTheme(
    color: Color(0xFF1A1A2F),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(
        color: Color(0xFF7B68EE).withOpacity(0.3),
        width: 1.5,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF7B68EE),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF00BFFF),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[300],
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[300],
      fontSize: 14,
      letterSpacing: 0.5,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF7B68EE),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1A1A2F),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF7B68EE)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF7B68EE).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00BFFF), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFF4081)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF7B68EE)),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF7B68EE),
      elevation: 8,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF00BFFF),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF7B68EE);
      }
      return Colors.grey[700]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFF00BFFF), width: 1.5),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFF7B68EE).withOpacity(0.2),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF1A1A2F),
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(
        color: Color(0xFF7B68EE).withOpacity(0.3),
        width: 1.5,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    contentTextStyle: TextStyle(
      color: Colors.grey[300],
      fontSize: 16,
      letterSpacing: 0.5,
    ),
  ),
);
