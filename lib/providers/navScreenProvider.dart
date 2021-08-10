import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int selectedScreen = 0;

  void onScreenTaped(int index) {
    selectedScreen = index;
    notifyListeners();
  }
}
