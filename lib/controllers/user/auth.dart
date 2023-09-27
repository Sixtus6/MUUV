import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/widget/arrow.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _user;

  UserModel? get user => _user;

  // Initialize the AuthProvider
  AuthProvider() {
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _user = null;
      } else {
        _user = UserModel(
            uid: firebaseUser.uid,
            name: "",
            emailAddress: "",
            password: "",
            phoneNumber: "",
            address: "");
      }
      notifyListeners();
    });
  }
  Future<void> signUpWithEmailAndPassword(String email, String password,
      String name, String address, String phoneNumber) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If user creation is successful, we can now update additional user details
      await _updateUserDetails(
          userCredential.user!, name, phoneNumber, address);
    } catch (e) {
      print('Error during sign up: $e');
      rethrow;
    }
  }

  Future<void> _updateUserDetails(
      User user, String name, String phoneNumber, String address) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': name,
        'phoneNumber': phoneNumber,
        'address': address
        // Add other details as needed
      });
    } catch (e) {
      print('Error updating user details: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
