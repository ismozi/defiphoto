import 'package:flutter/material.dart';
//import 'menu.dart';

class InformationTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Container(color:Colors.grey[900],child:NavDrawer()),
      backgroundColor: Colors.grey[750],
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
      ),
      body: Padding(
        padding:EdgeInsets.fromLTRB(30, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius:(40.0),
              ),
            ),
            Divider(
              height:40,
              color:Colors.grey[800],
            ),
            Text('Prénom',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing:2.0,
                )),
            SizedBox(height:10),
            Text('Kevin',
                style:TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing:2.0,
                    fontSize:28,
                    fontWeight: FontWeight.bold
                )),
            SizedBox(height:20),
            Text('Nom',
                style:TextStyle(
                  color: Colors.grey,
                  letterSpacing:2.0,
                )),
            SizedBox(height:10),
            Text('Chan',
                style:TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing:2.0,
                    fontSize:27,
                    fontWeight: FontWeight.bold
                )),
            SizedBox(height:20),
            Row(
              children:<Widget>[
                Text('Stage',
                  style:TextStyle(
                    color:Colors.grey,
                    letterSpacing:2.0,
                  ),
                ),
                Icon(
                  Icons.accessibility_new,
                  color:Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height:10),
            Text('Plomberie',
                style:TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing:2.0,
                    fontSize:28,
                    fontWeight: FontWeight.bold
                )),
            SizedBox(height:20),
            Row(
              children:<Widget>[
                Text('Année',
                  style:TextStyle(
                    color:Colors.grey,
                    letterSpacing:2.0,
                  ),
                ),
                Icon(
                  Icons.assignment_ind,
                  color:Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height:10),
            Text('3',
                style:TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing:2.0,
                    fontSize:28,
                    fontWeight: FontWeight.bold
                )),
            SizedBox(height:20),
            Row(
              children: <Widget>[
                Icon(
                  Icons.mail,
                  color:Colors.grey[400],
                ),
                SizedBox(width:10),
                Text('plomberie123@gmail.com',
                    style:TextStyle(
                      color: Colors.grey[400],
                      letterSpacing:1.0,
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}