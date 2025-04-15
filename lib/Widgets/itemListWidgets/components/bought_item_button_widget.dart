import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/BoughtItemCubit/bought_item_cubit.dart';



class BoughtItemButtonWidget extends StatelessWidget {
  const BoughtItemButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    return BlocBuilder<BoughtItemCubit, bool>(
      builder: (context, isBought) {
        return Checkbox(
          value: isBought,
          onChanged: (bool? value) {
            if (value != null) {
              context.read<BoughtItemCubit>().toggleItemStatus();
            }
          },
          activeColor: theme.iconTheme.color,
          checkColor: theme.cardColor,
          tristate: false,
        );
      },
    );
  }
}
