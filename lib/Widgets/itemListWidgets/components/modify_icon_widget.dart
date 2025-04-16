import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ModifyIconCubit/icon_selector_cubit.dart';
import '../../../Data/data_items.dart';

class ModifyIconWidget extends StatelessWidget {
  final String selectedIcon;
  final String documentId;
  final Function(String) onIconSelect;

  const ModifyIconWidget({
    super.key,
    required this.selectedIcon,
    required this.documentId,
    required this.onIconSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSelectorCubit = context.read<IconSelectorCubit>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: iconNames.length,
        itemBuilder: (context, index) {
          final String iconName = iconNames[index];
          final Widget iconWidget = getWidgetFromString(iconName, size: 30, color: theme.iconTheme.color);
          final bool isSelected = selectedIcon == iconName;

          return GestureDetector(
            onTap: () {
              iconSelectorCubit.updateIcon(iconName);
              onIconSelect(iconName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary.withOpacity(0.2) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: iconWidget,
            ),
          );
        },
      ),
    );
  }
}
