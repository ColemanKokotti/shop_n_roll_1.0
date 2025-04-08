import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/BoughtItemCubit/bought_item_cubit.dart';
import '../../Bloc_Cubit/BoughtItemCubit/bought_item_state.dart';



class BoughtItemButtonWidget extends StatelessWidget {
  const BoughtItemButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocBuilder<BoughtItemCubit, BoughtItemState>(
      builder: (context, state) {
        return Checkbox(
          value: state.isBought,
          onChanged: (bool? value) {
            if (value != null) {
              context.read<BoughtItemCubit>().toggleBoughtStatus();
            }
          },
          activeColor: theme.primaryColor,
          checkColor: theme.iconTheme.color,
        );
      },
    );
  }
}
