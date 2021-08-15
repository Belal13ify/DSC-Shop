import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String category;
  final num price;
  final String image;

  ProductDetails(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    var fb = Provider.of<FirebaseProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          // centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: ListView(
            children: [
              Image.network(
                image,
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: LocaleText('category',
                    // textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "$category",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    LocaleText(
                      "price",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ':\t\t\$$price',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LocaleText(
                  "describe",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "$description",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: ElevatedButton(
                      onPressed: () {
                        fb.addItem(id.toString(), title, price, image);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: LocaleText(
                              "additem",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            Icons.add_shopping_cart,
                            size: 35,
                          )
                        ],
                      )),
                )
              ]),
            ],
          ),
        ));
  }
}
