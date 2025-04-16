import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'receipt_history_state.dart';

class ReceiptHistoryCubit extends Cubit<ReceiptHistoryState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ReceiptHistoryCubit(this._firestore, this._auth) : super(const ReceiptHistoryState(isLoading: true));

  Future<void> loadReceiptHistory() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'User not authenticated'));
        return;
      }

      final receiptsSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('receipts')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> receipts = [];
      for (var doc in receiptsSnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        receipts.add(data);
      }

      emit(state.copyWith(
        isLoading: false,
        receipts: receipts,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> deleteReceipt(String receiptId) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(isLoading: false, error: 'User not authenticated'));
        return;
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('receipts')
          .doc(receiptId)
          .delete();

      await loadReceiptHistory();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
