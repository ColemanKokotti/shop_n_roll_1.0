import 'package:flutter/material.dart';

class BottomBarContainer extends StatelessWidget {
  final ThemeData theme;
  final Widget child;

  const BottomBarContainer({
    super.key,
    required this.theme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: child,
    );
  }
}