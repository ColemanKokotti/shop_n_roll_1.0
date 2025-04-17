import 'dart:async';
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

  ItemListCubit(
      this._itemFirebaseStorage,
      this._authService,
      this._accountService,
      ) : super(const ItemListState());

  @override
  Future<void> close() {
    _undoTimer?.cancel();
    return super.close();
  }

  Future<void> deleteItem(String itemId) async {
    try {
      // Cancel any existing timer
      _undoTimer?.cancel();

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

        // Set timer for 6 seconds
        _undoTimer = Timer(const Duration(seconds: 6), () {
          // Clear deleted item reference after timer expires
          emit(state.copyWith(
            deletedItem: null,
            isItemRestored: false,
          ));
        });
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> undoDelete() async {
    try {
      if (state.deletedItem != null) {
        _undoTimer?.cancel();

        final String itemId = state.deletedItem!['id'];
        final Map<String, dynamic> itemData = Map<String, dynamic>.from(state.deletedItem!['data']);

        // Remove the id from the data as it's used as the document ID
        if (itemData.containsKey('id')) {
          itemData.remove('id');
        }

        final success = await _itemFirebaseStorage.undoDelete(itemId, itemData);

        if (success) {
          emit(state.copyWith(
            isItemRestored: true,
            deletedItem: null,
          ));
        }
      }
    } catch (e) {
      print('Error restoring item: $e');
    }
  }
}