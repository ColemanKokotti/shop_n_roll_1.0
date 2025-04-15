import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../delete_item_widget.dart';
import 'item_card.dart';

class DismissibleItem extends StatelessWidget {
  final String documentId;
  final String nameItem;
  final String iconItem;
  final String descriptionItem;
  final int quantity;
  final ThemeData theme;

  const DismissibleItem({
    super.key,
    required this.documentId,
    required this.nameItem,
    required this.iconItem,
    required this.descriptionItem,
    required this.quantity,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final itemListCubit = context.read<ItemListCubit>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(documentId),
        direction: DismissDirection.startToEnd,
        background: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.redAccent,
          child: Icon(
            Icons.delete,
            color: theme.iconTheme.color,
          ),
        ),
        confirmDismiss: (direction) async {
          return await showDeleteConfirmationDialog(context, documentId, itemListCubit);
        },
        onDismissed: (direction) {
          itemListCubit.deleteItem(documentId);
        },
        child: ItemCard(
          documentId: documentId,
          nameItem: nameItem,
          iconItem: iconItem,
          descriptionItem: descriptionItem,
          quantity: quantity,
          theme: theme,
        ),
      ),
    );
  }
}
