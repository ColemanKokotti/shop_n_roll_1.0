import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReceiptBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReceiptBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style,
      child: Text('Back'.tr()),
    );
  }
}
