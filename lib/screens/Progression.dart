import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Progression extends StatelessWidget {
  double percentage = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: percentage,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: 0.5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: 0.5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: 0.5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: 0.5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                      color: Colors.cyanAccent,
                    ),
                  ),
                  LinearPercentIndicator(
                    width: 270.0,
                    lineHeight: 14.0,
                    percent: 0.5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.cyanAccent,
                  ),
                  Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.cyanAccent,
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
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
                CircularPercentIndicator(
                  radius: 180.0,
                  progressColor: Colors.redAccent,
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
    );
  }
}
