import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customDrawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class mainPageEleve extends StatefulWidget {
  
  mainPageEleveState createState() => new mainPageEleveState();
}

class mainPageEleveState extends State<mainPageEleve> {
  //Données de l'utilisateur de l'application
  Map userData = {};

  //Variable de pourcentage pour chaque catégories
  static int percentageM = 0,
      percentageE1 = 0,
      percentageT = 0,
      percentageI = 0,
      percentageE2 = 0,
      percentageR = 0;

  //Compteur pour vérifier combien de question on été répondu par l'élève
  int compteurM, compteurE, compteurT, compteurI, compteurE1, compteurR;

  //Compteur pour vérifier combien de question sont destiné à l'élève
  int compteurMtot,
      compteurEtot,
      compteurTtot,
      compteurItot,
      compteurE1tot,
      compteurRtot,
      compteurTOT;

  //Pourcentage total
  int percTot;

  //Listes et Map pour stocker les commentaire et questions
  Map questionData = {};
  List commentaires = [{}];
  List questions = [{}];
  List commentairesMe = [{}];
  

  bool isLoading = true;
  bool hasConnection;
  
  

  //Appel à l'api pour obtenir tout les commentaires
  _getCommentaires() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userData['connection']) {
      try {
        var response =
            await http.get("https://defiphoto-api.herokuapp.com/comments");
        if (response.statusCode == 200) {
          commentaires = json.decode(response.body);
          print(prefs.getString('givenId'));
        }
           isLoading = false;
      } catch (e) {
        if (e is SocketException) {
          isLoading = false;
        }
      }
    }
  }

  //Appel à l'api pour obtenir tout les questions destinées à l'élève
  _getQuestions() async {
    if (userData['connection']) {
      String id = userData["givenId"];
      var response;
      id = userData["givenId"];

      try {
        response =
            await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
        if (response.statusCode == 200) {
          questions = json.decode(response.body);
        }
         isLoading = false;
      } catch (e) {
        if (e is SocketException) {
          isLoading = false;
        }
      }
    }
  }

  //Méthode pour filtrer les commentaires qui ont été envoyés par l'élève
  _getCommentaireMe() {
    for (int i = 0; i < commentaires.length; i++) {
      if (commentaires[i]['sender'] == userData['givenId']) {
        commentairesMe.add(commentaires[i]);
      }
    }
  }

  //Grosse méthode qui gère tout le calcul des pourcentages de la progression
  _updateCompteur() {
    _getCommentaireMe();
    bool skipQuestion = false;
    int i = 0;

    //Initialiser les compteur à 0
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
    compteurTOT = 0;

    //Boucle for pour compter le nombre de question total de chq catégorie
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

    //Boucle while pour compter le nombre de question répondu de chq catégorie
    while (i < questions.length) {
      skipQuestion = false;

      for (int index = 0; index < commentairesMe.length; index++) {
        if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'M') {
          compteurM++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == "É") {
          compteurE++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'T') {
          compteurT++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'I') {
          compteurI++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'E') {
          compteurE1++;

          i++;
          skipQuestion = true;
        } else if (i < questions.length &&
            (commentairesMe[index]['questionId'] == questions[i]['_id']) &&
            questions[i]['type'] == 'R') {
          compteurR++;

          i++;
          skipQuestion = true;
        }
      }
      if (!skipQuestion) {
        i++;
      }
    }

    //Setstate pour update les pourcentages affichés
    setState(() {
      if (compteurMtot != 0)
        percentageM = (((compteurM.toDouble() / compteurMtot) * 100).toInt());
      if (compteurEtot != 0)
        percentageE1 = (((compteurE.toDouble() / compteurEtot) * 100).toInt());
      if (compteurTtot != 0)
        percentageT = (((compteurT.toDouble() / compteurTtot) * 100).toInt());
      if (compteurItot != 0)
        percentageI = (((compteurI.toDouble() / compteurItot) * 100).toInt());
      if (compteurE1tot != 0)
        percentageE2 =
            (((compteurE1.toDouble() / compteurE1tot) * 100).toInt());
      if (compteurRtot != 0)
        percentageR = (((compteurR.toDouble() / compteurRtot) * 100).toInt());

      compteurTOT = compteurMtot +
          compteurEtot +
          compteurTtot +
          compteurItot +
          compteurE1tot +
          compteurRtot;

      percTot = ((compteurM.toDouble() +
                  compteurE.toDouble() +
                  compteurT.toDouble() +
                  compteurI.toDouble() +
                  compteurE1.toDouble() +
                  compteurR.toDouble()) /
              (compteurTOT) *
              100)
          .round();

      if (percTot != 100) {
        setState(() {
          userData = {
            'givenId': userData["givenId"],
            'firstName': userData["firstName"],
            'lastName': userData["lastName"],
            'email': userData["email"],
            'role': userData["role"],
            'profId': userData["profId"],
            'stageName': userData['stageName'],
            'yearDebut': userData['schoolYearBegin'],
            'yearFin': userData['schoolYearEnd'],
            'questionEleve': false,
            'connection': userData['connection'],
            'nouvQuestion': true,
          };
        });
      }

      print("COMPTEUR TOT: $compteurTOT");

      isLoading = false;
    });
  }

  //Méthode Future<null> pour refresh les commentaires lorsqu'on swipe
  //par vers le bas
  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      if (this.mounted) {
        setState(() {
          userData = ModalRoute.of(context).settings.arguments;

          _getCommentaires().then((data) {
            _getQuestions().then((data) {
              _updateCompteur();
            });
          });
        });
      }
    });
    return null;
  }

  refresh2(){
    if (ModalRoute.of(context).isCurrent&&this.mounted) {
        setState(() {
          _getCommentaires().then((data) {
            _getQuestions().then((data) {
              _updateCompteur();
            });
          });
        });
      }
  }

  //Méthode du stream que permet de vérifier si il y a une connexion internet et couvre toute
  //l'application
  void stream() async {
    Duration interval = Duration(milliseconds: 1000);
    Stream<int> stream = Stream<int>.periodic(interval);
    await for (int i in stream) {
      if (this.mounted) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            hasConnection = true;
            refresh2();
          } else {
            hasConnection = false;
          }
        } on SocketException catch (_) {
          hasConnection = false;
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

  //Première fonction qui est appelé, initialise les données d'utilisateur,
  //la méthode refresh ainsi que le stream
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
        hasConnection = userData['connection'];
        if (userData['connection']) _refresh();
        if (!userData['connection']) isLoading = false;

        stream();
      });
    });
  }

  //Méthode qui construit l'affichage
  @override
  Widget build(BuildContext context) {
    if (userData['connection'] != null && !isLoading) {
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
                    child: !userData['connection']
                        ? Text("Mode hors-ligne",
                            style:
                                TextStyle(fontFamily: 'Arboria', fontSize: 16))
                        : Text("Ma progression",
                            style:
                                TextStyle(fontFamily: 'Arboria', fontSize: 16)),
                  )
                ]),
                SizedBox(width: 43),
              ]),
        ),
        body: !userData['connection']
            ? Container(
                color: Color(0xff141a24),
                child: ListView(children: <Widget>[
                  SizedBox(height: 200),
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text:
                                  "Vous êtes en mode hors-ligne, \nvous pouvez donc seulement\n regarder vos questions de stage.\nVous pouvez prendre les photos demandées sur votre téléphone\n et les envoyer lorsque que vous\naurez une connexion internet.",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontFamily: 'Arboria')),
                          textAlign: TextAlign.center)),
                  SizedBox(height: 100)
                ]))
            :  Container(
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
                                          progressColor: Colors.blueGrey,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        progressColor: Colors.blueGrey,
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
                ) ?? Center(child:Text('Les pourcentages ne sont pas calculés')),
      );
    } else {
      return Scaffold(
          body: Container(
              color: Color(0xff141a24),
              child: Center(
                  child: SpinKitDoubleBounce(size: 40, color: Colors.white))));
    }
  }
}
