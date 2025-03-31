import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Bloc_Cubit/ThemeCubit/theme_cubit.dart';
import '../../FireBase/account_service.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/firebase_language_preference.dart';
import '../../FireBase/theme_preference_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final AccountService _accountService;
  final ThemeCubit _themeCubit;
  final ThemePreferenceService _themePreferenceService;
  final LanguagePreferenceService _languagePreferenceService =
  LanguagePreferenceService();

  AuthCubit(this._authService, this._accountService, this._themeCubit,
      this._themePreferenceService)
      : super(AuthInitial());

  bool obscureText = true;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;
  bool rememberMe = false;
  String email = '';
  String password = '';

  void toggleObscureText() {
    obscureText = !obscureText;
    emit(AuthUpdate());
  }

  void updatePasswordRequirements(String password) {
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasMinLength = password.length >= 10;
    emit(AuthUpdate());
  }

  void updateRememberMe(bool value) {
    rememberMe = value;
    emit(AuthUpdate(rememberMe: rememberMe));
  }

  void updateEmail(String value) {
    email = value;
    emit(AuthUpdate(email: email));
  }

  void updatePassword(String value) {
    password = value;
    emit(AuthUpdate(password: password));
  }

  Future<void> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
    }
    emit(AuthUpdate(rememberMe: rememberMe, email: email, password: password));
  }

  Future<void> saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      prefs.setString('email', email);
      prefs.setString('password', password);
      prefs.setBool('rememberMe', true);
    } else {
      prefs.remove('email');
      prefs.remove('password');
      prefs.remove('rememberMe');
    }
    emit(AuthUpdate());
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      User? user = await _authService.login(email, password);
      if (user != null) {
        String? savedTheme =
        await _themePreferenceService.getThemePreference(user.uid);
        if (savedTheme != null) {
          _themeCubit.selectTheme(savedTheme);
        }

        String? savedLanguage =
        await _languagePreferenceService.getLanguagePreference(user.uid);

        emit(AuthAuthenticated(user, savedLanguage));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      emit(AuthLoading());
      User? user = await _authService.register(email, password);
      if (user != null) {
        await _accountService.createUserAccount(user.uid);
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      User? currentUser = _authService.getCurrentUser();
      if (currentUser != null) {
        String? savedTheme =
        await _themePreferenceService.getThemePreference(currentUser.uid);
        if (savedTheme != null) {
          _themeCubit.selectTheme(savedTheme);
        }

        String? savedLanguage =
        await _languagePreferenceService.getLanguagePreference(
            currentUser.uid);

        emit(AuthAuthenticated(currentUser, savedLanguage));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _authService.logout(context, this);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}