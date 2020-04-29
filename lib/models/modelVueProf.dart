import 'dart:math';




class Etudiant {
  String _nom;
  String _nomComplet;
  String _prenom;
  String _stage;
  int _idDonne;
  String _email;
  int _progression;
  int idSearch;
  PercentageEtud percentage;
  AnneScolaireEtud scolaireEtud;

  Etudiant(this._prenom, this._nom, this._progression, this._stage) {
    this._nomComplet = _prenom + ' ' + _nom;
    this.scolaireEtud = AnneScolaireEtud(2019, 2020,
        stage: Stage(_stage, 'Commis chez $_stage'));
    this.percentage = PercentageEtud.defaut();
    this._idDonne = 1800000 + Random().nextInt(20000);
    this._email = "${_prenom.toLowerCase()}123@gmail.com";
  }

  String afficherProg() {
    return 'Progression : $_progression %';
  }

  String afficherStage() {
    return 'Stage : $_stage';
  }

  String afficherInital() {
    return '${_prenom.substring(0,1).toUpperCase()}${_nom.substring(0,1).toUpperCase()}';
  }

  void setIdSearch(int id) {
    this.idSearch = id;
  }

  int get progression => _progression;

  String get email => _email;

  int get idDonne => _idDonne;

  String get stage => _stage;

  String get prenom => _prenom;

  String get nomComplet => _nomComplet;

  String get nom => _nom;


}

class PercentageEtud {
  int percentageM = 10;
  int percentageE1 = 50;
  int percentageT = 63;
  int percentageI = 59;
  int percentageE2 = 25;
  int percentageR = 38;
  int percTot;

  PercentageEtud.custom(
      {this.percentageM,
        this.percentageE1,
        this.percentageT,
        this.percentageI,
        this.percentageE2,
        this.percentageR}) {
    calculTot();
  }

  PercentageEtud.defaut() {
    calculTot();
  }

  void calculTot() {
    this.percTot = (percentageE1 +
        percentageE2 +
        percentageI +
        percentageM +
        percentageR +
        percentageT) ~/
        6;
  }
}

class Professeur {
  String _nom;
  List<AnneScolaireProf> _anneScolaires;
  AnneScolaireProf anneScolaireActuelle;

  Professeur(this._nom, this._anneScolaires) {
    this.anneScolaireActuelle = this._anneScolaires[0];
  }

  void setAnneScolaireActuelle(int position) {
    this.anneScolaireActuelle = _anneScolaires[position];
  }

  List<AnneScolaireProf> get anneScolaires => _anneScolaires;

  String get nom => _nom;

}

class Stage {
  String _stageName;
  String _stageDesc;

  Stage(this._stageName, this._stageDesc);

  String get stageDesc => _stageDesc;

  String get stageName => _stageName;


}

abstract class AnneScolaire {
  int _schoolYearBegin;
  int _schoolYearEnd;

  AnneScolaire(this._schoolYearBegin, this._schoolYearEnd);

  String afficherAnne() {
    return '$_schoolYearBegin - $_schoolYearEnd';
  }
}

class AnneScolaireEtud extends AnneScolaire {
  int schoolYearBegin;
  int schoolYearEnd;
  Stage stage;

  AnneScolaireEtud(this.schoolYearBegin, this.schoolYearEnd, {this.stage})
      : super(schoolYearBegin, schoolYearEnd);
}

class AnneScolaireProf extends AnneScolaire {
  List<Etudiant> listEtudiant;
  int debut;
  int fin;
  int idPosition;
  List<Etudiant> recentEtudiant;

  AnneScolaireProf(this.listEtudiant, this.debut, this.fin, this.idPosition,
      this.recentEtudiant)
      : super(debut, fin);
}