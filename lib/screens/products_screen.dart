import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/jsonData_providerd.dart';
import 'package:flutter/material.dart';
import '../widgets/search.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<Data>(context).products;
    return Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text("${products[index].id}");
          },
          itemCount: products.length,
        )

        //  Column(
        //   children: [
        //     Search(),

        //   ],
        // ),
        );
  }
}
