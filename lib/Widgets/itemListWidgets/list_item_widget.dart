import 'package:flutter/material.dart';
import 'components/item_list_stream.dart';
import '../../FireBase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(FirebaseAuth.instance);

    return Stack(
      children: [
        ItemListStream(authService: authService),
      ],
    );
  }
}