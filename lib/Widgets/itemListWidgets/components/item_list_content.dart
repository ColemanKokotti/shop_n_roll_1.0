import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dismissible_item.dart';

class ItemListContent extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final ThemeData theme;

  const ItemListContent({
    super.key,
    required this.snapshot,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return Center(child: Text('Error loading data'.tr()));
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text('No items found'.tr()));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot document = snapshot.data!.docs[index];
        Map data = document.data() as Map;
        String documentId = document.id;
        String nameItem = data['nameItem'] ?? 'Name not available'.tr();
        String iconItem = data['iconItem'] ?? 'error';
        String descriptionItem = data['descriptionItem'] ?? 'No description'.tr();
        int quantity = (data['quantity'] ?? 0) is int
            ? (data['quantity'] ?? 0)
            : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0;

        return DismissibleItem(
          documentId: documentId,
          nameItem: nameItem,
          iconItem: iconItem,
          descriptionItem: descriptionItem,
          quantity: quantity,
          theme: theme,
        );
      },
    );
  }
}
