import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final num price;
  final int quantity;
  final String image;
  final VoidCallback plusItem;
  final VoidCallback minusItem;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.image,
      required this.plusItem,
      required this.minusItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 7, right: 7),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 5,
              ),
              Image.network(
                image,
                width: 50,
                height: 60,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: minusItem,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        size: 30,
                      )),
                  Text("$quantity"),
                  IconButton(
                      onPressed: plusItem,
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 30,
                      )),
                  SizedBox(
                    width: 5,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
