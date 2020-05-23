import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_flutter/screens/pageCommentaire.dart';

//Classe des question posées à l'enseignant
class Questions extends StatefulWidget {
  //Information sur l'enseignant et l'utilisateur
  String idProf;
  String id;
  String role;

  Questions(String idProf, String id, String role) {
    this.idProf = idProf;
    this.id = id;
    this.role = role;
  }
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  //Variable bool pour différents états de l'application
  bool isLoading = true;
  bool isEmpty;

  //Liste qui contiendras les questions posées à l'enseignant
  List questions = [{}];
  List commentaires = [{}];

  //Méthode qui fait un appel à l'api pour obtenir les questions posées à l'enseignant
  _getQuestions() async {
    var sender = widget.id;
    var reciever = widget.idProf;
    print(widget.idProf);
    var data = {"sender": sender.toString(), "recievers": reciever.toString()};
    try {
      var response = await http.post(
          "https://defiphoto-api.herokuapp.com/questions/auProfs",
          body: data);
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          questions = json.decode(response.body);

          if (questions.isEmpty) {
            isEmpty = true;
            isLoading = false;
          } else {
            isEmpty = false;
            isLoading = false;
          }
        });
      }
    } catch (e) {
      if (e is SocketException) {}
    }
  }

  //Méthode qui fait un appel à l'api pour obtenir les commentaires
  _getCommentaires() async {
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/comments");
      if (response.statusCode == 200) {
        commentaires = json.decode(response.body);
      }
    } catch (e) {
      if (e is SocketException) {
        
      }
    }
  }

  //Première méthode qui est exécuté
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  //Méthode qui permet de supprimer une question et ses commentaires
  deleteCommentairesEtQuestion(String questionId) async {
    Navigator.of(context).pop();

    for (int i = 0; i < commentaires.length; i++) {
      if (commentaires[i]['questionId'] == questionId) {
        String id = commentaires[i]['_id'];
        print(commentaires[i]['text']);
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

  //Méthode permettant de refresh les informations
  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        _getQuestions();
        _getCommentaires();
      });
    });
    return null;
  }

  //Méthode qui construit l'aspect visuel de l'application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141a24),
      appBar: AppBar(
        title: Text("Mes questions posées",
            style: TextStyle(
              fontFamily: 'Arboria',
            )),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        flexibleSpace: Container(
          decoration: customBoxDecoration(),
        ),
      ),
      body: isLoading
          ? Center(child: SpinKitDoubleBounce(size: 40, color: Colors.white))
          : isEmpty
              ? Center(
                  child: Text("Vous n'avez pas posé de questions",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontFamily: 'Arboria')))
              : Container(
                  color: Color(0xff141a24),
                  child: ListView.builder(
                      itemCount: questions.length,
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
                                  questions[index]["text"] ?? "",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontFamily: 'Arboria'),
                                ),
                                subtitle: Text(
                                    questions[index]["sender"] != [widget.id]
                                        ? "Me"
                                        : "Prof",
                                    style: TextStyle(fontFamily: 'Arboria')),
                                leading: Icon(
                                  Icons.chat_bubble_outline,
                                  size: 40,
                                ),
                                contentPadding: EdgeInsets.all(20),
                                onLongPress: () {
                                  return showDialog<void>(
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
                                                      fontFamily: 'Arboria')),
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
                                                  questions[index]["_id"]);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Non',
                                                style: TextStyle(
                                                    fontFamily: 'Arboria')),
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
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/pageCommentaire',
                                      arguments: {
                                        'questionId': questions[index]["_id"]
                                            .toString()
                                            .trim(),
                                        'givenId': widget.id.toString().trim(),
                                        'role': widget.role.toString().trim(),
                                        'text': questions[index]['text']
                                      }).then((value) => _refresh());
                                },
                              ),
                            ));
                      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          creationQuestion(widget.id, widget.idProf)))
              .then((value) => _refresh());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
        elevation: 5.0,
      ),
    );
  }
}

//Classe de la fenêtre pour envoyer une question (utilisé par les élève et les enseignants)
class creationQuestion extends StatefulWidget {
  //Variables string des informations de l'expéditeur et du destinataire
  String idSender;
  String idReceiver;

  creationQuestion(String idSender, String idReceiver) {
    this.idSender = idSender;
    this.idReceiver = idReceiver;
  }

  @override
  _creationQuestionState createState() => _creationQuestionState();
}

class _creationQuestionState extends State<creationQuestion> {
  //Controller pour le textField
  TextEditingController questionText = new TextEditingController();
  //Variable pour faire fonctionner les radio buttons
  int _indexType;
  List<String> types = ["M", "É", "T", "I", "E", "R"];

  //Méthode pour envoyer une question
  _envoyerQuestion(String text, String type) async {
    if (text.trim().isNotEmpty) {
      var data = {
        "text": text.trim().toString(),
        "sender": widget.idSender.toString(),
        "recievers": widget.idReceiver.toString(),
        "type": type.trim().toString()
      };
      try {
        var response = await http
            .post("https://defiphoto-api.herokuapp.com/questions", body: data);
        if (response.statusCode == 200) {
          print("Done!");
        }
      } catch (e) {
        if (e is SocketException) {}
      }
    }
  }

  //Méthode qui construit l'aspect visuel de l'application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Poser une question",
              style: TextStyle(
                fontFamily: 'Arboria',
              )),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          flexibleSpace: Container(decoration: customBoxDecoration())),
      backgroundColor: Color(0xff141a24),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
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
                      padding: EdgeInsets.all(10.0),
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
                        controller: questionText,
                        style: new TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            hintText: "QUESTION"),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
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
                          Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Text("M",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 0,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("É",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 1,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("T",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 2,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("I",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 3,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("E",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 4,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("R",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 5,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ]))
                        ])),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          setState(() {
                            _envoyerQuestion(
                                questionText.text.toString().trim(),
                                types[_indexType].toString().trim());
                            Navigator.of(context).pop();
                          });
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff444d5d),
                        child: Text(
                          'ENVOYER',
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
    );
  }
}

//Classe de pour l'envoi de questions à plusieurs élèves
class creationQuestionGroupe extends StatefulWidget {
  //Variable contenant l'information de l'expéditeur et des destinataires
  String idSender;
  List idReceivers;

  creationQuestionGroupe(String idSender, List idReceivers) {
    this.idSender = idSender;
    this.idReceivers = idReceivers;
  }

  @override
  _creationQuestionGroupeState createState() => _creationQuestionGroupeState();
}

class _creationQuestionGroupeState extends State<creationQuestionGroupe> {
  //Controller pour le textField
  TextEditingController questionText = new TextEditingController();
  //Variables pour faire fonctionner les radio buttons
  int _indexType;
  List<String> types = ["M", "É", "T", "I", "E", "R"];

  //Méthode pour envoyer une question
  _envoyerQuestion(String text, String type) async {
    for (int index = 0; index < widget.idReceivers.length; index++) {
      if (text.trim().isNotEmpty) {
        var data = {
          "text": text.trim().toString(),
          "sender": widget.idSender.toString(),
          "recievers": widget.idReceivers[index].toString(),
          "type": type.trim().toString()
        };
        try {
          var response = await http.post(
              "https://defiphoto-api.herokuapp.com/questions",
              body: data);
          if (response.statusCode == 200) {
            print("Done!");
          }
        } catch (e) {
          if (e is SocketException) {}
        }
      }
    }
  }

  //Méthode qui construit l'aspect visuel de l'application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Poser une question",
              style: TextStyle(
                fontFamily: 'Arboria',
              )),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          flexibleSpace: Container(decoration: customBoxDecoration())),
      backgroundColor: Color(0xff141a24),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
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
                      padding: EdgeInsets.all(10.0),
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
                        controller: questionText,
                        style: new TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            hintText: "QUESTION"),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
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
                          Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Text("M",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 0,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("É",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 1,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("T",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 2,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("I",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 3,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("E",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 4,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text("R",
                                            style: TextStyle(
                                                fontFamily: 'Arboria',
                                                fontSize: 25)),
                                        Radio(
                                          value: 5,
                                          groupValue: _indexType,
                                          onChanged: (T) {
                                            setState(() {
                                              _indexType = T;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ]))
                        ])),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          setState(() {
                            _envoyerQuestion(
                                questionText.text.toString().trim(),
                                types[_indexType].toString().trim());
                            Navigator.of(context).pop();
                          });
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff444d5d),
                        child: Text(
                          'ENVOYER',
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
    );
  }
}

BoxDecoration customBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)]));
}
