import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/favourite.dart';
import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/widgets/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider with ChangeNotifier {
  late FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  late QuerySnapshot querySnapshot;
  // String name = "";
  String userEmail = "";
  String token = "";
  late String uid;
  String users = 'Users';
  // CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void initialize() {
    firestore = FirebaseFirestore.instance;
    notifyListeners();
  }

  Future<void> userSetup(String email) async {
    userEmail = email;
    // CollectionReference users = FirebaseFirestore.instance.collection('Users');
    uid = auth.currentUser!.uid; // here to fix the null checking issue
    // await users.add({'email': email, 'uid': uid});
  }

  void signUp(String email, String password, context) {
    initialize();
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => {Navigator.of(context).pushNamed('home')});
    userSetup("blah, blah");
    readCartItems();
    notifyListeners();
  }

  void login(String email, String password, context) {
    initialize();
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) => {Navigator.of(context).pushNamed('home')});
    userSetup("blah, blah");
    readCartItems();
    notifyListeners();
  }

  int quantity = 0;
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
      // await firestore.collection('Users').doc(uid).set(data);
      await firestore
          .collection('Users')
          .doc(uid)
          .collection('cart products')
          .add({
        'id': productId,
        'title': title,
        'price': price,
        'quantity': 1,
        'image': image
      });
    }
    notifyListeners();
  }

  void addToWishList(String productId, String title, num price, String image) {
    if (_favProducts.containsKey(productId)) {
      _favProducts.remove(productId);
    } else {
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

  Future<void> readCartItems() async {
    try {
      querySnapshot = await firestore
          .collection('Users')
          .doc(uid)
          .collection('cart products')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          print(querySnapshot.docs.length);
          var cartItem = CartProduct(
            id: doc['id'],
            title: doc['title'],
            price: doc['price'],
            quantity: doc['quantity'],
            image: doc['image'],
          );
          _items.putIfAbsent(doc['id'],
              () => cartItem); //here is the issue of reading >> fixed
        }
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
    // notifyListeners();
  }

  Future<void> readFavourite() async {
    QuerySnapshot querySnapshot;
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

  void deleteFromFavourite(String productId) {
    _favProducts.remove(productId);
    notifyListeners();
  }

  void deleteFromCart(productKey) {
    {
      _items.remove(productKey);
      notifyListeners();
    }
  }

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
