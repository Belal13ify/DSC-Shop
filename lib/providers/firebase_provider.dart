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

  void addtoCart() {}
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

  void plusItem(int productId) {
    cartProductCount++;
    notifyListeners();
  }

  void minusItem(int productId) {
    cartProductCount--;
    notifyListeners();
  }
}
