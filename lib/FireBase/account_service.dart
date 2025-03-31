import 'package:cloud_firestore/cloud_firestore.dart';


class AccountService {
  final CollectionReference _accountsCollection = FirebaseFirestore.instance.collection('Accounts');


  Future<void> addItemToAccount(String userId, String itemId) async {
    try {
      await _accountsCollection.doc(userId).update({
        'itemIds': FieldValue.arrayUnion([itemId]),
      });
    } catch (e) {
      print('Errore nell\'aggiungere l\'ID all\'account: $e');
    }
  }

  Future<void> removeItemFromAccount(String userId, String itemId) async {
    try {
      await _accountsCollection.doc(userId).update({
        'itemIds': FieldValue.arrayRemove([itemId]),
      });
    } catch (e) {
      print('Errore nella rimozione dell\'ID dall\'account: $e');
    }
  }

  Future<List<String>> getItemIdsFromAccount(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();
      if (doc.exists && doc.data() != null) {
        List<dynamic> itemIdsDynamic = doc.get('itemIds') ?? [];
        return itemIdsDynamic.map((item) => item.toString()).toList();
      }
      return [];
    } catch (e) {
      print('Errore nel recupero degli ID dall\'account: $e');
      return [];
    }
  }
  Future<void> createUserAccount(String userId, {String? preferredLanguage, String? preferredTheme}) async {
    try {
      await _accountsCollection.doc(userId).set({
        'itemIds': [],
        'preferredLanguage': preferredLanguage,
        'theme': preferredTheme,
      });
    } catch (e) {
      print('Errore nella creazione dell\'account: $e');
    }
  }
}
