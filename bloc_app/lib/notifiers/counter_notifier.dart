

import 'package:flutter/widgets.dart';

class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get getCount => _count;

  void set setCount(int count) {
    _count = count;
  }

  void updateCount({type}) {
    if (type == 'increment') {
      setCount = _count + 1;
      print(_count);
    } else if (type == 'decrement') {
      setCount = _count - 1;
    }
    notifyListeners();
  }

}