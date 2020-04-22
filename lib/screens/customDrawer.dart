import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class customDrawer extends StatelessWidget {
  Map userData= {};
  customDrawer({this.userData});

  // _getQuestions() async {
  //     String id = userData["givenId"];
  //    var response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
  //    if (response.statusCode == 200){
  //      setState(() {
  //        questions =  json.decode(response.body);
  //      });     
  //    }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(child:
      Container(color:Color(0xff141a24),
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
            title: Text('Tableau de bord',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.portrait),
            title: Text('Profil',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/progression', arguments: userData)},
          ),
            ListTile(
            leading: Icon(Icons.portrait),
            title: Text('Questions - Reponses',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {  Navigator.push(context,MaterialPageRoute(builder: (context) => Questions(users[index]['givenId'],widget.id,widget.role)));},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Aide',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pop(),Navigator.of(context).pushNamed('/aide')}
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Se déconnecter',style:TextStyle(fontFamily:'Arboria')),
            onTap: () => {Navigator.of(context).pushReplacementNamed('/login')}
          ),
        ],
      )),
    );
  }
}
