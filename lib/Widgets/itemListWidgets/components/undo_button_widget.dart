import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_cubit.dart';
import '../../../Bloc_Cubit/ItemListCubit/item_list_state.dart';

class UndoButtonWidget extends StatefulWidget {
  const UndoButtonWidget({super.key});

  @override
  State<UndoButtonWidget> createState() => _UndoButtonWidgetState();
}

class _UndoButtonWidgetState extends State<UndoButtonWidget> {
  bool _isVisible = false;
  Timer? _localTimer;

  @override
  void dispose() {
    _localTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ItemListCubit, ItemListState>(
      listenWhen: (previous, current) {
        // Listen for any changes to deletedItem or isItemRestored
        return previous.deletedItem != current.deletedItem ||
            previous.isItemRestored != current.isItemRestored;
      },
      listener: (context, state) {
        debugPrint("UndoButton listener - deletedItem: ${state.deletedItem != null ? 'present' : 'null'}, restored: ${state.isItemRestored}");

        // Cancel any existing timer
        _localTimer?.cancel();

        // Set visibility based on state
        if (state.deletedItem != null && !state.isItemRestored) {
          // Show the button
          setState(() {
            _isVisible = true;
          });

          // Start our OWN timer for 6 seconds
          _localTimer = Timer(const Duration(seconds: 6), () {
            debugPrint("Local timer completed - hiding undo button");
            setState(() {
              _isVisible = false;
            });

            // Also force update the cubit state to ensure consistency
            context.read<ItemListCubit>().forceHideUndoButton();
          });

        } else {
          // Hide the button
          setState(() {
            _isVisible = false;
          });
        }
      },
      child: _isVisible ? _buildUndoButton(theme, context) : const SizedBox.shrink(),
    );
  }

  Widget _buildUndoButton(ThemeData theme, BuildContext context) {
    return Positioned(
      bottom: 160,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(30),
          color: theme.primaryColor,
          child: InkWell(
            onTap: () {
              _localTimer?.cancel();
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
  }
}