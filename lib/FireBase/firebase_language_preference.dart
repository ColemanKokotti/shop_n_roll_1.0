import 'package:cloud_firestore/cloud_firestore.dart';

class LanguagePreferenceService {
  final CollectionReference _accountsCollection =
  FirebaseFirestore.instance.collection('Accounts');

  // Save user's language preference
  Future<void> saveLanguagePreference(String userId, String languageCode) async {
    try {
      await _accountsCollection.doc(userId).update({
        'preferredLanguage': languageCode,
      });
    } catch (e) {
      print('Error saving language preference: $e');
    }
  }

  // Retrieve user's language preference
  Future<String?> getLanguagePreference(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();

      if (doc.exists && doc.data() != null) {
        return (doc.data() as Map<String, dynamic>)['preferredLanguage'];
      }

      return null;
    } catch (e) {
      print('Error retrieving language preference: $e');
      return null;
    }
  }

  Future<void> clearLanguagePreference(String userId) async {
  }
}
