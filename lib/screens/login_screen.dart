import 'package:dsc_shop/models/product_model.dart';
import 'package:dsc_shop/providers/app_provider.dart';
import 'package:dsc_shop/providers/jsonData_provider.dart';
import 'package:dsc_shop/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dsc_shop/constants.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    String _email = "";
    String _password = "";
    List<Product> products = [];
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('DSC Shop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40.0,
                ),
                Text('Sign up or Login to an existing account',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Email required');
                        } else if (!value.contains("@")) {
                          return "Not a valid Email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Consumer<Others>(builder: (context, other, child) {
                      return TextFormField(
                        obscureText: other.secured,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              other.togglePassword();
                            },
                            icon: Icon(
                              other.secured
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off,
                              color: Colors.blue,
                              size: 22,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('password required');
                          } else if (value.length < 4) {
                            return "Password Can't be less than 4 characters";
                          }
                          return null;
                        },
                      );
                    }),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.orange,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _email = emailController.text;
                              _password = passwordController.text;

                              auth
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) => {
                                        Navigator.of(context).pushNamed('home')
                                      });
                              // openAlert();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: LocaleText(
                                'signUp',
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              // openAlert();
                              _email = emailController.text;
                              _password = passwordController.text;
                              await Provider.of<Data>(context, listen: false)
                                  .getData();
                              products =
                                  Provider.of<Data>(context, listen: false)
                                      .products;
                              auth
                                  .signInWithEmailAndPassword(
                                      email: _email, password: _password)
                                  .then((_) => {
                                        Navigator.of(context).pushNamed('home'),
                                      });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: LocaleText(
                                'login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
