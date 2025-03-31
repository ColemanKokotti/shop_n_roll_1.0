import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_state.dart';
import '../../FireBase/create_item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';

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
          onPressed: () {
            // Validate that all fields are filled
            if (_validateFields(context)) {
              _addItem(context);
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

  bool _validateFields(BuildContext context) {
    // Check if name, description, and icon are not empty
    if (cubit.nameController.text.trim().isEmpty ||
        cubit.descriptionController.text.trim().isEmpty ||
        state.selectedIcon.isEmpty) {
      showErrorDialog(context);
      return false;
    }
    return true;
  }

  Future<void> _addItem(BuildContext context) async {
    final CreateItemService itemService = CreateItemService(
        AuthService(FirebaseAuth.instance)
    );
    bool success = await itemService.addItemToUser(state);
    if (success) {
      cubit.reset();
      Navigator.of(context).pop();
    } else {
      showErrorDialog(context);
    }
  }

  void showErrorDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
          title: Center(
            child: Text(
              'Attention'.tr(),
              style: TextStyle(
                color: theme.appBarTheme.foregroundColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'All fields must be filled in to create the item.'.tr(),
              style: TextStyle(
                color: theme.appBarTheme.foregroundColor,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );

    // Automatically close the dialog after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }
}