import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReceiptTotalRow extends StatelessWidget {
  final double totalPrice;

  const ReceiptTotalRow({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Spacer(flex: 6),
          Expanded(
            flex: 2,
            child: Text(
              'Total'.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              totalPrice.toStringAsFixed(2),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}