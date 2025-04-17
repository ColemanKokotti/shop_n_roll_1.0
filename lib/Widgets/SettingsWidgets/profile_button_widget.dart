import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../../Bloc_Cubit/AuthCubit/auth_state.dart';
import '../../Screens/edit_profile_screen.dart';
import '../../Screens/history_receipt_screen.dart';
import '../../FireBase/account_service.dart';

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  String? avatarPath;
  final AccountService _accountService = AccountService();

  @override
  void initState() {
    super.initState();
    _loadAvatarPath();
  }

  Future<void> _loadAvatarPath() async {
    final authCubit = context.read<AuthCubit>();
    if (authCubit.state is AuthAuthenticated) {
      final user = (authCubit.state as AuthAuthenticated).user;
      final path = await _accountService.getUserAvatarPath(user.uid);
      if (path != null && mounted) {
        setState(() {
          avatarPath = path;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authCubit = context.read<AuthCubit>();

    if (authCubit.state is! AuthAuthenticated) {
      authCubit.checkAuthStatus(context);
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String username = 'Username';
        String email = 'email';

        if (state is AuthAuthenticated) {
          email = state.user.email ?? '';

          if (state.username != null && state.username!.isNotEmpty) {
            username = state.username!;
          } else if (state.user.displayName != null && state.user.displayName!.isNotEmpty) {
            username = state.user.displayName!;
          } else {
            username = email.split('@').first;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile'.tr(),
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: theme.primaryColor,
                          radius: 25,
                          backgroundImage: avatarPath != null ? AssetImage(avatarPath!) : null,
                          child: avatarPath == null ? Text(
                            username.isNotEmpty ? username[0].toUpperCase() : '?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ) : null,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                email,
                                style: TextStyle(
                                  color: theme.textTheme.bodyMedium?.color,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (state is AuthAuthenticated)
                          IconButton(
                            icon: Icon(Icons.edit, color: theme.primaryColor),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                    initialUsername: username,
                                  ),
                                ),
                              ).then((_) {
                                // Refresh avatar path after returning from edit screen
                                _loadAvatarPath();
                                // Refresh auth state to get updated username
                                authCubit.checkAuthStatus(context);
                              });
                            },
                            tooltip: 'Edit Profile'.tr(),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Material(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HistoryReceiptScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Receipt History'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}