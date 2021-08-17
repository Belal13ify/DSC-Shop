import 'package:flutter/material.dart';

class Others extends ChangeNotifier {
  bool secured = true;

  void togglePassword() {
    secured = !secured;
    notifyListeners();
  }
}
