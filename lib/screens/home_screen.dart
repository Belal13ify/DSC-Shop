import 'package:dsc_shop/providers/navScreenProvider.dart';
import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:dsc_shop/screens/products_screen.dart';
import 'package:dsc_shop/screens/shopping_screen.dart';
import 'package:dsc_shop/screens/wishlist_screen.dart';
import 'package:dsc_shop/widgets/botom_navigation.dart';
import 'package:dsc_shop/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products;
  HomeScreen({required this.products});
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context).checkDarkMode();
    List<Widget> selectedScreen = [
      Products(products: products),
      Wishlist(),
      ShoppingCart()
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("DSC Shop"),
      ),
      body: SafeArea(
          child: selectedScreen[
              Provider.of<NavigationProvider>(context).selectedScreen]),
      drawer: DrawerSection(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
