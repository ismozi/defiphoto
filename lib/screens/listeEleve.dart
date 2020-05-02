import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'customDrawer.dart';

class listeEleve extends StatefulWidget {
  @override
  _listeEleveState createState() => _listeEleveState();
}

class _listeEleveState extends State<listeEleve> {
  List users = [{}];
  Map userData = {};
  List eleveTab = [];
  List filteredEleveTab = [];
  bool isSearching = false;
  var eleve;
  Map userDataDrawer = {};


  _getUsers() async {
    var response = await http.get("https://defiphoto-api.herokuapp.com/users");
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
    }
  }

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
        "yearDebut": users[i]["schoolYearBegin"],
        "yearFin": users[i]["schoolYearEnd"]
      };
      if (users[i]["role"] == "S") {
        eleveTab.add(eleve);
      }
    }
  }


  void _filterEleves(value) {
    setState(() {
      print(value);
      filteredEleveTab = eleveTab
          .where((questionSection) => questionSection["firstName"]
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget _getBody() {
    return _createList(filteredEleveTab);
  }



  _createList(dynamic array) {
    String url;
    return ListView.builder(
        itemCount: array.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(6, 7, 6, 0),
              child: Card(
                color: Color(0xFF222b3b),
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
                        icon: Icon(Icons.message, size: 30), onPressed: () => {
                              Navigator.of(context).pushNamed('/mainPage',
                                  arguments: {
          'givenId': userData["givenId"],
            'firstName': userData["firstName"],
            'lastName': userData["lastName"],
            'email': userData["email"],
            'role': userData["role"],
            'stageName' : userData['stageName'],
            'yearDebut' : userData['schoolYearBegin'],
            'yearFin' : userData['schoolYearEnd'],
            'idStudent' : array[index]["givenId"],
            'nomEleve': array[index]["firstName"],
            'questionEleve' : false
            
        })
                            }),
                    SizedBox(width: 1),
                    VerticalDivider(thickness: 1.5),
                    IconButton(
                        icon: Icon(Icons.person, size: 30),
                        onPressed: () => {
                              Navigator.of(context).pushNamed('/profilEleve',
                                  arguments: array[index])
                            })
                  ]),

                  //leading: Icon(Icons.work, size: 40),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {},
                  onLongPress: () {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Avertissement',
                              style: TextStyle(fontFamily: 'Arboria')),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Voulez-vous enlevez cet utilisateur?',
                                    style: TextStyle(fontFamily: 'Arboria')),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Oui',
                                  style: TextStyle(fontFamily: 'Arboria')),
                              onPressed: () async {
                                String id = array[index]['givenId'];
                                var response = await http.delete(
                                    "https://defiphoto-api.herokuapp.com/users/$id");
                                print('Done!');

                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Non',
                                  style: TextStyle(fontFamily: 'Arboria')),
                              onPressed: () {
                                if (this.mounted) {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getUsers().then((data) {
        _getEleve();
        filteredEleveTab = eleveTab;
        userDataDrawer={
            'givenId': userData["givenId"],
            'firstName': userData["firstName"],
            'lastName': userData["lastName"],
            'email': userData["email"],
            'role': userData["role"],
            'stageName' : userData['stageName'],
            'yearDebut' : userData['schoolYearBegin'],
            'yearFin' : userData['schoolYearEnd'],
            'questionEleve' : true
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: !isSearching ? Container(color:Colors.grey[900],child:customDrawer(userData: userDataDrawer,)):null,
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
          ),
          title: !isSearching
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
                      Opacity(
                        opacity: 0.5,
                        child: Text("Mes élèves",
                            style:
                                TextStyle(fontFamily: 'Arboria', fontSize: 16)),
                      )
                    ])
              : TextField(
                  onChanged: (value) {
                    _filterEleves(value);
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: "Rechercher la question")),
          actions: <Widget>[
            !isSearching
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
                        filteredEleveTab=eleveTab;
                      });
                    })
          ]),
      backgroundColor: Color(0xff141a24),
      body: filteredEleveTab.length > 0 ? _getBody() : Center(
                child: Text("Vous n'avez pas d'étudiants",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        fontFamily: 'Arboria'))),
    );
  }
}
