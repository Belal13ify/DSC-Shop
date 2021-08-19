import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/favourite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  late FirebaseFirestore firestore;
  final auth = FirebaseAuth.instance;
  late QuerySnapshot querySnapshot;
  late String username;
  late String userEmail;
  late String uid;
  late String userPhoto;
  // String users = 'Users';
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  void initialize() {
    firestore = FirebaseFirestore.instance;
  }

  void getUserDetails() async {
    uid = auth.currentUser!.uid;
    await firestore.collection('Users').doc(uid).get().then((value) {
      username = value.data()!['Name'];
      userEmail = value.data()!['email'];
      userPhoto = value.data()!['photo'];
    });
  }

  void changePhoto() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();

    XFile? image;

    var status = await Permission.photos.request();

    if (status.isGranted) {
      image = await _picker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);
      var snapshot = await _storage
          .ref()
          .child('Users/$uid/photos')
          .putFile(file)
          .whenComplete(() => print('Completed'));

      userPhoto = await snapshot.ref.getDownloadURL();
      await users.doc(uid).update({'photo': userPhoto});
    } else {
      print('Permission Denied');
    }
    notifyListeners();
  }

  Future<void> changeName(String newUsername) async {
    username = newUsername;
    await users.doc(uid).update({'Name': username});
    notifyListeners();
  }

  Future<void> userSetup(String name, String email) async {
    username = name;
    userEmail = email;
    uid = auth.currentUser!.uid;
    String profilePhoto =
        "https://firebasestorage.googleapis.com/v0/b/dsc-shop.appspot.com/o/profile.png?alt=media&token=43852a9b-8baa-48a9-917a-80bc5b256665";
    // CollectionReference users = FirebaseFirestore.instance.collection('Users');

    await users.doc(uid).set(
        {'Name': username, 'email': email, 'uid': uid, 'photo': profilePhoto});
    userPhoto = profilePhoto;
  }

  void signUp(String name, String email, String password, context) {
    username = name;
    _items = {};
    _favProducts = {};
    initialize();
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => userSetup(name, email)) //setup in firebase
        .then((_) => readFavourites())
        .then((_) => readCartItems()
            .then((_) => {Navigator.of(context).pushNamed('home')}));
    // notifyListeners();
  }

  void login(String email, String password, context) async {
    // CollectionReference users = FirebaseFirestore.instance.collection('Users');
    _items = {};
    _favProducts = {};
    initialize();
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) =>
            getUserDetails()) // .then((_) => getUserDetails()) // get user details in the app
        .then((_) => readFavourites())
        .then((_) => readCartItems()
            .then((_) => {Navigator.of(context).pushNamed('home')}));
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
