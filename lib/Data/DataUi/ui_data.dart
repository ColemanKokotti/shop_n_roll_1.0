import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UIControllerData {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');


  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }

}

class UIValidation {
  static Future<bool> validateFields(BuildContext context, {
    required String name,
    required String description,
    required String icon,
    required ThemeData theme,
  }) async {
    if (name.isEmpty || description.isEmpty || icon.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            backgroundColor: theme.appBarTheme.backgroundColor,
            title: Text(
              "Warning".tr(),
              style: theme.textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            content: Text(
                "All fields must be filled in to create the item.".tr(),
              style: TextStyle(color: theme.textTheme.labelLarge?.backgroundColor),
            ),
          );
        },
      );
      return false;
    }
    return true;
  }
}
