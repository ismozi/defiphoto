import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'progression.dart';
import 'home.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
      Container(color:Colors.grey[900],
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                    radius: 55.0,
                  ),
                ),
                Positioned(
                    top: 12,
                    child: Container(
                        child: Text('Étudiant 1',
                            style: TextStyle(fontSize: 25)))),
                Positioned(
                    top: 50,
                    left: 1,
                    child: Container(
                        child: Text('Type de stage',
                            style: TextStyle(fontSize: 13)))),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Tableau de bord'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.portrait),
            title: Text('Profil'),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/screen3')},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Aide'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter'),
            onTap: () => {Navigator.of(context).pushReplacementNamed('/screen1')}
          ),
        ],
      )),
    );
  }
}
