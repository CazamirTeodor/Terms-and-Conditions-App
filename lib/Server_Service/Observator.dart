import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:terms_conditons_app/Server_Service/Fisier.dart';
import 'package:terms_conditons_app/Server_Service/User.dart';

class Observer extends ChangeNotifier {
  User user;
  String register_check;
  String received;
  bool login_check;
  bool login_screen;
  List<Fisier> lista_fisiere;
  Fisier current_fisier;
  Fisier fisier_to_save;
  Socket socket;
  Observer() {
    current_fisier = null;
    lista_fisiere = [];
    login_screen = true;
    login_check = false;
    register_check = '';
    user = null;
    connect();
  }
  void get_fisier(int index) {
    Map<String, dynamic> file = {};
    file["type"] = "getSpecificDocument";
    file["filename"] = lista_fisiere[index].name;
    String text = json.encode(file);
    socket.add(utf8.encode(text));
    socket.listen((List<int> event) {
      String received = utf8.decode(event);
      current_fisier = Fisier(lista_fisiere[index].name,
          json.decode(received)["summary"], json.decode(received)["original"]);
    });
  }

  void save_fisier() {
    Map<String, dynamic> file = {};
    file["type"] = "save";
    String text = json.encode(file);
    socket.add(utf8.encode(text));
    socket.listen((List<int> event) {
      String received = utf8.decode(event);
      print(json.decode(received)["type"]);
      lista_fisiere.add(Fisier(fisier_to_save.name, '', ''));
    });
  }

  void send_files(List<String> paths, String type, String filename) {
    Map<String, dynamic> file = {};
    file["type"] = "send";
    file["extension"] = type;
    file["filename"] = filename;
    List lista_fis = [];
    for (int i = 0; i < paths.length; i++) {
      lista_fis.add(File(paths[i]).readAsBytesSync().toString().length);
    }
    file["dimensions"] = lista_fis;
    String text = json.encode(file);
    print(text);
    socket.add(utf8.encode(text));
    String texti = File(paths[0]).readAsBytesSync().toString();
    print(texti);
    socket.add(utf8.encode(texti));
  }

  void connect() async {
    socket = await Socket.connect('192.168.43.187', 2400);
    print(socket.address);
  }

  void set_login_screen(bool value) {
    login_screen = value;
    notifyListeners();
  }

  void logout() {}
  void register(String name, String email, String password) {
    print(name + " " + email + " " + " something " + password);
    Map<String, dynamic> registration = {
      "type": "register",
      "name": name,
      "email": email,
      "password": password
    };
    print("text");
    String text = json.encode(registration);
    print(text);
    socket.add(utf8.encode(text));
    socket.listen((List<int> event) {
      String received = utf8.decode(event);
      print(received);
      user = new User(name, email, password);
      register_check = 'true';
      login_check = false;
      print("e bine");
      notifyListeners();
    });
  }

  void delete_fisier(int index) {
    Map<String, dynamic> file = {};
    file["type"] = "delete";
    file["filename"] = lista_fisiere[index].name;
    file["email"] = user.email;
    String text = json.encode(file);
    socket.add(utf8.encode(text));
    lista_fisiere.removeAt(index);
    notifyListeners();
  }

  void auth(String email, String password) {
    Map<String, dynamic> auth = {
      "type": "login",
      'email': email,
      "password": password,
    };
    String text = json.encode(auth);
    socket.add(utf8.encode(text));
    socket.listen((List<int> event) {
      received = utf8.decode(event);
      print(received);
      if (json.decode(received)["type"] == "send") {
        fisier_to_save = Fisier('', json.decode(received)["summary"],
            json.decode(received)["original"]);
      }
      if (json.decode(received)["type"] == "getFilenames") {
        for (int i = 0; i < json.decode(received)["message"].length; i++) {
          Fisier fisier =
              new Fisier(json.decode(received)["message"][i], '', '');
          lista_fisiere.add(fisier);
        }
        print(lista_fisiere);
        notifyListeners();
      }
      if (json.decode(received)["message"] == "OK") {
        user = new User(json.decode(received)['name'], email, password);
        login_check = true;
        print("something");

        notifyListeners();
      } else {
        print("Aici nu e bine");
      }
    }, onDone: () => {print("Everhtinok")});
  }

  void take_files() {
    print("intra aici");
    Map<String, dynamic> file = {};
    file["type"] = "getFilenames";
    file["email"] = user.email;
    String text = json.encode(file);
    socket.add(utf8.encode(text));
    print("trimite?");
    socket.listen((List<int> event) {
      received = utf8.decode(event);
      for (int i = 0; i < json.decode(received)["message"].length; i++) {
        Fisier fisier = new Fisier(json.decode(received)["message"][i], '', '');
        lista_fisiere.add(fisier);
      }
      print(lista_fisiere);
      notifyListeners();
    });
  }
}
