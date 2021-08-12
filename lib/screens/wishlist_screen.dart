import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/favourite_item.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> FavProducts =
        Provider.of<FirebaseProvider>(context).favProducts;
    List<Product> favouriteProducts = [
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
        var favProductData = favouriteProducts[index];
        String title = favProductData.title;
        if (title.length > 20) {
          String strippedtitle = title.substring(0, 20);
          title = strippedtitle;
        }
        return FavouriteItem(
            title: title,
            price: favProductData.price,
            image: favProductData.image,
            deleteFavourite: () {});
      },
      itemCount: 2,
    );
  }
}
