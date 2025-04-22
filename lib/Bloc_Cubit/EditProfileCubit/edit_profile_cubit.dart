import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Data/DataAccount/account_repository_interface.dart';
import '../../Data/DataAccount/avatar_entity.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final AccountRepository _accountRepository;
  final FirebaseAuth _auth;

  String _username = '';
  String _selectedAvatarPath = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  List<AvatarEntity> _availableAvatars = [];

  EditProfileCubit(this._accountRepository, this._auth)
      : super(EditProfileLoading()) {
    _initializeState();
  }

  Future<void> _initializeState() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(EditProfileError('User not authenticated'));
        return;
      }

      final username = await _accountRepository.getUsernameFromAccount(currentUser.uid) ??
          currentUser.displayName ?? '';
      _username = username;

      final avatarPath = await _accountRepository.getUserAvatarPath(currentUser.uid) ??
          'assets/profile_icon/default_avatar.png';
      _selectedAvatarPath = avatarPath;

      _loadAvatarPaths();

      emit(EditProfileInitial(
        username: _username,
        avatarPath: _selectedAvatarPath,
        availableAvatars: _availableAvatars,
      ));
    } catch (e) {
      emit(EditProfileError('Failed to load profile: ${e.toString()}'));
    }
  }

  void _loadAvatarPaths() {
    _availableAvatars = [
      AvatarEntity(path: 'assets/profile_icon/default_avatar.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar1.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar2.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar3.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar4.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar5.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar6.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar7.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar8.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar9.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar10.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar11.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar12.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar13.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar14.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar15.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar16.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar17.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar18.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar19.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar20.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar21.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar22.png', isSelected: false),
      AvatarEntity(path: 'assets/profile_icon/avatar23.png', isSelected: false),
    ];

    for (int i = 0; i < _availableAvatars.length; i++) {
      if (_availableAvatars[i].path == _selectedAvatarPath) {
        _availableAvatars[i] = _availableAvatars[i].copyWith(isSelected: true);
      }
    }
  }

  void updateUsername(String username) {
    _username = username;
  }

  void updatePassword(String password) {
    _password = password;
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    _emitUpdatedState();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    _emitUpdatedState();
  }

  void selectAvatar(String path) {
    _selectedAvatarPath = path;

    for (int i = 0; i < _availableAvatars.length; i++) {
      _availableAvatars[i] = _availableAvatars[i].copyWith(
          isSelected: _availableAvatars[i].path == path
      );
    }

    _emitUpdatedState();
  }

  void _emitUpdatedState() {
    if (state is EditProfileInitial || state is EditProfileError) {
      emit(EditProfileInitial(
        username: _username,
        avatarPath: _selectedAvatarPath,
        availableAvatars: _availableAvatars,
      ));
    }
  }

  Future<void> saveChanges() async {
    emit(EditProfileLoading());

    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(EditProfileError('User not authenticated'));
        return;
      }

      if (_password.isNotEmpty) {
        if (_password != _confirmPassword) {
          emit(EditProfileError('Passwords do not match'));
          return;
        }

        if (_password.length < 6) {
          emit(EditProfileError('Password must be at least 6 characters'));
          return;
        }

        await currentUser.updatePassword(_password);
      }

      await _accountRepository.updateUsername(currentUser.uid, _username);
      await currentUser.updateDisplayName(_username);

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({'username': _username.toLowerCase()});
      } catch (e) {
        print('Failed to update username in users collection: $e');
      }

      await _accountRepository.updateUserAvatarPath(currentUser.uid, _selectedAvatarPath);

      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError('Error updating profile: ${e.toString()}'));
    }
  }

  Future<void> deleteAccount() async {
    emit(EditProfileLoading());

    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(EditProfileError('User not authenticated'));
        return;
      }

      final String userId = currentUser.uid;

      WriteBatch batch = FirebaseFirestore.instance.batch();

      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentReference accountRef = FirebaseFirestore.instance.collection('Accounts').doc(userId);

      batch.delete(userRef);
      batch.delete(accountRef);

      await batch.commit();

      QuerySnapshot userItemsQuery = await FirebaseFirestore.instance
          .collection('userItems')
          .where('userId', isEqualTo: userId)
          .get();

      if (userItemsQuery.docs.isNotEmpty) {
        WriteBatch itemsBatch = FirebaseFirestore.instance.batch();
        for (var doc in userItemsQuery.docs) {
          itemsBatch.delete(doc.reference);
        }
        await itemsBatch.commit();
      }

      await currentUser.delete();

      emit(AccountDeleted());
    } catch (e) {
      String errorMessage = 'Error deleting account: ${e.toString()}';
      print(errorMessage);
      emit(EditProfileError(errorMessage));
    }
  }

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
}