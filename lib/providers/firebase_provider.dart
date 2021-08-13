import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/widgets/cart_item.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider with ChangeNotifier {
  List<Product> cartProducts = [];
  List<Product> favProducts = [];

  int quantity = 0;

  Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  num get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartProduct) {
      total += cartProduct.price * cartProduct.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, num price) {
    if (_items.containsKey(productId)) {
      //change quanity
      _items.update(
          productId,
          (existingCartItem) => CartProduct(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartProduct(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  late FirebaseFirestore firestore;

  late QuerySnapshot querySnapshot;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  void addtoCart(Product product) {
    if (cartProducts.isEmpty) {
      cartProducts.add(product);
      quantity++;
    }
    if (!cartProducts.map((p) => p.id).toList().contains(product.id)) {
      cartProducts.add(product);
      quantity++;
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
    quantity++;
    notifyListeners();
  }

  void minusItem() {
    quantity--;
    notifyListeners();
  }
}
