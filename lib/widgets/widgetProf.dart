


import 'package:flutter/material.dart';

import 'modelVueProf.dart';
import 'searchPageV2.dart';

class ProfBottomSheet extends BottomSheet {
  String anneScolaire;
  DropdownButton dropdownButton;
  static final double radius = 30;

  ProfBottomSheet({this.anneScolaire, this.dropdownButton})
      : super(
    elevation: 20,
    builder: (BuildContext context) => Container(
        child: Center(
          child: Text(' C H A M G E R  A N N E   S C O L A I R E'),
        ),
        height: MediaQuery.of(context).size.height * 0.082,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            // TODO changer un peu le radius apres
            shape: BoxShape.rectangle,
            color: Colors.black45)),
    onClosing: () {},
    enableDrag: false,
  );
}

class ProfAppBar extends AppBar {
  String titre;
  Widget widgetTitre;
  bool centerTitre;
  Professeur professeur;
  BuildContext context;

  ProfAppBar(this.titre, this.centerTitre, this.professeur, this.context)
      : super(
    elevation: 7,
    title: Text(titre), // TODO  si mettre un widget c plus facile
    actions: [
      IconButton(
          onPressed: () {
            // TODO showSearch
            showSearch(
                context: context,
                delegate: SearchPage(
                    listEtudiant:
                    professeur.anneScolaireActuelle.listEtudiant,
                    hintText: 'Cherchez un étudiant...',
                    recentEtudiant:
                    professeur.anneScolaireActuelle.recentEtudiant));
          },
          icon: Icon(
            Icons.search,
            size: 20,
            color: Colors.white,
          )),
      IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
      Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.yellow[400],
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ),
    ],
    centerTitle: centerTitre,
  );
}
