import 'package:dsc_shop/models/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/product_widget.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final String description;
  final dynamic price;
  final String image;

  ProductDetails(
      {required this.title,
      required this.description,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  image,
                  width: 220,
                  height: 220,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\$$price",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Description: $description",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Text(
                              "ADD TO CART",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                          )
                        ],
                      )),
                )
              ]),
        ));
  }
}
