import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Bloc_Cubit/AuthCubit/auth_cubit.dart';
import '../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../Widgets/CreateItemWidgets/create_item_button.dart';
import '../Widgets/itemListWidgets/components/undo_button_widget.dart';
import 'settings_screen.dart';
import '../Widgets/itemListWidgets/list_item_widget.dart';
import '../Widgets/TotalPriceBottomBarWidgets/total_price_bottom_bar.dart';
import '../FireBase/auth_service.dart';
import '../FireBase/account_service.dart';
import '../FireBase/item_firebase_storage.dart';
import '../Bloc_Cubit/ItemListCubit/item_list_state.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CreateItemCubit()),
        BlocProvider(create: (context) => ItemListCubit(
          ItemFirebaseStorage(),
          AuthService(FirebaseAuth.instance),
          AccountService(),
        )),
        BlocProvider.value(value: context.read<AuthCubit>()),
      ],
      child: BlocListener<ItemListCubit, ItemListState>(
        listener: (context, state) {
          // Optional: Add listener logic for item deletion events
          if (state.deletedItem != null && !state.isItemRestored) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item deleted. You can undo this action.'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            centerTitle: true,
            title: Text('Shop n Roll 🎸', style: TextStyle(color: theme.appBarTheme.titleTextStyle?.color)),
            actions: [
              IconButton(
                icon: Icon(
                    Icons.settings,
                    color: theme.appBarTheme.iconTheme?.color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ItemListWidget(),
                    ),
                    const TotalPriceBottomBar(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 100,
                  child: Center(
                    child: CreateItemButton(),
                  ),
                ),
                UndoButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}