import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/jsonData_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/search.dart';
import 'package:provider/provider.dart';
import '../widgets/product_widget.dart';
import 'product_details.dart';

class Products extends StatelessWidget {
  void productInfo(String title, String description, String category, num price,
      String image, context) {
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
    // List<Product> products = [
    //   Product(
    //       id: 1,
    //       title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    //       price: 15.99,
    //       description: "",
    //       category: "",
    //       image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    //   Product(
    //       id: 2,
    //       title: "Test 1",
    //       price: 15.99,
    //       description: "",
    //       category: "",
    //       image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    //   Product(
    //       id: 3,
    //       title: "Test 2",
    //       price: 15.99,
    //       description: "",
    //       category: "",
    //       image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
    //   Product(
    //       id: 4,
    //       title: "Test 3",
    //       price: 15.99,
    //       description: "",
    //       category: "",
    //       image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
    // ];
    List<Product> products = Provider.of<Data>(context, listen: false).products;
    List<Product> filteredProducts =
        Provider.of<Data>(context, listen: false).searchedProducts;

    return Consumer<FirebaseProvider>(builder: (context, fb, child) {
      return Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(child: Search()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: Text(fb.itemCount.toString()),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      size: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: filteredProducts.isEmpty
                  ? GridView.builder(
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
                        num price = productData.price;
                        String image = productData.image;

                        if (title.length > 20) {
                          String strippedtitle = title.substring(0, 20);
                          title = strippedtitle;
                        }

                        return SingleProduct(
                            title: title,
                            price: price,
                            imageSrc: image,
                            // addToCart: () => fb.addtoCart(productData),
                            addToCart: () => fb.addItem(
                                productData.id.toString(),
                                productData.title,
                                productData.price),
                            addToWishlist: () => fb.addToWishList(),
                            pressed: () => productInfo(productData.title,
                                description, category, price, image, context));
                      },
                      itemCount: products.length,
                    )
                  : ListView.builder(
                      itemBuilder: ((context, index) {
                        var productData = filteredProducts[index];

                        String title = productData.title;
                        String description = productData.description;
                        String category = productData.category;
                        num price = productData.price;
                        String image = productData.image;

                        if (title.length > 20) {
                          String strippedtitle = title.substring(0, 20);
                          title = strippedtitle;
                        }

                        return SingleProduct(
                            title: title,
                            price: price,
                            imageSrc: image,
                            // addToCart: () => fb.addtoCart(productData),
                            addToCart: () => fb.addItem(
                                productData.id.toString(),
                                productData.title,
                                productData.price),
                            addToWishlist: () => fb.addToWishList(),
                            pressed: () => productInfo(productData.title,
                                description, category, price, image, context));
                      }),
                      itemCount: filteredProducts.length)),
        ],
      );
    });
  }
}
