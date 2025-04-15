import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../FireBase/item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/account_service.dart';
import '../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../Bloc_Cubit/ItemListCubit/item_list_state.dart';
import 'components/undo_button_widget.dart';
import 'components/item_list_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemFirebaseStorage itemFirebaseStorage = ItemFirebaseStorage();
    final AuthService authService = AuthService(FirebaseAuth.instance);
    final AccountService accountService = AccountService();

    return BlocProvider(
      create: (context) => ItemListCubit(itemFirebaseStorage, authService, accountService),
      child: BlocBuilder<ItemListCubit, ItemListState>(
        builder: (context, state) {
          return Stack(
            children: [
              ItemListStream(authService: authService),
              UndoButtonWidget(),
            ],
          );
        },
      ),
    );
  }
}