import 'package:dsc_shop/models/product_model.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> cartProduct = [
      Product(
          id: 1,
          title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
          price: 15.99,
          description: "",
          category: "",
          image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
      Product(
          id: 1,
          title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
          price: 15.99,
          description: "",
          category: "",
          image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
    ];
    return ListView.builder(
      itemBuilder: (context, index) {
        var cartProductData = cartProduct[index];
        String title = cartProductData.title;
        if (title.length > 20) {
          String strippedtitle = title.substring(0, 20);
          title = strippedtitle;
        }
        return CartItem(
            title: title,
            price: cartProductData.price,
            image: cartProductData.image,
            plusItem: () {},
            minusItem: () {});
      },
      itemCount: 2,
    );
  }
}
