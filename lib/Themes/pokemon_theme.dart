import 'package:flutter/material.dart';

/// 🎮 POKEMON THEME
final ThemeData pokemonTheme = ThemeData(
  primaryColor: Color(0xFFE3350D), // Pokemon Red
  secondaryHeaderColor: Color(0xFF0075BE), // Pokemon Blue
  scaffoldBackgroundColor: Colors.white,
  
  colorScheme: ColorScheme.light(
    primary: Color(0xFFE3350D),
    secondary: Color(0xFF0075BE),
    surface: Colors.white,
    background: Colors.white,
    error: Colors.red[700]!,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFE3350D),
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pokemon',
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(color: Color(0xFFE3350D).withOpacity(0.2)),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFFE3350D),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFE3350D),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pokemon',
    ),
    titleMedium: TextStyle(
      color: Color(0xFF0075BE),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Pokemon',
    ),
    bodyLarge: TextStyle(
      color: Colors.grey[800],
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      color: Color(0xFFE3350D),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Pokemon',
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[50],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE3350D)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE3350D).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE3350D), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red[700]!),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFFE3350D)),
    hintStyle: TextStyle(color: Colors.grey[400]),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFFE3350D),
      elevation: 4,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontFamily: 'Pokemon',
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFE3350D),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        fontFamily: 'Pokemon',
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFFE3350D);
      }
      return Colors.grey[400]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),

  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFE3350D),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pokemon',
    ),
    contentTextStyle: TextStyle(
      color: Colors.grey[800],
      fontSize: 16,
    ),
  ),
);