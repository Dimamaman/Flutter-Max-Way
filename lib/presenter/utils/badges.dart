
import 'package:flutter/cupertino.dart';

class BadgeProvider extends ChangeNotifier {
  int _badgeValue = 0;

  int get badgeValue => _badgeValue;

  int updateBadgeValue(int newValue) {
    _badgeValue = newValue;
    notifyListeners();
    return _badgeValue;
  }

  void increment() {
    _badgeValue++;
    notifyListeners();
  }

  void decrement() {
    _badgeValue--;
    notifyListeners();
  }
}