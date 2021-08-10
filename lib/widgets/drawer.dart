import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:dsc_shop/screens/about.dart';
import 'package:dsc_shop/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    child: Image.asset(
                      'assets/images/logo.png',
                      // width: 70,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belal Mohamed "),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "belal_ph13@yahoo.com",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                      ))
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
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
            ),
            ListTile(
              leading: Text(
                "Languages",
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.language,
                    size: 30,
                  )),
            ),
            ListTile(
              leading: Text(
                "Sign out",
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 30,
                  )),
            ),
            ListTile(
              leading: Text(
                "About",
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                  icon: Icon(
                    Icons.info,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
