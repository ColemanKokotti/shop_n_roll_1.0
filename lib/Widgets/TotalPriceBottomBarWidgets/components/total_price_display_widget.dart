import 'package:flutter/material.dart';

class TotalPriceDisplay extends StatelessWidget {
  final double totalPrice;
  final ThemeData theme;

  const TotalPriceDisplay({
    super.key,
    required this.totalPrice,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${totalPrice.toStringAsFixed(2)}',
      style: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}