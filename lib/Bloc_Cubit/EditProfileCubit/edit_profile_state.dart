import '../../Data/DataAccount/avatar_entity.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {
  final String username;
  final String avatarPath;
  final List<AvatarEntity> availableAvatars;

  EditProfileInitial({
    required this.username,
    required this.avatarPath,
    required this.availableAvatars,
  });
}

class EditProfileLoading extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String errorMessage;

  EditProfileError(this.errorMessage);
}

class EditProfileSuccess extends EditProfileState {}

// New state for account deletion
class AccountDeleted extends EditProfileState {}