import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/File_Workout/View.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';

class Select_File extends StatefulWidget {
  @override
  _Select_FileState createState() => _Select_FileState();
}

class _Select_FileState extends State<Select_File> {
  File result = null;
  String path = null;
  void _get_file() async {
    result = await FilePicker.getFile(type: FileType.any);
    setState(() {
      path = result.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(60, 60, 30, 0),
        child: result == null
            ? Text('')
            : Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
                      child: Text(
                        basename(path),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )
                  ],
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var observer = Provider.of<Observer>(context);
          List<String> paths = [path];
          observer.send_files(paths, "pdf", basename(path));
          Navigator.pushReplacementNamed(context, "/view");
        },
        backgroundColor: Colors.yellow[800],
        focusColor: Colors.yellow[900],
        child: Icon(Icons.send),
      ),
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () {
                _get_file();
              },
              icon: Icon(Icons.add),
              label: Text('Select file'))
        ],
        title: Text('Choose file'),
        backgroundColor: Colors.yellow[800],
      ),
    );
  }
}
