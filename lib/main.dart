import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/Authen/Register.dart';
import 'package:terms_conditons_app/File_Workout/Files.dart';
import 'package:terms_conditons_app/Home/Home.dart';
import 'Authen/Auth.dart';
import 'File_Workout/Photos_Screen.dart';
import 'File_Workout/View_save.dart';
import 'Server_Service/Observator.dart';
import 'File_Workout/Files.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => Observer(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<Observer>(builder: (context, cart, child) {
        return cart.login_screen
            ? cart.login_check
                ? Home()
                : Auth()
            : cart.register_check == 'true'
                ? Home()
                : Register();
      }),
      routes: {
        '/login': (_) => new Home(),
        '/view': (_) => new View_save(),
        '/photo': (_) => new Photo(),
        '/select_file': (_) => new Select_File(),
      },
    );
  }
}
