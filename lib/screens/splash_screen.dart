import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
