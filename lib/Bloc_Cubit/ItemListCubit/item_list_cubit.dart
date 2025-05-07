import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../FireBase/item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/account_service.dart';
import 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemListState> {
  final ItemFirebaseStorage _itemFirebaseStorage;
  final AuthService _authService;
  final AccountService _accountService;
  Timer? _undoTimer;

  // Use this flag to track that we explicitly need to hide the undo button
  bool _shouldHideUndoButton = false;

  ItemListCubit(
      this._itemFirebaseStorage,
      this._authService,
      this._accountService,
      ) : super(const ItemListState());

  @override
  Future<void> close() {
    _cancelUndoTimer();
    return super.close();
  }

  void _cancelUndoTimer() {
    if (_undoTimer != null && _undoTimer!.isActive) {
      _undoTimer!.cancel();
      _undoTimer = null;
      debugPrint('Timer cancelled in ItemListCubit');
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      // Cancel any existing timer
      _cancelUndoTimer();

      // Reset the flag
      _shouldHideUndoButton = false;

      // Get the item before deletion to store it
      final itemData = await _itemFirebaseStorage.getItem(itemId);
      if (itemData == null) return;

      // Delete the item
      final success = await _itemFirebaseStorage.deleteItem(itemId);

      if (success) {
        emit(state.copyWith(
          deletedItem: {'id': itemId, 'data': itemData},
          isItemRestored: false,
        ));
        debugPrint('Item deleted, undo button should be visible now');

        // Set timer for 6 seconds
        _undoTimer = Timer(const Duration(seconds: 6), () {
          debugPrint('Timer completed - hiding undo button now');
          _shouldHideUndoButton = true;

          // Clear deleted item reference after timer expires
          emit(state.copyWith(
            deletedItem: null,
            isItemRestored: false,
          ));

          // Extra check - emit again after a short delay if needed
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_shouldHideUndoButton && state.deletedItem != null) {
              debugPrint('Forced update to hide undo button');
              emit(state.copyWith(
                deletedItem: null,
                isItemRestored: false,
              ));
            }
          });
        });
      }
    } catch (e) {
      debugPrint('Error deleting item: $e');
    }
  }

  Future<void> undoDelete() async {
    try {
      if (state.deletedItem != null) {
        // Cancel the timer
        _cancelUndoTimer();
        _shouldHideUndoButton = false;

        final String itemId = state.deletedItem!['id'];
        final Map<String, dynamic> itemData = Map<String, dynamic>.from(state.deletedItem!['data']);

        // Remove the id from the data as it's used as the document ID
        if (itemData.containsKey('id')) {
          itemData.remove('id');
        }

        final success = await _itemFirebaseStorage.undoDelete(itemId, itemData);

        if (success) {
          debugPrint('Item restored, hiding undo button');
          emit(state.copyWith(
            isItemRestored: true,
            deletedItem: null,
          ));
        }
      }
    } catch (e) {
      debugPrint('Error restoring item: $e');
    }
  }

  // This method can be called from a widget to force hide the undo button
  void forceHideUndoButton() {
    if (state.deletedItem != null) {
      debugPrint('Forcing hide of undo button');
      _cancelUndoTimer();
      emit(state.copyWith(
        deletedItem: null,
        isItemRestored: false,
      ));
    }
  }
}