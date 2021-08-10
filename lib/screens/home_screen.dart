import 'package:dsc_shop/screens/products.dart';
import 'package:dsc_shop/screens/shopping_screen.dart';
import 'package:dsc_shop/screens/wishlist_screen.dart';
import 'package:dsc_shop/widgets/botom_navigation.dart';
import 'package:dsc_shop/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> selectedScreen = [Products(), Wishlist(), ShoppingCart()];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DSC Shop"),
      ),
      body: SafeArea(child: selectedScreen[0]),
      drawer: DrawerSection(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
