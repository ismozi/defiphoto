import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController stageNameController = new TextEditingController();
  TextEditingController stageDescController = new TextEditingController();
  TextEditingController schoolYearBeginController = new TextEditingController();
  TextEditingController schoolYearEndController = new TextEditingController();
  TextEditingController stageBeginController = new TextEditingController();
  TextEditingController stageEndController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController profIdController = new TextEditingController();

  int _indexType;
  List<String> types = ["S", "P", "A"];

  void signUp(
      String id,
      String prenom,
      String nom,
      String courriel,
      String passwd,
      String role,
      String profId,
      String schoolYearBegin,
      String schoolYearEnd,
      String stageName,
      String stageDesc,
      String stageBegin,
      String stageEnd) async {
    var data = {
      "givenId": id,
      "firstName": prenom,
      "lastName": nom,
      "email": courriel,
      "password": passwd,
      "role": role.toString().trim(),
      "profId": profId,
      "schoolYearBegin": schoolYearBegin,
      "schoolYearEnd": schoolYearEnd,
      "stageName": stageName,
      "stageDesc": stageDesc,
      "stageBegin": stageBegin,
      "stageEnd": stageEnd
    };

    var response = await http
        .post("https://defiphoto-api.herokuapp.com/users/signup", body: data);

    print("Done!");
    setState(() {
      Navigator.of(context).pop();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
            ),
            title: Text("Créer un nouveau compte",
                style: TextStyle(fontFamily: 'Arboria'))),
        body: Container(
          color: Color(0xff141a24),
          child: Center(
            child: _isLoading
                ? Center(
                    child: SpinKitDoubleBounce(size: 40, color: Colors.white))
                : ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 8, 15, 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                  child: Text(
                                    "Quel est le type dutilisateur ?",
                                    style: TextStyle(
                                      fontFamily: 'Arboria',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2b3444),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 3),
                                            blurRadius: 5,
                                            color: Colors.black)
                                      ],
                                    ),
                                    child: Column(children: [
                                      Text(
                                          " Étudiant        Professeur        Admin  ",
                                          style: TextStyle(
                                              fontFamily: 'Arboria',
                                              fontSize: 16)),
                                      Row(children: [
                                        SizedBox(width: 28),
                                        Radio(
                                          value: 0,
                                          groupValue: _indexType,
                                          onChanged: (S) {
                                            setState(() {
                                              _indexType = S;
                                              print(types[_indexType].toString().trim());


                                            });
                                          },
                                        ),
                                        SizedBox(width: 62),
                                        Radio(
                                          value: 1,
                                          groupValue: _indexType,
                                          onChanged: (P) {
                                            setState(() {
                                              _indexType = P;
                                              print(types[_indexType].toString().trim());
                                            });
                                          },
                                        ),
                                        SizedBox(width: 53),
                                        Radio(
                                          value: 2,
                                          groupValue: _indexType,
                                          onChanged: (A) {
                                            setState(() {
                                              _indexType = A;
                                              print(types[_indexType].toString().trim());
                                            });
                                          },
                                        ),
                                      ])
                                    ])),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
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
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: firstNameController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Prénom"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: lastNameController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Nom de famille"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: emailController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "E-mail"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: passwdController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Mot-de-Passe"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: profIdController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.description,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Le ID du prof responsable"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: schoolYearBeginController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText:
                                            "Date du début de l'année : j/m/a"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: schoolYearEndController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Date du fin de l'année"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: stageNameController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Nom du stage"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
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
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Description du stage"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: stageBeginController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Date du début du stage"),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          color: Colors.black)
                                    ],
                                  ),
                                  child: TextField(
                                    controller: stageEndController,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.grey),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Date du fin du stage"),
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
                                      if (givenIdController.text.isEmpty ||
                                          firstNameController.text.isEmpty ||
                                          lastNameController.text.isEmpty ||
                                          emailController.text.isEmpty ||
                                          passwdController.text.isEmpty ||
                                         
                                          profIdController.text.isEmpty ||
                                          schoolYearBeginController
                                              .text.isEmpty ||
                                          schoolYearEndController
                                              .text.isEmpty ||
                                          stageNameController.text.isEmpty ||
                                          stageDescController.text.isEmpty ||
                                          stageBeginController.text.isEmpty ||
                                          stageEndController.text.isEmpty) {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Avertissement',
                                                  style: TextStyle(
                                                      fontFamily: 'Arboria')),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                        'Vous devez remplir tout les champs.',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Arboria')),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Arboria')),
                                                  onPressed: () {
                                                    if (this.mounted) {
                                                      setState(() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        setState(() {
                                          _isLoading = true;
                                          signUp(
                                              givenIdController.text
                                                  .toString()
                                                  .trim(),
                                              firstNameController.text
                                                  .toString()
                                                  .trim(),
                                              lastNameController.text
                                                  .toString()
                                                  .trim(),
                                              emailController.text
                                                  .toString()
                                                  .trim(),
                                              passwdController.text
                                                  .toString()
                                                  .trim(),
                                              types[_indexType].toString().trim(),
                                              profIdController.text
                                                  .toString()
                                                  .trim(),
                                              schoolYearBeginController.text
                                                  .toString()
                                                  .trim(),
                                              schoolYearEndController.text
                                                  .toString()
                                                  .trim(),
                                              stageNameController.text
                                                  .toString()
                                                  .trim(),
                                              stageDescController.text
                                                  .toString()
                                                  .trim(),
                                              stageBeginController.text
                                                  .toString()
                                                  .trim(),
                                              stageEndController.text
                                                  .toString()
                                                  .trim());
                                        });
                                      }
                                    },
                                    padding: EdgeInsets.all(16.0),
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
                              ]))
                    ],
                  ),
          ),
        ));
  }
}
