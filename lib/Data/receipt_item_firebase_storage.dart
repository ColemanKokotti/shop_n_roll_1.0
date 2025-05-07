import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReceiptItemFirebaseStorage {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ReceiptItemFirebaseStorage(this._firestore, this._auth);

  Future<void> updateBoughtStatus(String itemId, bool isBought) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(itemId)
          .update({
        'isBought': isBought,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating bought status: $e');
      rethrow;
    }
  }

  Future<void> updateItemQuantity(String itemId, int quantity) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(itemId)
          .update({
        'quantity': quantity,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating item quantity: $e');
      rethrow;
    }
  }

  Future<void> updateItemUnitPrice(String itemId, double unitPrice) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(itemId)
          .update({
        'unitPrice': unitPrice,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating item unit price: $e');
      rethrow;
    }
  }
}
