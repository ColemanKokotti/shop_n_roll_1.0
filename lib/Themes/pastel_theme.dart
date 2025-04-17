import 'package:flutter/material.dart';

/// 🎨 PASTEL THEME
final ThemeData pastelTheme = ThemeData(
  primaryColor: Color(0xFFFFC8DD), // Pastel Pink
  secondaryHeaderColor: Color(0xFFBDE0FE), // Pastel Blue
  scaffoldBackgroundColor: Color(0xFFFFF9F9),
  
  colorScheme: ColorScheme.light(
    primary: Color(0xFFFFC8DD),
    secondary: Color(0xFFBDE0FE),
    surface: Colors.white,
    background: Color(0xFFFFF9F9),
    error: Color(0xFFFF8B94),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFC8DD),
    foregroundColor: Color(0xFF4A4A4A),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xFF4A4A4A),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: Color(0xFF4A4A4A)),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      side: BorderSide(
        color: Color(0xFFFFC8DD).withOpacity(0.3),
        width: 1,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF4A4A4A),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF4A4A4A),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF4A4A4A),
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
      color: Color(0xFF4A4A4A),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      borderSide: BorderSide(color: Color(0xFFFFC8DD)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      borderSide: BorderSide(color: Color(0xFFFFC8DD).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      borderSide: BorderSide(color: Color(0xFFBDE0FE), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      borderSide: BorderSide(color: Color(0xFFFF8B94)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF4A4A4A)),
    hintStyle: TextStyle(color: Color(0xFF4A4A4A).withOpacity(0.6)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Color(0xFF4A4A4A),
      backgroundColor: Color(0xFFFFC8DD),
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Color(0xFF4A4A4A),
          width: 4.0,
        ),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF4A4A4A),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Full circular border
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF4A4A4A),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // Full circular border
      ),
      side: BorderSide(color: Color(0xFFFFC8DD), width: 2.0),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  ),

  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: CircleBorder(), // Perfect circle for icon buttons
      padding: EdgeInsets.all(12),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFFC8DD),
    foregroundColor: Color(0xFF4A4A4A),
    shape: CircleBorder(), // Perfect circle for FABs
    elevation: 4,
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFFFFC8DD);
      }
      return Colors.grey[300]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Slightly rounded for checkboxes
    ),
    side: BorderSide(color: Color(0xFFFFC8DD), width: 1.5),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFFFFC8DD).withOpacity(0.2),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Updated to match buttons
      side: BorderSide(
        color: Color(0xFFFFC8DD).withOpacity(0.3),
        width: 1,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF4A4A4A),
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
