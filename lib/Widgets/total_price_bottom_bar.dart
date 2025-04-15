import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';

class TotalPriceBottomBar extends StatelessWidget {
  const TotalPriceBottomBar({super.key});

  Future<double> _calculateTotalPrice(BuildContext context) async {
    final state = context.read<ItemListCubit>().state;
    double totalPrice = 0.0;

    final cubit = context.read<ItemListCubit>();

    for (final entry in state.itemQuantities.entries) {
      final itemId = entry.key;

      try {
        final itemData = await cubit.getItemData(itemId);
        if (itemData != null) {
          final totalItemPrice = double.tryParse(itemData['totalPrice'].toString()) ?? 0.0;
          totalPrice += totalItemPrice;
        }
      } catch (e) {
        print('Errore nel calcolo del prezzo per l\'item $itemId: $e');
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<double>(
      future: _calculateTotalPrice(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Error'.tr(),
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        final totalPrice = snapshot.data ?? 0.0;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total'.tr(),
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 16,
                ),
              ),
              Text(
                '${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
