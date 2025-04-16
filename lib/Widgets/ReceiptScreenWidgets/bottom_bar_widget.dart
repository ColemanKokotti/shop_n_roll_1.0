import 'package:flutter/material.dart';
import 'Buttons/back_button_widget.dart';
import 'Buttons/save_and_clear_button_widget.dart';

class ReceiptBottomBar extends StatelessWidget {
  const ReceiptBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReceiptBackButton(
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 16),
          const ReceiptSaveAndClearButton(),
        ],
      ),
    );
  }
}
