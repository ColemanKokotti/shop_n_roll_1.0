import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_state.dart';
class UndoButtonWidget extends StatelessWidget {
  const UndoButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ItemListCubit, ItemListState>(
      builder: (context, state) {
        if (state.deletedItem == null || state.isItemRestored) {
          return const SizedBox.shrink();
        }
        return Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Center(
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(30),
              color: theme.primaryColor,
              child: InkWell(
                onTap: () {
                  context.read<ItemListCubit>().undoDelete();
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.undo,
                        size: 24,
                        color: theme.appBarTheme.iconTheme?.color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Undo'.tr(),
                        style: TextStyle(
                          color: theme.appBarTheme.foregroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}