import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    prefixIcon: Icon(
      Icons.account_circle,
      color: Colors.grey,
    ),
    labelText: 'Label',
    labelStyle: TextStyle(fontSize: 20));

const Widget KRequired = Text('Required',
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ));
