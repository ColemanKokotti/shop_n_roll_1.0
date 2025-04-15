import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';

class QuantityControl extends StatelessWidget {
  final String documentId;
  final int quantity;

  const QuantityControl({
    super.key,
    required this.documentId,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemListCubit = context.read<ItemListCubit>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: theme.iconTheme.color),
          onPressed: () {
            if (quantity > 0) {
              itemListCubit.updateQuantity(documentId, quantity - 1);
            }
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.primaryColorLight,
          ),
          child: Text(
            '$quantity',
            style: TextStyle(
              color: theme.textTheme.labelLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add, color: theme.iconTheme.color),
          onPressed: () {
            itemListCubit.updateQuantity(documentId, quantity + 1);
          },
        ),
      ],
    );
  }
}