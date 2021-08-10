import 'package:flutter/material.dart';

class Others extends ChangeNotifier {
  bool secured = false;

  void togglePassword() {
    secured = !secured;
    notifyListeners();
  }
}
