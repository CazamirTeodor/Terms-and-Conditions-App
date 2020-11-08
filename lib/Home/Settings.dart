import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[800],
        appBar: AppBar(
          backgroundColor: Colors.yellow[800],
          elevation: 0,
        ),
        body: Consumer<Observer>(builder: (context, cart, child) {
          return Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                          backgroundImage: AssetImage('images/image.png'),
                          radius: 40),
                    ),
                    Divider(
                      height: 40,
                      color: Colors.white,
                    ),
                    Text("NAME:",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Adi Diac",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    Text("Adress:",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        cart.user != null
                            ? Text(cart.user.email,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  letterSpacing: 1,
                                ))
                            : Text('')
                      ],
                    ),
                  ]));
        }));
  }
}
