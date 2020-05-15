import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainPageAdmin extends StatefulWidget {
  @override
  _mainPageAdminState createState() => _mainPageAdminState();
}

class _mainPageAdminState extends State<mainPageAdmin> {
  int _selectedIndex = 0;
  List users = [{}];
  List questions = [{}];
  List comments = [{}];
  Map userData = {};

  bool isSearching = false;

  bool isLoading = true;

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('givenId', null);
    prefs.setString('password', null);
  }

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

  _getData() {
    _getUsers();
    _getQuestions();
    _getComments();
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

  String _getQuestionname(String id) {
    String name = "";
    for (int i = 0; i < questions.length; i++) {
      if (id == questions[i]['_id']) {
        name = questions[i]['text'];
      }
    }
    return name;
  }

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

  _createList(dynamic array, bool isUser, bool isQuestion, bool isComment) {
    bool isFileFound = false;
    String url;

    return array.length > 0
        ? ListView.builder(
            itemCount: array.length,
            itemBuilder: (context, index) {
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
                              ? "Role : " +
                                      array[index]["role"] +
                                      "  " +
                                      "ID : " +
                                      array[index]["givenId"] ??
                                  ""
                              : isComment
                                  ? isFileFound
                                      ? "Sender : " +
                                              _getUsername(
                                                  array[index]["sender"]) +
                                              "\n" +
                                              "Question : " +
                                              _getQuestionname(
                                                  array[index]["questionId"]) +
                                              "\n" +
                                              "File name : " +
                                              array[index]["fileName"]
                                                  .toString() ??
                                          ""
                                      : "Sender : " +
                                              _getUsername(
                                                  array[index]["sender"]) +
                                              "\n" +
                                              "Question : " +
                                              _getQuestionname(
                                                  array[index]["questionId"]) ??
                                          ""
                                  : "Sender : " +
                                          _getUsername(array[index]["sender"]) +
                                          "\n" +
                                          "Recievers by Id : " +
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
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }
                                    if (isComment && !isFileFound) {
                                      String id = array[index]['_id'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/comments/$id");
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }
                                    if (isQuestion) {
                                      String id = array[index]['_id'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/questions/$id");
                                      } catch (e) {
                                        if (e is SocketException) {}
                                      }
                                    }

                                    if (isUser) {
                                      String id = array[index]['givenId'];
                                      try {
                                        var response = await http.delete(
                                            "https://defiphoto-api.herokuapp.com/users/$id");
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
                ? Text(
                    "Il n'y a pas d'utilisateur",
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

  _stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
    await for (int i in stream) {
      _getData();
    }
  }

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
        title: Text("Défi photo - Admin",
            style: TextStyle(
              fontFamily: 'Arboria',
            )),
      ),
      backgroundColor: Color(0xff141a24),
      body: _getBody(_selectedIndex),
      floatingActionButton: _selectedIndex != 0
          ? null
          : FloatingActionButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed('/ajoutUtilisateur')},
              backgroundColor: Color(0xff444d5d),
              child: Icon(Icons.add, color: Colors.white)),
      bottomNavigationBar: GradientBottomNavigationBar(
        backgroundColorStart: Color(0xff141a24),
        backgroundColorEnd: Color(0xFF2b3444),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Utilisateurs')),
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
    });
  }
}
