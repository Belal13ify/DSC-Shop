import 'package:flutter/material.dart';
import '../widgets/search.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Search(),
        ],
      ),
    );
  }
}
