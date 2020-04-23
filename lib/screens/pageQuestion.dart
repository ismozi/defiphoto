import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_flutter/screens/pageCommentaire.dart';

class pageQuestion extends StatefulWidget {
  String id;
  String role;
  pageQuestion(String id, String role){
    this.id = id;
    this.role = role;
  }

  @override
  State<StatefulWidget> createState() => pageQuestionState();
}

class pageQuestionState extends State<pageQuestion> {
  
  List questions = [{}];
  List users= [{}];
  File file;
  TextEditingController messageSend = new TextEditingController();
  bool isEmpty;
  bool isLoading=true;

  _getPeople() async{
    var response;
    if(widget.role == "P" || widget.role == "A"){
      response = await http.get("https://defiphoto-api.herokuapp.com/users/");
        }
    else{
      response = await http.get("https://defiphoto-api.herokuapp.com/users/profs");
      }
     
    if (response.statusCode == 200&&this.mounted){
       setState(() {
         users = json.decode(response.body);
       });    
        
     }
  }

  
  _ouvrirGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      file = image;
    });
  }

  _ouvrirCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      file = image;
    });
  }

  _getQuestions() async{
       var response;
      String id = widget.id;
      if(widget.role == "S"){
     response = await http.get("https://defiphoto-api.herokuapp.com/questions/sender/$id");
      }
      else{
         response = await http.get("https://defiphoto-api.herokuapp.com/questions/$id");
      }

     if (response.statusCode == 200 && this.mounted){
       setState(() {
         questions =  json.decode(response.body);
         if(questions.isNotEmpty){
           isEmpty = false;
           isLoading=false;
         }
         else{
           isEmpty = true;
             isLoading=false;
         }
       });     
     }
  }


  _stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
        await for(int i in stream){
        if(this.mounted){
          setState(() {
              _getPeople();
              _getQuestions();
          });
        }
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
    return Scaffold(
      backgroundColor: Color(0xFF222b3b),
        appBar: AppBar(
          flexibleSpace: Container(
          decoration: customBoxDecoration(),        
           ),      
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Poser une question',
                  style: TextStyle(fontFamily:'Arboria')
                ),
                Opacity(
                  opacity: 0.65,
                )
              ]),
        ),
        body: isLoading ? Center(child:SpinKitDoubleBounce(size: 40,color: Colors.white)) : 
       Container(
          decoration: customBoxDecoration(),
            child:
              ListView.builder(
              itemCount: users.length,
              itemBuilder:  (context ,index){
              return Padding(padding: EdgeInsets.fromLTRB(6, 15, 6, 2),
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
                title: Text(users[index]["firstName"] ??"",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'Arboria'),
                ),
                subtitle: Text(users[index]["lastName"]??"",style: TextStyle(fontFamily:'Arboria')),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Questions(users[index]['givenId'],widget.id,widget.role)));
                },
              ),
            )
        );
      })
    )
        );
  }
}

class Questions extends StatefulWidget {
 
  String idProf;
  String id;
  String role; 

  Questions(String idProf, String id, String role){
    this.idProf = idProf;
    this.id = id;
    this.role = role;
  }
  @override
  
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool isLoading = true;
  bool isEmpty;
  List questions = [{}];

  _getQuestions() async {
    var sender = widget.id;
    var reciever = widget.idProf;
    var data = {
         "sender" : sender.toString(),
        "recievers" : reciever.toString()
    };
    var response = await http.post("https://defiphoto-api.herokuapp.com/questions/auProfs", body:data);
     if (response.statusCode == 200 && this.mounted){
       setState(() {
         questions =  json.decode(response.body);
         if(questions.isEmpty){
           isEmpty = true;
           isLoading=false;
         }
         else{
           isEmpty = false;
           isLoading=false;
         }
       });     
     }
  }

 


    _stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
        await for(int i in stream){
        if(this.mounted){
          setState(() {
              _getQuestions();
          });
        }
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
    return Scaffold(
       backgroundColor: Color(0xFF222b3b),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
          flexibleSpace: Container(
          decoration:customBoxDecoration(),        
       ),      
     ),
     body: isLoading ? 
          Text("Loading...") : 
     isEmpty ? Text('Null') : Container(
          decoration:customBoxDecoration(),
            child:
              ListView.builder(
              itemCount: questions.length,
              itemBuilder:  (context ,index){
              return Padding(padding: EdgeInsets.fromLTRB(6, 15, 6, 2),
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
                title: Text(questions[index]["text"] ??"",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'Arboria'),
                ),
                subtitle: Text(questions[index]["sender"] != [widget.id]? "Me" : "Prof" ,style: TextStyle(fontFamily:'Arboria')),
                leading: Icon(Icons.question_answer, size: 40,),
                contentPadding: EdgeInsets.all(20),
                onTap: () {
                Navigator.pushNamed(context,'/pageCommentaire',arguments: {
                       'questionId': questions[index]["_id"].toString().trim(),
                       'givenId' : widget.id.toString().trim(),
                       'role' : widget.role.toString().trim()
                  });
                },
              ),
            )
        );
      })
    ),
       floatingActionButton: FloatingActionButton(
      onPressed: () {
         Navigator.push(context,MaterialPageRoute(builder: (context) => creationQuestion(widget.id,widget.idProf)));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.lightBlue.shade50,
      elevation: 5.0,
    ),
    );
  }
}


class creationQuestion extends StatefulWidget {
  String id;
  String idProf;

  creationQuestion(String id, String idProf){
    this.id = id;
    this.idProf = idProf;
  }
  
  @override
  _creationQuestionState createState() => _creationQuestionState();
}

class _creationQuestionState extends State<creationQuestion> {

     _envoyerQuestion(String text, String type) async {
       
        if(text.trim().isNotEmpty){
       var data = {
         "text" : text.trim().toString(),
         "sender" : widget.id.toString(),
        "recievers" : [widget.idProf.toString()],
        "type" : type.trim().toString()
    };
      var response = await http.post("https://defiphoto-api.herokuapp.com/questions", body : data);
         if(response.statusCode==200){
      print("Done!");
      }
        }
  }

TextEditingController questionText = new TextEditingController();
int _indexType;
List<String> types = ["M","É","T","I","E","R"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading : IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.pop(context)),  flexibleSpace: Container(decoration:customBoxDecoration())),
      backgroundColor: Color(0xFF2b3444),
      body: ListView(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            new Card(
              color:Color(0xFF222b3b),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  ),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 45, 15, 15),
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.black)
                          ],),
              child: TextField(
                          controller: questionText,
                          style: new TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: "QUESTION"),

                        ),
                      ),
                SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Color(0xFF2b3444),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.black)
                          ],
                            ),

              child: Column(children: [
                  Text("M.É.T.I.E.R."),
                Row(
                  children :[
                       Radio(
                    value: 0,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        _indexType = T;
                      });
                    },
                  ),
                     Radio(
                    value: 1,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        _indexType = T;
                      });
                    },
                  ),
                     Radio(
                    value: 2,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        _indexType = T;
                      });
                    },
                  ),
                     Radio(
                    value: 3,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        print(T);
                        _indexType = T;
                      });
                    },
                  ),
                     Radio(
                    value: 4,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        _indexType = T;
                      });
                    },
                  ),
                  
                     Radio(
                    value: 5,
                    groupValue: _indexType,
                    onChanged: (T){
                      setState(() {
                        _indexType = T;
                      });
                    },
                  ),
                  ]
               
                )
              ])
                      ),
                 
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                              setState(() {
                                _envoyerQuestion(questionText.text.toString().trim(),types[_indexType].toString().trim());
                                 Navigator.of(context).pop();
                              });
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xff444d5d),
                          child: Text(
                            'ENVOYER',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontFamily: 'Arboria',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                ])))
          ],
        ),
    );
  }
}

BoxDecoration customBoxDecoration(){
  return BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color(0xff141a24),
              Color(0xFF2b3444)
            ])          
         );
}