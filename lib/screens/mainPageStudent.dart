import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/screens/information.dart';
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
  bool isSearching = false;
  
  List filteredQuestionTab =[];
  List questionSectionTab=[];
     var questionSection;
  

 


  getData() async {
  
     String id = userData["givenId"];
     var response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
     if (response.statusCode == 200&&this.mounted){
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
            _getQuestionSection();
            filteredQuestionTab=questionSectionTab;
      }
      else if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));
        
        section='É';
        
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
        
      }
      else if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));
        section='T';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));
        section='I';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));
        section='E';
        _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
      else if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));
            section='R';
            _getQuestionSection();
        filteredQuestionTab=questionSectionTab;
      }
    });
  }

_getQuestionSection(){
  questionSectionTab = new List();
        getData();

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

  getBody(int currentIndex){
    

    
    return Container(child:
    filteredQuestionTab.length>0 ?
    ListView.builder(
    itemCount: filteredQuestionTab.length,
    itemBuilder:  (context ,index){
      
      return 
      Padding(padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
              child:
      Card(
              color:Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  side: BorderSide(width: 1, color: Colors.grey[800])),
              child: 
              ListTile(
                leading: Icon(Icons.question_answer ,size: 40),
                title: Text(filteredQuestionTab[index]["text"] ??'',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(filteredQuestionTab[index]["sender"]??""),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                  
                
                 Navigator.pushNamed(context,'/pageCommentaire',arguments: {
                       'questionId': questionSectionTab[index]["id"],
                  });
                },
              ),
            ));
        }
    ):Center(child:CircularProgressIndicator()));


  }
@override
  void initState() {
    
    super.initState();
  
     Future.delayed(Duration(milliseconds: 500)).then((_) {
       setState(() {
           userData = ModalRoute.of(context).settings.arguments;
       
           
          getData().then((data){
            _getQuestionSection();
            filteredQuestionTab=questionSectionTab;
          });         
       });   
    });
  }
  void _filterQuestions(value){
    setState(() {
      print(value);
      filteredQuestionTab = questionSectionTab.where((questionSection)=>questionSection["text"].toLowerCase().contains(value.toLowerCase())).toList();
      print(filteredQuestionTab);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: !isSearching ? Container(color:Colors.grey[900],child:customDrawer(userData: userData,)):null,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
          title: !isSearching ? Column(
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