import 'package:flutter/material.dart';

class MainText extends ChangeNotifier {
  String _value;

  void updateTo(String newValue) {
    if (newValue != null) {
      _value = newValue;
      notifyListeners();
    }
  }

  void reset() {
    _value = null;
  }

  String getValue() {
    return _value;
  }
}
