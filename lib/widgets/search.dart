import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/jsonData_provider.dart';

TextEditingController searchController = TextEditingController();

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TextEditingController searchController = TextEditingController();
    var search = Provider.of<Data>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          onChanged: (val) {
            if (val == "") {
              search.clearSearch();
            } else {
              search.search(val);
            }

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
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.text = '';
                searchController.clear();
                search.clearSearch();
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
