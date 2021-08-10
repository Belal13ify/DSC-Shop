import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About our DSC Shop APP"),
          centerTitle: true,
        ),
        body:
            // Center(child: Text("This is test")
            Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: ListView(
            children: [
              ListTile(
                leading: Text(
                  "App name: ",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  "DSC Shop",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: Text(
                  "Version: ",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  "1.0",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: Text(
                  "Author: ",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  "Belal Mohamed El Sharkawy",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ));
    // );
  }
}
