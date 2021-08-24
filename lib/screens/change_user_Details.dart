import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../constants.dart';
import 'package:provider/provider.dart';
import '../providers/firebase_provider.dart';

class ChangeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fb = Provider.of<FirebaseProvider>(context);
    String newUserName;
    TextEditingController usernameController = TextEditingController();
    final _key = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: LocaleText(
            "edit",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  if (!_key.currentState!.validate()) {
                    return;
                  } else if (usernameController.text == "") {
                    newUserName = fb.username;
                    Navigator.of(context).pop();
                  } else {
                    newUserName = usernameController.text;
                    fb.changeName(newUserName);
                    Navigator.of(context).pop();
                  }
                },
                child: LocaleText(
                  "save",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ))
          ],
          centerTitle: true,
          backgroundColor: Color(0xff0C1B32),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.infinity,
                    color: Color(0xff0C1B32),
                    // color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        CircleAvatar(
                          // backgroundColor: Color(0xff0C1B32),
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(fb.userPhoto),
                          radius: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () => fb.changePhoto(),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: LocaleText(
                              'pick',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: 'New username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              newUserName = fb.username;
                            } else if (value.length < 4) {
                              return "Username Can't be less than 4 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        LocaleText(
                          'profileText',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}
