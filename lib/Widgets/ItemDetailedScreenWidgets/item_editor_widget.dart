import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';
import '../../Data/data_items.dart';
import 'item_editor_fields.dart';

class ItemEditorWidget extends StatelessWidget {
  final Item item;

  const ItemEditorWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: theme.primaryColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Item',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.labelLarge?.color,
                ),
              ),
              IconField(initialValue: item.iconItem, documentId: item.id,),
              const SizedBox(height: 20),
              NameField(initialValue: item.nameItem),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PriceField(initialValue: item.price),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: QuantityField(initialValue: item.quantity),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const SizedBox(height: 15),
              DescriptionField(initialValue: item.descriptionItem),
              const SizedBox(height: 25),
              _buildActionButtons(context, theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ThemeData theme) {
    final cubit = context.read<ItemDetailCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
        icon: Icon(Icons.save, size: 20,color: theme.appBarTheme.iconTheme?.color,),
        label: const Text('Save'),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: theme.textTheme.bodyLarge?.color,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        onPressed: () {
          cubit.saveEditing();
        },
      ),
        const SizedBox(width: 15),

        ElevatedButton.icon(
          icon: Icon(Icons.cancel, size: 20, color: theme.appBarTheme.iconTheme?.color,),
          label: const Text('Cancel'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.buttonTheme.colorScheme?.error,
            foregroundColor: theme.textTheme.bodyLarge?.color,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          onPressed: () {
            cubit.cancelEditing();
          },
        ),
      ],
    );
  }
}