import 'package:flutter/material.dart';
import '../../Data/data_items.dart';


class ItemHeaderCard extends StatelessWidget {
  final String itemName;
  final String iconItem;

  const ItemHeaderCard({
    Key? key,
    required this.itemName,
    required this.iconItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
      child: Column(
        children: [
          getWidgetFromString(iconItem, size: 80, color: theme.iconTheme.color),
          const SizedBox(height: 15),
          Text(
            itemName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.labelLarge?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}