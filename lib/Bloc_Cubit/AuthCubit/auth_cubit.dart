import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final LanguagePreferenceService _languagePreferenceService = LanguagePreferenceService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit(this._authService, this._accountService, this._themeCubit, this._themePreferenceService)
      : super(AuthInitial());

  bool obscureText = true;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;
  bool rememberMe = false;
  String email = '';
  String password = '';
  String username = '';
  String? avatarPath; // Added avatarPath property

  ThemeCubit getThemeCubit() {
    return _themeCubit;
  }

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

  void updateUsername(String value) {
    username = value;
    emit(AuthUpdate());
  }

  // Added method to update avatar path
  void updateAvatarPath(String value) {
    avatarPath = value;
    emit(AuthUpdate(avatarPath: avatarPath));
  }

  // Added method to get avatar path for current user
  Future<String?> getAvatarPathForCurrentUser() async {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      return await _accountService.getUserAvatarPath(currentUser.uid);
    }
    return null;
  }

  // Added method to update avatar path in Firestore
  Future<void> updateUserAvatar(String newAvatarPath) async {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      await _accountService.updateUserAvatarPath(currentUser.uid, newAvatarPath);
      avatarPath = newAvatarPath;

      // Update the state if currently authenticated
      if (state is AuthAuthenticated) {
        final currentState = state as AuthAuthenticated;
        emit(AuthAuthenticated(
            currentState.user,
            currentState.preferredLanguage,
            currentState.preferredTheme,
            username: currentState.username,
            avatarPath: newAvatarPath
        ));
      }
    }
  }

  Future<String?> getUsernameForCurrentUser() async {
    User? currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      return await _fetchUsernameWithFallback(currentUser.uid);
    }
    return null;
  }

  Future<void> setAuthScreenLanguage(BuildContext context) async {
    emit(AuthUpdate());
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

  Future<String?> _fetchUsernameWithFallback(String userId) async {
    String? username;

    // Debug: Print userId
    print("DEBUG - Fetching username for userId: $userId");

    // Try to get username from 'users' collection first
    try {
      print("DEBUG - Checking users collection");
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        var data = userDoc.data() as Map<String, dynamic>;
        username = data['username'] as String?;
        print("DEBUG - Username from users collection: $username");

        if (username != null && username.isNotEmpty) {
          // Save this username to the Accounts collection for future use
          await _accountService.updateUsername(userId, username);
          return username;
        }
      } else {
        print("DEBUG - User document does not exist in users collection");
      }
    } catch (e) {
      print("DEBUG - Error fetching from users: $e");
    }

    // If not found, try to get from 'Accounts' collection
    try {
      print("DEBUG - Checking Accounts collection");
      username = await _accountService.getUsernameFromAccount(userId);
      print("DEBUG - Username from Accounts collection: $username");

      if (username != null && username.isNotEmpty) {
        return username;
      }
    } catch (e) {
      print("DEBUG - Error fetching from Accounts: $e");
    }

    // Last resort: Check Firebase Auth displayName
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != null && user.displayName!.isNotEmpty) {
      username = user.displayName;
      print("DEBUG - Using displayName from Firebase Auth: $username");

      // Save this for future use
      await _accountService.updateUsername(userId, username!);
      return username;
    }

    // If we reached here, no username was found anywhere
    print("DEBUG - No username found anywhere for userId: $userId");
    return null;
  }

  // New method to fetch avatar path
  Future<String?> _fetchAvatarPath(String userId) async {
    try {
      return await _accountService.getUserAvatarPath(userId);
    } catch (e) {
      print("DEBUG - Error fetching avatar path: $e");
      return null;
    }
  }

  Future<void> login(String identifier, String password, BuildContext context) async {
    try {
      emit(AuthLoading());
      User? user = await _authService.login(identifier, password);

      if (user != null) {
        print("DEBUG - User logged in successfully, user ID: ${user.uid}");

        final themePreferenceFuture = _themePreferenceService.getThemePreference(user.uid);
        final languagePreferenceFuture = _languagePreferenceService.getLanguagePreference(user.uid);
        final avatarPathFuture = _fetchAvatarPath(user.uid); // Added avatar path fetch

        String? username = await _fetchUsernameWithFallback(user.uid);
        print("DEBUG - Username after login: $username");

        final results = await Future.wait([themePreferenceFuture, languagePreferenceFuture, avatarPathFuture]);
        final String? savedTheme = results[0];
        final String? savedLanguage = results[1];
        final String? userAvatarPath = results[2]; // Get avatar path from results

        if (savedTheme != null) {
          await _themeCubit.selectTheme(savedTheme);
        } else {
          await _themeCubit.selectTheme('default');
        }

        if (savedLanguage != null) {
          context.setLocale(Locale(savedLanguage));
        }

        print("DEBUG - Emitting AuthAuthenticated with username: $username, avatarPath: $userAvatarPath");
        emit(AuthAuthenticated(
            user,
            savedLanguage,
            savedTheme,
            username: username,
            avatarPath: userAvatarPath
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('Errore nel login: $e');
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> checkAuthStatus(BuildContext context) async {
    try {
      emit(AuthLoading());
      User? currentUser = _authService.getCurrentUser();

      if (currentUser != null) {
        print("DEBUG - User already authenticated, user ID: ${currentUser.uid}");

        final themePreferenceFuture = _themePreferenceService.getThemePreference(currentUser.uid);
        final languagePreferenceFuture = _languagePreferenceService.getLanguagePreference(currentUser.uid);
        final avatarPathFuture = _fetchAvatarPath(currentUser.uid); // Added avatar path fetch

        String? username = await _fetchUsernameWithFallback(currentUser.uid);
        print("DEBUG - Username after auth check: $username");

        final results = await Future.wait([themePreferenceFuture, languagePreferenceFuture, avatarPathFuture]);
        final String? savedTheme = results[0];
        final String? savedLanguage = results[1];
        final String? userAvatarPath = results[2]; // Get avatar path from results

        if (savedTheme != null) {
          await _themeCubit.selectTheme(savedTheme);
        } else {
          await _themeCubit.selectTheme('default');
        }

        if (savedLanguage != null) {
          context.setLocale(Locale(savedLanguage));
        }

        print("DEBUG - Emitting AuthAuthenticated with username: $username, avatarPath: $userAvatarPath");
        emit(AuthAuthenticated(
            currentUser,
            savedLanguage,
            savedTheme,
            username: username,
            avatarPath: userAvatarPath
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('Errore nel controllo dello stato di autenticazione: $e');
      emit(AuthUnauthenticated());
    }
  }

  Future<void> register(String username, String email, String password, BuildContext context) async {
    try {
      emit(AuthLoading());
      print("DEBUG - Registering user with username: $username, email: $email");

      User? user = await _authService.register(username, email, password);

      if (user != null) {
        print("DEBUG - Firebase user created: ${user.uid}");

        // Default avatar path for new users
        String defaultAvatarPath = 'assets/profile_icon/default_avatar.png';

        // Store username in both places to be safe
        await _accountService.createUserAccount(
            user.uid,
            preferredLanguage: 'en',
            preferredTheme: 'default',
            username: username,
            avatarPath: defaultAvatarPath // Added default avatar path
        );
        print("DEBUG - Account created in Accounts collection with username: $username");

        if (username.isNotEmpty) {
          await user.updateDisplayName(username);
          await user.reload();
          user = _authService.getCurrentUser();
          print("DEBUG - DisplayName updated in Firebase Auth: ${user?.displayName}");
        }

        await _themeCubit.selectTheme('default');
        context.setLocale(Locale('en'));

        // Verify username is stored in Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user!.uid).get();
        if (userDoc.exists) {
          print("DEBUG - User document in 'users' collection: ${userDoc.data()}");
        } else {
          print("DEBUG - User document in 'users' collection not found!");
        }

        DocumentSnapshot accountDoc = await _firestore.collection('Accounts').doc(user.uid).get();
        if (accountDoc.exists) {
          print("DEBUG - User document in 'Accounts' collection: ${accountDoc.data()}");
        } else {
          print("DEBUG - User document in 'Accounts' collection not found!");
        }

        print("DEBUG - Emitting AuthAuthenticated with username: $username, avatarPath: $defaultAvatarPath");
        emit(AuthAuthenticated(
            user,
            'en',
            'default',
            username: username,
            avatarPath: defaultAvatarPath
        ));
      } else {
        print("DEBUG - Registration failed: user is null");
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      print('Errore nella registrazione: $e');
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> checkAuthScreen(BuildContext context) async {
    if (state is! AuthAuthenticated) {
    }
    await loadCredentials();
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _authService.logout(context, this);
      emit(AuthUnauthenticated());
    } catch (e) {
      print('Errore nel logout: $e');
      emit(AuthError(e.toString()));
    }
  }
}