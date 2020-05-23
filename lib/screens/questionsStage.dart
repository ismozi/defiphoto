import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pageQuestion.dart';
import '../widgets/fabbottomappbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/database_helpers.dart';
import 'mainPageEleve.dart';

//C'est la classe dans laquelle on peut retouver les questions de stage de élève ainsi que les que
//les questions posées à l'enseignant
class questionStage extends StatefulWidget {
  questionStageState createState() => new questionStageState();
}

class questionStageState extends State<questionStage> {
  //Listes et Map pour qui contiendra les information des questions, utilisateurs, commentaires
  List questions = [{}];
  List users = [{}];
  List filteredQuestionTab = [];
  List questionSectionTab = [];
  List commentaires = [{}];
  List commentairesMe = [{}];
  List commentairesQuestion = [{}];
  var questionSection;
  Map userData = {};

  //Variables booléenne des différents états de l'application
  bool isSearching = false;
  bool isLoading = true;
  bool loadingDeleteQuestion = false;

  //Différentes initialisation de variable pour définir l'état initial de l'application
  Text titreEnseignant = Text("Mes questions",
      style: TextStyle(
        fontFamily: 'Arboria',
      ));
  Widget appBarTitle = Text('Matières et produits',
      style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
  String nomEleve;
  String section = 'M';
  int _currentIndex = 0;

  //Instance du Text-to-speech et sa langue
  FlutterTts flutterTts;
  String language = 'fr-FR';

  //Méthode qui fait un appel à l'api pour obtenir les commentaires
  _getCommentaires() async {
    if (userData['connection']) {
      try {
        var response =
            await http.get("https://defiphoto-api.herokuapp.com/comments");
        if (response.statusCode == 200) {
          commentaires = json.decode(response.body);
        }
      } catch (e) {
        if (e is SocketException) {
          isLoading = false;
        }
      }
    }
  }

  //Méthode qui permet de filtrer les commentaires qui proviennent de l'utilisateur actif
  _getCommentaireMe() {
    for (int i = 0; i < commentaires.length; i++) {
      if (commentaires[i]['sender'] == userData['givenId']) {
        commentairesMe.add(commentaires[i]);
      }
    }
  }

  //Méthode qui permet de supprimer une question et ses commentaires
  deleteCommentairesEtQuestion(String questionId) async {
    commentairesQuestion = [{}];

    Navigator.of(context).pop();

    for (int i = 0; i < commentaires.length; i++) {
      if (commentaires[i]['questionId'] == questionId) {
        String id = commentaires[i]['_id'];
        try {
          var response = await http
              .delete("https://defiphoto-api.herokuapp.com/comments/$id");

          if (response.statusCode == 200 && this.mounted) {
            setState(() {
              print("deleted!");
              isLoading = true;
            });
          }
        } catch (e) {
          if (e is SocketException) {}
        }
      }
    }
    deleteQuestion(questionId);
  }

  //Méthode qui permet de supprimer une question
  deleteQuestion(String questionId) async {
    String id = questionId;
    try {
      var response = await http
          .delete("https://defiphoto-api.herokuapp.com/questions/$id");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          loadingDeleteQuestion = false;
          _refresh();
        });
      }
    } catch (e) {
      if (e is SocketException) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  //Méthode qui permet de sauvegarder les questions dans la base de données locale
  _save() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.deleteAll();
    for (int i = 0; i < questions.length; i++) {
      Question question = Question();
      question.id = questions[i]['_id'];
      question.text = questions[i]['text'];
      question.type = questions[i]['type'];
      question.sender = questions[i]['sender'];

      int id = await helper.insert(question);
    }
    _readDB();
  }

  //Méthode qui permet de lire le contenu de la base de donnée locale
  _readDB() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List questionsLocales = await helper.queryAllRows();
    if (questionsLocales == null) {
      print('YA RIEN');
    } else {}
  }

  //Méthode qui initialise le Text-to-speech
  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage(language);
    flutterTts.setSpeechRate(1.0);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
  }

  //Méthode qui permet de vérifié si l'utilisateur à répondu à une question en particulier
  bool checkIfReplied(var question) {
    bool isAns = false;
    for (int i = 0; i < commentairesMe.length; i++) {
      if (question['id'] == commentairesMe[i]['questionId']) {
        isAns = true;
      }
    }
    return isAns;
  }

  //Méthode qui permet désactiver certaine choses lorsqu'on ferme la page
  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  //Méthode qui permet au text-to-speech de lire un text
  Future _read(String text) async {
    await flutterTts.stop();
    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text.toLowerCase());
    }
  }

  //Méthode qui permet d'obtenir les questions dans le mode hors-ligne
  _getDataOffline() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    questions = await helper.queryAllRows();
    if (questions == null) {
      print('YA RIEN');
    } else {}
    isLoading = false;
  }

  //Méthode qui fait un appel à l'api pour permettre d'obtenir les questions dans le mode en-ligne
  _getDataOnline() async {
    String id = userData["givenId"];
    var response;

    if (userData['role'] == 'P') {
      id = userData["idStudent"];
      if (userData['questionEleve']) {
        id = userData['givenId'];
      }
    } else if (userData['role'] == 'S') {
      id = userData["givenId"];
    }

    try {
      response =
          await http.get("https://defiphoto-api.herokuapp.com/questions/$id");

      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          questions = json.decode(response.body);
          if (userData['role'] == 'S') _save();
        });
      }
    } catch (e) {
      if (e is SocketException) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  //Méthode qui fait un appel à l'api pour obtenir les utilisateurs
  _getUser() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/users");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          users = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {}
    }
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

  //Méthode qui permet de changer l'aspect visuel en fonction de l'onglet sélectionné
  void _selectedTab(int index) {
    setState(() {
      if (index == 0) {
        appBarTitle = Text('Matières et produits',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
        section = 'M';
        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      } else if (index == 1) {
        appBarTitle = Text('Équipement',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));

        section = 'É';

        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      } else if (index == 2) {
        appBarTitle = Text('Tâches',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
        section = 'T';
        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      } else if (index == 3) {
        appBarTitle = Text('Individu',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
        section = 'I';
        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      } else if (index == 4) {
        appBarTitle = Text('Environnement',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
        section = 'E';
        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      } else if (index == 5) {
        appBarTitle = Text('Ressources humaines',
            style: TextStyle(fontFamily: 'Arboria', fontSize: 15));
        section = 'R';
        _getQuestionSection();
        filteredQuestionTab = questionSectionTab;
      }
    });
  }

  //Méthode permettant d'obtenir les questions spécifiques à une section de l'acronyme MÉTIER
  _getQuestionSection() {
    questionSectionTab = new List();
    if (userData['connection'])
      _getDataOnline();
    else if (!userData['connection']) {
      _getDataOffline();
    }

    if (userData['role'] == 'P' && !userData['questionEleve']) {
      for (var i = 0; i < questions.length; i++) {
        questionSection = {
          "id": questions[i]["_id"],
          "sender": questions[i]["sender"],
          "text": questions[i]["text"]
        };
        if (questions[i]["type"] == section &&
            questions[i] != null &&
            questions[i]["sender"] == userData['givenId']) {
          questionSectionTab.add(questionSection);
        }
      }
    } else if (userData['role'] == 'S' || userData['questionEleve']) {
      for (var i = 0; i < questions.length; i++) {
        questionSection = {
          "id": questions[i]["_id"],
          "sender": questions[i]["sender"],
          "text": questions[i]["text"],
          "isAns": questions[i]["isAns"],
          "type": questions[i]["type"],
          "recievers": questions[i]["recievers"],
        };
        if (questions[i]["type"] == section && questions[i] != null) {
          questionSectionTab.add(questionSection);
        }
      }
    }
  }

  //Méthode permettant d'aller à la page de conversation d'une question
  goToPageCommentaire(var filteredQuestionTab) async {
    await Navigator.pushNamed(context, '/pageCommentaire', arguments: {
      'questionId': filteredQuestionTab["id"],
      'givenId': userData['givenId'],
      'role': userData['role'],
      'text': filteredQuestionTab["text"],
      'isAns': filteredQuestionTab['isAns'],
      'sender': filteredQuestionTab['sender'],
      'recievers': filteredQuestionTab['recievers'],
      'type': filteredQuestionTab['type'],
    }).then((value) => _refresh());
  }

  //Méthode permettant de construire l'aspect visuel de la liste des questions
  _getBody(int currentIndex) {
    return isLoading
        ? Container(
            color: Color(0xff141a24),
            child: Center(
                child: SpinKitDoubleBounce(size: 40, color: Colors.white)))
        : Container(
            color: Color(0xff141a24),
            child: filteredQuestionTab.length > 0
                ? ListView.builder(
                    itemCount: filteredQuestionTab.length,
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
                                filteredQuestionTab[index]["text"] ?? '',
                                style: TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.white,
                                    fontFamily: 'Arboria'),
                              ),
                              subtitle: !userData['connection']
                                  ? null
                                  : Text(
                                      !userData['questionEleve'] &&
                                              userData['role'] == "P"
                                          ? 'Moi'
                                          : _getUsername(
                                                  filteredQuestionTab[index]
                                                      ["sender"]) ??
                                              "",
                                      style: TextStyle(fontFamily: 'Arboria')),
                              leading: userData['role'] == 'P' &&
                                      userData['questionEleve']
                                  ? Icon(
                                      Icons.chat_bubble_outline,
                                      size: 40,
                                    )
                                  : Icon(
                                      Icons.comment,
                                      color: Colors.grey[400],
                                      size: 35,
                                    ),
                              trailing: (userData['role'] == 'S' &&
                                          userData['connection']) &&
                                      !checkIfReplied(
                                          filteredQuestionTab[index])
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                          VerticalDivider(thickness: 1.5),
                                          IconButton(
                                              icon: Icon(Icons.volume_up,
                                                  size: 30),
                                              onPressed: () {
                                                _read(filteredQuestionTab[index]
                                                    ["text"]);
                                              }),
                                          ClipOval(
                                              child: Material(
                                                  color: Colors.cyan,
                                                  child: SizedBox(
                                                      width: 13, height: 13)))
                                        ])
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                          VerticalDivider(thickness: 1.5),
                                          IconButton(
                                              icon: Icon(Icons.volume_up,
                                                  size: 30),
                                              onPressed: () {
                                                _read(filteredQuestionTab[index]
                                                    ["text"]);
                                              }),
                                        ]),
                              contentPadding: EdgeInsets.all(20),
                              onLongPress: () {
                                return userData['role'] == 'P'
                                    ? showDialog<void>(
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
                                                      'Voulez-vous enlevez cette question?',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Arboria')),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Oui',
                                                    style: TextStyle(
                                                        fontFamily: 'Arboria')),
                                                onPressed: () async {
                                                  deleteCommentairesEtQuestion(
                                                      filteredQuestionTab[index]
                                                          ["id"]);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('Non',
                                                    style: TextStyle(
                                                        fontFamily: 'Arboria')),
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
                                      )
                                    : null;
                              },
                              onTap: () {
                                !userData['connection']
                                    ? null
                                    : goToPageCommentaire(
                                        filteredQuestionTab[index]);
                              },
                            ),
                          ));
                    })
                : filteredQuestionTab.length == 0 && userData['connection']
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Center(
                                child: Text("Il n'y a pas de question",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20,
                                        letterSpacing: 1.2,
                                        fontFamily: 'Arboria'))),
                            SizedBox(height: 20),
                            ClipOval(
                                child: Material(
                                    color: Colors.blueGrey,
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                          child: IconButton(
                                              icon: Icon(Icons.refresh),
                                              color: Colors.black,
                                              onPressed: () => _refresh()),
                                        ))))
                          ])
                    : Center(
                        child: Text("Il n'y a pas de question",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                letterSpacing: 1.2,
                                fontFamily: 'Arboria'))));
  }

  //Méthode permettant de refresh les informations
  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
        if (userData['connection']) {
          _getDataOnline().then((data) {
            nomEleve = userData['nomEleve'];
            titreEnseignant = Text("Mes questions | " + "$nomEleve",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Arboria',
                ));
            _getQuestionSection();
            filteredQuestionTab = questionSectionTab;
            if (userData['role'] == 'P') {
              _getCommentaires().then((data) {
                setState(() {
                  isLoading = false;
                });
              });
            }
          });
          if (userData['role'] == 'S') {
            _getCommentaires().then((data) {
              commentairesMe = [{}];
              _getCommentaireMe();
              isLoading = false;
            });
          }

          _getUser();
        } else if (!userData['connection']) {
          setState(() {
            _getDataOffline().then((data) {
              _getQuestionSection();
              setState(() {
                filteredQuestionTab = questionSectionTab;
              });
            });
          });
        }
      });
    });
    return null;
  }

  //Méthode permettant de filtrer les questions
  void _filterQuestions(value) {
    setState(() {
      // print(value);
      filteredQuestionTab = questionSectionTab
          .where((questionSection) => questionSection["text"]
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      // print(filteredQuestionTab);
    });
  }

  //Méthode qui est exécuté en premier
  @override
  void initState() {
    super.initState();

    _refresh();

    initTts();
  }

  //Méthode qui permet de construire l'aspect visuel de l'application.
  @override
  Widget build(BuildContext context) {
    if (userData['role'] == null) {
      return Scaffold(
          body: Container(
              color: Color(0xff141a24),
              child: Center(
                  child: SpinKitDoubleBounce(size: 40, color: Colors.white))));
    }
    if (userData['role'] == 'S') {
      return Scaffold(
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
                            child: Text("Question de stage",
                                style: TextStyle(
                                  fontFamily: 'Arboria',
                                ))),
                        Opacity(
                          opacity: 0.5,
                          child: appBarTitle,
                        )
                      ])
                : TextField(
                    onChanged: (value) {
                      _filterQuestions(value);
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
                          filteredQuestionTab = questionSectionTab;
                        });
                      })
            ]),
        body: new RefreshIndicator(
            child: _getBody(_currentIndex), onRefresh: _refresh),
        bottomNavigationBar: FABBottomAppBar(
          role: userData['role'],
          questionEleve: userData['questionEleve'],
          onTabSelected: _selectedTab,
          selectedColor: Color(0xFF0d1118),
          notchedShape: CircularNotchedRectangle(),
          backgroundColor: Color(0xFF222b3b),
          items: [
            FABBottomAppBarItem(text: "M"),
            FABBottomAppBarItem(text: "É"),
            FABBottomAppBarItem(text: "T"),
            FABBottomAppBarItem(text: "I"),
            FABBottomAppBarItem(text: "E"),
            FABBottomAppBarItem(text: "R"),
          ],
        ),
      );
    } else if (userData['role'] == 'P') {
      return Scaffold(
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
                              child: !userData['questionEleve']
                                  ? titreEnseignant
                                  : Text("Questions d'élèves",
                                      style: TextStyle(
                                        fontFamily: 'Arboria',
                                      ))),
                          Opacity(
                            opacity: 0.5,
                            child: appBarTitle,
                          )
                        ])
                  : TextField(
                      onChanged: (value) {
                        _filterQuestions(value);
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
                            filteredQuestionTab = questionSectionTab;
                          });
                        })
              ]),
          body: new RefreshIndicator(
              child: _getBody(_currentIndex), onRefresh: _refresh),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: !userData['questionEleve']
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(
                            builder: (context) => (creationQuestion(
                                userData["givenId"], userData['idStudent']))))
                        .then((value) => _refresh());
                  },
                  backgroundColor: Color(0xff444d5d),
                  child: Icon(Icons.add, color: Colors.white))
              : null,
          bottomNavigationBar: FABBottomAppBar(
            role: userData['role'],
            questionEleve: userData['questionEleve'],
            onTabSelected: _selectedTab,
            selectedColor: Color(0xFF0d1118),
            notchedShape: CircularNotchedRectangle(),
            backgroundColor: Color(0xFF222b3b),
            items: [
              FABBottomAppBarItem(text: "M"),
              FABBottomAppBarItem(text: "É"),
              FABBottomAppBarItem(text: "T"),
              FABBottomAppBarItem(text: "I"),
              FABBottomAppBarItem(text: "E"),
              FABBottomAppBarItem(text: "R"),
            ],
          ));
    }
  }
}
