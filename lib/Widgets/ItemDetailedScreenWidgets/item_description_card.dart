import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ItemDescriptionCard extends StatelessWidget {
  final String description;

  const ItemDescriptionCard({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDescription = description.isNotEmpty
        ? description
        : 'No description available'.tr();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.labelLarge?.color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formattedDescription,
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.labelLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}