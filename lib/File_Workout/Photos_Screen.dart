import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:terms_conditons_app/File_Workout/take_picture_page.dart';
import 'package:terms_conditons_app/Server_Service/Observator.dart';
import 'dart:io';

import 'View.dart';

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  String _path = null;
  List<_Image> lista_imagini = [];

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file.path;
    });
    if (_path != null) {
      setState(() {
        lista_imagini.add(new _Image(
          path: _path,
        ));
      });
    }
  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    setState(() {
      _path = result;
    });
    if (_path != null) {
      setState(() {
        lista_imagini.add(new _Image(
          path: _path,
        ));
      });
    }
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(children: <Widget>[
                  ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showCamera();
                      },
                      leading: Icon(Icons.photo_camera),
                      title: Text("Take a picture from camera")),
                  ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showPhotoLibrary();
                      },
                      leading: Icon(Icons.photo_library),
                      title: Text("Choose from photo library"))
                ]),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var observer = Provider.of<Observer>(context);
            List<String> paths;
            for (int i = 0; i < lista_imagini.length; i++) {
              paths.add(lista_imagini[i].get_path());
            }
            var date = DateTime.now();
            observer.send_files(paths, "photo", "$date");
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
                  _showOptions(context);
                },
                icon: Icon(Icons.add),
                label: Text('Add a picture'))
          ],
          title: Text('Choose Images'),
          backgroundColor: Colors.yellow[800],
        ),
        body: Container(
            child: ListView.builder(
                itemCount: lista_imagini.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return lista_imagini[index];
                })));
  }
}

class _Image extends StatelessWidget {
  final String path;
  String get_path() {
    return this.path;
  }

  const _Image({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        child: Image(
          image: FileImage(File(path)),
        ));
  }
}
