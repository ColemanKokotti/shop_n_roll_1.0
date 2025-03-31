import 'package:cloud_firestore/cloud_firestore.dart';

class ThemePreferenceService {
  final CollectionReference _accountsCollection = FirebaseFirestore.instance.collection('Accounts');

  Future<void> saveThemePreference(String userId, String theme) async {
    try {
      await _accountsCollection.doc(userId).update({
        'theme': theme,
      });
    } catch (e) {
      print('Errore nel salvare il tema: $e');

      // Se il documento non esiste, crealo con il tema
      try {
        await _accountsCollection.doc(userId).set({
          'itemIds': [],
          'theme': theme,
        });
      } catch (createError) {
        print('Errore nella creazione dell\'account con tema: $createError');
      }
    }
  }

  Future<String?> getThemePreference(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return doc.get('theme');
      }
      return null;
    } catch (e) {
      print('Errore nel recuperare il tema: $e');
      return null;
    }
  }


  Future<void> clearThemePreference(String userId) async {
  }
}
