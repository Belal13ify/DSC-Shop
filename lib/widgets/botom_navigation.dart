import 'package:flutter/material.dart';

//Bottom Navigation bar widget
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 16,
        unselectedFontSize: 14,
        backgroundColor: Color(0xff043551),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 35,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_shopping_cart,
              size: 35,
            ),
            label: 'Shopping Cart',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.white,
        onTap: (index) {
          // controller.onItemTapped(index);
        },
      ),
    );
  }
}
