import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:test_flutter/screens/pageQuestion.dart';
import '../main.dart';
import 'customDrawer.dart';

//Classe de la page principale des enseignats
class mainPageProf extends StatefulWidget {
  @override
  mainPageProfState createState() => mainPageProfState();
}

class mainPageProfState extends State<mainPageProf> {
  //Listes qui contient les élèves filtrés
  List filteredEleveTab = [];
  //Liste qui contient les utilisateurs
  List users = [{}];
  //Liste qui contient les élèves temporairement
  List eleveTab = [];
  //Liste des élèves selectionnés
  List<String> selectedEleveTab = [];

  //Map qui contient les informations des utilisateurs
  Map userDataDrawer = {};
  Map userData = {};

  //Variable qui détermine la connexion
  bool hasConnection;

  //Variable qui détermine si on est en état de selection
  bool selectionState = false;

  //Variable qui détermine si on est en mode recherche
  bool isSearching = false;

  var eleve;

  //Appel à l'api pour get les users
  _getUsers() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/users");
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {}
    }
  }

  //Fonction qui filtre les élèves de l'enseignants
  _getEleve() {
    eleveTab = new List();
    _getUsers();

    for (var i = 0; i < users.length; i++) {
      eleve = {
        "givenId": users[i]["givenId"],
        "firstName": users[i]["firstName"],
        "lastName": users[i]["lastName"],
        "stageName": users[i]["stageName"],
        "email": users[i]["email"],
        "role": users[i]['role'],
        "yearDebut": users[i]["schoolYearBegin"],
        "yearFin": users[i]["schoolYearEnd"],
        "stageDesc": users[i]["stageDesc"],
        "profId": users[i]["profId"],
        "connection": true,
        "colorSelect": Color(0xFF222b3b),
        'isTeacher':true,
        'nouvQuestion': false
      };
      if (users[i]["role"] == "S" &&
          users[i]["profId"] == userData["givenId"]) {
        eleveTab.add(eleve);
      }
    }
  }

  //Stream qui vérifie la connexion internet
  void stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
    await for (int i in stream) {
      if (this.mounted) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            hasConnection = true;
          } else {
            hasConnection = false;
            print('FUK');
          }
        } on SocketException catch (_) {
          hasConnection = false;
          print('FUKMAN');
        }
        if (userData['connection'] == !hasConnection) {
          if (this.mounted) {
            setState(() {
              RestartWidget.restartApp(context);
            });
          }
        }
      }
    }
  }

  //Filtrer les élèves avec la barre de recherche
  void _filterEleves(value) {
    setState(() {
      print(value);
      filteredEleveTab = eleveTab
          .where((eleveTab) => eleveTab["firstName"]
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget _getBody() {
    return _createList(filteredEleveTab);
  }

  //Fonction qui créé la liste d'élèves
  _createList(dynamic array) {
    String url;
    return ListView.builder(
        itemCount: array.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(6, 7, 6, 0),
              child: Card(
                color: array[index]['colorSelect'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: ListTile(
                  title: Text(
                    " " +
                        array[index]['firstName'] +
                        " " +
                        array[index]['lastName'],
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Arboria'),
                  ),
                  subtitle: Text(" " + array[index]['stageName'],
                      style: TextStyle(fontFamily: 'Arboria')),

                  trailing:
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.timeline, size: 30),
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed('/mainPageEleve', arguments: 
                                array[index]
                              )
                            }),
                    SizedBox(width: 1),
                    VerticalDivider(thickness: 1.5),
                    IconButton(
                        icon: Icon(Icons.perm_identity, size: 30),
                        onPressed: () => {
                              Navigator.of(context).pushNamed('/profilEleve',
                                  arguments: array[index])
                            })
                  ]),

                  //leading: Icon(Icons.work, size: 40),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {
                    if (selectionState) {
                      setState(() {
                        if (!selectedEleveTab
                            .contains(array[index]['givenId'])) {
                          array[index]['colorSelect'] = Color(0xFF39475e);
                          selectedEleveTab.add(array[index]['givenId']);
                          print(selectedEleveTab);
                        } else if (selectedEleveTab
                            .contains(array[index]['givenId'])) {
                          array[index]['colorSelect'] = Color(0xFF222b3b);
                          selectedEleveTab.remove(array[index]['givenId']);
                          print(selectedEleveTab);
                        }
                        if (selectedEleveTab.length == 0) {
                          setState(() {
                            print(selectedEleveTab.length);
                            selectionState = false;
                          });
                        }
                      });
                    } else {
                      Navigator.of(context)
                          .pushNamed('/questionsStage', arguments: {
                        'givenId': userData["givenId"],
                        'firstName': userData["firstName"],
                        'lastName': userData["lastName"],
                        'email': userData["email"],
                        'role': userData["role"],
                        'stageName': userData['stageName'],
                        'yearDebut': userData['schoolYearBegin'],
                        'yearFin': userData['schoolYearEnd'],
                        'idStudent': array[index]["givenId"],
                        'nomEleve': array[index]["firstName"],
                        'questionEleve': false,
                        'connection': userData['connection']
                      });
                    }
                  },
                  onLongPress: () {
                    setState(() {
                      if (!selectedEleveTab.contains(array[index]['givenId'])) {
                        selectionState = true;
                        array[index]['colorSelect'] = Color(0xFF39475e);
                        selectedEleveTab.add(array[index]['givenId']);
                        print(selectedEleveTab);
                      }
                    });
                  },
                ),
              ));
        });
  }

  //Fonction qui est initialiser une seule fois avant tout autre fonction
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      stream();
      _getUsers().then((data) {
        _getEleve();
        filteredEleveTab = eleveTab;
        userDataDrawer = {
          'givenId': userData["givenId"],
          'firstName': userData["firstName"],
          'lastName': userData["lastName"],
          'email': userData["email"],
          'role': userData["role"],
          'stageName': userData['stageName'],
          'yearDebut': userData['schoolYearBegin'],
          'yearFin': userData['schoolYearEnd'],
          'questionEleve': true,
          'connection': userData['connection']
        };
      });
    });
  }

  //Fonction qui reset les élève qui sont selectionné (pour les déselectionner)
  resetSelected() {
    setState(() {
      for (int i = 0; i < eleveTab.length; i++) {
        eleveTab[i]['colorSelect'] = Color(0xFF222b3b);
      }
      selectedEleveTab = [];
      selectionState = false;
    });
  }

  //Fonction qui construit l'aspect visuel de la page
  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: !isSearching && userData['connection']
          ? Container(
              color: Colors.grey[900],
              child: customDrawer(
                userData: userDataDrawer,
              ))
          : null,
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
          ),
          title: !isSearching && !selectionState
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Center(
                          child: Text("Défi photo - Enseignant",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Arboria',
                              ))),
                      userData['connection']
                          ? Opacity(
                              opacity: 0.5,
                              child: Text("Mes élèves",
                                  style: TextStyle(
                                      fontFamily: 'Arboria', fontSize: 16)),
                            )
                          : Opacity(
                              opacity: 0.5,
                              child: Text("Mode hors-ligne",
                                  style: TextStyle(
                                      fontFamily: 'Arboria', fontSize: 16)),
                            )
                    ])
              : isSearching
                  ? TextField(
                      onChanged: (value) {
                        _filterEleves(value);
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Rechercher la question"))
                  : Center(
                      child: Text("Mode sélection",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Arboria',
                          ))),
          actions: userData['connection']
              ? <Widget>[
                  selectionState
                      ? IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => (creationQuestionGroupe(
                                    userData["givenId"], selectedEleveTab))));
                            Timer(Duration(milliseconds: 1000),
                                () => resetSelected());
                          })
                      : !isSearching
                          ? IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  this.isSearching = true;
                                });
                              })
                          : IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  this.isSearching = false;
                                  filteredEleveTab = eleveTab;
                                });
                              })
                ]
              : null),
      backgroundColor: Color(0xff141a24),
      body: filteredEleveTab.length > 0 && userData['connection']
          ? _getBody()
          : filteredEleveTab.length == 0 && userData['connection']
              ? Center(
                  child: Text("Vous n'avez pas d'étudiants",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          letterSpacing: 1.2,
                          fontFamily: 'Arboria')))
              : Container(
                  color: Color(0xff141a24),
                  child: ListView(children: <Widget>[
                    SizedBox(height: 200),
                    Center(
                        child: RichText(
                            text: TextSpan(
                                text:
                                    "Vous êtes en mode hors-ligne. \nVous devez vous connecter à\ninternet pour effectuer des actions.",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontFamily: 'Arboria')),
                            textAlign: TextAlign.center)),
                    SizedBox(height: 100)
                  ])),
    );
  }
}
