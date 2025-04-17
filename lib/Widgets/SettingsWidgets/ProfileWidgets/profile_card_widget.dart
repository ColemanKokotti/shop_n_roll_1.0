import 'package:flutter/material.dart';
import 'profile_avatar_widget.dart';
import 'profile_info_widget.dart';
import 'profile_edit_button_widget.dart';
import 'history_button_widget.dart';

class ProfileCardWidget extends StatelessWidget {
  final String username;
  final String email;
  final String? avatarPath;
  final bool isAuthenticated;
  final VoidCallback onEditComplete;

  const ProfileCardWidget({
    super.key,
    required this.username,
    required this.email,
    this.avatarPath,
    required this.isAuthenticated,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
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
                ProfileAvatarWidget(
                  username: username,
                  avatarPath: avatarPath,
                ),
                const SizedBox(width: 16),
                ProfileInfoWidget(
                  username: username,
                  email: email,
                ),
                if (isAuthenticated)
                  ProfileEditButtonWidget(
                    username: username,
                    onEditComplete: onEditComplete,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const HistoryButtonWidget(),
          ],
        ),
      ),
    );
  }
}