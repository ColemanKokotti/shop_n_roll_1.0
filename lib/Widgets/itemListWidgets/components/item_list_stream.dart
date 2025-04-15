import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../FireBase/auth_service.dart';
import 'item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemListStream extends StatelessWidget {
  final AuthService authService;

  const ItemListStream({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _getUserItems(authService),
      builder: (context, snapshot) {
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

            return ItemCard(document: document, data: data);
          },
        );
      },
    );
  }
}

Stream<QuerySnapshot> _getUserItems(AuthService authService) {
  User? currentUser = authService.getCurrentUser();
  if (currentUser != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('items')
        .snapshots();
  } else {
    return Stream.empty();
  }
}