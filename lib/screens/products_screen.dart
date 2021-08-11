import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/jsonData_providerd.dart';
import 'package:flutter/material.dart';
import '../widgets/search.dart';
import 'package:provider/provider.dart';
import '../widgets/product_widget.dart';
import 'product_details.dart';

class Products extends StatelessWidget {
  void productInfo(
      String title, String description, dynamic price, String image, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetails(
                  title: title,
                  description: description,
                  price: price,
                  image: image,
                )));
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<Data>(context).products;
    return GridView.builder(
      padding: EdgeInsets.all(5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        var productData = products[index];
        // int id = productData.id;
        String title = productData.title;
        String description = productData.description;
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
            pressed: () =>
                productInfo(title, description, price, image, context));
        // return Text("${products[index].id}");
      },
      itemCount: products.length,
    );
  }
}
