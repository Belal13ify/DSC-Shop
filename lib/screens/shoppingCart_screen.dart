import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var cartProductData =
            Provider.of<FirebaseProvider>(context).cartProducts[index];
        String title = cartProductData.title;
        if (title.length > 19) {
          String strippedtitle = title.substring(0, 15);
          title = strippedtitle;
        }
        var providerData =
            Provider.of<FirebaseProvider>(context, listen: false);
        int cartCount = Provider.of<FirebaseProvider>(context, listen: false)
            .cartProductCount;
        return CartItem(
            id: cartProductData.id,
            title: title,
            itemCount: cartCount,
            price: cartProductData.price,
            image: cartProductData.image,
            plusItem: () => providerData.plusItem(),
            minusItem: () => providerData.minusItem());
      },
      itemCount: Provider.of<FirebaseProvider>(context, listen: false)
          .cartProducts
          .length,
    );
  }
}
