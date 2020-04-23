import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';

class mainPageAdmin extends StatefulWidget {
  @override
  _mainPageAdminState createState() => _mainPageAdminState();
}

class _mainPageAdminState extends State<mainPageAdmin> {
  int _selectedIndex = 0;
  List users = [{}];
  List questions = [{}];
  List comments = [{}];
  Map userData = {};


 _getUsers() async {
     var response = await http.get("https://defiphoto-api.herokuapp.com/users");
     if (response.statusCode == 200){
       setState(() {
         users =  json.decode(response.body);
       });     
     }
 }

 _getQuestions() async {
     var response = await http.get("https://defiphoto-api.herokuapp.com/questions");
     if (response.statusCode == 200){
       setState(() {
         questions =  json.decode(response.body);
       });     
     }
 }

 _getComments() async {
     var response = await http.get("https://defiphoto-api.herokuapp.com/comments");
     if (response.statusCode == 200){
       setState(() {
         comments =  json.decode(response.body);
       });     
     }
 }

 _getData() {
        _getUsers();
        _getQuestions();
        _getComments();
 }
 
 Widget _getBody(int index){
   switch(index){
     case 0 :
     return _createList(users,true,false,false); 

     break;
     case 1:
     return _createList(questions,false,true,false); 
     break;
     case 2:
     return _createList(comments,false,false,true); 
     break;
   }

 }

 _createList(dynamic array, bool isUser, bool isQuestion, bool isComment){
   return ListView.builder(
     itemCount: array.length,
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
                
                title: Text(array[index]["text"] ??'',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'Arboria'),
                ),
                subtitle: Text(array[index]["sender"]??"",style: TextStyle(fontFamily:'Arboria')),
                leading: Icon(Icons.work, size: 40),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                  
              
                },
              ),
            ));
        }

     );

 }
  _stream() async {
  Duration interval = Duration(milliseconds: 500);
  Stream<int> stream = Stream<int>.periodic(interval);
  await for(int i in stream){
    _getData();
  }
}


 


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _stream();
  }






  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
          title: 
              Center(
                child: Text(
                    "Défi photo (Admin)", 
                    style: TextStyle(fontFamily: 'Arboria',
                  )),
              )
    ),
    backgroundColor: Color(0xff141a24),
    body: _getBody(_selectedIndex),
      bottomNavigationBar: GradientBottomNavigationBar(
        backgroundColorStart: Color(0xff141a24),
        backgroundColorEnd: Color(0xFF2b3444),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      );
  }

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
