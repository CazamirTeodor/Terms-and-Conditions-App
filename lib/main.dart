import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terms_conditons_app/Home.dart';
import 'package:terms_conditons_app/Register.dart';

import 'Auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
