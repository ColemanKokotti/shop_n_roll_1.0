import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_n_roll/Themes/cyberpunk_theme.dart';
import 'package:shop_n_roll/Themes/godofwar_theme.dart';
import 'package:shop_n_roll/Themes/honkaistarrail_theme.dart';
import 'package:shop_n_roll/Themes/pokemon_theme.dart';
import 'package:shop_n_roll/Themes/thewitcher_theme.dart';
import 'package:shop_n_roll/Themes/warframe_theme.dart';
import '../../FireBase/theme_preference_service.dart';
import '../../Themes/default_theme.dart';
import '../../Themes/earthy_theme.dart';
import '../../Themes/light_theme.dart';
import '../../Themes/ocean_breeze_theme.dart';
import '../../Themes/pastel_theme.dart';
import '../../Themes/theme_dark.dart';
import '../../Themes/vintageRetro_theme.dart';

final themeMap = {
  'default': defaultTheme,
  'light': lightTheme,
  'dark': darkTheme,
  'pastel': pastelTheme,
  'vintage': vintageRetroTheme,
  'earthy': earthyTheme,
  'ocean': oceanBreezeTheme,
  'cyberpunk': cyberpunkTheme ,
  'godofwar': godOfWarTheme,
  'pokemon': pokemonTheme ,
  'honkaistarrail': honkaiStarRailTheme,
  'warframe': warframeTheme,
  'witcher' : witcherTheme
};

class ThemeCubit extends Cubit<ThemeData> {
  final ThemePreferenceService _themePreferenceService = ThemePreferenceService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ThemeCubit() : super(defaultTheme) {
    // Set default theme first
    _setDefaultTheme();
    // Load saved theme if user is authenticated
    _loadSavedTheme();
  }

  void _setDefaultTheme(){
    emit(defaultTheme);
  }

  Future<void> _loadSavedTheme() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String? savedTheme = await _themePreferenceService.getThemePreference(currentUser.uid);
      if (savedTheme != null) {
        selectTheme(savedTheme);
      }
    }
  }

  void selectTheme(String themeName) {
    final selectedTheme = themeMap[themeName] ?? defaultTheme;

    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _themePreferenceService.saveThemePreference(currentUser.uid, themeName);
    }
    emit(selectedTheme);
  }
}
