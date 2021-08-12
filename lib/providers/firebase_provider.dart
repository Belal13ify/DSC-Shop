import 'package:dsc_shop/models/product_model.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  List<Product> cartProducts = [];
  List<Product> favProducts = [];

  int cartProductCount = 0;

  void addtoCart() {}
  void addToWishList() {}

  void deleteFromFavourite() {}

  void plusItem(int productId) {
    cartProductCount++;
    notifyListeners();
  }

  void minusItem(int productId) {
    cartProductCount--;
    notifyListeners();
  }
}
