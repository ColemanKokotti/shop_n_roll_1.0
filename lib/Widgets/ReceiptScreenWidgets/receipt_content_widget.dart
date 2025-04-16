import 'package:flutter/material.dart';
import 'package:shop_n_roll/Widgets/ReceiptScreenWidgets/receipt_body_widget.dart';
import 'package:shop_n_roll/Widgets/ReceiptScreenWidgets/receipt_header_widget.dart';



class ReceiptContent extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalPrice;

  const ReceiptContent({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Receipt Header
            ReceiptHeader(theme: theme),

            // Receipt Body
            ReceiptBody(items: items, totalPrice: totalPrice),
          ],
        ),
      ),
    );
  }
}