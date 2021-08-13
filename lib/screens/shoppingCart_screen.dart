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
          padding: const EdgeInsets.only(
            right: 10.0,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Text(cart.itemCount.toString()),
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var cartProductData =
                  Provider.of<FirebaseProvider>(context).cartProducts[index];
              String title = cartProductData.title;
              if (title.length > 19) {
                String strippedtitle = title.substring(0, 15);
                title = strippedtitle;
              }
              var providerData = Provider.of<FirebaseProvider>(context);
              int quantity = Provider.of<FirebaseProvider>(context).quantity;
              return CartItem(
                  id: cartProductData.id,
                  title: title,
                  quantity: quantity,
                  price: cartProductData.price,
                  image: cartProductData.image,
                  plusItem: () => providerData.plusItem(),
                  minusItem: () => providerData.minusItem());
            },
            itemCount: Provider.of<FirebaseProvider>(context, listen: false)
                .cartProducts
                .length,
          ),
        ),
      ],
    );
  }
}
