import 'package:flutter/material.dart';
import '../../Data/data_icons.dart';

class ReceiptItemRow extends StatelessWidget {
  final Map<String, dynamic> item;

  const ReceiptItemRow({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final String iconName = item['iconItem'] ?? 'error';
    final String name = item['nameItem'] ?? 'Unknown';
    final int quantity = item['quantity'] is int
        ? item['quantity']
        : int.tryParse(item['quantity'].toString()) ?? 0;
    final double unitPrice = item['unitPrice'] is double
        ? item['unitPrice']
        : double.tryParse(item['unitPrice'].toString()) ?? 0.0;
    final double itemTotalPrice = unitPrice * quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: getWidgetFromString(iconName, color: Colors.black87, size: 24),
          ),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              quantity.toString(),
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              unitPrice.toStringAsFixed(2),
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              itemTotalPrice.toStringAsFixed(2),
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}