import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final ThemeData theme;

  const ErrorContainer({
    super.key,
    required this.theme,
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
      child: Center(
        child: Text(
          'Error'.tr(),
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}