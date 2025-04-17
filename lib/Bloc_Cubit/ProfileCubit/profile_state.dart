import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String? username;
  final String email;
  final String? avatarPath;

  const ProfileLoaded({
    required this.username,
    required this.email,
    this.avatarPath,
  });

  @override
  List<Object?> get props => [username, email, avatarPath];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}