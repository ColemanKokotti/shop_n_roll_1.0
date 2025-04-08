import 'package:flutter/material.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';

class QuantityController extends StatelessWidget {
  final int quantity;
  final String documentId;
  final ThemeData theme;
  final ItemListCubit itemListCubit;

  const QuantityController({
    Key? key,
    required this.quantity,
    required this.documentId,
    required this.theme,
    required this.itemListCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            icon: Icons.add,
            onPressed: () {
              itemListCubit.updateQuantity(documentId, quantity + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: theme.iconTheme.color,
            size: 20,
          ),
        ),
      ),
    );
  }
}
