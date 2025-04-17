import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../../Bloc_Cubit/AuthCubit/auth_state.dart';
import '../../Bloc_Cubit/ProfileCubit/profile_cubit.dart';
import '../../Bloc_Cubit/ProfileCubit/profile_state.dart';
import 'ProfileWidgets/profile_card_widget.dart';
import 'ProfileWidgets/profile_header_widget.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();

    if (authCubit.state is! AuthAuthenticated) {
      authCubit.checkAuthStatus(context);
    } else {
      final authState = authCubit.state as AuthAuthenticated;
      if (profileCubit.state is! ProfileLoaded && profileCubit.state is! ProfileLoading) {
        profileCubit.loadProfile(authState.user);
      }
    }

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            String username = 'Username';
            String email = 'email';
            String? avatarPath;
            bool isAuthenticated = false;

            if (profileState is ProfileLoaded) {
              username = profileState.username ?? '';
              email = profileState.email;
              avatarPath = profileState.avatarPath;
              isAuthenticated = true;

              if (username.isEmpty) {
                username = email.split('@').first;
              }
            }
            else if (authState is AuthAuthenticated) {
              email = authState.user.email ?? '';
              isAuthenticated = true;

              if (authState.username != null && authState.username!.isNotEmpty) {
                username = authState.username!;
              } else if (authState.user.displayName != null && authState.user.displayName!.isNotEmpty) {
                username = authState.user.displayName!;
              } else {
                username = email.split('@').first;
              }

              avatarPath = authState.avatarPath;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeaderWidget(),
                if (profileState is ProfileLoading && !(authState is AuthAuthenticated))
                  const Center(child: CircularProgressIndicator())
                else
                  ProfileCardWidget(
                    username: username,
                    email: email,
                    avatarPath: avatarPath,
                    isAuthenticated: isAuthenticated,
                    onEditComplete: () {
                      authCubit.checkAuthStatus(context);
                      if (authState is AuthAuthenticated) {
                        profileCubit.refreshProfile(authState.user);
                      }
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}