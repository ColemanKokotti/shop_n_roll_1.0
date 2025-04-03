import 'package:cloud_firestore/cloud_firestore.dart';

class LanguagePreferenceService {
  final CollectionReference _accountsCollection =
  FirebaseFirestore.instance.collection('Accounts');

  Future<void> saveLanguagePreference(String userId, String languageCode) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();

      if (doc.exists) {
        await _accountsCollection.doc(userId).update({
          'preferredLanguage': languageCode,
        });
      } else {
        await _accountsCollection.doc(userId).set({
          'itemIds': [],
          'preferredLanguage': languageCode,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      print('Lingua salvata con successo: $languageCode');
    } catch (e) {
      print('Error saving language preference: $e');
    }
  }

  // Retrieve user's language preference
  Future<String?> getLanguagePreference(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();

      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['preferredLanguage'] as String?;
      }

      return null;
    } catch (e) {
      print('Error retrieving language preference: $e');
      return null;
    }
  }

  Future<void> clearLanguagePreference(String userId) async {
    try {
      await _accountsCollection.doc(userId).update({
        'preferredLanguage': FieldValue.delete(),
      });
    } catch (e) {
      print('Error clearing language preference: $e');
    }
  }
}
