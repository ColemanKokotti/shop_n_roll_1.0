import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../FireBase/account_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AccountService _accountService;

  ProfileCubit(this._accountService) : super(ProfileInitial());

  Future<void> loadProfile(User user) async {
    // Non ricaricare se già in caricamento
    if (state is ProfileLoading) return;

    // Non ricaricare se già caricato con lo stesso utente (a meno che non sia forzato)
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      if (currentState.email == user.email) {
        return; // Dati già caricati per questo utente
      }
    }

    try {
      emit(ProfileLoading());

      final avatarPath = await _accountService.getUserAvatarPath(user.uid);
      final storedUsername = await _accountService.getUsernameFromAccount(user.uid);

      String username = storedUsername ?? '';
      if (username.isEmpty && user.displayName != null && user.displayName!.isNotEmpty) {
        username = user.displayName!;
      } else if (username.isEmpty && user.email != null) {
        username = user.email!.split('@').first;
      }

      final email = user.email ?? '';

      emit(ProfileLoaded(
        username: username,
        email: email,
        avatarPath: avatarPath,
      ));
    } catch (e) {
      print('ProfileCubit error: $e');
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  // Forza il ricaricamento dei dati
  Future<void> refreshProfile(User user) async {
    try {
      emit(ProfileLoading());

      final avatarPath = await _accountService.getUserAvatarPath(user.uid);
      final storedUsername = await _accountService.getUsernameFromAccount(user.uid);

      String username = storedUsername ?? '';
      if (username.isEmpty && user.displayName != null && user.displayName!.isNotEmpty) {
        username = user.displayName!;
      } else if (username.isEmpty && user.email != null) {
        username = user.email!.split('@').first;
      }

      final email = user.email ?? '';

      emit(ProfileLoaded(
        username: username,
        email: email,
        avatarPath: avatarPath,
      ));
    } catch (e) {
      print('ProfileCubit error: $e');
      emit(ProfileError('Failed to refresh profile: $e'));
    }
  }

  Future<void> updateAvatarPath(String userId, String avatarPath) async {
    try {
      await _accountService.updateUserAvatarPath(userId, avatarPath);

      // Aggiorna lo stato con il nuovo avatar
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        emit(ProfileLoaded(
          username: currentState.username,
          email: currentState.email,
          avatarPath: avatarPath,
        ));
      }
    } catch (e) {
      emit(ProfileError('Failed to update avatar: $e'));
    }
  }
}