import 'package:flutter/material.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../../UI/CreateItem/create_item_controller_adapter.dart';

class QuantitySelectorWidget extends StatelessWidget {
  final CreateItemCubit cubit;
  final ThemeData theme;
  final CreateItemControllerAdapter controllerAdapter;

  const QuantitySelectorWidget({
    super.key,
    required this.cubit,
    required this.theme,
    required this.controllerAdapter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => cubit.decreaseQuantity(),
          icon: Icon(Icons.remove),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 50,
          child: TextField(
            controller: controllerAdapter.quantityController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          onPressed: () => cubit.increaseQuantity(),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
