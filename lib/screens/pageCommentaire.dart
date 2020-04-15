import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/models/message_model.dart';
import 'package:audio_recorder/audio_recorder.dart';
import '../widget/messageReceivedWidget.dart';
import '../widget/messageSentWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class pageCommentaire extends StatefulWidget {
  
  pageCommentaire();
  
  @override
  State<StatefulWidget> createState() => pageCommentaireState();
}

class pageCommentaireState extends State<pageCommentaire> {

  File imageFile;
  TextEditingController messageSend = new TextEditingController();
  Map questionData = {};
  List commentaires = [{}];


  

  getCommentaires() async {
  
     String id = questionData["questionId"];
     var response = await http.get("https://defiphoto-api.herokuapp.com/comments/$id");
     if (response.statusCode == 200){
       setState(() {
         commentaires = json.decode(response.body);
       });    
        print(commentaires); 
        
     }

 }


     _buildMessage(dynamic message, bool isMe){
       return Padding(
         padding: EdgeInsets.all(10),
         child: Column(
          crossAxisAlignment: isMe ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
           children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: isMe ? Alignment(0.8,0) :Alignment(-0.6,0) ,
                child: Text(isMe ? "Me" : message['sender'],style: TextStyle(color: Colors.grey[300])), 
              )
              ),
             SizedBox(height: 5,),
             Material(
               borderRadius: BorderRadius.circular(30),
               elevation: 7.0,
               color: isMe ? Colors.lightBlueAccent : Colors.blueGrey,
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                 child: Text(
                   message['text'],
                   style: TextStyle(
                     color:  Colors.white,
                     fontSize: 17.0,
                     fontWeight: FontWeight.bold,
                   ),
                   ),
               ),
             ),
           ],
         ) ,
       );
     }
  

  // _gestionTab() {
  //   print(widget.idConvo);
  //   List<Message> commentaires = new List();
  //   for (int i = 0; i < messages.length; i++) {
  //     Message commentaire = messages[i];
  //     if (widget.idConvo == commentaire.idConvo) {
  //       commentaires.add(commentaire);
  //     }
  //   }
  //   return commentaires;
  // }

  _ouvrirGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = image;
    });
  }

  _ouvrirCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = image;
    });
  }

  envoyerCommentaire(String text) async{
      var data = {
        "text" : text.trim().toString(),
        "sender" : questionData["givenId"].trim().toString(),
        "questionId" : questionData["questionId"].toString()
    };
    var response = await http.post("https://defiphoto-api.herokuapp.com/comments/noFile", body : data);
  }

  Future<Null> _refresh() async{
   await Future.delayed(Duration(milliseconds: 500)).then((_) {
      if(this.mounted){
       setState(() {
          questionData = ModalRoute.of(context).settings.arguments;
          getCommentaires();
       });
      }   
    });
  return null;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
   
  }




  @override
  Widget build(BuildContext context) {
    // List<Message> commentaires = _gestionTab();
    bool isMe;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed:() {Navigator.of(context).pop();}),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Répondre à la question',
                ),
                Opacity(
                  opacity: 0.65,
                )
              ]),
        ),
        body: new RefreshIndicator(child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(children: <Widget>[
              Positioned.fill(
                  child: Column(children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: commentaires.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      if(commentaires[i]['sender']!= null){
                       try{
                      
                      if(int.parse(commentaires[i]['sender']) is int){
                        isMe = true;
                        return _buildMessage(commentaires[i], isMe);
                        }
                    
                      }
                      on FormatException catch(err){
                        isMe = false;
                        return _buildMessage(commentaires[i], isMe);
                      }
                    
                      }
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(15.0),
                    height: 61,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 5,
                                    color: Colors.black)
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.send, color: Colors.black),
                                    onPressed: () {
                                      setState(() {
                                        envoyerCommentaire(messageSend.text);
                                        getCommentaires();
                                        messageSend.clear();
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    }),
                                Expanded(
                                  child: TextField(
                                    controller: messageSend,
                                    style: new TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: "Répondre",
                                        hintStyle: TextStyle(
                                            fontSize: 15.0, color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo_camera,
                                      color: Colors.black),
                                  onPressed: () {
                                    // _ouvrirCamera();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo, color: Colors.black),
                                  onPressed: () {
                                    // _ouvrirGallery();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.cyan, shape: BoxShape.circle),
                          child: InkWell(
                            child: Icon(
                              Icons.keyboard_voice,
                              color: Colors.black,
                            ),
                            onLongPress: () {
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    )),
              ]))
            ])), onRefresh: _refresh));
  }
}