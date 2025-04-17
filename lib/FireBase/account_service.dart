import 'package:cloud_firestore/cloud_firestore.dart';

class AccountService {
  final CollectionReference _accountsCollection = FirebaseFirestore.instance.collection('Accounts');

  // Existing methods
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

  Future<String?> getUsernameFromAccount(String userId) async {
    try {
      print("DEBUG - AccountService: Retrieving username for userId: $userId");
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();
      print("DEBUG - AccountService: Got document: ${doc.exists}, data: ${doc.data()}");

      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        String? username = data['username'] as String?;
        print("DEBUG - AccountService: Retrieved username: $username");
        return username;
      }
      print("DEBUG - AccountService: Document does not exist or is null");
      return null;
    } catch (e) {
      print('DEBUG - AccountService: Error retrieving username: $e');
      return null;
    }
  }

  Future<void> createUserAccount(String userId, {
    String? preferredLanguage,
    String? preferredTheme,
    String? username,
    String? avatarPath
  }) async {
    try {
      print("DEBUG - AccountService: Creating account for userId: $userId with username: $username");

      // Always set (not update) to ensure all fields are present
      await _accountsCollection.doc(userId).set({
        'itemIds': [],
        'preferredLanguage': preferredLanguage ?? 'en',
        'theme': preferredTheme ?? 'default',
        'username': username ?? '',
        'avatarPath': avatarPath ?? 'assets/profile_icon/default_avatar.png',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('DEBUG - AccountService: Account created/updated for: $userId with username: $username');

      // Verify the account was created correctly
      DocumentSnapshot verifyDoc = await _accountsCollection.doc(userId).get();
      print('DEBUG - AccountService: Verification - account data: ${verifyDoc.data()}');

    } catch (e) {
      print('DEBUG - AccountService: Error creating account: $e');
    }
  }

  Future<void> updateUsername(String userId, String username) async {
    try {
      print("DEBUG - AccountService: Updating username for userId: $userId to: $username");

      // Check if document exists first
      DocumentSnapshot docCheck = await _accountsCollection.doc(userId).get();

      if (docCheck.exists) {
        await _accountsCollection.doc(userId).update({
          'username': username,
        });
        print('DEBUG - AccountService: Username updated for existing document');
      } else {
        // Document doesn't exist, create it
        await _accountsCollection.doc(userId).set({
          'itemIds': [],
          'preferredLanguage': 'en',
          'theme': 'default',
          'username': username,
          'avatarPath': 'assets/profile_icon/default_avatar.png',
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('DEBUG - AccountService: Created new account with username');
      }

      // Verify the update was successful
      DocumentSnapshot verifyDoc = await _accountsCollection.doc(userId).get();
      if (verifyDoc.exists) {
        var data = verifyDoc.data() as Map<String, dynamic>;
        print('DEBUG - AccountService: Verification - updated username is: ${data['username']}');
      }

    } catch (e) {
      print('DEBUG - AccountService: Error updating username: $e');
      // Create document if update failed
      try {
        await _accountsCollection.doc(userId).set({
          'itemIds': [],
          'preferredLanguage': 'en',
          'theme': 'default',
          'username': username,
          'avatarPath': 'assets/profile_icon/default_avatar.png',
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('DEBUG - AccountService: Created document after update failed');
      } catch (e2) {
        print('DEBUG - AccountService: Error creating document after update failed: $e2');
      }
    }
  }

  // New Methods for Avatar
  Future<String?> getUserAvatarPath(String userId) async {
    try {
      DocumentSnapshot doc = await _accountsCollection.doc(userId).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        String? avatarPath = data['avatarPath'] as String?;
        return avatarPath;
      }
      return null;
    } catch (e) {
      print('DEBUG - AccountService: Error retrieving avatar path: $e');
      return null;
    }
  }

  Future<void> updateUserAvatarPath(String userId, String avatarPath) async {
    try {
      print("DEBUG - AccountService: Updating avatar path for userId: $userId to: $avatarPath");

      // Check if document exists first
      DocumentSnapshot docCheck = await _accountsCollection.doc(userId).get();

      if (docCheck.exists) {
        await _accountsCollection.doc(userId).update({
          'avatarPath': avatarPath,
        });
        print('DEBUG - AccountService: Avatar path updated');
      } else {
        // Document doesn't exist, create it with default values
        await createUserAccount(userId, avatarPath: avatarPath);
      }
    } catch (e) {
      print('DEBUG - AccountService: Error updating avatar path: $e');
    }
  }
}