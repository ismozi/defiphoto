import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'modelVueProf.dart';
import 'popupPageV2.dart';

class PageEtudiants extends StatefulWidget {
  Etudiant etudiant;
  Function delete;

  PageEtudiants({this.etudiant, this.delete});

  @override
  _PageEtudiantsState createState() => _PageEtudiantsState();
}

class _PageEtudiantsState extends State<PageEtudiants>
    with TickerProviderStateMixin {
  TabController tabController;
  //AnimationController _animationController;

  static final int NB_TAB = 3;
  static final double TAILE_ICON = 22;
  static final Color ICON_COLOR = Colors.white;

  

  PopupPage popupParametre;
  PopupPage popupModifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: NB_TAB, vsync: this, initialIndex: 1);
    popupParametre = new PopupPage.defaut(

      //TODO WIDGET POUR MODIFIER LES PARAMETRE
        Container(
          child: Text('Mettre les parametre'),
        ),
        context,
        'Parametre');
    popupModifier = new PopupPage.defaut(

      // TODO WIDGET POUR MODIFER L ELEVE
        Container(
          child: Text('Modifier levee'),
        ),
        context,
        "Modfier l'élève");
 //   _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 2500));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double bdSize = 17.1, bdSizeSub = 13;
    return BackdropScaffold(
      iconPosition: BackdropIconPosition.action,
      title: Text(widget.etudiant.nomComplet),
      backLayer: Container(
        color: Colors.black26,
        child: SafeArea(
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .09,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Stage'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Text(
                        'Nom: ${widget.etudiant.scolaireEtud.stage.stageName}'),
                    Text(
                        'Description ${widget.etudiant.scolaireEtud.stage.stageDesc}')
                  ],
                ),
              ),
              Divider(
                thickness: 4,
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  "Modifier l'élève",
                  style:
                  TextStyle(fontSize: bdSize, fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  "Modifier les informations de l'élève",
                  style: TextStyle(fontSize: bdSizeSub * 0.90,fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  popupModifier.showPopup();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Paramètres", style: TextStyle(fontSize: bdSize, fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  "Modifier les paramtres de questions de l'élèves",
                  style: TextStyle(fontSize: bdSizeSub * 0.90,fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  popupParametre.showPopup();
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  "Nouvelle question",
                  style:
                  TextStyle(fontSize: bdSize, fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  'Poser une question à cet élève ',
                  style: TextStyle(fontSize: bdSizeSub,fontStyle: FontStyle.italic),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Builder(
                builder: (context) => ListTile(
                  leading: Icon(Icons.delete,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Supprimer l'élève",
                    style: TextStyle(
                        fontSize: bdSize, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text('', style: TextStyle(fontSize: bdSizeSub,fontStyle: FontStyle.italic),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // todo essayer navigator.replace

                  },
                ),
              )
            ],
          ),
        ),
      ),
      frontLayer: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 15,
          bottom: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                text: 'Question',
                icon: Icon(Icons.question_answer),
              ),
              Tab(
                icon: Icon(Icons.account_circle),
                text: 'Profile',
              ),
              Tab(
                text: 'Progression',
                icon: Icon(Icons.fitness_center),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Text('Q U E S T I O N   E T U D I A N T S'),
              ),
            ),
            InformationEtudiant(widget.etudiant),
            ProgressionEtudiant(widget.etudiant.percentage),
          ],
          controller: tabController,
        ),
      ),
      headerHeight: MediaQuery.of(context).size.height * .30,
      frontLayerBorderRadius: BorderRadius.circular(15),
      animationCurve: Curves.slowMiddle,
     // controller: _animationController,
    );
  }
}

class InformationEtudiant extends Container {
  Etudiant etudiant;
  BoxDecoration boxDecoration;

  InformationEtudiant(this.etudiant, {this.boxDecoration})
      : super(
    child: CustomScrollView(
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
                        backgroundImage: NetworkImage('https://steamuserimages-a.akamaihd.net/ugc/862856504898300492/6F5F3C9B107871D10013A24FA18F60F68ED6555B/'),
                        radius: (70.0),
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
                    Text('${etudiant.idDonne}',
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
                    Text('${etudiant.prenom}',
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
                    Text('${etudiant.nom}',
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
                    Text('${etudiant.scolaireEtud.stage.stageName}',
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
                    Text('${etudiant.scolaireEtud.afficherAnne()}',
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
                        Text('${etudiant.email}',
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
    decoration: boxDecoration,
  );
}

class ProgressionEtudiant extends Container {
  PercentageEtud percentageEtud;
  BoxDecoration boxDecoration;

  ProgressionEtudiant(this.percentageEtud, {this.boxDecoration})
      : super(
    decoration: boxDecoration,
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
                            percent: percentageEtud.percentageM / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageM}%',
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
                            percent: percentageEtud.percentageE1 / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageE1}%',
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
                            percent: percentageEtud.percentageT / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageT}%',
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
                            percent: percentageEtud.percentageI / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageI}%',
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
                            percent: percentageEtud.percentageE2 / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageE2}%',
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
                            percent: percentageEtud.percentageR / 100,
                            backgroundColor: Colors.grey[300],
                            progressColor: Colors.cyan,
                          ),
                          Text(
                            '${percentageEtud.percentageR}%',
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
                          percent: percentageEtud.percTot / 100,
                          animation: true,
                          lineWidth: 30.0,
                          center: Text(
                            '${percentageEtud.percTot}%',
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
  );
}
