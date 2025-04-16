import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Data/data_items.dart';
import '../../../Data/item_firebase_storage.dart';
import '../../../Screens/list_detailed_screen.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../../Bloc_Cubit/BoughtItemCubit/bought_item_cubit.dart';
import 'icon_selector_button.dart';
import 'delete_item_widget.dart';
import 'quantity_control.dart';
import 'bought_item_button_widget.dart';

class ItemCard extends StatelessWidget {
  final DocumentSnapshot document;
  final Map data;

  const ItemCard({
    super.key,
    required this.document,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemListCubit = context.read<ItemListCubit>();

    String documentId = document.id;
    String nameItem = data['nameItem'] ?? 'Name not available';
    String iconItem = data['iconItem'] ?? 'error';
    String descriptionItem = data['descriptionItem'] ?? 'Description not available';
    double unitPrice = (data['unitPrice'] ?? 0.0) is double
        ? (data['unitPrice'] ?? 0.0)
        : double.tryParse(data['unitPrice']?.toString() ?? '0.0') ?? 0.0;
    int quantity = (data['quantity'] ?? 0) is int
        ? (data['quantity'] ?? 0)
        : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0;
    double totalPrice = (unitPrice * quantity).toDouble();

    Item item = Item(
      id: documentId,
      nameItem: nameItem,
      iconItem: iconItem,
      descriptionItem: descriptionItem,
    );

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
          // Handled by the confirmDismiss callback
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            elevation: 8,
            shadowColor: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: theme.primaryColor, width: 2),
            ),
            color: theme.cardColor,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              leading: IconSelectorButton(
                currentIconName: iconItem,
                documentId: documentId,
              ),
              title: Text(
                nameItem,
                style: TextStyle(
                  color: theme.textTheme.labelLarge?.color,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Tot: ${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: theme.textTheme.labelLarge?.color,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QuantityControl(
                    documentId: documentId,
                    quantity: quantity,
                  ),
                  BlocProvider(
                    create: (_) {
                      final itemFirebaseStorage = ItemFirebaseStorage(
                        FirebaseFirestore.instance,
                        FirebaseAuth.instance,
                      );
                      return BoughtItemCubit(
                        itemFirebaseStorage,
                        documentId,
                        initialState: data['isBought'] ?? false,
                      );
                    },
                    child: BoughtItemButtonWidget(
                      itemId: documentId,
                      initialIsBought: data['isBought'] ?? false,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDetailed(item: item),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}