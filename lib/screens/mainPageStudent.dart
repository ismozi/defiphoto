import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'menu.dart';
import 'fabwithicons.dart';
import 'layout.dart';
import 'pageQuestion.dart';
import '../data/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget appBarTitle =
    Text('Matières et produits', style: TextStyle(fontSize: 15));

class MainPage extends StatefulWidget {
  mainPage createState() => new mainPage();
}

class mainPage extends State<MainPage> {

  List questions = [{}];
  Map userData = {};
  int _currentIndex=0;


void getData() async {
  
     String id = userData["givenId"];
     var response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
     if (response.statusCode == 200){
       if(this.mounted){
       setState(() {
         questions = json.decode(response.body);
       });
       }
     }
 }


Widget createQuestionWidgets(){
 
  return ListView.builder(
    itemCount: questions.length,
    itemBuilder:  (context ,index){
      return Card(
              color:Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  side: BorderSide(width: 0.5, color: Colors.grey)),
              child: ListTile(
                title: Text(questions[index]["text"] ?? '',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(questions[index]["sender"]??""),
                contentPadding: EdgeInsets.all(10),
                onTap: () {
                
                 Navigator.pushReplacementNamed(context,'/mainPageStudent',arguments: {
                       'questionId': questions[index]["_id"],
                  });
                },
              ),
            );
        }
    );
}


  String type;
 

  void _selectedTab(int index) {
    setState(() {
      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontSize: 15));
            type='M';
      }
      if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));
        type='É';
      }
      if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));
        type='T';
      }
      if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));
        type='I';
      }
      if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));
        type='E';
      }
      if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));
            type='R';
      }
    });
  }


  
  
  @override
  Widget build(BuildContext context) {

  userData = ModalRoute.of(context).settings.arguments;
  getData();


    return Scaffold(
      drawer: Container(color:Colors.grey[900],child:NavDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Défi photo",
                ),
                Opacity(
                  opacity: 0.65,
                  child: appBarTitle,
                )
              ]),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ]),
      body: createQuestionWidgets() ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
      // body: listViewWidget(
      //  type: type
      // ),
        backgroundColor: Colors.grey[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("M")
          ),
          BottomNavigationBarItem(
               icon: Icon(Icons.scanner),
            title: Text("É")
          ),
          BottomNavigationBarItem(
               icon: Icon(Icons.group_work),
            title: Text("T")
          ),
          BottomNavigationBarItem(
               icon: Icon(Icons.people),
            title: Text("I")
          ),
          BottomNavigationBarItem(
               icon: Icon(Icons.work),
            title: Text("E")
          ),
          BottomNavigationBarItem(
               icon: Icon(Icons.people),
            title: Text("R")
          ),
        ],
           onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
        },
        ),
      
    );
  
  }
  
}
