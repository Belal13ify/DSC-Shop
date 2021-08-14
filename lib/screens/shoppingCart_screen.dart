import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<FirebaseProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.purpleAccent,
                      )
                    ],
                  ),
                  alignment: Alignment.center),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.itemCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      size: 25,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              // var cartProductData =
              //     Provider.of<FirebaseProvider>(context).cartProducts[index];
              // var cartProductData =
              //     Provider.of<FirebaseProvider>(context).items[index];
              String title = cart.items.values.toList()[index].title;
              if (title.length > 19) {
                String strippedtitle = title.substring(0, 15);
                title = strippedtitle;
              }
              // int quantity = cart.quantity;

              return CartItem(
                  id: cart.items.values.toList()[index].id,
                  title: title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price,
                  image: cart.items.values.toList()[index].image,
                  plusItem: () => cart.plusItem((index + 1).toString()),
                  minusItem: () => cart.minusItem((index + 1).toString()));
            },
            itemCount: cart.items.length,
          ),
        ),
      ],
    );
  }
}
