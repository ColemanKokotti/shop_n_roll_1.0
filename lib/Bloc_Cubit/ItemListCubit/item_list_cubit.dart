import 'package:bloc/bloc.dart';
import '../../FireBase/item_firebase_storage.dart';
import '../../FireBase/auth_service.dart';
import '../../FireBase/account_service.dart';
import 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemListState> {
  final ItemFirebaseStorage _itemFirebaseStorage;
  final AuthService _authService;
  final AccountService _accountService;

  ItemListCubit(this._itemFirebaseStorage, this._authService, this._accountService) : super(ItemListState());

  Future<void> deleteItem(String documentId) async {
    try {
      final itemData = await _itemFirebaseStorage.getItem(documentId);

      if (itemData != null) {
        await _itemFirebaseStorage.deleteItem(documentId);

        emit(state.copyWith(
          deletedItem: itemData,
          deletedItemId: documentId,
          showUndoButton: true,
        ));

        if (_authService.getCurrentUser() != null) {
          await _accountService.removeItemFromAccount(_authService.getCurrentUser()!.uid, documentId);
        }
      }
    } catch (e) {
      print("Errore durante la cancellazione dell'elemento: $e");
      emit(state.setError("Errore durante la cancellazione: ${e.toString()}"));
    }
  }

  Future<void> undoDelete() async {
    if (state.deletedItem != null && state.deletedItemId != null) {
      try {
        bool success = await _itemFirebaseStorage.undoDelete(state.deletedItemId!, state.deletedItem!);
        if (success) {
          emit(state.clearDeletedItem().copyWith(showUndoButton: false));
          if (_authService.getCurrentUser() != null) {
            await _accountService.addItemToAccount(_authService.getCurrentUser()!.uid, state.deletedItemId!);
          }
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
    }
  }
}
