class UserScreenStateModel {
   bool _hasClicked = false;

    bool get hasClicked => _hasClicked;

   void click (bool newValue) {
    _hasClicked = newValue;
  }
}
