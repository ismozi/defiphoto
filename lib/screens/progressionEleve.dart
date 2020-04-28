import 'package:flutter/material.dart';
import 'customDrawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'customDrawer.dart';

class progressionEleve extends StatefulWidget {
  progressionEleveState createState() => new progressionEleveState();
}

class progressionEleveState extends State<progressionEleve> {
  Map userData = {};

  static int percentageM = 10;
  static int percentageE1 = 50;
  static int percentageT = 63;
  static int percentageI = 59;
  static int percentageE2 = 25;
  static int percentageR = 38;
  static int percTot = (percentageE1 +
          percentageE2 +
          percentageI +
          percentageM +
          percentageR +
          percentageT) ~/
      6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
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
      body: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'M',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageM / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageM%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'É',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageE1 / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageE1%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'T',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageT / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageT%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'I',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageI / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageI%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'E',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageE2 / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageE2%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'R',
                                style: TextStyle(
                                    fontSize: 28.0, fontFamily: 'Arboria'),
                              ),
                              LinearPercentIndicator(
                                width: 230.0,
                                lineHeight: 14.0,
                                percent: percentageR / 100,
                                backgroundColor: Colors.grey[300],
                                progressColor: Colors.cyan,
                              ),
                              Text(
                                '$percentageR%',
                                style: TextStyle(
                                    fontSize: 25.0, fontFamily: 'Arboria'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey[750],
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                              progressColor: Colors.cyan,
                              backgroundColor: Colors.grey[300],
                              percent: percTot / 100,
                              animation: true,
                              lineWidth: 30.0,
                              center: Text(
                                '$percTot%',
                                style: TextStyle(
                                    fontSize: 35.0, fontFamily: 'Arboria'),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
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
    );
  }
}
