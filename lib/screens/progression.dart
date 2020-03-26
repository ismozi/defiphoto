import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'menu.dart';
class Progression extends StatelessWidget {
  int percentage = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(color:Colors.grey[900],child:NavDrawer()),
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
      ),
      body: Column(
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
                    percent: percentage/100,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '$percentage%',
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
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '50%',
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
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '50%',
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
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '50%',
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
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '50%',
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
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyan,
                  ),
                  Text(
                    '50%',
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
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
                CircularPercentIndicator(
                  radius: 160.0,
                  progressColor: Colors.blueGrey,
                  percent: 0.5,
                  animation: true,
                  lineWidth: 30.0,
                  center: Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}