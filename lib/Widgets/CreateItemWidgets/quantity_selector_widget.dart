import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final CreateItemCubit cubit;
  final ThemeData theme;

  const QuantitySelectorWidget({super.key,
    required this.cubit,
    required this.theme,
  });

  Widget _buildButton({required IconData icon, required VoidCallback onPressed}) {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Quantity:'.tr(),
          style: TextStyle(
            color: theme.textTheme.labelLarge?.color,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Container(
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
                  onPressed: () => cubit.decreaseQuantity(),
                ),
                Expanded(
                  child: TextField(
                    controller: cubit.quantityController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: theme.textTheme.labelLarge?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      if (int.tryParse(value) == null) {
                        cubit.quantityController.text = '1';
                        cubit.quantityController.selection = TextSelection.fromPosition(
                          TextPosition(offset: cubit.quantityController.text.length),
                        );
                      }
                    },
                  ),
                ),
                _buildButton(
                  icon: Icons.add,
                  onPressed: () => cubit.increaseQuantity(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
