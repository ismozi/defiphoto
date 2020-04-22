import 'package:flutter/material.dart';

class DrawerProf extends Drawer {
  String nom;
  String email;
  static double sizeboxD=38;

  DrawerProf(this.nom, this.email) 
      : super(
          elevation: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      '$nom',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.cyan[300],
                      radius: 60,
                      child: Text(
                          '${nom.substring(0, 1).toUpperCase()}'),
                    ),
                    onDetailsPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Acceuil')
                      ],
                    ),
                    onTap: () {},
                  ),
                  //    Divider(),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Mon Profil')
                      ],
                    ),
                    onTap: () {},
                  ),
                  //  Divider(),
                  // Divider(),
                  Divider(),
                  SizedBox(
                    height: sizeboxD,
                  ),
                  //Divider(),
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Aide')
                      ],
                    ),
                    onTap: () {},
                  ),
                  // Divider(),
                  ListTile(
                    leading: Icon(Icons.report),
                    title: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Signaler un problème')
                      ],
                    ),
                    onTap: () {},
                  ),
                  //Divider(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: (sizeboxD * 2) + 10,
                  ),
                  //      Divider(),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Text('Se déconnecter')
                      ],
                    ),
                    trailing: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    //TODO TROUVER UN ICON POUR DECONNEXTION
                    onTap: () {},
                  ),
                  Divider(),
                  Text('Version 64')
                ],
              ),
            ],
          ),


        );
}
