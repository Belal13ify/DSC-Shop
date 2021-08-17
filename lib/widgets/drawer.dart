import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:dsc_shop/screens/about.dart';
import 'package:dsc_shop/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dropdown.dart';
import 'package:flutter_locales/flutter_locales.dart';
import '../providers/firebase_provider.dart';

class DrawerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fb = Provider.of<FirebaseProvider>(context);
    return Drawer(
      child: Material(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 37,
                        child: Image.asset(
                          'assets/images/logo.png',
                          // width: 70,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(fb.username),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        fb.userEmail,
                        style: TextStyle(fontSize: 15),
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
              title: LocaleText(
                'darkmode',
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
                leading: LocaleText(
                  "language",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: DropDown()),
            ListTile(
              leading: LocaleText(
                "signOut",
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
              leading: LocaleText(
                "about",
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
