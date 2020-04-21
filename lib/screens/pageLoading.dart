




import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'modelVueProf.dart';
import 'pageProfEleveV2.dart';

class LoadingProf extends StatefulWidget {
  static final String text = 'Chargement...';

  @override
  _LoadingProfState createState() => _LoadingProfState();
}

class _LoadingProfState extends State<LoadingProf> {
  Professeur getDataProfesseur() {
    List<Etudiant> etudiants = [
      Etudiant('Prince', 'Madzou', 90, 'Walmart'),
      Etudiant('Ismael', 'Zirek', 100, 'Walmart'),
      Etudiant('Off', 'White', 90, 'Walmart'),
      Etudiant('Rebecka', 'Madzou', 1, 'Mcdo'),
      Etudiant('Prince', 'Madzou', 90, 'Walmart'),
      Etudiant('Rony', 'Mawad', 45, 'Walmart'),
      Etudiant('Foot', 'Locker', 90, 'FL'),
      Etudiant('Raouff', 'Babari', 2, 'Walmart'),
      Etudiant('Calvin', 'Klein', 90, 'Ck'),
      Etudiant('A', 'Bathin Bape', 90, 'Walmart'),
      Etudiant('Ryan', 'Kattoura', 70, 'Walmart'),
      Etudiant('Sports', 'Expert', 90, 'SportExpert'),
      Etudiant('Prince', 'Madzou', 90, 'Walmart'),
      Etudiant('Rami', 'Hawi', 89, 'Walmart'),
      Etudiant('Levi', 'Strauss', 90, 'Levis'),
      Etudiant('Prince', 'Madzou', 90, 'Walmart'),
      Etudiant('Kevin', 'Chan', 80, 'Walmart'),
      Etudiant('Toys', 'Roys', 90, 'Walmart'),
      Etudiant('Triple Stripes', 'Adidas', 90, 'Walmart'),
      Etudiant('Paul', 'Farid', 95, 'Walmart'),
      Etudiant('The', 'NorthFace', 90, 'TNF'),
      Etudiant('Prince', 'Madzou', 90, 'Walmart'),
      Etudiant('True', 'Religion', 90, 'TR'),
    ];

    List<Etudiant> etudiants1 = [
      Etudiant('Rich', 'TheKid', 100, 'The World Is Yours '),
      Etudiant('Jay', 'Critch', 100, 'RichForver'),
      Etudiant('Lil Uzi', 'Vert', 100, 'LuvIsRage 2'),
      Etudiant('Da', 'Baby', 10001, 'Kirk'),
      Etudiant('Koba', 'LaD', 100, "L'affranchi"),
      Etudiant('Lil ', 'Tecca', 100, 'We Love You Tecca'),
      Etudiant('Travis', 'Scott', 100, 'AstroWorld'),
      Etudiant('N', 'I', 100, 'Destin'),
      Etudiant('Zola', "L'abeille", 100, 'Cicatrices'),
      Etudiant('Charo', 'Niska', 100, 'Mr.Sal'),
      Etudiant('Tekashi', 'SixNine', 100, 'Dummy'),
      Etudiant('Dj', 'Mustard', 100, 'Perfect Teen'),
      Etudiant('Young', 'Thug', 100, 'So Much Fun'),
      Etudiant('Q.E', 'Favelas', 100, 'Bipolaire'),
      Etudiant('Dems', 'Damso', 100, 'Ipséité'),
      Etudiant('Y', 'H', 100, 'Cagoule Nwar'),
      Etudiant('Lil', 'Baby', 100, 'Drip Harder'),
    ];

    List<AnneScolaireProf> anneScolaire = new List<AnneScolaireProf>();
    List<Etudiant> recentEtudiant = [];
    List<Etudiant> recentEtudiant1 = [];
    AnneScolaireProf as =
    AnneScolaireProf(etudiants, 2019, 2020, 0, recentEtudiant);
    AnneScolaireProf as1 =
    AnneScolaireProf(etudiants1, 2018, 2019, 1, recentEtudiant1);

    anneScolaire.add(as);
    anneScolaire.add(as1);

    return Professeur('Monsieur Madzou.', anneScolaire);
  }

  void loadingPage(BuildContext context) async {
    Future.delayed(Duration(seconds: 10), () {
      // print('Rebecka caca');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PageProfEleve(professeur: getDataProfesseur())));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            LoadingProf.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.cyan[300]),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.cyan[300],
          size: 220,
        ),
      ),
    );
  }
}

class Loading extends StatefulWidget {
  bool basic;
  Duration duration;
  Widget widget2;

  Loading(this.basic, this.duration, this.widget2);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Widget getSpinKitAlleatoir() {
    Widget spinKit;
    double size = 220;
    Color color = Colors.cyan[200];
    int spin = Random().nextInt(7);
    switch (spin) {
      case 0:
        spinKit = SpinKitSquareCircle(
          size: size,
          color: color,
        );
        break;
      case 1:
        spinKit = SpinKitWave(
          color: color,
          size: size,
        );
        break;
      case 2:
        spinKit = SpinKitCubeGrid(
          size: size,
          color: color,
        );
        break;
      case 3:
        spinKit = SpinKitDualRing(
          size: size,
          color: color,
        );
        break;
      case 4:
        spinKit = SpinKitHourGlass(
          size: size,
          color: color,
        );
        break;
      case 5:
        spinKit = SpinKitPouringHourglass(
          size: size,
          color: color,
        );
        break;
      case 6:
        spinKit = SpinKitFadingCube(
          size: size,
          color: color,
        );
        break;
      case 7:
        spinKit = SpinKitFoldingCube(
          size: size,
          color: color,
        );
        break;
    }

    return spinKit;
  }

  Color savoirCouleur(bool noir) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingPage();
  }

  void loadingPage() async {
    Future.delayed(widget.duration, () {
      if (widget.basic == false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.widget2));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.widget2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            LoadingProf.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.cyan[300]),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: getSpinKitAlleatoir(),
      ),
    );
  }
}