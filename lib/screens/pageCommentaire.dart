import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
  bool _isLoading = true;
  ScrollController _scrollController = new ScrollController();


  

  getCommentaires() async {
  
     String id = questionData["questionId"];
     var response = await http.get("https://defiphoto-api.herokuapp.com/comments/$id");
     if (response.statusCode == 200&&this.mounted){
       setState(() {
         
         _isLoading=false;
         commentaires = json.decode(response.body);
         
       });    
     }

 }


     _buildCommentaire(dynamic message, bool isMe, bool isStudent, bool fromData){
       String filePath;
       String url;
       if(fromData){
         filePath = message['fileName'];
         url = "https://defiphoto-api.herokuapp.com/comments/file/$filePath";
       }   
       return Padding(
         padding: EdgeInsets.all(10),
         child: Column(
          crossAxisAlignment: isMe ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
           children: <Widget>[
            // SizedBox(
            //   width: double.infinity,
            //   child: Align(
            //     alignment: isMe ? Alignment(0.8,0) :Alignment(-0.6,0) ,
            //     child: Text(isMe ? "Me" : message['sender'],style: TextStyle(color: Colors.grey[300])), 
            //   )
            //   ),
             SizedBox(height: 5,),
             Material(

               borderRadius: BorderRadius.circular(30),
               elevation: 7.0,
               color: isMe ? Colors.lightBlueAccent : (isStudent ? Colors.blueGrey : Colors.deepOrange),
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                 child: fromData ? 
                 Material(
                    child: InkWell(
                      onTap: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context) => imagePage(url)));
                      },
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(url,),
                        ),),
                    )
                )  
                 :Text(
                   message['text']?? "",
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
    var compImage = await _compresserImage(image,image.path);
    this.setState(() {
      imageFile = compImage;
    });
  }

  _ouvrirCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var compImage = await _compresserImage(image, image.path);
    this.setState(() {
      imageFile = compImage;
    });
  }

 Future<File> _compresserImage(File file, String targetPath) async {
        var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 180,
      );
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }

  _envoyerCommentaire(String text) async{
      var data = {
        "text" : text.trim().toString(),
        "sender" : questionData["givenId"].trim().toString(),
        "questionId" : questionData["questionId"].toString()
    };
    var response = await http.post("https://defiphoto-api.herokuapp.com/comments/noFile", body : data);
  }


    _envoyerImage(dynamic filePath) async {
       var reponse = await http.MultipartRequest('POST', Uri.parse("https://defiphoto-api.herokuapp.com/comments/"))
       ..fields['sender'] = questionData["givenId"].trim().toString()
       ..fields['questionId'] = questionData["questionId"].toString()
       ..files.add(await http.MultipartFile.fromPath('commentFile', filePath));
        var res = await reponse.send();
        if (res.statusCode == 200) print('Uploaded!');
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

  void stream() async {
  Duration interval = Duration(milliseconds: 500);
  Stream<int> stream = Stream<int>.periodic(interval);
  await for(int i in stream){
   if(this.mounted){
    setState(() {
          getCommentaires();
       });
   }
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionData = ModalRoute.of(context).settings.arguments;
    stream();
  }




  @override
  Widget build(BuildContext context) {
    // List<Message> commentaires = _gestionTab();
    bool isMe;
    bool isStudent;
    bool fromData;

    return Scaffold(
        appBar: AppBar(flexibleSpace: Container(
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
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed:() {Navigator.of(context).pop();}),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Répondre à la question',
                            style: TextStyle(fontFamily:'Arboria')
                ),
                Opacity(
                  opacity: 0.65,
                )
              ]),
        ),
        body: Container( color: Color(0xff141a24),
        
        child:new RefreshIndicator(child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(children: <Widget>[
              Positioned.fill(
                  child:  Column(children: <Widget>[
                Expanded(
                  child: 
                  _isLoading ? Center(child:SpinKitDoubleBounce(size: 40,color: Colors.white)) :
                  ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(15),
                    itemCount: commentaires.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      if(commentaires[i]['sender']!= null){
                       try{
                      
                          if(int.parse(commentaires[i]['sender']) is int){
                            if (commentaires[i]['sender'] == questionData["givenId"]){
                            
                              if(commentaires[i]['fileName'] != null){
                                isStudent=false;
                                isMe = true;
                                fromData = true;
                                return _buildCommentaire(commentaires[i], isMe, isStudent, fromData);
                             
                              }
                              else{
                                isStudent=false;
                                isMe = true;
                                fromData = false;
                                return _buildCommentaire(commentaires[i], isMe, isStudent, fromData);
                                  
                              }
                           
                            }


                            else{
                               if(commentaires[i]['fileName'] != null){
                                 isStudent=true;
                                  isMe = false;
                                  fromData = true;
                                  return _buildCommentaire(commentaires[i], isMe,isStudent,fromData);
                                 }
                                 else{
                                    isStudent=true;
                                  isMe = false;
                                  fromData = false;
                                  return _buildCommentaire(commentaires[i], isMe,isStudent,fromData);
                                 }
                               }
                            }

                      }
                      on FormatException catch(err){
                          if(commentaires[i]['fileName'] != null){
                        isStudent=false;
                        isMe = false;
                        fromData = true;
                        return _buildCommentaire(commentaires[i], isMe,isStudent,fromData);
                          }
                          else{
                            isStudent=false;
                        isMe = false;
                        fromData = false;
                        return _buildCommentaire(commentaires[i], isMe,isStudent,fromData);
                          }
                     
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
                                        _envoyerCommentaire(messageSend.text);
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
                                    _ouvrirCamera();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo, color: Colors.black),
                                  onPressed: () {
                                    _ouvrirGallery();
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
              ])
    )])), onRefresh: _refresh)));
  }
}

class imagePage extends StatefulWidget {
  String url;
  imagePage(String url){
   this.url = url;
  }

  @override
  _imagePageState createState() => _imagePageState();
  
}


class _imagePageState extends State<imagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),),
      body: Center(child :
      PinchZoomImage(
        image: Image.network(widget.url),
        zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
        hideStatusBarWhileZooming: true,
        onZoomStart: () {
            print('Zoom started');
        },
        onZoomEnd: () {
            print('Zoom finished');
        },
        )));
  }
}