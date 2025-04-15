import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ItemPriceCard extends StatelessWidget {
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  const ItemPriceCard({
    Key? key,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            context,
            Icons.price_change,
            'Unit Price:'.tr(),
            '${unitPrice.toStringAsFixed(2)}',
            theme,
          ),
          const SizedBox(height: 15),
          _buildInfoRow(
            context,
            Icons.shopping_bag,
            'Quantity:'.tr(),
            '$quantity',
            theme,
          ),
          const SizedBox(height: 15),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 15),
          _buildInfoRow(
            context,
            Icons.attach_money,
            'Total Price:'.tr(),
            '${totalPrice.toStringAsFixed(2)}',
            theme,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, ThemeData theme, {bool isTotal = false}) {
    return Row(
      children: [
        Icon(icon, color: theme.iconTheme.color, size: 24),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: theme.textTheme.labelLarge?.color,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? theme.primaryColor : theme.textTheme.labelLarge?.color,
          ),
        ),
      ],
    );
  }
}