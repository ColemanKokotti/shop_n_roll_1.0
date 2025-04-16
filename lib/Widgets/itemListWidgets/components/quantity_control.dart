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

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            context,
            icon: Icons.remove,
            onPressed: () {
              if (quantity > 0) {
                itemListCubit.updateQuantity(documentId, quantity - 1);
              }
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$quantity',
              style: TextStyle(
                color: theme.textTheme.labelLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          _buildButton(
            context,
            icon: Icons.add,
            onPressed: () {
              itemListCubit.updateQuantity(documentId, quantity + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Theme.of(context).iconTheme.color),
      onPressed: onPressed,
    );
  }
}