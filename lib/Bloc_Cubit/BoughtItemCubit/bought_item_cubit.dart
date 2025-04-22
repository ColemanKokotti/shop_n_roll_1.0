import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/item_firebase_storage.dart';

class BoughtItemCubit extends Cubit<bool> {
  final String itemId;
  final ItemFirebaseStorage _itemFirebaseStorage;
  
  BoughtItemCubit(this._itemFirebaseStorage, this.itemId, {bool initialState = false}) 
      : super(initialState);

  Future<void> toggleItemStatus() async {
    try {
      final newState = !state;
      print('Current state: $state, new state: $newState');
      
      // Update the bought status in Firestore
      await _itemFirebaseStorage.updateBoughtStatus(itemId, newState);
      
      // Emit the new state only after successful update
      emit(newState);
    } catch (e) {
      print('Error updating bought status for item $itemId: $e');
      // If update fails, keep the previous state
      emit(state);
    }
  }
}