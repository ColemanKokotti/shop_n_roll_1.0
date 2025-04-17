import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Data/DataAccount/avatar_entity.dart';

class AvatarSection extends StatelessWidget {
  final String selectedPath;
  final List<AvatarEntity> availableAvatars;
  final Function(String) onSelect;

  const AvatarSection({
    super.key,
    required this.selectedPath,
    required this.availableAvatars,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Picture'.tr(),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: CircleAvatar(
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            radius: 50,
            backgroundImage: AssetImage(selectedPath),
          ),
        ),
        SizedBox(height: 16),
        _buildAvatarList(theme),
      ],
    );
  }

  Widget _buildAvatarList(ThemeData theme) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableAvatars.length,
        itemBuilder: (context, index) {
          final avatar = availableAvatars[index];
          final isSelected = avatar.isSelected;

          return GestureDetector(
            onTap: () => onSelect(avatar.path),
            child: Container(
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: theme.primaryColor, width: 3)
                    : null,
              ),
              child: CircleAvatar(
                backgroundColor: theme.primaryColor.withOpacity(0.1),
                radius: 36,
                backgroundImage: AssetImage(avatar.path),
              ),
            ),
          );
        },
      ),
    );
  }
}