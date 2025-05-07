import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../main.dart';
import '../../FireBase/item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/account_service.dart';
import 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemListState> {
  final ItemFirebaseStorage _itemFirebaseStorage;
  final AuthService _authService;
  final AccountService _accountService;

  ItemListCubit(this._itemFirebaseStorage, this._authService, this._accountService) : super(ItemListState());

  Timer? _autoClearTimer;

  Future<void> deleteItem(String documentId) async {
    try {
      final itemData = await _itemFirebaseStorage.getItem(documentId);

      if (itemData != null) {
        await _itemFirebaseStorage.deleteItem(documentId);

        // First clear any existing state
        emit(ItemListState(itemQuantities: state.itemQuantities));

        // Then set the new deleted item
        emit(ItemListState(
          itemQuantities: state.itemQuantities,
          deletedItem: itemData,
          deletedItemId: documentId,
          isItemRestored: false,
        ));

        if (_authService.getCurrentUser() != null) {
          await _accountService.removeItemFromAccount(_authService.getCurrentUser()!.uid, documentId);
        }

        // Clear the deleted item after 6 seconds if not undone
        _autoClearTimer?.cancel();
        _autoClearTimer = Timer(const Duration(seconds: 6), () {
          if (state.deletedItemId == documentId) {  // Only clear if it's the same item
            emit(state.clearDeletedItem());
            // Trigger soft reload to refresh the UI
            WidgetsBinding.instance.addPostFrameCallback((_) {
              softReload();
            });
          }
        });
      }
    } catch (e) {
      print("Errore durante la cancellazione dell'elemento: $e");
      emit(state.setError("Errore durante la cancellazione: ${e.toString()}"));
    }
  }

<<<<<<< Updated upstream
=======
  // New method to delete items without activating the undo functionality
  // This will be used by the Receipt screen when saving and clearing
  Future<void> deleteItemWithoutUndo(String documentId) async {
    try {
      await _itemFirebaseStorage.deleteItem(documentId);

      if (_authService.getCurrentUser() != null) {
        await _accountService.removeItemFromAccount(_authService.getCurrentUser()!.uid, documentId);
      }

      // Important: we don't update the state with the deleted item
      // This prevents the undo button from appearing
    } catch (e) {
      print("Errore durante la cancellazione permanente dell'elemento: $e");
      emit(state.setError("Errore durante la cancellazione: ${e.toString()}"));
    }
  }

>>>>>>> Stashed changes
  @override
  Future<void> close() {
    _autoClearTimer?.cancel();
    return super.close();
  }

  Future<void> undoDelete() async {
    if (state.deletedItem != null && state.deletedItemId != null) {
      try {
        bool success = await _itemFirebaseStorage.undoDelete(state.deletedItemId!, state.deletedItem!);
        if (success) {
          _autoClearTimer?.cancel();
          emit(state.clearDeletedItem());
          if (_authService.getCurrentUser() != null) {
            await _accountService.addItemToAccount(_authService.getCurrentUser()!.uid, state.deletedItemId!);
          }
          // Trigger soft reload to refresh the UI
          WidgetsBinding.instance.addPostFrameCallback((_) {
            softReload();
          });
        }
      } catch (e) {
        print("Errore durante il ripristino dell'elemento: $e");
        emit(state.setError("Errore durante il ripristino: ${e.toString()}"));
      }
    }
  }

  Future<void> updateQuantity(String documentId, int newQuantity) async {
    try {
      if (newQuantity >= 0) {
        bool success = await _itemFirebaseStorage.updateQuantity(documentId, newQuantity);
        if (success) {
          emit(state.updateQuantity(documentId, newQuantity));
        }
      }
    } catch (e) {
      print("Errore durante l'aggiornamento della quantità: $e");
      emit(state.setError("Errore durante l'aggiornamento: ${e.toString()}"));
<<<<<<< Updated upstream
=======
    }
  }

  Future<Map<String, dynamic>?> getItemData(String itemId) async {
    try {
      return await _itemFirebaseStorage.getItem(itemId);
    } catch (e) {
      print("Errore durante il recupero dei dati dell'item: $e");
      return null;
>>>>>>> Stashed changes
    }
  }

  Future<Map<String, dynamic>?> getItemData(String itemId) async {
    try {
      return await _itemFirebaseStorage.getItem(itemId);
    } catch (e) {
      print("Errore durante il recupero dei dati dell'item: $e");
      return null;
    }
  }
}
