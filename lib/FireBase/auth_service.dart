import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../myapp.dart';
import '../Bloc_Cubit/AuthCubit/auth_cubit.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService(this._firebaseAuth);

  bool _isEmail(String input) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> login(String identifier, String password) async {
    try {
      if (_isEmail(identifier)) {
        final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: identifier,
          password: password,
        );
        return userCredential.user;
      }

      final userDoc = await _firestore
          .collection('users')
          .where('username', isEqualTo: identifier.toLowerCase())
          .get();

      if (userDoc.docs.isEmpty) {
        throw AuthException('Utente non trovato.');
      }

      final userEmail = userDoc.docs.first.data()['email'] as String;
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      print('Errore nel login: $e');
      throw AuthException('Login fallito. Si prega di riprovare.');
    }
  }

  Future<User?> register(String username, String email, String password) async {
    try {
      final existingUser = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.toLowerCase())
          .get();

      if (existingUser.docs.isNotEmpty) {
        throw AuthException('Username già in uso.');
      }

      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username.toLowerCase(),
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userCredential.user;
    } catch (e) {
      print('Errore nella registrazione: $e');
      throw AuthException('Registrazione fallita. Si prega di riprovare.');
    }
  }

  Future<void> logout(BuildContext context, AuthCubit authCubit) async {
    try {
      await _firebaseAuth.signOut();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp(authCubit: authCubit)),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Errore nel logout: $e');
      throw AuthException('Errore durante il logout.');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}