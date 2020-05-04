import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading1 = false;

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
          loginUser(id, password);
          _isLoading = false;
          if (userData["role"] == "S") {
            Navigator.pushReplacementNamed(context, '/mainPageStudent',
                arguments: {
                  'givenId': userData["givenId"],
                  'firstName': userData["firstName"],
                  'lastName': userData["lastName"],
                  'email': userData["email"],
                  'role': userData["role"],
                  'profId': userData["profId"],
                  'stageName': userData['stageName'],
                  'yearDebut': userData['schoolYearBegin'],
                  'yearFin': userData['schoolYearEnd'],
                  'questionEleve': false
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
                });
          }
          print(userData['profId']);
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
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('givenId');
    final String password = prefs.getString('password');

    if (userId != null && password != null) {
      setState(() {
        signIn(userId, password);
      });
      return;
    } else {
      setState(() {
        isLoading1 = true;
      });
    }
  }

  Future<Null> loginUser(String id, String pssword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('givenId', id);
    prefs.setString('password', pssword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isLoading1
            ? Container(
                color: Color(0xff141a24),
                child: ListView(children: <Widget>[
                  SizedBox(
                      height: (MediaQuery.of(context).size.height / 2) - (169.86)),
                  Center(
                      child: Image.asset(
                    'assets/logo.png',
                    width: 203.65,
                    height: 169.86
                  )),
                  SizedBox(height: 75),
                  Center(child:SpinKitThreeBounce(
                              size: 40, color: Colors.grey))
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
