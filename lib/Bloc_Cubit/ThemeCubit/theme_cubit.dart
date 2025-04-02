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
  'cyberpunk': cyberpunkTheme,
  'godofwar': godOfWarTheme,
  'pokemon': pokemonTheme,
  'honkaistarrail': honkaiStarRailTheme,
  'warframe': warframeTheme,
  'witcher': witcherTheme
};

class ThemeCubit extends Cubit<ThemeData> {
  final ThemePreferenceService _themePreferenceService = ThemePreferenceService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentTheme = 'default';

  ThemeCubit() : super(defaultTheme) {
    loadSavedTheme();
  }

  String get currentThemeName => _currentTheme;

  Future<void> loadSavedTheme() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String? savedTheme = await _themePreferenceService.getThemePreference(currentUser.uid);
        if (savedTheme != null && themeMap.containsKey(savedTheme)) {
          _currentTheme = savedTheme;
          emit(themeMap[savedTheme]!);
          print('Tema caricato: $savedTheme');
        } else {
          _currentTheme = 'default';
          emit(defaultTheme);
          print('Tema predefinito applicato');
        }
      } else {
        _currentTheme = 'default';
        emit(defaultTheme);
      }
    } catch (e) {
      print('Errore nel caricamento del tema: $e');
      _currentTheme = 'default';
      emit(defaultTheme);
    }
  }

  Future<void> selectTheme(String themeName) async {
    try {
      if (!themeMap.containsKey(themeName)) {
        themeName = 'default';
      }

      _currentTheme = themeName;
      final selectedTheme = themeMap[themeName]!;

      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _themePreferenceService.saveThemePreference(currentUser.uid, themeName);
        print('Tema selezionato e salvato: $themeName');
      }

      emit(selectedTheme);
    } catch (e) {
      print('Errore nella selezione del tema: $e');
    }
  }
}
