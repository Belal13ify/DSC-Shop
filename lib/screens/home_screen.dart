import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/navScreenProvider.dart';
import 'package:dsc_shop/screens/products_screen.dart';
import 'package:dsc_shop/screens/shoppingCart_screen.dart';
import 'package:dsc_shop/screens/wishlist_screen.dart';
import 'package:dsc_shop/widgets/botom_navigation.dart';
import 'package:dsc_shop/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nav = Provider.of<NavigationProvider>(context);
    var fb = Provider.of<FirebaseProvider>(context);

    List<Widget> selectedScreen = [Products(), Wishlist(), ShoppingCart()];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: LocaleText("dsc"),
        actions: [
          GestureDetector(
            onTap: () => Provider.of<NavigationProvider>(context, listen: false)
                .onScreenTaped(2),
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      fb.itemCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(child: selectedScreen[nav.selectedScreen]),
      drawer: DrawerSection(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
