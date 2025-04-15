import 'package:flutter/material.dart';

/// 🌐 CYBERPUNK THEME
final ThemeData cyberpunkTheme = ThemeData(
  primaryColor: Color(0xFF00FF9C),
  secondaryHeaderColor: Color(0xFFFF0055),
  scaffoldBackgroundColor: Color(0xFF0D0D0D),
  
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF00FF9C),
    secondary: Color(0xFFFF0055),
    surface: Color(0xFF1A1A1A),
    background: Color(0xFF0D0D0D),
    error: Color(0xFFFF3D00),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A),
    foregroundColor: Color(0xFF00FF9C),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xFF00FF9C),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
    iconTheme: IconThemeData(color: Color(0xFF00FF9C)),
  ),

  cardTheme: CardTheme(
    color: Color(0xFF1A1A1A),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(color: Color(0xFF00FF9C).withOpacity(0.3), width: 2.0),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF00FF9C),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF00FF9C),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
    titleMedium: TextStyle(
      color: Color(0xFF00FF9C),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Orbitron',
    ),
    bodyLarge: TextStyle(
      color: Colors.cyan[100],
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Colors.cyan[100],
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF00FF9C),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Orbitron',
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1A1A1A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00FF9C)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00FF9C).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00FF9C), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFF0055)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF00FF9C)),
    hintStyle: TextStyle(color: Color(0xFF00FF9C).withOpacity(0.5)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Color(0xFF00FF9C),
      elevation: 8,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontFamily: 'Orbitron',
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF00FF9C),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        fontFamily: 'Orbitron',
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF00FF9C);
      }
      return Colors.grey[800]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFF00FF9C), width: 2.0),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFF00FF9C).withOpacity(0.2),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF1A1A1A),
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(color: Color(0xFF00FF9C).withOpacity(0.3), width: 2.0),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF00FF9C),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Orbitron',
    ),
    contentTextStyle: TextStyle(
      color: Colors.cyan[100],
      fontSize: 16,
    ),
  ),
);