import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          onChanged: (val) {
            // value.search(val);
          },
          controller: searchController,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: 'Search for a Product',
            hintStyle: TextStyle(fontSize: 16),

            //triggering the clear icon button in search field to clear the text field and close the search option
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // value.toggleSearch();
                // textController.text = '';
                // textController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ));
  }
}
