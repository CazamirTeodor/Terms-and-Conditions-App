import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/Authen/Register.dart';
import 'package:terms_conditons_app/Home/Home.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 130, 20, 0),
        child: Column(
          children: <Widget>[
            Text(
              "Terms and Condition\n App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 60,
            ),
            Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Email"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        email = value;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Password"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        password = value;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        color: Colors.yellow[900],
                        textColor: Colors.white,
                        disabledColor: Colors.blue[700],
                        disabledTextColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            print(email + " " + password);
                            var observer = Provider.of<Observer>(context);
                            observer.auth(email, password);
                          }
                        },
                        child: Text('Login'),
                      ),
                      FlatButton(
                        color: Colors.yellow[900],
                        textColor: Colors.white,
                        disabledColor: Colors.blue[700],
                        disabledTextColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          var observer = Provider.of<Observer>(context);
                          observer.set_login_screen(false);
                        },
                        child: Text('Register'),
                      ),
                    ],
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
