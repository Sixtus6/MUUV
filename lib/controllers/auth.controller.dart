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
            phone: "",
            address: "");
      }
      notifyListeners();
    });
  }
Future<void> signUpWithEmailAndPassword(String email, String password, String displayName, String phoneNumber) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // If user creation is successful, we can now update additional user details
    await _updateUserDetails(userCredential.user!, displayName, phoneNumber);
  } catch (e) {
    print('Error during sign up: $e');
    rethrow;
  }
}

Future<void> _updateUserDetails(User user, String displayName, String phoneNumber) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': displayName,
      'phoneNumber': phoneNumber,
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
