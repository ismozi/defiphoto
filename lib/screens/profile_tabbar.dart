import 'package:flutter/material.dart';
import 'customDrawer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoEleve extends StatefulWidget { 
  infoEleve createState() => new infoEleve();
}

class infoEleve extends State<InfoEleve> {
  Map userData  = {};
  static String idStudent;
  static String name;
  static String lastName;
  static String stage;
  static String yearDebut;
  static String yearFin;
  static String mail;

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
          percentageT) ~/ 6;

_setInfo(){
  idStudent=userData["givenId"];
  print(idStudent);
  name=userData["firstName"];
  lastName=userData["lastName"];
  stage=userData["stageName"];
  mail=userData["email"];
  yearDebut=userData["yearDebut"];
  yearFin = userData["yearFin"];


}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration(milliseconds: 100)).then((_) {
       setState(() {
           userData = ModalRoute.of(context).settings.arguments;   
                
       _setInfo();
       });   
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index > 0) return null;
                      return Padding(
                        padding: EdgeInsets.fromLTRB(30, 40, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatar.jpg'),
                                radius: (55.0),
                              ),
                            ),
                            Divider(
                              height: 40,
                              color: Colors.grey[800],
                            ),
                            Text('ID',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                )),
                            SizedBox(height: 10),
                            Text('$idStudent',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Text('Prénom',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                )),
                            SizedBox(height: 10),
                            Text('$name',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Text('Nom',
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 2.0,
                                )),
                            SizedBox(height: 10),
                            Text('$lastName',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.accessibility_new,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  'Stage',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('$stage',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.assignment_ind,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  'Année',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('$yearDebut - $yearFin',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.mail,
                                      color: Colors.grey[400],
                                    ),
                                    Text(
                                      'Courriel',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Text('$mail',
                                    style: TextStyle(
                                        color: Colors.cyan,
                                        letterSpacing: 2.0,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index > 0) return null;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: Container(
                              color: Colors.grey[750],
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageM / 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageE1 / 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageT / 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageI / 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageE2 / 100,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    percent: percentageR / 100,
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
                                  radius: 200.0,
                                  progressColor: Colors.redAccent,
                                  backgroundColor: Colors.grey[300],
                                  percent: percTot / 100,
                                  animation: true,
                                  lineWidth: 30.0,
                                  center: Text(
                                    '$percTot%',
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
                      );
                    },
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
