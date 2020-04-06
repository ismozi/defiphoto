import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/screens/main.dart';
import 'customDrawer.dart';
import 'pageQuestion.dart';
import '../data/user.dart';
import '../widget/fabbottomappbar.dart';
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
  String type;
  String section='M';
 


  getData() async {
  
     String id = userData["givenId"];
     
     var response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
     if (response.statusCode == 200){
       setState(() {
         questions =  json.decode(response.body);
       });     
     }
 }

 void _selectedTab(int index) {
    setState(() {

      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontSize: 15));
            section='M';
      }
      else if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));
        section='É';
      }
      else if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));
        section='T';
      }
      else if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));
        section='I';
      }
      else if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));
        section='E';
      }
      else if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));
            section='R';
      }
    });
  }



  getBody(int currentIndex){
     
     var questionSection;
     List questionSectionTab = new List();
        getData();
    
    
    print(section);

    for(var i=0; i < questions.length ; i++){
      questionSection = {
          "id":questions[i]["_id"],
          "sender":questions[i]["sender"],
          "text":questions[i]["text"]
        };
      if(questions[i]["type"]==section && questions[i]!= null){
        questionSectionTab.add(questionSection);     
      }
    }

    
    return Container(child:
    ListView.builder(
    itemCount: questionSectionTab.length,
    itemBuilder:  (context ,index){
      return Card(
              color:Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  side: BorderSide(width: 1, color: Colors.grey)),
              child: ListTile(
                leading: Icon(Icons.question_answer ,size: 40),
                title: Text(questionSectionTab[index]["text"] ??'',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(questionSectionTab[index]["sender"]??""),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                  
                
                 Navigator.pushReplacementNamed(context,'/pageCommentaire',arguments: {
                       'questionId': questionSection[index]["_id"],
                  });
                },
              ),
            );
        }
    ));


  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration(milliseconds: 100)).then((_) {
       setState(() {
           userData = ModalRoute.of(context).settings.arguments;
          getData();         
       });   
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Container(color:Colors.grey[900],child:customDrawer(userData: userData,)),
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
      body: getBody(_currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => (pageQuestion())));
          },
          backgroundColor: Colors.cyan,
          child: Icon(Icons.question_answer)),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        selectedColor: Colors.cyan,
        notchedShape: CircularNotchedRectangle(),
        backgroundColor: Colors.grey[900],
        items: [
          FABBottomAppBarItem(text: "M"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "T"),
          FABBottomAppBarItem(text: "I"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "R"),
        ],
      ),
      );
      
    
  
  }
  
}