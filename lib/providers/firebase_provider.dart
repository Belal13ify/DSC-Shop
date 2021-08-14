import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/favourite.dart';
import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/widgets/cart_item.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider with ChangeNotifier {
  // List<Product> cartProducts = [];
  // List<Product> favProducts = [];

  int quantity = 0;
  bool isFav = false;

  Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items {
    return {..._items};
  }

  Map<String, FavouriteProduct> _favProducts = {};
  Map<String, FavouriteProduct> get favProducts {
    return {..._favProducts};
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

  void addItem(String productId, String title, num price, String image) {
    if (_items.containsKey(productId)) {
      //change quanity
      _items.update(
          productId,
          (existingCartItem) => CartProduct(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price,
              image: existingCartItem.image));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartProduct(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              image: image));
    }
    notifyListeners();
  }

  late FirebaseFirestore firestore;

  late QuerySnapshot querySnapshot;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  void addToWishList(String productId, String title, num price, String image) {
    if (_favProducts.containsKey(productId)) {
      _favProducts.remove(productId);
      // isFav = false;
    } else {
      // isFav = true;
      _favProducts.putIfAbsent(
          productId,
          () => FavouriteProduct(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              image: image));
    }
    notifyListeners();
  }

  bool checkFavouriteProduct(String productKey) {
    // print(productKey);
    // print(_favProducts.values.map((e) => print(e)));
    return _favProducts.containsKey(productKey) ? true : false;
  }
  // void checkFavourite(String favouriteKey) {
  //   bool isFavourite = _favProducts.containsKey(favouriteKey);
  //   if (isFavourite) {
  //     _favProducts.remove(favouriteKey);
  //   }else{
  //   }
  // }

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
          // favProducts.add(product);
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deleteFromFavourite() {}

  void plusItem(String productId) {
    // print(productId);
    // print(_items);
    _items.update(
        productId,
        (existingCartItem) => CartProduct(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price,
            image: existingCartItem.image));

    notifyListeners();
  }

  void minusItem(String productId) {
    // print(productId);
    // print(_items);
    _items.update(
        productId,
        (existingCartItem) => CartProduct(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity == 0
                ? existingCartItem.quantity
                : existingCartItem.quantity - 1,
            price: existingCartItem.price,
            image: existingCartItem.image));

    notifyListeners();
  }
}
