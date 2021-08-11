import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/jsonData_providerd.dart';
import 'package:flutter/material.dart';
import '../widgets/search.dart';
import 'package:provider/provider.dart';
import '../widgets/product_widget.dart';

class Products extends StatelessWidget {
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
        String title = productData.title;
        dynamic price = productData.price;
        String image = productData.image;

        if (title.length > 20) {
          String strippedtitle = title.substring(0, 15) + '...';
          title = strippedtitle;
        }
        print(productData.image[0]);
        return SingleProduct(title: title, price: price, imageSrc: image);
        // return Text("${products[index].id}");
      },
      itemCount: products.length,
    );
  }
}
