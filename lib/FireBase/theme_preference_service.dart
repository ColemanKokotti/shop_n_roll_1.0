import 'package:cloud_firestore/cloud_firestore.dart';

class ThemePreferenceService {
  final CollectionReference _accountsCollection = FirebaseFirestore.instance.collection('Accounts');

  Future<void> saveThemePreference(String userId, String theme) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();

      if (doc.exists) {
        await _accountsCollection.doc(userId).update({
          'theme': theme,
        });
      } else {
        await _accountsCollection.doc(userId).set({
          'itemIds': [],
          'theme': theme,
          'preferredLanguage': 'en',
        });
      }
      print('Tema salvato con successo: $theme');
    } catch (e) {
      print('Errore nel salvare il tema: $e');
    }
  }

  Future<String?> getThemePreference(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['theme'] as String?;
      }
      return null;
    } catch (e) {
      print('Errore nel recuperare il tema: $e');
      return null;
    }
  }

  Future<void> clearThemePreference(String userId) async {
    try {
      await _accountsCollection.doc(userId).update({
        'theme': FieldValue.delete(),
      });
    } catch (e) {
      print('Errore nella cancellazione del tema: $e');
    }
  }
}
