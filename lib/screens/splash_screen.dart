import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context).checkDarkMode();
    return SplashScreenView(
      navigateRoute: Login(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/logo.png",
      backgroundColor: Colors.white,
      text: 'Welcome to DSC Shop',
      textStyle: TextStyle(
          fontSize: 28, color: Colors.blue, fontWeight: FontWeight.bold),
    );
  }
}
