import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'mainPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

check() async{
  if(readf()!=null||readf2()!=null)
  {var id = await readf();
  var pass = await readf2();
  print(id);
  print(pass);
  print("Saved!");}
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  TextEditingController givenId = new TextEditingController();
  TextEditingController passwd = new TextEditingController();

  void signIn(String id, String password) async {
    var data = {
      "givenId": id.trim().toString(),
      "password": password.trim().toString()
    };
    var response = await http
        .post("https://defiphoto-api.herokuapp.com/users/login", body: data);
    if (response.statusCode == 200) {
      Map authData = json.decode(response.body);
      var token = authData["token"];
      var userData = Jwt.parseJwt(token);

      if (this.mounted) {
        setState(() {
          _isLoading = false;
          if (userData["role"] == "S" || userData["role"] == "P") {
            Navigator.pushReplacementNamed(context, '/mainPage', arguments: {
              'givenId': userData["givenId"],
              'firstName': userData["firstName"],
              'lastName': userData["lastName"],
              'email': userData["email"],
              'role': userData["role"],
              'stageName': userData['stageName'],
              'yearDebut': userData['schoolYearBegin'],
              'yearFin': userData['schoolYearEnd'],
            });
          }
          if (userData["role"] == "A") {
            ////main page pour l'admin
          }
        });
      }
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur', style: TextStyle(fontFamily: 'Arboria')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Mauvais ID ou Mot de passe!',
                      style: TextStyle(fontFamily: 'Arboria')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child:
                    Text('Re-essayer', style: TextStyle(fontFamily: 'Arboria')),
                onPressed: () {
                  if (this.mounted) {
                    setState(() {
                      _isLoading = false;
                      Navigator.of(context).pop();
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xff141a24),
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: _isLoading
            ? Center(child: SpinKitDoubleBounce(size: 40, color: Colors.white))
            : ListView(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 181,
                      height: 151.0,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  new Card(
                      color: Color(0xFF222b3b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                      ),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 45, 15, 15),
                          child: Column(children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.black)
                                ],
                              ),
                              child: TextField(
                                controller: givenId,
                                style: new TextStyle(
                                    fontSize: 20, color: Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "ID d'utilisateur"),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.black)
                                ],
                              ),
                              child: TextField(
                                controller: passwd,
                                style: new TextStyle(
                                    fontSize: 20, color: Colors.black),
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Mot-de-passe"),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  _isLoading = true;
                                  setState(() {
                                    signIn(givenId.text, passwd.text);
                                  });
                                  write(givenId.text);
                                  write2(passwd.text);
                                  check();
                                },
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xff444d5d),
                                child: Text(
                                  'CONNEXION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontFamily: 'Arboria',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ])))
                ],
              ),
      ),
    ));
  }
}

Future<String> get localpath async {
  final path = await getApplicationDocumentsDirectory();
  return path.path;
}

Future<File> get localfile async {
  final file = await localpath;
  return new File("$file/data.txt");
}

Future<File> get localfile2 async {
  final file2 = await localpath;
  return new File("$file2/data2.txt");
}

Future<File> write(String value) async {
  final file = await localfile;
  return file.writeAsString(value);
}

Future<File> write2(String value) async {
  final file2 = await localfile2;
  return file2.writeAsString(value);
}

Future<String> readf() async {
  try {
    final file = await localfile;
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "vide";
  }
}

Future<String> readf2() async {
  try {
    final file2 = await localfile2;
    String data2 = await file2.readAsString();
    return data2;
  } catch (e) {
    return "vide";
  }
}
