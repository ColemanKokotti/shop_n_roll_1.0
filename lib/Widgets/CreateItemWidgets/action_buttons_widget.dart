import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_state.dart';
import '../../UI/CreateItem/create_item_controller_adapter.dart';

class ActionButtonsWidget extends StatelessWidget {
  final CreateItemCubit cubit;
  final CreateItemState state;
  final VoidCallback onPressed;
  final CreateItemControllerAdapter controllerAdapter;

  const ActionButtonsWidget({
    Key? key,
    required this.cubit,
    required this.state,
    required this.onPressed,
    required this.controllerAdapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            controllerAdapter.reset();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'Cancel'.tr(),
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'Add'.tr(),
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
