import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List profs = [{}];
  List questions = [{}];

  _getProfs() async{
    var response = await http.get("https://defiphoto-api.herokuapp.com/users/sup");
    if (response.statusCode == 200&&this.mounted){
       setState(() {
         profs = json.decode(response.body);
       });    
        print(profs);   
     }
  }
  
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfs();
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
        body: (questions[0]["id"]==null) ? Container(
           color: Color(0xff141a24),
        child :   
           ListView.builder(
              itemCount: profs.length,
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
                          
                          title: Text((profs[index]["firstName"] +" "??"" +profs[index]["lastName"]??"") ??"",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'Arboria'),
                          ),
                          
                          subtitle: Text(profs[index]["givenId"]??"",style: TextStyle(fontFamily:'Arboria')),
                          contentPadding: EdgeInsets.all(20),
                          onTap: () {
                            
                          
                          //  Navigator.pushNamed(context,'/pageCommentaire',arguments: {
                          //        'questionId': filteredQuestionTab[index]["id"],
                          //        'givenId' : userData['givenId']
                            // });
                          },
                        ),
                      ));
                  }
              
        )) : Text('ya des questions my g') //Montrer les questions
        //  Container(
        //   color: Color(0xff141a24),
        //   child:Stack(children: <Widget>[
        //   Positioned.fill(
        //       child: Column(children: <Widget>[
        //     Expanded(child: Text('')
        //     ),
        //     Container(
        //         margin: EdgeInsets.all(15.0),
        //         height: 61,
        //         child: Row(
        //           children: <Widget>[
        //             Expanded(
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.circular(35.0),
        //                   boxShadow: [
        //                     BoxShadow(
        //                         offset: Offset(0, 3),
        //                         blurRadius: 5,
        //                         color: Colors.black)
        //                   ],
        //                 ),
        //                 child: Row(
        //                   children: <Widget>[
        //                     IconButton(
        //                         icon: Icon(Icons.send,color:Colors.black), 
        //                         onPressed: () {
        //                           _envoyerQuestion(messageSend.text);
        //                         }),
        //                     Expanded(
        //                       child: TextField(
        //                         style: new TextStyle(color: Colors.black),
        //                         controller:messageSend,
        //                         decoration: InputDecoration(
        //                             hintText: "Question",
        //                              hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        //                             border: InputBorder.none),
        //                       ),
        //                     ),
        //                     IconButton(
        //                       icon: Icon(Icons.photo_camera,color:Colors.black),
        //                       onPressed: () {_ouvrirCamera();},
        //                     ),
        //                     IconButton(
        //                       icon: Icon(Icons.photo,color:Colors.black),
        //                       onPressed: () {_ouvrirGallery();},
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             SizedBox(width: 15),
        //             Container(
        //               padding: const EdgeInsets.all(15.0),
        //               decoration: BoxDecoration(
        //                   color: Color(0xff444d5d), shape: BoxShape.circle),
        //               child: InkWell(
        //                 child: Icon(
        //                   Icons.keyboard_voice,
        //                   color: Colors.black,
        //                 ),
        //                 onLongPress: () {
        //                   setState(() {});
        //                 },
        //               ),
        //             )
        //           ],
        //         )),
        //   ]))
        // ]))
        );
  }
}
