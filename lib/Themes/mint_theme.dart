import 'package:flutter/material.dart';

/// 🌿 MINT THEME
final ThemeData mintTheme = ThemeData(
  primaryColor: Color(0xFF7EC8AA), // Mint Green
  secondaryHeaderColor: Color(0xFF3D5A59), // Dark Teal
  scaffoldBackgroundColor: Color(0xFFF7FAF9),

  colorScheme: ColorScheme.light(
    primary: Color(0xFF7EC8AA), // Mint Green
    secondary: Color(0xFF3D5A59), // Dark Teal
    tertiary: Color(0xFFB5DFCA), // Light Mint
    surface: Colors.white,
    background: Color(0xFFF7FAF9), // Off-white
    error: Color(0xFFE57373), // Soft Red
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Color(0xFF2A3B39), // Near-black
    onBackground: Color(0xFF2A3B39), // Near-black
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF7EC8AA),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Color(0xFFB5DFCA).withOpacity(0.3),
        width: 1,
      ),
    ),
    shadowColor: Color(0xFF7EC8AA).withOpacity(0.3),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF3D5A59),
    size: 24,
  ),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.0,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF7EC8AA)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF7EC8AA).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF7EC8AA), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE57373)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(color: Color(0xFF3D5A59)),
    hintStyle: TextStyle(color: Color(0xFF3D5A59).withOpacity(0.6)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF7EC8AA),
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white, width: 1.5),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      shadowColor: Color(0xFF7EC8AA).withOpacity(0.4),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF7EC8AA),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF7EC8AA),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      side: BorderSide(color: Color(0xFF7EC8AA), width: 1.5),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ),

  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Color(0xFF3D5A59),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF7EC8AA),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 6,
    splashColor: Colors.white.withOpacity(0.3),
    extendedTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF7EC8AA);
      }
      return Colors.grey[300]!;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(color: Color(0xFF7EC8AA), width: 1.5),
  ),


  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: Color(0xFFB5DFCA).withOpacity(0.3),
        width: 1,
      ),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFF2A3B39),
      fontSize: 16,
      letterSpacing: 0.25,
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF3D5A59),
    contentTextStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 0.25,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 4,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF7EC8AA),
    unselectedItemColor: Color(0xFF3D5A59).withOpacity(0.6),
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
  ),

  tabBarTheme: TabBarTheme(
    labelColor: Color(0xFF7EC8AA),
    unselectedLabelColor: Color(0xFF3D5A59).withOpacity(0.6),
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFF7EC8AA),
          width: 3.0,
        ),
      ),
    ),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: Color(0xFFB5DFCA).withOpacity(0.3),
    deleteIconColor: Color(0xFF3D5A59),
    disabledColor: Colors.grey[300],
    selectedColor: Color(0xFF7EC8AA),
    secondarySelectedColor: Color(0xFF3D5A59),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    labelStyle: TextStyle(
      color: Color(0xFF2A3B39),
      fontWeight: FontWeight.w500,
    ),
    secondaryLabelStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
