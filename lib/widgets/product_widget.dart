import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String title;
  final dynamic price;
  final String imageSrc;
  final String descrition;
  final String category;
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
      required this.addToCart,
      required this.addToWishlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                imageSrc,
                width: 120,
                height: 120,
              ),
              SizedBox(
                height: 15,
              ),
              Text(title, style: TextStyle(fontSize: 16)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  "\$$price",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: addToWishlist,
                    icon: Icon(
                      Icons.favorite,
                      size: 25,
                    ))
              ]),
              ElevatedButton(
                  onPressed: addToCart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ADD TO CART",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.add_shopping_cart,
                        size: 25,
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
