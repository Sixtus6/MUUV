import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/screens/home/user/index.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/arrow.dart';
import 'package:nb_utils/nb_utils.dart';

class UserAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSignUpSuccessful = false;
  bool get isSignUpSuccessful => _isSignUpSuccessful;
  bool _isLoginSuccessful = false;
  bool get isLoginSuccessful => _isLoginSuccessful;
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
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // If login is successful, set the login success flag to true
      _isLoginSuccessful = true;
      notifyListeners();
      toast("Login successfully");
      await _fetchUserDetails(userCredential.user!.uid, email);
      //saves user to shared preferences
      saveUserToPrefs(_user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _isLoginSuccessful = false;
        notifyListeners();
        toast("Email or password incorrect");
      } else {
        // toast("Something went wrong");
        _isLoginSuccessful = false;
        notifyListeners();
      }

      print('Error during login: ${e.message}');
      _isLoginSuccessful = false;
      notifyListeners();

      rethrow;
    } catch (e) {
      print('Unexpected error during login: $e');
      _isLoginSuccessful = false;
      notifyListeners();
      rethrow;
    }
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
      await _fetchUserDetails(userCredential.user!.uid, email);
      //saves user to shared preferences
      saveUserToPrefs(_user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _isSignUpSuccessful = false;
        notifyListeners();

        // Handle the case where email is already in use by an existing account
        toast("Email already exist");
      } else {
        toast("Something went wrong");
        _isSignUpSuccessful = false;
        notifyListeners();

        print('Error during sign up: ${e.message}');
      }
    } catch (e) {
      toast("Something went wrong");
      _isSignUpSuccessful = false;
      notifyListeners();

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

  Future<void> _fetchUserDetails(String uid, email) async {
    // Fetch user details from Firestore using uid and update _userDetails
    // Example: Fetching from a 'users' collection
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print(userSnapshot.data());
    if (userSnapshot.exists) {
      _user = UserModel(
        uid: uid,
        name: userSnapshot['fullName'],
        emailAddress: email,
        address: userSnapshot['address'],
        phoneNumber: userSnapshot['phoneNumber'],
        password: "",
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
