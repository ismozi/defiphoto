import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
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

  _getCommentaires() async {
    String id = questionData["questionId"];
    var response =
        await http.get("https://defiphoto-api.herokuapp.com/comments/$id");
    if (response.statusCode == 200 && this.mounted) {
      setState(() {
        _isLoading = false;
        commentaires = json.decode(response.body);
      });
    }
  }

  _enleverCommentaire(dynamic message) async {
    String id = message['_id'];
    var response =
        await http.delete("https://defiphoto-api.herokuapp.com/comments/$id");
    if (response.statusCode == 200 && this.mounted) {
      print('Deleted');
    }
  }

  _buildCommentaire(dynamic message, bool isMe, bool isStudent, bool fromData) {
    String filePath;
    String url;
    Image alo;
    if (fromData) {
      filePath = message['fileName'];
      url = "https://defiphoto-api.herokuapp.com/comments/file/$filePath";
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
            elevation: 7.0,
            color: isMe
                ? Colors.lightBlueAccent
                : (isStudent ? Colors.blueGrey : Colors.deepOrange),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: fromData
                    ? Material(
                        child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => imagePage(url)));
                        },
                        child: Container(
                          color: isMe
                              ? Colors.lightBlueAccent
                              : (isStudent
                                  ? Colors.blueGrey
                                  : Colors.deepOrange),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: SpinKitWave(                                   
                                   size: 20, color: Colors.white
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ))
                    : InkWell(
                        onLongPress: () {
                          if (questionData['role'] == "P" ||
                              questionData['role'] == "A") {
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Avertissement',
                                      style: TextStyle(fontFamily: 'Arboria')),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Voulez-vous enlevez ce message?',
                                            style: TextStyle(
                                                fontFamily: 'Arboria')),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Oui',
                                          style:
                                              TextStyle(fontFamily: 'Arboria')),
                                      onPressed: () {
                                        if (this.mounted) {
                                          setState(() {
                                            _enleverCommentaire(message);
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Non',
                                          style:
                                              TextStyle(fontFamily: 'Arboria')),
                                      onPressed: () {
                                        if (this.mounted) {
                                          setState(() {
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          message['text'] ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
          ),
        ],
      ),
    );
  }

  _ouvrirGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var compImage = await _compresserImage(image,'/storage');
    this.setState(() {
      imageFile = image;
    });
    _envoyerImage(imageFile.path);
    // compImage.delete();
  }

  _ouvrirCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // var compImage = await _compresserImage(image, '/storage');
    this.setState(() {
      imageFile = image;
    });
    _envoyerImage(imageFile.path);
    // compImage.delete();
  }

//  Future<File> _compresserImage(File file, String targetPath) async {
//     try{
//         var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path, targetPath,
//         quality: 88,
//         rotate: 180,
//       );
//     print(file.lengthSync());
//     print(result.lengthSync());
//     return result;
//     }
//     catch(err){
//       print(err);
//       return file;
//     }
//   }

  _envoyerCommentaire(String text) async {
    if (text.trim().isNotEmpty) {
      var data = {
        "text": text.trim().toString(),
        "sender": questionData["givenId"].trim().toString(),
        "questionId": questionData["questionId"].toString(),
        "role": questionData["role"].toString()
      };
      var response = await http.post(
          "https://defiphoto-api.herokuapp.com/comments/noFile",
          body: data);
    }
  }

  _envoyerImage(dynamic filePath) async {
    var reponse = await http.MultipartRequest(
        'POST', Uri.parse("https://defiphoto-api.herokuapp.com/comments/"))
      ..fields['sender'] = questionData["givenId"].trim().toString()
      ..fields['questionId'] = questionData["questionId"].toString()
      ..fields['role'] = questionData["role"].toString()
      ..files.add(await http.MultipartFile.fromPath('commentFile', filePath));
    var res = await reponse.send();
    if (res.statusCode == 200) print('Uploaded!');
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      if (this.mounted) {
        setState(() {
          questionData = ModalRoute.of(context).settings.arguments;
          _getCommentaires();
        });
      }
    });
    return null;
  }

  void stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
    await for (int i in stream) {
      if (this.mounted) {
        setState(() {
          questionData = ModalRoute.of(context).settings.arguments;
          _getCommentaires();
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream();
  }

  @override
  Widget build(BuildContext context) {
    // List<Message> commentaires = _gestionTab();
    bool isMe;
    bool isStudent;
    bool fromData;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Répondre à la question',
                    style: TextStyle(fontFamily: 'Arboria')),
                Opacity(
                  opacity: 0.65,
                )
              ]),
        ),
        body: Container(
            color: Color(0xff141a24),
            child: new RefreshIndicator(
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Stack(children: <Widget>[
                      Positioned.fill(
                          child: Column(children: <Widget>[
                        Expanded(
                          child: _isLoading
                              ? Center(
                                  child: SpinKitDoubleBounce(
                                      size: 40, color: Colors.white))
                              : ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(15),
                                  itemCount: commentaires.length,
                                  itemBuilder: (BuildContext ctx, int i) {
                                    if (commentaires[i]['sender'] != null) {
                                      if (commentaires[i]['role'] ==
                                              questionData["role"] &&
                                          commentaires[i]['sender'] ==
                                              questionData['givenId']) {
                                        if (commentaires[i]['fileName'] !=
                                            null) {
                                          isStudent = false;
                                          isMe = true;
                                          fromData = true;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
                                        } else {
                                          isStudent = false;
                                          isMe = true;
                                          fromData = false;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
                                        }
                                      }

                                      if (commentaires[i]['role'] == "S" &&
                                          commentaires[i]['sender'] !=
                                              questionData['givenId']) {
                                        if (commentaires[i]['fileName'] !=
                                            null) {
                                          isStudent = true;
                                          isMe = false;
                                          fromData = true;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
                                        } else {
                                          isStudent = true;
                                          isMe = false;
                                          fromData = false;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
                                        }
                                      }

                                      if (commentaires[i]['role'] == "P" &&
                                          commentaires[i]['sender'] !=
                                              questionData['givenId']) {
                                        if (commentaires[i]['fileName'] !=
                                            null) {
                                          isStudent = false;
                                          isMe = false;
                                          fromData = true;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
                                        } else {
                                          isStudent = false;
                                          isMe = false;
                                          fromData = false;
                                          return _buildCommentaire(
                                              commentaires[i],
                                              isMe,
                                              isStudent,
                                              fromData);
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
                                            icon: Icon(Icons.send,
                                                color: Colors.black),
                                            onPressed: () {
                                              setState(() {
                                                _envoyerCommentaire(
                                                    messageSend.text);
                                                messageSend.clear();
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                              });
                                            }),
                                        Expanded(
                                          child: TextField(
                                            controller: messageSend,
                                            style: new TextStyle(
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                                hintText: "Répondre",
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
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
                                          icon: Icon(Icons.photo,
                                              color: Colors.black),
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
                                      color: Color(0xff444d5d),
                                      shape: BoxShape.circle),
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
                    ])),
                onRefresh: _refresh)));
  }
}

class imagePage extends StatefulWidget {
  String url;
  imagePage(String url) {
    this.url = url;
  }

  @override
  _imagePageState createState() => _imagePageState();
}

class _imagePageState extends State<imagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
          ),
        ),
        body: Container(
            color: Color(0xff141a24),
            child: Center(
                child: PhotoView(
              imageProvider: NetworkImage(widget.url),
              backgroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
              initialScale: 1.0,
              minScale: 0.5,
            ))));
  }
}
