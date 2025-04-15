import 'package:flutter/material.dart';

/// 🌊 OCEAN BREEZE THEME
final ThemeData oceanBreezeTheme = ThemeData(
  primaryColor: Color(0xFF0277BD), // Deep Ocean Blue
  secondaryHeaderColor: Color(0xFF4DD0E1), // Aqua
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
  
  colorScheme: ColorScheme.light(
    primary: Color(0xFF0277BD),
    secondary: Color(0xFF4DD0E1),
    surface: Colors.white,
    background: Color(0xFFF5F5F5),
    error: Color(0xFFE57373),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF0277BD),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF0277BD).withOpacity(0.1),
        width: 1,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF0277BD),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF0277BD),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF0277BD),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      color: Colors.black87,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF0277BD),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF0277BD)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF0277BD).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF4DD0E1), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE57373)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF0277BD)),
    hintStyle: TextStyle(color: Colors.black45),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF0277BD),
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
      foregroundColor: Color(0xFF0277BD),
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
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF0277BD);
      }
      return Colors.grey[300]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFF0277BD), width: 1.5),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFF0277BD).withOpacity(0.1),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF0277BD).withOpacity(0.1),
        width: 1,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF0277BD),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    contentTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
  ),
);
