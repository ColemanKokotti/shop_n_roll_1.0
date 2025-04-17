import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';
import '../../../Bloc_Cubit/ItemDetailedCubit/item_detailed_state.dart';


class QuantityField extends StatelessWidget {
  final int initialValue;

  const QuantityField({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quantity'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        BlocBuilder<ItemDetailCubit, ItemDetailState>(
          builder: (context, state) {
            // Usare il valore dal componente che si sta modificando, oppure il valore iniziale
            final quantity = state.editingItem?.quantity ?? initialValue;
            final cubit = context.read<ItemDetailCubit>();

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: theme.primaryColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    context,
                    icon: Icons.remove,
                    onPressed: () {
                      if (quantity > 0) {
                        cubit.updateEditingQuantity(quantity - 1);
                      }
                    },
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      color: theme.textTheme.labelLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildButton(
                    context,
                    icon: Icons.add,
                    onPressed: () {
                      cubit.updateEditingQuantity(quantity + 1);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Theme.of(context).iconTheme.color),
      onPressed: onPressed,
    );
  }
}