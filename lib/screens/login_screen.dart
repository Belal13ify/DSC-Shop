import 'package:flutter/material.dart';
import 'package:dsc_shop/constants.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool secured = false;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Email required');
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      obscureText: secured,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // setState(() {
                            //   secured = !secured;
                            // });
                          },
                          icon: Icon(
                            secured
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
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.orange,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              // openAlert();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              // openAlert();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
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
