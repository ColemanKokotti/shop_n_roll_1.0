import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../Screens/receipt_screen.dart';


class ReceiptButton extends StatelessWidget {
  const ReceiptButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReceiptScreen(),
          ),
        );
      },
      icon: Icon(
        Icons.receipt_long,
        color: theme.appBarTheme.iconTheme?.color,
      ),
      label: Text(
        'Receipt'.tr(),
        style: TextStyle(
          color: theme.textTheme.bodyMedium?.color,
          fontSize: 15,
        ),
      ),
      style: theme.elevatedButtonTheme.style,
    );
  }
}