import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Classe de la page de connexion
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Variables booléenne responsable des loading
  bool isLoading1 = true;
  bool _isLoading = false;

  //Controllers pour les TextFields
  TextEditingController givenId = new TextEditingController();
  TextEditingController passwd = new TextEditingController();

  //Variable booléenne qui défini si l'appareil a accès à internet
  bool _hasNetworkConnection;

  //Fonction de base qui connecte l'utilisateur 
  void signIn(String id, String password) async {
    var response;
    var data = {
      "givenId": id.trim().toString(),
      "password": password.trim().toString()
    };

    try {
      response = await http
          .post("https://defiphoto-api.herokuapp.com/users/login", body: data);
      if (response.statusCode == 200) {
        Map authData = json.decode(response.body);
        var token = authData["token"];
        var userData = Jwt.parseJwt(token);

        if (this.mounted) {
          setState(() {
            loginUser(userData, password);
            _isLoading = false;
            if (userData["role"] == "S") {
              Navigator.pushReplacementNamed(context, '/mainPageEleve',
                  arguments: {
                    'givenId': userData["givenId"],
                    'firstName': userData["firstName"],
                    'lastName': userData["lastName"],
                    'email': userData["email"],
                    'role': userData["role"],
                    'profId': userData["profId"],
                    'stageName': userData['stageName'],
                    'stageDesc' : userData['stageDesc'],
                    'yearDebut': userData['schoolYearBegin'],
                    'yearFin': userData['schoolYearEnd'],
                    'questionEleve': false,
                    'connection': _hasNetworkConnection,
                    'nouvQuestion': false,
                    'isTeacher':false
                  });
            }
            if (userData["role"] == "A") {
              Navigator.pushReplacementNamed(context, '/mainPageAdmin',
                  arguments: {
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
            if (userData["role"] == "P") {
              Navigator.pushReplacementNamed(context, '/mainPageProf',
                  arguments: {
                    'givenId': userData["givenId"],
                    'firstName': userData["firstName"],
                    'lastName': userData["lastName"],
                    'email': userData["email"],
                    'role': userData["role"],
                    'stageName': userData['stageName'],
                    'yearDebut': userData['schoolYearBegin'],
                    'yearFin': userData['schoolYearEnd'],
                    'connection': _hasNetworkConnection
                  });
            }
            print(userData['profId']);
          });
        }
      }//Message d'erreur s'il les informations sont mauvaises
      else {
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
                  child: Text('Re-essayer',
                      style: TextStyle(fontFamily: 'Arboria')),
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
      //Message d'erreur s'il n'y a pas de connexion 
    } catch (e, stackTrace) {
      if (e is SocketException) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Échec de connexion',
                  style: TextStyle(fontFamily: 'Arboria')),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("Vous n'avez pas de connexion internet",
                        style: TextStyle(fontFamily: 'Arboria')),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Re-essayer',
                      style: TextStyle(fontFamily: 'Arboria')),
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
  }

  //Fonction init pour qui est appelé en premier de tout
  @override
  void initState() {
    super.initState();

    _hasNetworkConnection = false;

    _updateConnectivity();
    print("allo");
  }
  
  //Fonction qui vérifie s'il y a une connexion internet
  void _updateConnectivity() async {
    if (this.mounted) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            _hasNetworkConnection = true;
            autoLogIn();
          });
        } else {
          setState(() {
            _hasNetworkConnection = false;
            autoLogIn();
          });
        }
      } on SocketException catch (_) {
        setState(() {
          _hasNetworkConnection = false;
          autoLogIn();
        });
      }
    }
  }
  
  //Fonction qui permet de connecter automatiquement
  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('givenId');
    final String password = prefs.getString('password');
    final String firstName = prefs.getString('firstName');
    final String lastName = prefs.getString('lastName');
    final String email = prefs.getString('email');
    final String role = prefs.getString('role');
    final String stageName = prefs.getString('stageName');
    final String yearDebut = prefs.getString('yearDebut');
    final String yearFin = prefs.getString('yearFin');
    print(_hasNetworkConnection);

    if (userId != null &&
        password != null &&
        !_hasNetworkConnection &&
        role == 'S') {
      if (this.mounted) {
        setState(() {
          Navigator.pushReplacementNamed(context, '/mainPageEleve', arguments: {
            'givenId': userId,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'role': role,
            'stageName': stageName,
            'schoolYearBegin': yearDebut,
            'yearFin': yearFin,
            'questionEleve': false,
            'connection': false,
            'nouvQuestion': false,
            'isTeacher':false
          });
        });
      }
    } else if (userId != null &&
        password != null &&
        !_hasNetworkConnection &&
        role == 'P') {
      if (this.mounted) {
        setState(() {
          Navigator.pushReplacementNamed(context, '/mainPageProf', arguments: {
            'givenId': userId,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'role': role,
            'stageName': stageName,
            'yearDebut': yearDebut,
            'yearFin': yearFin,
            'questionEleve': false,
            'connection': false
          });
        });
      }
    } else if (userId != null && password != null && _hasNetworkConnection) {
      if (this.mounted) {
        setState(() {
          signIn(userId, password);
        });
        return;
      }
    } else if (userId == null && password == null) {
      if (this.mounted) {
        setState(() {
          isLoading1 = false;
        });
      }
    }
  }
  
  //Fonction qui enregistre les informations dans le téléphone lors de la connexion
  Future<Null> loginUser(var userData, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('givenId', userData["givenId"]);
    prefs.setString('password', password);
    prefs.setString('firstName', userData["firstName"]);
    prefs.setString('lastName', userData["lastName"]);
    prefs.setString('email', userData["email"]);
    prefs.setString('role', userData["role"]);
    prefs.setString('stageName', userData["stageName"]);
    prefs.setString('yearDebut', userData["schoolYearBegin"]);
    prefs.setString('yearFin', userData["schoolYearEnd"]);
  }

  //Fonction qui construit l'aspect visuel de l'application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading1
            ? Container(
                color: Color(0xff141a24),
                child: ListView(children: <Widget>[
                  SizedBox(
                      height:
                          (MediaQuery.of(context).size.height / 2) - (169.86)),
                  Center(
                      child: Image.asset('assets/logo.png',
                          width: 203.65, height: 169.86)),
                  SizedBox(height: 75),
                  Center(
                      child: SpinKitThreeBounce(size: 40, color: Colors.grey))
                ]))
            : Container(
                color: Color(0xff141a24),
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: _isLoading
                      ? Center(
                          child: SpinKitDoubleBounce(
                              size: 40, color: Colors.white))
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
                                    padding:
                                        EdgeInsets.fromLTRB(15, 45, 15, 15),
                                    child: Column(children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.grey),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                              fontSize: 20,
                                              color: Colors.black),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.grey),
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
                                        padding: EdgeInsets.symmetric(
                                            vertical: 25.0),
                                        width: double.infinity,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () {
                                            _isLoading = true;
                                            setState(() {
                                              signIn(givenId.text, passwd.text);
                                            });
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
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
