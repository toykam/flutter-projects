import 'package:flutter/cupertino.dart';

class AuthPageNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get getCurrentIndex => _currentIndex;

  void set currentIndex(int index) {
    _currentIndex = index;
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    // print(_currentIndex);
    notifyListeners();
  }
}