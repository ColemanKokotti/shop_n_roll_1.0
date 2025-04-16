import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';
import '../Bloc_Cubit/ItemDetailedCubit/item_detailed_state.dart';
import '../Data/data_items.dart';
import '../FireBase/item_firebase_storage.dart';
import '../Widgets/ItemDetailedScreenWidgets/item_description_card.dart';
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
      create: (context) {
        final cubit = ItemDetailCubit(ItemFirebaseStorage());
        cubit.loadItemDetails(item.id);
        return cubit;
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          centerTitle: true,
          title: Text(
              item.nameItem,
              style: TextStyle(color: theme.appBarTheme.titleTextStyle?.color)
          ),
          iconTheme: IconThemeData(color: theme.appBarTheme.foregroundColor),
        ),
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

            final cubit = context.read<ItemDetailCubit>();
            final unitPrice = cubit.getUnitPrice();
            final quantity = cubit.getQuantity();
            final totalPrice = cubit.getTotalPrice();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon and Name Section
                    ItemHeaderCard(
                      itemName: item.nameItem,
                      iconItem: item.iconItem,
                    ),

                    const SizedBox(height: 25),

                    // Price and Quantity Section
                    ItemPriceCard(
                      unitPrice: unitPrice,
                      quantity: quantity,
                      totalPrice: totalPrice,
                    ),

                    const SizedBox(height: 25),

                    // Description Section
                    ItemDescriptionCard(
                      description: item.descriptionItem,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}