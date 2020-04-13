import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/models/message_model.dart';

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


  

  getData() async {
  
     String id = questionData["questionId"];
     var response = await http.get("https://defiphoto-api.herokuapp.com/comments/$id");
     if (response.statusCode == 200){
       setState(() {
         commentaires = json.decode(response.body);
       });    
        print(commentaires); 
        
     }

 }

  _buildMessage(dynamic message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Colors.blueGrey : Colors.cyan,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 8.0),
          Text(
            message["text"],
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
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

  // _envoyerMessage() {
  //   messages.add(Message(
  //       sender: currentUser,
  //       time: '4:30 PM',
  //       text: messageSend.text,
  //       idConvo: widget.idConvo));
  // }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((_) {
      if(this.mounted){
       setState(() {
          questionData = ModalRoute.of(context).settings.arguments;
          getData();
       });
      }
    });
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
        body: GestureDetector(
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
                                        // _envoyerMessage();
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
            ])));
  }
}