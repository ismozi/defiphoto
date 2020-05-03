import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'customDrawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'customDrawer.dart';
import 'package:http/http.dart' as http;

class progressionEleve extends StatefulWidget {
  progressionEleveState createState() => new progressionEleveState();
}

class progressionEleveState extends State<progressionEleve> {
  Map userData = {};

  static int percentageM;
  static int percentageE1;
  static int percentageT;
  static int percentageI;
  static int percentageE2;
  static int percentageR;
  int percTot;
  bool isLoading = true;

  String eAccent = "É";
  Map questionData = {};
  List commentaires = [{}];
  List questions = [{}];
  List commentairesMe = [{}];
  int compteurM;
  int compteurE;
  int compteurT;
  int compteurI;
  int compteurE1;
  int compteurR;
  int compteurMtot;
  int compteurEtot;
  int compteurTtot;
  int compteurItot;
  int compteurE1tot;
  int compteurRtot;

  _getCommentaires() async {
    var response =
        await http.get("https://defiphoto-api.herokuapp.com/comments");
    if (response.statusCode == 200) {
      commentaires = json.decode(response.body);
    }
  }

  _getQuestions() async {
    String id = userData["givenId"];
    var response;

    id = userData["givenId"];

    response =
        await http.get("https://defiphoto-api.herokuapp.com/questions/$id");

    if (response.statusCode == 200) {
      questions = json.decode(response.body);
    }
  }

  _getCommentaireMe() {
    for (int i = 0; i < commentaires.length; i++) {
      if (commentaires[i]['sender'] == userData['givenId']) {
        commentairesMe.add(commentaires[i]);
      }
    }
  }

  _updateCompteur() {
    _getCommentaireMe();

    bool skipQuestion = false;
    int i = 0;

    compteurM = 0;
    compteurE = 0;
    compteurT = 0;
    compteurI = 0;
    compteurE1 = 0;
    compteurR = 0;
    compteurMtot = 0;
    compteurEtot = 0;
    compteurTtot = 0;
    compteurItot = 0;
    compteurE1tot = 0;
    compteurRtot = 0;

    for (int z = 0; z < questions.length; z++) {
      if (questions[z]['type'] == 'M') {
        compteurMtot++;
      } else if (questions[z]['type'] == 'É') {
        compteurEtot++;
      } else if (questions[z]['type'] == 'T') {
        compteurTtot++;
      } else if (questions[z]['type'] == 'I') {
        compteurItot++;
      } else if (questions[z]['type'] == 'E') {
        compteurE1tot++;
      } else if (questions[z]['type'] == 'R') {
        compteurRtot++;
      }
    }

    while (i < questions.length) {
      skipQuestion = false;

      print(i);
      for (int index = 0; index < commentairesMe.length; index++) {
        if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'M') {
          print(questions[i]['_id']);
          compteurM++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == "É") {
          print(questions[i]['_id']);
          compteurE++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'T') {
          print(questions[i]['_id']);
          compteurT++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'I') {
          print(questions[i]['_id']);
          compteurI++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'E') {
          print(questions[i]['_id']);
          compteurE1++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'R') {
          print(questions[i]['_id']);
          compteurR++;

          i++;
          skipQuestion = true;
        }
      }
      if (!skipQuestion) {
        i++;
      }
    }

    print(userData['profId']);

    setState(() {
      percentageM = (((compteurM.toDouble() / compteurMtot) * 100).toInt());
      percentageE1 = (((compteurE.toDouble() / compteurEtot) * 100).toInt());
      percentageT = (((compteurT.toDouble() / compteurTtot) * 100).toInt());
      percentageI = (((compteurI.toDouble() / compteurItot) * 100).toInt());
      percentageE2 = (((compteurE1.toDouble() / compteurE1tot) * 100).toInt());
      percentageR = (((compteurR.toDouble() / compteurRtot) * 100).toInt());

      percTot = (percentageE1 +
              percentageE2 +
              percentageI +
              percentageM +
              percentageR +
              percentageT) ~/
          6;

      isLoading = false;
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;

        _getCommentaires().then((data) {
          _getQuestions().then((data) {
            _updateCompteur();
          });
        });
      });
    });
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
        _refresh();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(
        userData: userData,
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Text("Défi photo",
                    style: TextStyle(
                      fontFamily: 'Arboria',
                    )),
                Opacity(
                  opacity: 0.5,
                  child: Text("Ma progression",
                      style: TextStyle(fontFamily: 'Arboria', fontSize: 16)),
                )
              ]),
              SizedBox(width: 43),
            ]),
      ),
      body: isLoading
          ? Container(
              color: Color(0xff141a24),
              child: Center(
                  child: SpinKitDoubleBounce(size: 40, color: Colors.white)))
          : new RefreshIndicator(
              child: Container(
                color: Color(0xff141a24),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index > 0) return null;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 15),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: Text('PROGRESSION PAR CATÉGORIE',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Arboria',
                                          color: Colors.white))),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Divider(
                                  height: 20,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Card(
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'M',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageM / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey,
                                      ),
                                      Text(
                                        '$percentageM%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'É',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageE1 / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey,
                                      ),
                                      Text(
                                        '$percentageE1%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'T',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageT / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey,
                                      ),
                                      Text(
                                        '$percentageT%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(24, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'I',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageI / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey,
                                      ),
                                      Text(
                                        '$percentageI%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'E',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageE2 / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey
                                        ,
                                      ),
                                      Text(
                                        '$percentageE2%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  color: Color(0xFF222b3b),
                                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'R',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      LinearPercentIndicator(
                                        width: 230.0,
                                        lineHeight: 14.0,
                                        percent: percentageR / 100,
                                        backgroundColor: Colors.grey[300],
                                        progressColor: Colors.blueGrey,
                                      ),
                                      Text(
                                        '$percentageR%',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.grey[750],
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'PROGRESSION TOTALE',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Arboria',
                                          color: Colors.white),
                                    ),
                                    Divider(
                                      height: 20,
                                      color: Colors.grey[800],
                                    ),
                                    CircularPercentIndicator(
                                      radius: 175.0,
                                      progressColor: Colors.blueGrey
                                      ,
                                      backgroundColor: Colors.grey[300],
                                      percent: percTot / 100,
                                      animation: true,
                                      lineWidth: 30.0,
                                      center: Text(
                                        '$percTot%',
                                        style: TextStyle(
                                            fontSize: 35.0,
                                            fontFamily: 'Arboria'),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              onRefresh: _refresh),
    );
  }
}
