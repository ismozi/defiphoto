import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/screens/information.dart';
import 'customDrawer.dart';
import 'pageQuestion.dart';
import '../widgets/fabbottomappbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget appBarTitle =
    Text('Matières et produits', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));

class MainPage extends StatefulWidget {
  
  mainPage createState() => new mainPage();
}

class mainPage extends State<MainPage> {

  List questions = [{}];
  List users = [{}];
  Map userData = {};
  int _currentIndex=0;
  String type;
  String section='M';
  bool isSearching = false;
  
  List filteredQuestionTab =[];
  List questionSectionTab=[];
  var questionSection;
  

 


  _getData() async {
     String id = userData["givenId"];
     var response;
     if(userData['role']== "P"){
    response = await http.get("https://defiphoto-api.herokuapp.com/questions/sender/$id"); 
     }
     if(userData['role']== "S"){
     response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
     }
     if (response.statusCode == 200){
       setState(() {
         questions =  json.decode(response.body);
       });     
     }
 }

  _getUser() async {
     var response = await http.get("https://defiphoto-api.herokuapp.com/users");
     if (response.statusCode == 200){
       setState(() {
         users =  json.decode(response.body);
       });     
     }
     
 }

 String _getUsername(String id){
   String name = "";
   for(int i=0; i<users.length; i++){
       if(id == users[i]['givenId']){
           name = users[i]['firstName'] + " " + users[i]['lastName'];
       }
     }
     return name;
 }

 void _selectedTab(int index) {
    setState(() {

      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
            section='M';
            _getQuestionSection();
            filteredQuestionTab=questionSectionTab;
      }
      else if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
        
        section='É';
        
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
        
      }
      else if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
        section='T';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
        section='I';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
        section='E';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontFamily: 'Arboria',fontSize: 15));
            section='R';
            _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
    });
  }

_getQuestionSection(){
  questionSectionTab = new List();
        _getData();

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
}

  _getBody(int currentIndex) {

    return Container(
      color: Color(0xff141a24),
      
    child:
    filteredQuestionTab.length>0 ?
    ListView.builder(
    itemCount: filteredQuestionTab.length,
    itemBuilder:  (context ,index){
      
      return 
      Padding(padding: EdgeInsets.fromLTRB(6, 15, 6, 2),
              child:
      Card(
              color:Color(0xFF222b3b),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  ),
              child: 
              ListTile(
                
                title: Text(filteredQuestionTab[index]["text"] ??'',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'Arboria'),
                ),
                subtitle: Text(_getUsername(filteredQuestionTab[index]["sender"])??"",style: TextStyle(fontFamily:'Arboria')),
                leading: Icon(Icons.work, size: 40),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                  
                
                 Navigator.pushNamed(context,'/pageCommentaire',arguments: {
                       'questionId': filteredQuestionTab[index]["id"],
                       'givenId' : userData['givenId'],
                       'role' : userData['role']
                  });
                },
              ),
            ));
        }
    ):Center(child:Text("Il n'y a pas de questions", style: TextStyle(color: Colors.blueGrey, fontSize: 20,letterSpacing: 1.2,fontFamily: 'Arboria' ))));


  }


Future<Null> _refresh() async{
   await Future.delayed(Duration(milliseconds: 500)).then((_) {
       setState(() {
           userData = ModalRoute.of(context).settings.arguments;
          _getData().then((data){
            _getQuestionSection();
            filteredQuestionTab=questionSectionTab;
          });         
        
       });  
       _getUser(); 
         
    });
  return null;
  }

  
  void _filterQuestions(value){
    setState(() {
      print(value);
      filteredQuestionTab = questionSectionTab.where((questionSection)=>questionSection["text"].toLowerCase().contains(value.toLowerCase())).toList();
      print(filteredQuestionTab);
    });
  }


@override
  void initState() {
    super.initState();
     _refresh();
     
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: !isSearching ? Container(color:Colors.grey[900],child:customDrawer(userData: userData,)):null,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color(0xff141a24),
              Color(0xFF2b3444)
            ])          
         ),        
     ),      
          title: !isSearching ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child:Text(
                  "Défi photo", 
                  style: TextStyle(fontFamily: 'Arboria',
                  
                ))) ,
                Opacity(
                  opacity: 0.5,
                  child: appBarTitle,
                )
              ]): 
              TextField(onChanged: (value){
                  _filterQuestions(value);
                },
                decoration:InputDecoration(icon: Icon(Icons.search),hintText: "Rechercher la question")),
          actions: <Widget>[
            !isSearching ?
            IconButton(icon: Icon(Icons.search), onPressed: () {
              setState(() {
                this.isSearching=true;
                
              });
            }):
            IconButton(icon: Icon(Icons.cancel), onPressed: () {
              setState(() {
                this.isSearching=false;
                filteredQuestionTab=questionSectionTab;
              });
            })
          ]),
      body: new RefreshIndicator(child: _getBody(_currentIndex), onRefresh: _refresh) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => (pageQuestion(userData["givenId"],userData['role']))));
          },
          backgroundColor: Color(0xff444d5d),
          child: Icon(Icons.question_answer, color:Colors.white)),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        selectedColor: Color(0xFF0d1118),
        notchedShape: CircularNotchedRectangle(),
        backgroundColor: Color(0xFF222b3b),
        items: [
          FABBottomAppBarItem(text: "M"),
          FABBottomAppBarItem(text: "É"),
          FABBottomAppBarItem(text: "T"),
          FABBottomAppBarItem(text: "I"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "R"),
        ],
      ),
      );
      
  }
  
}