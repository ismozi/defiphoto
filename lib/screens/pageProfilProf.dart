

import 'package:flutter/material.dart';

import 'drawerProfV2.dart';
import 'modelVueProf.dart';

class PageProfProfil extends StatefulWidget {
  Professeur professeur;

  PageProfProfil({@required this.professeur});

  @override
  _PageProfProfilState createState() => _PageProfProfilState();
}

class _PageProfProfilState extends State<PageProfProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerProfWrap.side(drawer: DrawerProf(widget.professeur, context: context),radius: 40,),
      appBar: AppBar(
        title: Text('Mon Profil'),
      ),
      body: Center(
        child: Text('P R O F I L'),
      ),
    );
  }
}


