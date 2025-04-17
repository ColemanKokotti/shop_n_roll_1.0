import 'package:flutter/material.dart';

/// ⚔️ GOD OF WAR THEME
final ThemeData godOfWarTheme = ThemeData(
  primaryColor: Color(0xFFBF2626), // Spartan Red
  secondaryHeaderColor: Color(0xFFD4AF37), // Norse Gold
  scaffoldBackgroundColor: Color(0xFF1A1A1A),
  
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFBF2626),
    secondary: Color(0xFFD4AF37),
    surface: Color(0xFF262626),
    background: Color(0xFF1A1A1A),
    error: Color(0xFFFF3D00),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF262626),
    foregroundColor: Color(0xFFD4AF37),
    elevation: 4,
    titleTextStyle: TextStyle(
      color: Color(0xFFD4AF37),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
  ),

  cardTheme: CardTheme(
    color: Color(0xFF262626),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Color(0xFFBF2626).withOpacity(0.3), width: 1.5),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFFD4AF37),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFD4AF37),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFD4AF37),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
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
      color: Color(0xFFD4AF37),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF262626),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFBF2626)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFBF2626).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFD4AF37), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFF3D00)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFFD4AF37)),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFFBF2626),
      elevation: 8,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.white,
          width: 4.0,
        ),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFD4AF37),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFFBF2626);
      }
      return Colors.grey[700]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFFBF2626).withOpacity(0.3),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF262626),
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Color(0xFFBF2626).withOpacity(0.3), width: 1.5),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFD4AF37),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    contentTextStyle: TextStyle(
      color: Colors.grey[300],
      fontSize: 16,
      letterSpacing: 0.5,
    ),
  ),
);