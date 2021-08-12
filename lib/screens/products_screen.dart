import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/jsonData_providerd.dart';
import 'package:flutter/material.dart';
import '../widgets/search.dart';
import 'package:provider/provider.dart';
import '../widgets/product_widget.dart';
import 'product_details.dart';

class Products extends StatelessWidget {
  void productInfo(String title, String description, String category,
      dynamic price, String image, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetails(
                  title: title,
                  description: description,
                  category: category,
                  price: price,
                  image: image,
                )));
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<Data>(context).products;
    return Consumer<FirebaseProvider>(builder: (context, fb, child) {
      return GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          var productData = products[index];

          String title = productData.title;
          String description = productData.description;
          String category = productData.category;
          dynamic price = productData.price;
          String image = productData.image;

          if (title.length > 20) {
            String strippedtitle = title.substring(0, 20);
            title = strippedtitle;
          }
          print(productData.image[0]);
          return SingleProduct(
              title: title,
              price: price,
              imageSrc: image,
              addToCart: () => fb.addtoCart(),
              addToWishlist: () => fb.addToWishList(),
              pressed: () => productInfo(productData.title, description,
                  category, price, image, context));
        },
        itemCount: products.length,
      );
    });
  }
}
