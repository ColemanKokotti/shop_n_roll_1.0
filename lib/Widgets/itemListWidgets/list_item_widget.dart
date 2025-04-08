import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../Bloc_Cubit/ItemListCubit/item_list_state.dart';
import '../../FireBase/item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/account_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/item_list_content.dart';
import 'undo_button_widget.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ItemFirebaseStorage itemFirebaseStorage = ItemFirebaseStorage();
    final AuthService authService = AuthService(FirebaseAuth.instance);
    final AccountService accountService = AccountService();

    return BlocProvider(
      create: (context) => ItemListCubit(itemFirebaseStorage, authService, accountService),
      child: BlocBuilder<ItemListCubit, ItemListState>(
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: _getUserItems(authService),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  ItemListContent(
                    snapshot: snapshot,
                    theme: theme,
                  ),
                  UndoButtonWidget(),
                ],
              );
            },
          );
        },
      ),
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