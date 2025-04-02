import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String? preferredLanguage;
  final String? preferredTheme;

  AuthAuthenticated(this.user, this.preferredLanguage,this.preferredTheme);
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

  AuthUpdate({this.rememberMe, this.email, this.password});
}
