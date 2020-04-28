import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ajoutUtilisateur extends StatefulWidget {
  @override
  _AjoutUtilisateurState createState() => _AjoutUtilisateurState();
}

class _AjoutUtilisateurState extends State<ajoutUtilisateur> {
  bool _isLoading = false;
  TextEditingController givenIdController = new TextEditingController();
  TextEditingController passwdController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController courrielController = new TextEditingController();
  TextEditingController stageController = new TextEditingController();
  TextEditingController stageDescController = new TextEditingController();

  void signUp(String id, String prenom, String nom, String courriel,
      String stage, String stageDesc) async {
    String passwd = 'oui123';
    String role = 'S';
    String debut = '2019';
    String fin = '2020';

    print(id.trim().toString());
    print(prenom.trim().toString());
    print(nom.trim().toString());
    print(courriel.trim().toString());
    print(stage.trim().toString());
    print(stageDesc.trim().toString());

    var data = {
      "givenId": id.trim().toString(),
      "firstName": prenom.trim().toString(),
      "lastName": nom.trim().toString(),
      "email": courriel.trim().toString(),
      "password": passwd.trim().toString(),
      "role": role.trim().toString(),
      "stageName": stage.trim().toString(),
      "stageDesc": stageDesc.trim().toString(),
    };

    var response = await http.post("https://defiphoto-api.herokuapp.com/users",
        body: data);
    if (response.statusCode == 200) {
      print("Done!");
      setState(() {
        Navigator.of(context).pop();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xff141a24),
      child: Center(
        child: _isLoading
            ? Center(child: SpinKitDoubleBounce(size: 40, color: Colors.white))
            : ListView(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
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
                                controller: givenIdController,
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
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                                controller: prenomController,
                                style: new TextStyle(
                                    fontSize: 20, color: Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 20.0, color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Prénom"),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                                controller: nomController,
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
                                    hintText: "Nom"),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                                controller: courrielController,
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
                                    hintText: "Adresse courriel"),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                                controller: stageController,
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
                                    hintText: "Nom de stage"),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              alignment: Alignment.center,
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
                                controller: stageDescController,
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
                                    hintText: "Description de stage"),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  _isLoading = true;
                                  setState(() {
                                    setState(() {
                                      signUp(
                                          givenIdController.text
                                              .toString()
                                              .trim(),
                                          prenomController.text
                                              .toString()
                                              .trim(),
                                          nomController.text.toString().trim(),
                                          courrielController.text
                                              .toString()
                                              .trim(),
                                          stageController.text
                                              .toString()
                                              .trim(),
                                          stageDescController.text
                                              .toString()
                                              .trim());
                                    });
                                  });
                                },
                                padding: EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xff444d5d),
                                child: Text(
                                  'CRÉER LE COMPTE',
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
