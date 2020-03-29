import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoEleve extends StatelessWidget {
  static int percentageM = 10;
  static int percentageE1 = 50;
  static int percentageT = 63;
  static int percentageI = 59;
  static int percentageE2 = 25;
  static int percentageR = 38;

  String nom = 'Raouf';
  String nomFamille = 'Babari';
  String ecole = 'Bois de Boulogne';
  int id = 1826597;
  String courriel = 'raouf.babari@bdeb.qc.ca';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Container(color: Colors.grey[900], child: NavDrawer()),
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profil",
                ),
              ]),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.info)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius: 85.0,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ID: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            '$id ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Nom: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            '$nomFamille ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Prénom: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            '$nom ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'École: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            '$ecole ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Courriel: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.cyan,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            '$courriel ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'M',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageM%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'É',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageE1%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'T',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageT%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'I',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageI%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'E',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageE2%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.grey[750],
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'R',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.cyan,
                          ),
                        ),
                        LinearPercentIndicator(
                          width: 230.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey[300],
                          progressColor: Colors.cyan,
                        ),
                        Text(
                          '$percentageR%',
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[750],
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.redAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 160.0,
                        progressColor: Colors.redAccent,
                        backgroundColor: Colors.grey[300],
                        percent: 0.5,
                        animation: true,
                        lineWidth: 30.0,
                        center: Text(
                          '50%',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
