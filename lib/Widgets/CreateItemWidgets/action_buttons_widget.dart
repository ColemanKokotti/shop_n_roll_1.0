import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_state.dart';
import '../../FireBase/create_item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../Data/DataUi/ui_data.dart';


class ActionButtonsWidget extends StatelessWidget {
  final CreateItemCubit cubit;
  final CreateItemState state;

  const ActionButtonsWidget({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            // Validate that all fields are filled
            if (await _validateFields(context)) {
              await _addItem(context);
            }
          },
          child: Text(
            'Add'.tr(),
            style: TextStyle(color: theme.appBarTheme.foregroundColor, fontSize: 15),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel'.tr(),
            style: TextStyle(color: theme.appBarTheme.foregroundColor, fontSize: 15),
          ),
        ),
      ],
    );
  }

  Future<bool> _validateFields(BuildContext context) async {
    final theme = Theme.of(context);
    return await UIValidation.validateFields(
      context,
      name: cubit.nameController.text.trim(),
      description: cubit.descriptionController.text.trim(),
      icon: state.selectedIcon,
      theme: theme,
    );
  }

  Future<void> _addItem(BuildContext context) async {
    final CreateItemFirebase itemService = CreateItemFirebase(
        AuthService(FirebaseAuth.instance)
    );
    bool success = await itemService.addItemToUser(state);
    if (success) {
      cubit.reset();
      Navigator.of(context).pop();
    } else {
      await UIValidation.validateFields(
        context,
        name: '',
        description: '',
        icon: '',
        theme: Theme.of(context),
      );
    }
  }
}
