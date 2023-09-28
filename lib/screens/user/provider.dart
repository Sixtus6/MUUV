import 'package:flutter/material.dart';

class UserScreenProvider with ChangeNotifier {
  bool _hasClickedLogin = true;
  bool _hasClickedSignup = false;
  bool _passwordVisible = true;
  bool _rememberMe = true;
  bool _haserror = true;
  bool _isLoading = false;

  bool get hasClickedLogin => _hasClickedLogin;
  bool get hasClickedSignup => _hasClickedSignup;
  bool get isPasswordVisible => _passwordVisible;
  bool get rememberMe => _rememberMe;
  bool get haserror => _haserror;
  bool get isLoadingLogin => _isLoading;
  

  void sethasClickedLogin(bool value) {
    _hasClickedLogin = value;
    notifyListeners();
  }

  void setError(bool value) {
    _haserror = value;
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

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
