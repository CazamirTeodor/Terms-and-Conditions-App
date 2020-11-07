import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terms_conditons_app/Settings.dart';
import 'package:terms_conditons_app/Storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgets = [Storage(), Settings()];
  List<Widget> widget_float = [
    FloatingActionButton(
      onPressed: () => {},
      child: Icon(Icons.add),
    ),
    null,
  ];
  int _curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget_float[_curentIndex],
      backgroundColor: Colors.blue[400],
      body: widgets[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Settings"))
        ],
        currentIndex: _curentIndex,
        onTap: (value) => {
          setState(() => {_curentIndex = value})
        },
      ),
    );
  }
}
