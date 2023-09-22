import 'package:flutter/material.dart';

class UserScreenProvider with ChangeNotifier {
  bool _hasClickedLogin = true;
  bool _hasClickedSignup = false;
  bool _passwordVisible = true;

  bool get hasClickedLogin => _hasClickedLogin;
  bool get hasClickedSignup => _hasClickedSignup;
  bool get isPasswordVisible => _passwordVisible;

  void sethasClickedLogin(bool value) {
    _hasClickedLogin = value;
    notifyListeners();
  }

  void sethasClickedSignup(bool value) {
    _hasClickedSignup = value;
    notifyListeners();
  }

  void setPasswordVisible(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }
}
