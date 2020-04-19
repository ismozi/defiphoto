import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class pageQuestion extends StatefulWidget {
  final String txt;

  pageQuestion({
    this.txt,
  });

  @override
  State<StatefulWidget> createState() => pageQuestionState();
}

class pageQuestionState extends State<pageQuestion> {
  
  File imageFile;
  TextEditingController messageSend = new TextEditingController();

  _ouvrirGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = image;
    });
  }

  _ouvrirCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = image;
    });
  }

  _envoyerQuestion(String text){

  }

  
  
  @override
  Widget build(BuildContext context) {
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
        body: Container(
          color: Color(0xff141a24),
          child:Stack(children: <Widget>[
          Positioned.fill(
              child: Column(children: <Widget>[
            Expanded(child: Text('')
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
                                icon: Icon(Icons.send,color:Colors.black), 
                                onPressed: () {
                                  _envoyerQuestion(messageSend.text);
                                }),
                            Expanded(
                              child: TextField(
                                style: new TextStyle(color: Colors.black),
                                controller:messageSend,
                                decoration: InputDecoration(
                                    hintText: "Question",
                                     hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.photo_camera,color:Colors.black),
                              onPressed: () {_ouvrirCamera();},
                            ),
                            IconButton(
                              icon: Icon(Icons.photo,color:Colors.black),
                              onPressed: () {_ouvrirGallery();},
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Color(0xff444d5d), shape: BoxShape.circle),
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
