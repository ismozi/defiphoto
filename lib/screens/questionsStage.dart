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

Widget appBarTitle = Text('Matières et produits',
    style: TextStyle(fontFamily: 'Arboria', fontSize: 15));

class questionStage extends StatefulWidget {
  questionStageState createState() => new questionStageState();
}

class questionStageState extends State<questionStage> {
  List questions = [{}];
  List users = [{}];
  Map userData = {};
  int _currentIndex = 0;
  String type;
  String section = 'M';
  bool isSearching = false;
  bool isLoading = true;
  String nomEleve;
  Text titreEnseignant = Text("Mes questions",
      style: TextStyle(
        fontFamily: 'Arboria',
      ));

  List filteredQuestionTab = [];
  List questionSectionTab = [];
  var questionSection;

  FlutterTts flutterTts;

  String language = 'fr-FR';

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

  _readDB() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List questionsLocales = await helper.queryAllRows();
    if (questionsLocales == null) {
      print('YA RIEN');
    } else {}
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage(language);
    flutterTts.setSpeechRate(1.0);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _read(String text) async {
    await flutterTts.stop();
    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text.toLowerCase());
    }
  }

  _getDataOffline() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    questions = await helper.queryAllRows();
    if (questions == null) {
      print('YA RIEN');
    } else {}
    isLoading = false;
  }

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
          _save();
          isLoading = false;
        });
      }
    } catch (e) {
      if (e is SocketException) {
        isLoading = false;
      }
    }
  }

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

  String _getUsername(String id) {
    String name = "";
    for (int i = 0; i < users.length; i++) {
      if (id == users[i]['givenId']) {
        name = users[i]['firstName'] + " " + users[i]['lastName'];
      }
    }
    return name;
  }

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
          "text": questions[i]["text"]
        };
        if (questions[i]["type"] == section && questions[i] != null) {
          questionSectionTab.add(questionSection);
        }
      }
    }
  }

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
                              subtitle: !userData['connection']? null:Text(
                                  !userData['questionEleve'] &&
                                          userData['role'] == "P"
                                      ? 'Moi'
                                      : _getUsername(filteredQuestionTab[index]
                                              ["sender"]) ??
                                          "",
                                  style: TextStyle(fontFamily: 'Arboria')),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    VerticalDivider(thickness: 1.5),
                                    IconButton(
                                        icon: Icon(Icons.volume_up, size: 30),
                                        onPressed: () {
                                          _read(filteredQuestionTab[index]
                                              ["text"]);
                                        })
                                  ]),
                              contentPadding: EdgeInsets.all(20),
                              onTap: () {
                                !userData['connection']
                                    ? null
                                    : Navigator.pushNamed(
                                        context, '/pageCommentaire',
                                        arguments: {
                                            'questionId':
                                                filteredQuestionTab[index]
                                                    ["id"],
                                            'givenId': userData['givenId'],
                                            'role': userData['role']
                                          });
                              },
                            ),
                          ));
                    })
                : Center(
                    child: Text("Il n'y a pas de questions",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontFamily: 'Arboria'))));
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
        if (userData['connection']) {
          _getDataOnline().then((data) {
            nomEleve = userData['nomEleve'];
            titreEnseignant = Text("Mes questions | " + "$nomEleve",
                style: TextStyle(
                  fontFamily: 'Arboria',
                ));
            _getQuestionSection();
            filteredQuestionTab = questionSectionTab;
          });
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

  @override
  void initState() {
    super.initState();

    _refresh();

    initTts();
  }

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
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => (creationQuestion(
                            userData["givenId"], userData['idStudent']))));
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
