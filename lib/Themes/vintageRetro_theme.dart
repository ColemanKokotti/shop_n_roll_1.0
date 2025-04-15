import 'package:flutter/material.dart';

/// 🎭 VINTAGE RETRO THEME
final ThemeData vintageRetroTheme = ThemeData(
  primaryColor: Color(0xFF795548), // Vintage Brown
  secondaryHeaderColor: Color(0xFFD4B996), // Aged Paper
  scaffoldBackgroundColor: Color(0xFFF5F2E9),
  
  colorScheme: ColorScheme.light(
    primary: Color(0xFF795548),
    secondary: Color(0xFFD4B996),
    surface: Color(0xFFFAF7EE),
    error: Color(0xFFC62828),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF795548),
    foregroundColor: Color(0xFFF5F2E9),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xFFF5F2E9),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: Color(0xFFF5F2E9)),
  ),

  cardTheme: CardTheme(
    color: Color(0xFFFAF7EE),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF795548).withOpacity(0.1),
        width: 1,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF795548),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF795548),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF795548),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF4A4A4A),
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF4A4A4A),
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF795548),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFAF7EE),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF795548)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF795548).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFD4B996), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFC62828)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF795548)),
    hintStyle: TextStyle(color: Color(0xFF795548).withOpacity(0.6)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Color(0xFFF5F2E9),
      backgroundColor: Color(0xFF795548),
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF795548),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF795548);
      }
      return Color(0xFFE0E0E0);
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFF795548), width: 2.0),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFF795548).withOpacity(0.1),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFFFAF7EE),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF795548).withOpacity(0.1),
        width: 1,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF795548),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFF4A4A4A),
      fontSize: 16,
      letterSpacing: 0.5,
    ),
  ),
);
