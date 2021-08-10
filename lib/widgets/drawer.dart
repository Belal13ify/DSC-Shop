import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
                Text(
                  'DSC Shop',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),

            //Dark mode switch controller with GETX
            trailing: Switch(
                activeColor: Colors.green,
                // value: controler.isActive,
                value: Provider.of<ThemeProvider>(context).isActive,
                onChanged: (val) async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isDark', val);

                  Provider.of<ThemeProvider>(context, listen: false)
                      .checkDarkMode();
                }),
          )
        ],
      ),
    );
  }
}
