import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> items = ['ar', 'en'];
  String? selectedValue = 'en';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: selectedValue,
        onChanged: (String? val) {
          setState(() {
            selectedValue = val;
            LocaleNotifier.of(context)!.change(selectedValue!);
          });
        },
        items: items.map((String item) {
          return DropdownMenuItem(
            child: Text(
              item,
              style: TextStyle(fontSize: 14),
            ),
            value: item,
          );
        }).toList());
  }
}
