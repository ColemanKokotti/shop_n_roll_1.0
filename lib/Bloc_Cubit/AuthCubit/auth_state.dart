import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String? preferredLanguage;
  final String? preferredTheme;
  final String? username;
  final String? avatarPath; // Added avatar path property

  AuthAuthenticated(this.user, this.preferredLanguage, this.preferredTheme, {
    this.username,
    this.avatarPath  // Added avatarPath parameter
  });

  String getUsername() {
    if (username != null && username!.isNotEmpty) {
      return username!;
    } else if (user.displayName != null && user.displayName!.isNotEmpty) {
      return user.displayName!;
    } else if (user.email != null) {
      return user.email!.split('@').first;
    }
    return 'User';
  }

  String getEmail() {
    return user.email ?? '';
  }

  // Add a getter for avatar path with default value
  String getAvatarPath() {
    return avatarPath ?? 'assets/profile_icon/default_avatar.png';
  }
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthUpdate extends AuthState {
  final bool? rememberMe;
  final String? email;
  final String? password;
  final String? username;
  final String? avatarPath; // Added avatarPath

  AuthUpdate({this.rememberMe, this.email, this.password, this.username, this.avatarPath});
}