import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/File_Workout/View.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final String user = "Adi";
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: Colors.yellow[800],
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.yellow[700],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.yellow[800],
          title: Text('Welcome back'),
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.file_present),
              label: Text('get storage'),
              onPressed: () {
                Provider.of<Observer>(context).take_files();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        ),
        body: Column(children: [
          Column(
            children: [
              TopContainer(
                height: 100,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 35.0,
                              backgroundImage: AssetImage('images/image.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Adi Diac',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.yellow[900],
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Down here is your storage\nClick plus for add a new file',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            child: Consumer<Observer>(builder: (context, cart, child) {
              return cart.lista_fisiere.length == 0
                  ? Text('')
                  : ListView.builder(
                      itemCount: cart.lista_fisiere.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          child: new Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.yellow[800],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    cart.lista_fisiere[index].name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FlatButton(
                                          color: Colors.yellow[900],
                                          textColor: Colors.white,
                                          disabledColor: Colors.blue[700],
                                          disabledTextColor: Colors.white,
                                          padding: EdgeInsets.all(8.0),
                                          splashColor: Colors.blueAccent,
                                          onPressed: () {
                                            var observer =
                                                Provider.of<Observer>(context);
                                            observer.get_fisier(index);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => View(),
                                                ));
                                          },
                                          child: Text("See")),
                                      FlatButton(
                                          color: Colors.yellow[900],
                                          textColor: Colors.white,
                                          disabledColor: Colors.blue[700],
                                          disabledTextColor: Colors.white,
                                          padding: EdgeInsets.all(8.0),
                                          splashColor: Colors.blueAccent,
                                          onPressed: () {
                                            var observer =
                                                Provider.of<Observer>(context);
                                            observer.delete_fisier(index);
                                          },
                                          child: Text("Delete"))
                                    ],
                                  )
                                ],
                              )),
                        );
                      });
            }),
          ),
        ]));
  }
}

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer({this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
