import 'package:dsc_shop/providers/jsonData_provider.dart';
import 'package:dsc_shop/providers/navScreenProvider.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/themeProvider.dart';
import 'package:dsc_shop/screens/home_screen.dart';
import 'package:dsc_shop/screens/shoppingCart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/app_provider.dart';
import 'package:flutter_locales/flutter_locales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(['en', 'ar']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
            create: (context) => NavigationProvider()),
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
          },
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context, listen: false).isActive
              ? Provider.of<ThemeProvider>(context).darkTheme
              : Provider.of<ThemeProvider>(context).lightTheme),
    );
  }
}
