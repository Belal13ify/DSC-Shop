import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SingleProduct extends StatelessWidget {
  final String title;
  final num price;
  final String imageSrc;
  final String descrition;
  final String category;
  final bool isFav;
  final VoidCallback pressed;
  final VoidCallback addToCart;
  final VoidCallback addToWishlist;

  SingleProduct(
      {required this.title,
      required this.price,
      required this.imageSrc,
      required this.pressed,
      this.descrition = "",
      this.category = "",
      required this.isFav,
      required this.addToCart,
      required this.addToWishlist});

  @override
  Widget build(BuildContext context) {
    // var fb = Provider.of<FirebaseProvider>(context);
    return GestureDetector(
      onTap: pressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                imageSrc,
                width: 90,
                height: 90,
              ),
              SizedBox(
                height: 15,
              ),
              Text(title, style: TextStyle(fontSize: 17)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  "\$$price",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: addToWishlist,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          // Colors.red,
                          isFav ? Colors.red : Colors.black,
                      size: 25,
                    ))
              ]),
              ElevatedButton(
                  onPressed: addToCart,
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocaleText(
                        "additem",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.add_shopping_cart,
                        size: 25,
                        color: Colors.grey,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
