import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: LocaleText("appinfo"),
          centerTitle: true,
        ),
        body:
            // Center(child: Text("This is test")
            Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: ListView(
            children: [
              ListTile(
                leading: LocaleText(
                  "app",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: LocaleText(
                  "dsc",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: LocaleText(
                  "version",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  "1.0",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: LocaleText(
                  "developer",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: LocaleText(
                  "authorname",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ));
    // );
  }
}
