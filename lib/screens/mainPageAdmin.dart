import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class mainPageAdmin extends StatefulWidget {
  @override
  _mainPageAdminState createState() => _mainPageAdminState();
}

class _mainPageAdminState extends State<mainPageAdmin> {
  //Listes et Map pour stocker les informations
  List users = [{}];
  List questions = [{}];
  List comments = [{}];
  Map userData = {};

  //Variable qui détermine quelle onglet est actif
  int _selectedIndex = 0;

  //Variable booléenne qui détermine différent état de l'application
  bool hasConnection;
  bool isSearching = false;
  bool isLoading = true;

  //Méthode qui déconnecte tout en effacant les données enregistrées
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('givenId', null);
    prefs.setString('password', null);
  }

  //Méthode qui fait un appel à l'API pour obtenir les utilisateurs
  _getUsers() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/users");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          users = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {
        isLoading = false;
      }
    }
  }

  //Méthode qui fait un appel à l'API pour obtenir les questions
  _getQuestions() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/questions");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          questions = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {
        isLoading = false;
      }
    }
  }

  //Méthode qui fait un appel à l'API pour obtenir les commentaires
  _getComments() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/comments");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          comments = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {
        isLoading = false;
      }
    }
  }

  //Méthode qui permet d'obtenir toutes les données nécessaires
  _getData() {
    
    _getUsers();
    _getQuestions();
    _getComments();
  }

  //Méthode qui permet d'obtenir le nom d'un utilisateur
  String _getUsername(String id) {
    String name = "";
    for (int i = 0; i < users.length; i++) {
      if (id == users[i]['givenId']) {
        name = users[i]['firstName'] + " " + users[i]['lastName'];
      }
    }
    return name;
  }

  //Méthode qui permet d'obtenir le texte d'une question
  String _getQuestionname(String id) {
    String name = "";
    for (int i = 0; i < questions.length; i++) {
      if (id == questions[i]['_id']) {
        name = questions[i]['text'];
      }
    }
    return name;
  }

  //Méthode qui permet d'obtenir le contenu du body de la vue
  Widget _getBody(int index) {
    if (!isLoading) {
      switch (index) {
        case 0:
          return _createList(users, true, false, false);
          break;
        case 1:
          return _createList(questions, false, true, false);
          break;
        case 2:
          return _createList(comments, false, false, true);
          break;
      }
    } else if (isLoading) {
      return Container(
          color: Color(0xff141a24),
          child: Center(
              child: SpinKitDoubleBounce(size: 40, color: Colors.white)));
    }
  }

  deleteCommentairesEtQuestion(String questionId) async {
    for (int i = 0; i < comments.length; i++) {
      if (comments[i]['questionId'] == questionId) {
        String id = comments[i]['_id'];
        try {
          var response = await http
              .delete("https://defiphoto-api.herokuapp.com/comments/$id");
          if (response.statusCode == 200 && this.mounted) {
            setState(() {
              isLoading=true;
              print("deleted!");
            });
          }
        } catch (e) {
          if (e is SocketException) {
            setState(() {
              isLoading=false;
            });
          }
        }
      }
    }
    deleteQuestion(questionId);
  }

  deleteQuestion(String questionId) async {
    String id = questionId;
    try {
      var response = await http
          .delete("https://defiphoto-api.herokuapp.com/questions/$id");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          _getData();
          isLoading=false;
        });
      }
    } catch (e) {
      if (e is SocketException) {
        setState(() {
          isLoading=false;
        });
      }
    }
    // _enleverCommentaire(message);
  }

  //Méthode qui créé la liste qui sera affiché dans le body
  _createList(dynamic array, bool isUser, bool isQuestion, bool isComment) {
    String url;

    return array.length > 0
        ? ListView.builder(
            itemCount: array.length,
            itemBuilder: (context, index) {
              bool isFileFound = false;
              if (isComment && array[index]['fileName'] != null) {
                isFileFound = true;
                url = "https://defiphoto-api.herokuapp.com/comments/file/" +
                    array[index]['fileName'].toString();
              }

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
                        isUser
                            ? array[index]['firstName'] +
                                    " " +
                                    array[index]['lastName'] ??
                                ""
                            : isFileFound
                                ? "(Image)"
                                : array[index]["text"] ?? '',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'Arboria'),
                      ),
                      subtitle: Text(
                          isUser
                              ? "Rôle : " +
                                      array[index]["role"] +
                                      "  " +
                                      "ID : " +
                                      array[index]["givenId"] ??
                                  ""
                              : isComment
                                  ? isFileFound
                                      ? "Expéditeur : " +
                                              _getUsername(
                                                  array[index]["sender"]) +
                                              "\n" +
                                              "Question : " +
                                              _getQuestionname(
                                                  array[index]["questionId"]) +
                                              "\n" +
                                              "Nom de fichier : " +
                                              array[index]["fileName"]
                                                  .toString() ??
                                          ""
                                      : "Expéditeur : " +
                                              _getUsername(
                                                  array[index]["sender"]) +
                                              "\n" +
                                              "Question : " +
                                              _getQuestionname(
                                                  array[index]["questionId"]) ??
                                          ""
                                  : "Expéditeur : " +
                                          _getUsername(array[index]["sender"]) +
                                          "\n" +
                                          "Destinataires pr ID: " +
                                          array[index]["recievers"].toString() +
                                          "\n" +
                                          "Type : " +
                                          array[index]['type'] +
                                          "\n" +
                                          "Question : " +
                                          _getQuestionname(
                                              array[index]["_id"]) ??
                                      "",
                          style: TextStyle(fontFamily: 'Arboria')),
                      leading: Icon(Icons.work, size: 40),
                      contentPadding: EdgeInsets.all(20),
                      onTap: () {
                        if (isComment && isFileFound) {}
                        if (isComment && !isFileFound) {}
                        if (isQuestion) {}
                        if (isUser) {}
                      },
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
                                    Text(
                                        isUser
                                            ? 'Voulez-vous enlevez cet utilisateur?'
                                            : isComment
                                                ? 'Voulez-vous enlevez ce commentaire?'
                                                : 'Voulez-vous enlevez cette question?',
                                        style:
                                            TextStyle(fontFamily: 'Arboria')),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Oui',
                                      style: TextStyle(fontFamily: 'Arboria')),
                                  onPressed: () async {
                                    if (isComment && isFileFound) {
                                      String id = array[index]['_id'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/comments/$id");
                                        if (response.statusCode == 200 &&
                                            this.mounted) {
                                          _getData();
                                        }
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }
                                    if (isComment && !isFileFound) {
                                      String id = array[index]['_id'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/comments/$id");
                                        if (response.statusCode == 200 &&
                                            this.mounted) {
                                          _getData();
                                        }
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }
                                    if (isQuestion) {
                                      deleteCommentairesEtQuestion(
                                          array[index]['_id']);
                                    }

                                    if (isUser) {
                                      String id = array[index]['givenId'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/users/$id");
                                        if (response.statusCode == 200 &&
                                            this.mounted) {
                                          _getData();
                                        }
                                        print('Done!');
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }

                                    // _enleverCommentaire(message);
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
            })
        : Center(
            child: isUser
                ? Text("Il n'y a pas d'utilisateur",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        fontFamily: 'Arboria'))
                : isQuestion
                    ? Text("Il n'y a pas de question",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontFamily: 'Arboria'))
                    : Text("Il n'y a pas de commentaire",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontFamily: 'Arboria')));
  }

  //Méthode "stream" qui permet de vérifier la connexion à internet
  _stream() async {
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

  //Méthode permettant de refresh les informations
  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        _getData();
      });
    });
    return null;
  }

  //Première fonction qui est appelée, fait les appels nécessaires pour obtenir les données
  //et initialise le stream
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers().then((data) {
      _getQuestions().then((data) {
        _getComments().then((data) {
          isLoading = false;
          _stream();
        });
      });
    });

    _stream();
  }

  //Méthode qui construit l'affichage
  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout();
              Navigator.of(context).pushReplacementNamed('/login');
            }),
        actions: <Widget>[],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
        ),
        title: userData['connection']
            ? Text("Défi photo - Admin",
                style: TextStyle(
                  fontFamily: 'Arboria',
                ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text("Défi photo - Admin",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arboria',
                        )),
                    Opacity(
                      opacity: 0.5,
                      child: Text("Mode hors-ligne",
                          style:
                              TextStyle(fontFamily: 'Arboria', fontSize: 16)),
                    )
                  ]),
      ),
      backgroundColor: Color(0xff141a24),
      body: userData['connection']
          ? new RefreshIndicator(
            child: _getBody(_selectedIndex), onRefresh: _refresh)
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
      floatingActionButton: _selectedIndex != 0 || !userData['connection']
          ? null
          : FloatingActionButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed('/ajoutUtilisateur').then((value) => _getData())},
              backgroundColor: Color(0xff444d5d),
              child: Icon(Icons.add, color: Colors.white)),
      bottomNavigationBar: !userData['connection']
          ? null
          : GradientBottomNavigationBar(
              backgroundColorStart: Color(0xff141a24),
              backgroundColorEnd: Color(0xFF2b3444),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text('Utilisateurs')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assignment), title: Text('Questions')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    title: Text('Commentaires')),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
        _getData();
    });
  }
}
