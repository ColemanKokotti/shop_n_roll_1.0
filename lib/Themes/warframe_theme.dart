import 'package:flutter/material.dart';

/// ⚔️ WARFRAME THEME
final ThemeData warframeTheme = ThemeData(
  primaryColor: Color(0xFF00A8CC), // Tenno Blue
  secondaryHeaderColor: Color(0xFFFFB300), // Orokin Gold
  scaffoldBackgroundColor: Color(0xFF1A1A1A),
  
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF00A8CC),
    secondary: Color(0xFFFFB300),
    surface: Color(0xFF2A2A2A),
    error: Color(0xFFFF4444),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF2A2A2A),
    foregroundColor: Color(0xFFFFB300),
    elevation: 4,
    titleTextStyle: TextStyle(
      color: Color(0xFFFFB300),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFB300)),
  ),

  cardTheme: CardTheme(
    color: Color(0xFF2A2A2A),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF00A8CC).withOpacity(0.3),
        width: 1.5,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF00A8CC),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFFFB300),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF00A8CC),
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
      color: Color(0xFF00A8CC),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.8,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2A2A2A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00A8CC)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF00A8CC).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFB300), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFF4444)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(color: Color(0xFF00A8CC)),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
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
      foregroundColor: Color(0xFFFFB300),
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
    fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF00A8CC);
      }
      return Colors.grey[700]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFFFFB300), width: 1.5),
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFF00A8CC).withOpacity(0.2),
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF2A2A2A),
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFF00A8CC).withOpacity(0.3),
        width: 1.5,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFB300),
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
