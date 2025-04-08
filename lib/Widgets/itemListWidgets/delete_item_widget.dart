import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';


Future<bool> showDeleteConfirmationDialog(BuildContext context, String itemId,ItemListCubit itemListCubit) async {
  final theme = Theme.of(context);

  bool confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.dialogTheme.backgroundColor,
          title: Text(
            'Confirm deletion'.tr(), 
            textAlign: TextAlign.center,
            style: theme.dialogTheme.titleTextStyle,
          ),
          content: Text(
            'Are you sure you want to delete this item?'.tr(), 
            style: theme.dialogTheme.contentTextStyle,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: theme.textButtonTheme.style,
                  child: Text('Cancel'.tr()),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    await itemListCubit.deleteItem(itemId);
                    Navigator.of(context).pop(true);
                  },
                  style: theme.textButtonTheme.style,
                  child: Text('Delete'.tr()),
                ),
              ],
            ),
          ],
        );
      }
  ) ?? false;

  return confirmed;
}
