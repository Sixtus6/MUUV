import 'package:flutter/material.dart';

class UserScreenProvider with ChangeNotifier {
  bool _hasClickedLogin = true;
  bool _hasClickedSignup = false;

  bool get hasClickedLogin => _hasClickedLogin;
  bool get hasClickedSignup => _hasClickedSignup;

  void sethasClickedLogin(bool value) {
    _hasClickedLogin = value;
    notifyListeners();
  }

  void sethasClickedSignup(bool value) {
    _hasClickedSignup = value;
    notifyListeners();
  }
}
