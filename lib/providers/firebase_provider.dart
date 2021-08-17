import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/favourite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  late FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  late QuerySnapshot querySnapshot;
  String username = "";
  String userEmail = "";
  String token = "";
  late String uid;
  // String users = 'Users';
  // CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void initialize() {
    firestore = FirebaseFirestore.instance;
    notifyListeners();
  }

  Future<void> userSetup(String username, String email) async {
    userEmail = email;
    // CollectionReference users = FirebaseFirestore.instance.collection('Users');
    uid = auth.currentUser!.uid; // here to fix the null checking issue
    // await users.add({'usernasme': username,'email': email, 'uid': uid});
  }

  void signUp(String name, String email, String password, context) {
    username = name;
    _items = {};
    _favProducts = {};
    initialize();
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => userSetup(name, email))
        .then((_) => readFavourites())
        .then((_) => readCartItems()
            .then((_) => {Navigator.of(context).pushNamed('home')}));
    notifyListeners();
  }

  void login(String name, String email, String password, context) {
    _items = {};
    _favProducts = {};
    initialize();
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) => userSetup(name, email))
        .then((_) => readFavourites())
        .then((_) => readCartItems()
            .then((_) => {Navigator.of(context).pushNamed('home')}));
    notifyListeners();
  }

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

  Future<void> addItem(
      String productId, String title, num price, String image) async {
    uid = FirebaseAuth.instance.currentUser!.uid;

    querySnapshot = await firestore
        .collection('Shop')
        .doc(uid)
        .collection('cart products')
        .get();
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
      firestore
          .collection('Shop')
          .doc(uid)
          .collection('cart products')
          .doc(productId)
          .update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      _items.putIfAbsent(
          productId,
          () => CartProduct(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              image: image));
      // await firestore.collection('Users').doc(uid).set(data);
      await firestore
          .collection('Shop')
          .doc(uid)
          .collection('cart products')
          .doc(productId)
          .set({
        'id': productId,
        'title': title,
        'price': price,
        'quantity': 1,
        'image': image
      });
    }
    notifyListeners();
  }

  Future<void> addToWishList(
      String productId, String title, num price, String image) async {
    if (_favProducts.containsKey(productId)) {
      _favProducts.remove(productId);
      firestore
          .collection('Shop')
          .doc(uid)
          .collection('favourite products')
          .doc(productId)
          .delete();
    } else {
      _favProducts.putIfAbsent(
          productId,
          () => FavouriteProduct(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              image: image));
      await firestore
          .collection('Shop')
          .doc(uid)
          .collection('favourite products')
          .doc(productId)
          .set({
        'id': productId,
        'title': title,
        'price': price,
        'image': image
      });
    }
    notifyListeners();
  }

  Future<void> readCartItems() async {
    try {
      querySnapshot = await firestore
          .collection('Shop')
          .doc(uid)
          .collection('cart products')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var cartItem = CartProduct(
            id: doc['id'],
            title: doc['title'],
            price: doc['price'],
            quantity: doc['quantity'],
            image: doc['image'],
          );

          _items.putIfAbsent(doc.id, () => cartItem);
        }
      }
    } catch (e) {
      print(e);
    }
    // notifyListeners();
  }

  Future<void> readFavourites() async {
    try {
      querySnapshot = await firestore
          .collection('Shop')
          .doc(uid)
          .collection('favourite products')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var favouriteProduct = FavouriteProduct(
            id: doc['id'],
            title: doc['title'],
            price: doc['price'],
            image: doc['image'],
          );

          _favProducts.putIfAbsent(doc.id, () => favouriteProduct);
        }
      }
    } catch (e) {
      print(e);
    }
    // notifyListeners();
  }

  void deleteFromFavourite(String productId) {
    _favProducts.remove(productId);
    firestore
        .collection('Shop')
        .doc(uid)
        .collection('favourite products')
        .doc(productId)
        .delete();
    notifyListeners();
  }

  void deleteFromCart(productId) async {
    _items.remove(productId);
    firestore
        .collection('Shop')
        .doc(uid)
        .collection('cart products')
        .doc(productId)
        .delete();
    notifyListeners();
  }

  void plusItem(String productId) {
    print(productId);
    _items.update(
        productId,
        (existingCartItem) => CartProduct(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price,
            image: existingCartItem.image));

    firestore
        .collection('Shop')
        .doc(uid)
        .collection('cart products')
        .doc(productId)
        .update({
      'quantity': FieldValue.increment(1),
    });

    notifyListeners();
  }

  void minusItem(String productId) {
    _items.update(
        productId,
        (existingCartItem) => CartProduct(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity == 1
                ? 1
                : existingCartItem.quantity - 1,
            price: existingCartItem.price,
            image: existingCartItem.image));

    firestore
        .collection('Shop')
        .doc(uid)
        .collection('cart products')
        .doc(productId)
        .update({
      'quantity': FieldValue.increment(-1), //bug tto fix
    });

    notifyListeners();
  }
}
