import 'package:flutter_bloc/flutter_bloc.dart';
import '../../FireBase/item_firebase_storage.dart';
import 'item_detailed_state.dart';



class ItemDetailCubit extends Cubit<ItemDetailState> {
  final ItemFirebaseStorage _itemFirebaseStorage;

  ItemDetailCubit(this._itemFirebaseStorage) : super(const ItemDetailState(isLoading: true));

  Future<void> loadItemDetails(String itemId) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final itemData = await _itemFirebaseStorage.getItem(itemId);

      if (itemData != null) {
        emit(state.copyWith(isLoading: false, itemData: itemData));
      } else {
        emit(state.copyWith(isLoading: false, error: 'Item not found'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  double getUnitPrice() {
    final unitPrice = state.itemData?['unitPrice'] ?? 0.0;
    return unitPrice is double
        ? unitPrice
        : double.tryParse(unitPrice.toString()) ?? 0.0;
  }

  int getQuantity() {
    final quantity = state.itemData?['quantity'] ?? 0;
    return quantity is int
        ? quantity
        : int.tryParse(quantity.toString()) ?? 0;
  }

  double getTotalPrice() {
    return getUnitPrice() * getQuantity();
  }
}