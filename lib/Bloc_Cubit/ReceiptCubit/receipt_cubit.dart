import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ItemListCubit/item_list_cubit.dart';
import 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  ItemListCubit? _itemListCubit;

  ReceiptCubit(this._firestore, this._auth) : super(const ReceiptState(isLoading: true));

  // Method to set the ItemListCubit reference
  void setItemListCubit(ItemListCubit cubit) {
    _itemListCubit = cubit;
  }

  Future<void> loadBoughtItems() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'User not authenticated'));
        return;
      }

      final itemsSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .where('isBought', isEqualTo: true)
          .get();

      List<Map<String, dynamic>> boughtItems = [];
      double totalPrice = 0.0;

      for (var doc in itemsSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;

        // Get the unit price
        double unitPrice = data['unitPrice'] is double
            ? data['unitPrice']
            : double.tryParse(data['unitPrice']?.toString() ?? '0.0') ?? 0.0;

        // Get the quantity
        int quantity = data['quantity'] is int
            ? data['quantity']
            : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0;

        // Calculate the item's total price
        double itemTotalPrice = unitPrice * quantity;
        data['totalPrice'] = itemTotalPrice;

        // Add to running total
        totalPrice += itemTotalPrice;

        boughtItems.add(data);
      }

      emit(state.copyWith(
        isLoading: false,
        items: boughtItems,
        totalPrice: totalPrice,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> saveReceiptAndClear() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'User not authenticated'));
        return;
      }

      // Save receipt to Firebase
      final receiptRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('receipts')
          .doc();

      await receiptRef.set({
        'items': state.items,
        'totalPrice': state.totalPrice,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Save items to savedItems collection
      for (var item in state.items) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('savedItems')
            .doc(item['id'])
            .set({
          ...item,
          'savedAt': FieldValue.serverTimestamp(),
        });
      }

      // Instead of directly deleting items, store their IDs temporarily
      List<String> itemIdsToDelete = state.items.map<String>((item) => item['id'] as String).toList();

      // Delete items from the list without triggering the undo functionality
      for (var itemId in itemIdsToDelete) {
        // Use a special flag when deleting items via receipt to avoid undo functionality
        if (_itemListCubit != null) {
          await _itemListCubit!.deleteItemWithoutUndo(itemId);
        } else {
          // Fallback direct deletion if ItemListCubit isn't available
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('items')
              .doc(itemId)
              .delete();
        }
      }

      emit(state.copyWith(isLoading: false, items: [], totalPrice: 0.0));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}