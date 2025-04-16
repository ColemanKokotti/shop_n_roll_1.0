import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FireBase/auth_service.dart';

class ItemFirebaseStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService(FirebaseAuth.instance);

  Stream<Map<String, dynamic>?> getItemStream(String documentId) {
    final user = _authService.getCurrentUser();
    if (user == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('items')
        .doc(documentId)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['id'] = documentId;
            return data;
          }
          return null;
        })
        .handleError((error) {
          print('Errore nel recupero dell\'elemento: $error');
          return null;
        });
  }

  Future<Map<String, dynamic>?> getItem(String documentId) async {
    try {
      return await getItemStream(documentId).first;
    } catch (e) {
      print('Errore nel recupero dell\'elemento: $e');
      return null;
    }
  }

  Future<bool> deleteItem(String documentId) async {
    try {
      final user = _authService.getCurrentUser();
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(documentId)
          .delete();

      return true;
    } catch (e) {
      print('Errore nella cancellazione dell\'elemento: $e');
      return false;
    }
  }

  Future<bool> undoDelete(String documentId, Map<String, dynamic> itemData) async {
    try {
      final user = _authService.getCurrentUser();
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(documentId)
          .set(itemData);

      return true;
    } catch (e) {
      print('Errore nel ripristino dell\'elemento: $e');
      return false;
    }
  }

  Future<bool> updateQuantity(String documentId, int newQuantity) async {
    try {
      final user = _authService.getCurrentUser();
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(documentId)
          .update({'quantity': newQuantity});

      return true;
    } catch (e) {
      print('Errore nell\'aggiornamento della quantità: $e');
      return false;
    }
  }

  Future<bool> updateItem(String documentId, Map<String, dynamic> updates) async {
    try {
      final user = _authService.getCurrentUser();
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .doc(documentId)
          .update(updates);

      return true;
    } catch (e) {
      print('Errore nell\'aggiornamento dell\'elemento: $e');
      return false;
    }
  }
}
