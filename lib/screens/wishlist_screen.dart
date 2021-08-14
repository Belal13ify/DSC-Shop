import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/favourite_item.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Product> FavProducts =
    //     Provider.of<FirebaseProvider>(context).favProducts;
    var fb = Provider.of<FirebaseProvider>(context, listen: false);
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
        String title = fb.favProducts.values.toList()[index].title;
        if (title.length > 19) {
          String strippedtitle = title.substring(0, 15);
          title = strippedtitle;
        }

        return FavouriteItem(
          id: fb.favProducts.values.toList()[index].id,
          title: title,
          price: fb.favProducts.values.toList()[index].price,
          image: fb.favProducts.values.toList()[index].image,
          deleteFavourite: () => fb.deleteFromFavourite(),
        );
      },
      itemCount: fb.favProducts.length,
    );
  }
}
