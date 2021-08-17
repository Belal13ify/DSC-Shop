import 'package:dsc_shop/providers/app_provider.dart';
import 'package:dsc_shop/providers/firebase_provider.dart';
import 'package:dsc_shop/providers/jsonData_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dsc_shop/constants.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseProvider>(context);
    // auth.initialize();
    final data = Provider.of<Data>(context);
    String _username = "";
    String _email = "";
    String? _pass1 = "";
    String? _pass2 = "";
    String _password = "";

    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController password1Controller = TextEditingController();
    TextEditingController password2Controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Create a new account',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
                SizedBox(
                  height: 10.0,
                ),
                LocaleText('dsc',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15.0,
                ),
                Text('Register a new Account',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Username required');
                        } else if (value.length < 4) {
                          return "Username Can't be less than 4 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
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
                      height: 10,
                    ),
                    Consumer<Others>(builder: (context, other, child) {
                      return Column(
                        children: [
                          TextFormField(
                            obscureText: other.secured,
                            // keyboardType: TextInputType.visiblePassword,
                            controller: password1Controller,
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
                              _pass1 = value;
                              if (value == null || value.isEmpty) {
                                return ('password required');
                              } else if (value.length < 4) {
                                return "Password Can't be less than 4 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: other.secured,
                            // keyboardType: TextInputType.visiblePassword,
                            controller: password2Controller,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              _pass2 = value;
                              if (value == null || value.isEmpty) {
                                return ('password required');
                              } else if (value.length < 4) {
                                return "Password Can't be less than 4 characters";
                              } else if (_pass1 != _pass2) {
                                return "Password and Confirm password fields don't match";
                              }
                              return null;
                            },
                          ),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          await data.getData();
                          _username = usernameController.text;
                          _email = emailController.text;
                          _password = password1Controller.text;

                          auth.signUp(_username, _email, _password, context);
                          // auth.userSetup(_email);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 5),
                          child: LocaleText(
                            'signUp',
                            style: TextStyle(fontSize: 22),
                          ),
                        )),
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
