import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter/models/database_helpers.dart';
import 'package:test_flutter/screens/pageQuestion.dart';



class customDrawer extends StatelessWidget {
  Map userData= {};
  customDrawer({this.userData});

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('givenId', null);
    prefs.setString('password', null);
    prefs.setString('firstName', null);
    prefs.setString('lastName', null);
    prefs.setString('email', null);
    prefs.setString('role', null);
    prefs.setString('stageName', null);
    prefs.setString('yearDebut', null);
    prefs.setString('yearFin', null);

  }
  


  @override
  Widget build(BuildContext context) {
    
    return Drawer(child:
      Container(color:Color(0xff141a24),
      child: ListView(
        
        padding: EdgeInsets.zero,
        
        children:  userData['role']=='S'&&userData['connection'] ? <Widget>[
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
                        child: Text(userData['firstName'] + " " +userData['lastName'],
                            style: TextStyle(fontFamily:'Arboria',fontSize: 25)))),
                Positioned(
                    top: 50,
                    left: 1,
                    child: Container(
                        child: Text(userData["stageName"],
                            style: TextStyle(fontFamily:'Arboria',fontSize: 13)))),
              ],
            ),
          ),
          
           ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Ma progression',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop()},
          ),
           ListTile(
            leading: Icon(Icons.message),
            title: Text('Questions de stage',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/questionsStage', arguments: userData)},
          ),
          
            ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Poser des questions',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => { print(userData['profID']),Navigator.push(context,MaterialPageRoute(builder: (context) => Questions(userData['profId'],userData['givenId'],userData['role'])))},
          ),
          ListTile(
            leading: Icon(Icons.portrait),
            title: Text('Profil',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/profilEleve', arguments: userData)},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Aide',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/pageAide')}
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter',style:TextStyle(fontFamily:'Arboria')),
            onTap: ()  {
              DatabaseHelper helper = DatabaseHelper.instance;
              helper.deleteAll();
              logout();
              Navigator.of(context).pushReplacementNamed('/login');}
          ),
        ]: userData['role']=='S'&&!userData['connection'] ? <Widget>[
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
                        child: Text(userData['firstName'] + " " +userData['lastName'],
                            style: TextStyle(fontFamily:'Arboria',fontSize: 25)))),
                Positioned(
                    top: 50,
                    left: 1,
                    child: Container(
                        child: Text(userData["stageName"],
                            style: TextStyle(fontFamily:'Arboria',fontSize: 13)))),
              ],
            ),
          ),
          
           ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Ma progression',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop()},
          ),
           ListTile(
            leading: Icon(Icons.message),
            title: Text('Questions de stage',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/questionsStage', arguments: userData)},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Aide',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/pageAide')}
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter',style:TextStyle(fontFamily:'Arboria')),
            onTap: ()  {
              DatabaseHelper helper = DatabaseHelper.instance;
              helper.deleteAll();
              logout();
              Navigator.of(context).pushReplacementNamed('/login');}
          )]: <Widget>[
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
                        child: Text(userData['firstName'] + " " +userData['lastName'],
                            style: TextStyle(fontFamily:'Arboria',fontSize: 25)))),
                Positioned(
                    top: 50,
                    left: 1,
                    child: Container(
                        child: Text('Superviseur de stages',
                            style: TextStyle(fontFamily:'Arboria',fontSize: 13)))),
              ],
            ),
          ),
          
           ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Mes élèves',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text("Questions d'élèves",style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(), Navigator.of(context).pushNamed('/questionsStage',
                                  arguments: userData)
                            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter',style:TextStyle(fontFamily:'Arboria')),
            onTap: () {
              logout();
              Navigator.of(context).pushReplacementNamed('/login');}
          ),
        ],
      )),
    );
  }
}
