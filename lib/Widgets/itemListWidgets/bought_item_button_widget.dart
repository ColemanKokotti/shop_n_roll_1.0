import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/BoughtItemCubit/bought_item_cubit.dart';



class BoughtItemButtonWidget extends StatelessWidget {
  const BoughtItemButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    return BlocBuilder<BoughtItemCubit, bool>(
      builder: (context, isBought) {
        return IconButton(
          icon: Icon(
            isBought ? Icons.check_circle: Icons.add_circle_outlined ,
            color: isBought ? theme.iconTheme.color : theme.iconTheme.color,
          ),
          onPressed: () => context.read<BoughtItemCubit>().toggleItemStatus(),
        );
      },
    );
  }
}
