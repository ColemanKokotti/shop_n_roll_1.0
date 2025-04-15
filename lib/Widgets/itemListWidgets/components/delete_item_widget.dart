import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';


Future<bool> showDeleteConfirmationDialog(BuildContext context, String itemId,ItemListCubit itemListCubit) async {
  final theme = Theme.of(context);

  bool confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.appBarTheme.backgroundColor,
          title: Text('Confirm deletion'.tr(), textAlign: TextAlign.center),
          titleTextStyle: TextStyle(color:  theme.appBarTheme.foregroundColor, fontSize: 30),
          content: Text('Are you sure you want to delete this item?'.tr(), style: TextStyle(color: theme.appBarTheme.foregroundColor)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(backgroundColor:   theme.appBarTheme.iconTheme?.color),
                  child: Text('Cancel'.tr(), style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 15)),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    await itemListCubit.deleteItem(itemId);
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(backgroundColor:  theme.appBarTheme.iconTheme?.color),
                  child: Text('Delete'.tr(), style: TextStyle(color:  theme.textTheme.bodyLarge?.color, fontSize: 15)),
                ),
              ],
            ),
          ],
        );
      }
  ) ?? false;

  return confirmed;
}
