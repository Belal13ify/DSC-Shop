import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider with ChangeNotifier {
  List<Product> cartProducts = [];
  List<Product> favProducts = [];
  int cartProductCount = 0;
  late FirebaseFirestore firestore;

  late QuerySnapshot querySnapshot;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  void addtoCart(Product product) {
    if (cartProducts.isEmpty) {
      cartProducts.add(product);
      cartProductCount++;
    }
    if (!cartProducts.map((p) => p.id).toList().contains(product.id)) {
      cartProducts.add(product);
      cartProductCount++;
    }
    notifyListeners();
  }

  void addToWishList() {}

  Future<void> readFavourite() async {
    try {
      querySnapshot = await firestore.collection('favourite products').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var product = Product(
              id: 0,
              title: doc['title'],
              price: doc['price'],
              description: "",
              category: "",
              image: doc['image']);
          favProducts.add(product);
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deleteFromFavourite() {}

  void plusItem() {
    cartProductCount++;
    notifyListeners();
  }

  void minusItem() {
    cartProductCount--;
    notifyListeners();
  }
}
