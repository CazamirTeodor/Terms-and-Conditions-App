import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/File_Workout/Files.dart';
import 'package:terms_conditons_app/File_Workout/Photos_Screen.dart';

import 'package:terms_conditons_app/Home/Settings.dart';
import 'package:terms_conditons_app/Home/Storage.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  List<Widget> widgets = [Storage(), Settings()];
  int _curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _curentIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.yellow[800],
              focusColor: Colors.yellow[900],
              onPressed: () => {_showMyDialog(context)},
              child: Icon(Icons.add),
            )
          : null,
      backgroundColor: Colors.blue[400],
      body: widgets[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.yellow[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              title: Text(
                "Settings",
              ))
        ],
        currentIndex: _curentIndex,
        onTap: (value) => {
          setState(() => {_curentIndex = value})
        },
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow[800],
        title: Text(
          'Select a option',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () =>
                      {Navigator.pushReplacementNamed(context, "/photo")},
                  icon: Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: Text(
                    'Take a picture',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 20,
              ),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/select_file");
                  },
                  icon: Icon(
                    Icons.file_upload,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: Text(
                    'Upload a file',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Approve',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
