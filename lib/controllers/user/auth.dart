import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/screens/home/user/index.dart';
import 'package:muuv/widget/arrow.dart';
import 'package:nb_utils/nb_utils.dart';

class UserAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSignUpSuccessful = false;

  bool get isSignUpSuccessful => _isSignUpSuccessful;

  UserModel? _user;

  UserModel? get user => _user;

  // Initialize the AuthProvider
  UserAuthProvider() {
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
      _isSignUpSuccessful = true;
      notifyListeners();
      toast("Account created successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Handle the case where email is already in use by an existing account
        toast("Email already exist");
      } else {
        toast("Something went wrong");
        // Handle other FirebaseAuthException
        print('Error during sign up: ${e.message}');
      }
    } catch (e) {
      toast("Something went wrong");

      print('Unexpected error during sign up: $e');
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
