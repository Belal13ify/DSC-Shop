import 'package:dsc_shop/providers/dropDown_provider.dart';
import 'package:dsc_shop/providers/jsonData_provider.dart';
import 'package:dsc_shop/providers/navScreenProvider.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:dsc_shop/screens/change_user_Details.dart';
import 'package:dsc_shop/screens/home_screen.dart';
import 'package:dsc_shop/screens/login_screen.dart';
import 'package:dsc_shop/screens/register_screen.dart';
import 'package:dsc_shop/screens/shoppingCart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/app_provider.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(['en', 'ar']);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}
/*

====================================please Read Before using the app=====================
                                       All bonus Done
DSC Shop has the following Features 

1- Multi Languages Support (English and Arabic), user can switch between languages and save it for next login with no changes
2- Multi Users Registration and login, Every user has own login, Favourites, Cart products, firebase name,email and photo

3- Dark mode enabled and set with shared preferences for the device
4- image picker to pick a photo from the Galery and save into firebase, can change whenever the user changes it and saved in firebase for next login 
5- Home, Favourite, Cart pages, can add, delete, read, and update products from either favourites and cart screens and update the changes in firebase
6- every product has title, price, quantity, descriptions and updating in firebase

7-any user register can has a default profile photo but the user can change the profile photo and saves in firebase for next logins

8- cart page showing all items added, with their total price, you can increase , decrease your quantity as you want and can swipe left or right to delete and all changes will reflect on firebase
9- can save favourite and reflect on firebase, with eiher add or delete


10- no statful widget at all, only used provider


*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
            create: (context) => NavigationProvider()),
        ChangeNotifierProvider<DropDownProvider>(
            create: (context) => DropDownProvider()),
        ChangeNotifierProvider<FirebaseProvider>(
            create: (context) => FirebaseProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<Others>(create: (context) => Others()),
        ChangeNotifierProvider<Data>(create: (context) => Data()),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            'home': (context) => HomeScreen(),
            'cart': (context) => ShoppingCart(),
            'login': (context) => Login(),
            'signup': (context) => Register(),
            'edit': (context) => ChangeDetail()
          },
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).isActive
              ? Provider.of<ThemeProvider>(context).darkTheme
              : Provider.of<ThemeProvider>(context).lightTheme),
    );
  }
}
