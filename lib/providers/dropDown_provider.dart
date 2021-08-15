import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DropDownProvider with ChangeNotifier {
  List<String> languages = ['ar', 'en'];
  String? selectedValue = 'en';

  void changeLang(String? val, context) {
    selectedValue = val;
    LocaleNotifier.of(context)!.change(selectedValue!);
    notifyListeners();
  }
}
