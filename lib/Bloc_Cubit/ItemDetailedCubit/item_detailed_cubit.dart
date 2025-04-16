import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'item_detailed_state.dart';
import '../../Data/data_items.dart';
import '../../FireBase/item_firebase_storage.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  final ItemFirebaseStorage _storage;
  String _itemId = '';

  ItemDetailCubit(this._storage) : super(const ItemDetailState());

  Future<void> loadItemDetails(String itemId) async {
    _itemId = itemId;
    emit(state.copyWith(isLoading: true));
    try {
      final itemData = await _storage.getItem(itemId);
      if (itemData != null) {
        emit(state.copyWith(
          isLoading: false,
          itemData: itemData,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: 'Item not found'.tr(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Error loading item details'.tr(),
      ));
    }
  }

  double getUnitPrice() {
    return state.itemData?['unitPrice']?.toDouble() ?? 0.0;
  }

  int getQuantity() {
    return state.itemData?['quantity']?.toInt() ?? 0;
  }

  double getTotalPrice() {
    return getUnitPrice() * getQuantity();
  }

  void startEditing() {
    final currentItem = Item(
      id: _itemId,
      nameItem: state.itemData?['nameItem'] ?? '',
      iconItem: state.itemData?['iconItem'] ?? '',
      descriptionItem: state.itemData?['descriptionItem'] ?? '',
      price: state.itemData?['unitPrice']?.toDouble() ?? 0.0,
      quantity: state.itemData?['quantity']?.toInt() ?? 0,
    );

    emit(state.copyWith(
      isEditing: true,
      editingItem: currentItem,
    ));
  }

  void cancelEditing() {
    emit(state.copyWith(
      isEditing: false,
      editingItem: null,
    ));
  }

  Future<void> saveEditing() async {
    if (state.editingItem == null) return;

    emit(state.copyWith(isEditing: false));
    await loadItemDetails(_itemId);
  }

  void updateEditingField(String field, dynamic value) async {
    if (state.editingItem == null) return;

    final updatedItem = Item(
      id: state.editingItem!.id,
      nameItem: field == 'nameItem' ? value : state.editingItem!.nameItem,
      iconItem: field == 'iconItem' ? value : state.editingItem!.iconItem,
      descriptionItem: field == 'descriptionItem' ? value : state.editingItem!.descriptionItem,
      price: state.editingItem!.price,
      quantity: state.editingItem!.quantity,
    );

    emit(state.copyWith(
      editingItem: updatedItem,
    ));

    await _storage.updateItem(_itemId, {
      field: value,
    });
  }

  void updateEditingPrice(double price) async {
    if (state.editingItem == null) return;

    final updatedItem = Item(
      id: state.editingItem!.id,
      nameItem: state.editingItem!.nameItem,
      iconItem: state.editingItem!.iconItem,
      descriptionItem: state.editingItem!.descriptionItem,
      price: price,
      quantity: state.editingItem!.quantity,
    );

    emit(state.copyWith(
      editingItem: updatedItem,
    ));

    await _storage.updateItem(_itemId, {
      'unitPrice': price,
    });
  }

  void updateEditingQuantity(int quantity) async {
    if (state.editingItem == null) return;

    final updatedItem = Item(
      id: state.editingItem!.id,
      nameItem: state.editingItem!.nameItem,
      iconItem: state.editingItem!.iconItem,
      descriptionItem: state.editingItem!.descriptionItem,
      price: state.editingItem!.price,
      quantity: quantity,
    );

    emit(state.copyWith(
      editingItem: updatedItem,
    ));

    await _storage.updateItem(_itemId, {
      'quantity': quantity,
    });
  }
}