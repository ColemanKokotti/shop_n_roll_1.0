import 'package:flutter/material.dart';

/// 🗝️ KINGDOM HEARTS THEME
final ThemeData kingdomHeartsTheme = ThemeData(
  primaryColor: Color(0xFF3A75C4), // Keyblade Blue
  secondaryHeaderColor: Color(0xFFFFD700), // Kingdom Key Gold
  scaffoldBackgroundColor: Color(0xFF1A1F35), // Deep Night Sky

  colorScheme: ColorScheme.dark(
    primary: Color(0xFF3A75C4), // Keyblade Blue
    secondary: Color(0xFF8257B2), // Heart Purple
    tertiary: Color(0xFFFFD700), // Kingdom Key Gold
    surface: Color(0xFF252B40), // Station of Awakening
    background: Color(0xFF1A1F35), // Deep Night Sky
    error: Color(0xFFE53935), // Heartless Red
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Color(0xFFE0E0E0), // Light Silver
    onBackground: Color(0xFFE0E0E0), // Light Silver
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF252B40), // Station of Awakening
    foregroundColor: Color(0xFFFFD700), // Kingdom Key Gold
    elevation: 6,
    shadowColor: Color(0xFF3A75C4).withOpacity(0.6), // Glowing Blue Shadow
    titleTextStyle: TextStyle(
      color: Color(0xFFFFD700), // Kingdom Key Gold
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFD700)), // Kingdom Key Gold
  ),

  cardTheme: CardTheme(
    color: Color(0xFF252B40), // Station of Awakening
    elevation: 10,
    shadowColor: Color(0xFF3A75C4).withOpacity(0.8), // Glowing Blue Shadow
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: BorderSide(
        color: Color(0xFFFFD700).withOpacity(0.4), // Kingdom Key Gold Border
        width: 1.5,
      ),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFFFFD700), // Kingdom Key Gold
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFFFFD700), // Kingdom Key Gold
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFD700), // Kingdom Key Gold
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFFE0E0E0), // Light Silver
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFFE0E0E0), // Light Silver
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      color: Color(0xFFFFD700), // Kingdom Key Gold
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF252B40), // Station of Awakening
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(0xFF3A75C4)), // Keyblade Blue
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(0xFF3A75C4).withOpacity(0.6)), // Keyblade Blue
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(0xFFFFD700), width: 2), // Kingdom Key Gold
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Color(0xFFE53935)), // Heartless Red
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    labelStyle: TextStyle(color: Color(0xFFE0E0E0)), // Light Silver
    hintStyle: TextStyle(color: Color(0xFF9E9E9E).withOpacity(0.6)), // Dimmed Silver
    prefixIconColor: Color(0xFF3A75C4), // Keyblade Blue
    suffixIconColor: Color(0xFF3A75C4), // Keyblade Blue
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Color(0xFFFFD700), // Text - Kingdom Key Gold
      backgroundColor: Color(0xFF3A75C4), // Keyblade Blue
      elevation: 8,
      shadowColor: Color(0xFF3A75C4).withOpacity(0.6), // Glowing Blue Shadow
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: Color(0xFFFFD700), // Kingdom Key Gold Border
          width: 2.5,
        ),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFFFD700), // Kingdom Key Gold
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFFFD700), // Kingdom Key Gold
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      side: BorderSide(color: Color(0xFF3A75C4), width: 2), // Keyblade Blue
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF3A75C4), // Keyblade Blue
    foregroundColor: Color(0xFFFFD700), // Kingdom Key Gold
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: Color(0xFFFFD700), // Kingdom Key Gold Border
        width: 2,
      ),
    ),
    elevation: 8,
    splashColor: Color(0xFF8257B2).withOpacity(0.5), // Heart Purple Splash
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF3A75C4); // Keyblade Blue
      }
      return Color(0xFF252B40); // Station of Awakening
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    side: BorderSide(color: Color(0xFFFFD700), width: 1.5), // Kingdom Key Gold
    checkColor: MaterialStateProperty.all(Color(0xFFFFD700)), // Kingdom Key Gold Check
  ),

  dividerTheme: DividerThemeData(
    color: Color(0xFFFFD700).withOpacity(0.3), // Kingdom Key Gold
    thickness: 1,
    space: 1,
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF252B40), // Station of Awakening
    elevation: 16,
    shadowColor: Color(0xFF3A75C4).withOpacity(0.8), // Glowing Blue Shadow
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(
        color: Color(0xFFFFD700).withOpacity(0.5), // Kingdom Key Gold Border
        width: 2,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFD700), // Kingdom Key Gold
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFFE0E0E0), // Light Silver
      fontSize: 16,
      letterSpacing: 0.5,
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF252B40), // Station of Awakening
    contentTextStyle: TextStyle(
      color: Color(0xFFE0E0E0), // Light Silver
      letterSpacing: 0.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: Color(0xFF3A75C4), // Keyblade Blue Border
        width: 1,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 8,
  ),

  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: Color(0xFF252B40), // Station of Awakening
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Color(0xFFFFD700).withOpacity(0.5), // Kingdom Key Gold Border
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3A75C4).withOpacity(0.4), // Glowing Blue Shadow
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    textStyle: TextStyle(
      color: Color(0xFFE0E0E0), // Light Silver
      fontSize: 14,
      letterSpacing: 0.25,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF252B40), // Station of Awakening
    selectedItemColor: Color(0xFFFFD700), // Kingdom Key Gold
    unselectedItemColor: Color(0xFF9E9E9E), // Dimmed Silver
    elevation: 16,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
  ),
);