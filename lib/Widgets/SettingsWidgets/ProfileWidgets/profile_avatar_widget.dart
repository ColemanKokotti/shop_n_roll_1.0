import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String username;
  final String? avatarPath;

  const ProfileAvatarWidget({
    super.key,
    required this.username,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      backgroundColor: theme.primaryColor,
      radius: 25,
      backgroundImage: avatarPath != null ? AssetImage(avatarPath!) : null,
      child: avatarPath == null ? Text(
        username.isNotEmpty ? username[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ) : null,
    );
  }
}