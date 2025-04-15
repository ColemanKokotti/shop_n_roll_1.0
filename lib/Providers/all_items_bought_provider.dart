import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllItemsBoughtProvider {
  static Stream<bool> allItemsBoughtStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(false);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return false; // No items, so we can't proceed to receipt
      }

      // Check if all items are marked as bought
      bool allBought = snapshot.docs.every((doc) {
        Map<String, dynamic> data = doc.data();
        return data['isBought'] == true;
      });

      return allBought;
    });
  }
}
