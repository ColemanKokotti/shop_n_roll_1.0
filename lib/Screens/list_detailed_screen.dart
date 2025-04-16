import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';
import '../Bloc_Cubit/ItemDetailedCubit/item_detailed_state.dart';
import '../Data/data_items.dart';
import '../FireBase/item_firebase_storage.dart';
import '../Widgets/ItemDetailedScreenWidgets/item_description_card.dart';
import '../Widgets/ItemDetailedScreenWidgets/item_editor_widget.dart';
import '../Widgets/ItemDetailedScreenWidgets/item_header_card.dart';
import '../Widgets/ItemDetailedScreenWidgets/item_price_card.dart';

class ListDetailed extends StatelessWidget {
  final Item item;

  const ListDetailed({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) {
        final cubit = ItemDetailCubit(ItemFirebaseStorage());
        cubit.loadItemDetails(item.id);
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: _buildAppBar(context, theme),
            body: BlocBuilder<ItemDetailCubit, ItemDetailState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(
                    child: Text(
                      'Error loading item details'.tr(),
                      style: TextStyle(color: theme.textTheme.labelLarge?.color),
                    ),
                  );
                }

                return _buildContent(context, state);
              },
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, ThemeData theme) {
    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      centerTitle: true,
      title: BlocBuilder<ItemDetailCubit, ItemDetailState>(
        builder: (context, state) {
          final itemName = state.isEditing
              ? (state.editingItem?.nameItem ?? item.nameItem)
              : (state.itemData?['nameItem'] ?? item.nameItem);

          return Text(
              state.isEditing ? 'Edit $itemName' : itemName,
              style: TextStyle(
                color: theme.appBarTheme.titleTextStyle?.color,
                fontWeight: FontWeight.bold,
              )
          );
        },
      ),
      iconTheme: IconThemeData(color: theme.appBarTheme.foregroundColor),
      actions: [
        BlocBuilder<ItemDetailCubit, ItemDetailState>(
          builder: (context, state) {
            if (!state.isEditing) {
              return IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit Item'.tr(),
                onPressed: () {
                  context.read<ItemDetailCubit>().startEditing();
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ItemDetailState state) {
    final cubit = context.read<ItemDetailCubit>();
    final unitPrice = cubit.getUnitPrice();
    final quantity = cubit.getQuantity();
    final totalPrice = cubit.getTotalPrice();

    // Use the data from state if available, or fall back to the passed item
    final itemData = state.itemData;
    final displayItem = Item(
      id: item.id,
      nameItem: itemData?['nameItem'] ?? item.nameItem,
      iconItem: itemData?['iconItem'] ?? item.iconItem,
      descriptionItem: itemData?['descriptionItem'] ?? item.descriptionItem,
      price: unitPrice,
      quantity: quantity,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state.isEditing)
              ItemEditorWidget(
                item: state.editingItem ?? displayItem,
              )
            else
              Column(
                children: [
                  ItemHeaderCard(
                    itemName: displayItem.nameItem,
                    iconItem: displayItem.iconItem,
                  ),
                  const SizedBox(height: 25),
                  ItemPriceCard(
                    unitPrice: unitPrice,
                    quantity: quantity,
                    totalPrice: totalPrice,
                  ),
                  const SizedBox(height: 25),
                  ItemDescriptionCard(
                    description: displayItem.descriptionItem,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}