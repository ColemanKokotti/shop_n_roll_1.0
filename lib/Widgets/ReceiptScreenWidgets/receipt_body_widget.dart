import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop_n_roll/Widgets/ReceiptScreenWidgets/receipt_item_row_widget.dart';
import 'package:shop_n_roll/Widgets/ReceiptScreenWidgets/receipt_table_header_widget.dart';
import 'package:shop_n_roll/Widgets/ReceiptScreenWidgets/receipt_total_row_widget.dart';


class ReceiptBody extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalPrice;

  const ReceiptBody({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Table Header
          const ReceiptTableHeader(),

          const Divider(thickness: 1),

          // Items List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ReceiptItemRow(item: item);
            },
          ),

          const Divider(thickness: 1),

          // Total Row
          ReceiptTotalRow(totalPrice: totalPrice),

          const SizedBox(height: 20),

          // Thank you message
          Text(
            'Thank you for shopping!'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}