import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dropDown_provider.dart';

class DropDown extends StatelessWidget {
  Widget build(BuildContext context) {
    var dd = Provider.of<DropDownProvider>(context);
    List<String> languages = dd.languages;
    return DropdownButton<String>(
        value: dd.selectedValue,
        onChanged: (val) => dd.changeLang(val, context),
        items: languages.map((String language) {
          return DropdownMenuItem(
            child: Text(
              language,
              style: TextStyle(fontSize: 14),
            ),
            value: language,
          );
        }).toList());
  }
}
