import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/screens/pageQuestion.dart';
import 'pageCommentaire.dart';
import 'package:test_flutter/models/message_model.dart';

class listViewWidget extends StatefulWidget {
  final String type;

  listViewWidget({this.type}){
    this.type;
  }
    
  

  @override
  State<StatefulWidget> createState() => listViewWidgetState();
}

class listViewWidgetState extends State<listViewWidget> {
 
  _gestionTab(){
    List<Message> questions= new List();
    for(int i=0;i<chats.length;i++){
      Message question = chats[i]; 
      
      if(widget.type==question.type){
        questions.add(question);
      }
    }
    return questions;
  }

   

  _affichageTxt (List<Message> questions,int position)  {
    Message question = questions[position];
  
    Text txt = Text(
                  question.text,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                );
  
   Card card = new Card(
                          color:Colors.grey[850],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              side: BorderSide(width: 0.5, color: Colors.grey)),
                          child: ListTile(
                            title: txt,
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) =>
                          (pageCommentaire(question.idConvo))));
                },
              ),
            );
            
    
    return card;

  }


  
  @override
  Widget build(BuildContext context) {
    List<Message> questions = _gestionTab();
    return Container(
      height: 4800,
      child: ListView.builder(
          itemCount: questions.length,
          itemExtent: 150,
          padding: const EdgeInsets.all(7.0),
          itemBuilder: (context, position) {
           return _affichageTxt(questions, position);
          }),
    );
  }
}
