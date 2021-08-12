import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class Data with ChangeNotifier {
  List<Product> products = [];

  Future<void> getData() async {
    products = [];
    String url = 'https://fakestoreapi.com/products';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var p in jsonData) {
        Product product = Product.fromJson(p);
        products.add(product);
      }
    } else {
      throw Exception("Error");
    }

    notifyListeners();
  }
}
