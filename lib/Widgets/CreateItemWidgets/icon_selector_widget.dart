import 'package:flutter/material.dart';
import '../../Data/data_items.dart';

class IconSelectorWidget extends StatelessWidget {
  final String selectedIcon;
  final Function(String) onIconSelect;
  final ThemeData theme;

  const IconSelectorWidget({
    super.key,
    required this.selectedIcon,
    required this.onIconSelect,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.dividerColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        height: 150,
        width: 300,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 1.0,
          ),
          itemCount: iconNames.length,
          itemBuilder: (context, index) {
            final name = iconNames[index];
            final Widget iconWidget = getWidgetFromString(name, size: 30, color: theme.iconTheme.color);
            final bool isSelected = selectedIcon == name;

            return GestureDetector(
              onTap: () {
                onIconSelect(name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? theme.secondaryHeaderColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.dividerColor,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: iconWidget,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
