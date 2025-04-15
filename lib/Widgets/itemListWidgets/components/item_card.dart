import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../../Bloc_Cubit/BoughtItemCubit/bought_item_cubit.dart';
import '../../../Data/data_items.dart';
import '../../../Screens/list_detailed_screen.dart';
import '../bought_item_button_widget.dart';
import '../icon_selector_button.dart';
import 'quantity_controller.dart';

class ItemCard extends StatelessWidget {
  final String documentId;
  final String nameItem;
  final String iconItem;
  final String descriptionItem;
  final int quantity;
  final ThemeData theme;

  const ItemCard({
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

    return Card(
      color: theme.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: IconSelectorButton(
          currentIconName: iconItem,
          documentId: documentId,
        ),
        title: Text(
          nameItem,
          style: TextStyle(
            color: theme.textTheme.labelLarge?.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          descriptionItem,
          style: TextStyle(
            color: theme.textTheme.labelLarge?.color,
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuantityController(
              quantity: quantity,
              documentId: documentId,
              theme: theme,
              itemListCubit: itemListCubit,
            ),
            BlocProvider(
              create: (_) => BoughtItemCubit(),
              child: BoughtItemButtonWidget(),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListDetailed(
                item: Item(
                  id: documentId,
                  nameItem: nameItem,
                  iconItem: iconItem,
                  descriptionItem: descriptionItem,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
