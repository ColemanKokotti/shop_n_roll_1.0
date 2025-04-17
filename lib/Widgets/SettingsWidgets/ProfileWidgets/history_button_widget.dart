import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../Screens/history_receipt_screen.dart';

class HistoryButtonWidget extends StatelessWidget {
  const HistoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HistoryReceiptScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            'Receipt History'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}