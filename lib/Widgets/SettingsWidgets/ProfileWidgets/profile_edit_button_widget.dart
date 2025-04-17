// lib/Widgets/Profile/profile_edit_button_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../../../Bloc_Cubit/AuthCubit/auth_state.dart';
import '../../../Bloc_Cubit/ProfileCubit/profile_cubit.dart';
import '../../../Screens/edit_profile_screen.dart';

class ProfileEditButtonWidget extends StatelessWidget {
  final String username;
  final VoidCallback onEditComplete;

  const ProfileEditButtonWidget({
    super.key,
    required this.username,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();

    return IconButton(
      icon: Icon(Icons.edit, color: theme.primaryColor),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(
            ),
          ),
        ).then((_) {
          // Dopo la modifica, aggiorna i dati
          if (authCubit.state is AuthAuthenticated) {
            final user = (authCubit.state as AuthAuthenticated).user;
            // Forza il refresh dei dati del profilo
            profileCubit.refreshProfile(user);
          }
          // Chiamata callback
          onEditComplete();
        });
      },
      tooltip: 'Edit Profile'.tr(),
    );
  }
}