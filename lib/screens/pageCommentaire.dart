import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class pageCommentaire extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  pageCommentaire({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => pageCommentaireState();
}

class pageCommentaireState extends State<pageCommentaire> {
  //Map et liste pour stocker l'information sur question et les commentaires
  Map questionData = {};
  List commentaires = [{}];

  //Variables booléenne pour les différents états de l'application
  bool canScroll = true;
  bool isPlaying = false;
  bool _isRecording = false;
  bool _isLoading = true;

  //Controllers
  ScrollController _scrollController = new ScrollController();
  TextEditingController messageSend = new TextEditingController();

  //Fichier pour stocker l'image
  File imageFile;

  //Variables pour vérifier si le listView devrait scroll
  int currentMessageLenght;
  int previousMessageLenght = 0;

  //Instance du audioRecoder
  Recording _recording = new Recording();

  //Instance de AudioPlayer
  AudioPlayer audioPlayer = AudioPlayer();

  //Méthode qui permet de faire jouer un fichier audio
  play(String url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      isPlaying = true;
    }
  }

  //Méthode qui fait un appel à l'API pour obtenir les commentaire reliés à la question
  _getCommentaires() async {
    String id = questionData["questionId"];
    try {
      var response =
          await http.get("https://defiphoto-api.herokuapp.com/comments/$id");
      if (response.statusCode == 200 && this.mounted) {
        setState(() {
          _isLoading = false;
          commentaires = json.decode(response.body);
        });
      }
    } catch (e) {
      if (e is SocketException) {}
    }
  }

  //Méthode qui permet de commencer l'enregistrement audio
  _startRecording() async {
    try {
      if (await AudioRecorder.hasPermissions) {
        await AudioRecorder.start();

        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          _recording = new Recording(duration: new Duration(), path: "");
          _isRecording = isRecording;
        });
      } else {
        print("ACCEPT");
      }
    } catch (e) {
      print(e);
    }
  }

  //Méthode qui permet d'arrêter l'enregistrement audio
  _stopRecording() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = widget.localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
      _envoyerImage(recording.path);
    });
  }

  //Méthode qui permet de supprimer un commentaire
  _enleverCommentaire(dynamic message) async {
    String id = message['_id'];
    var response =
        await http.delete("https://defiphoto-api.herokuapp.com/comments/$id");
    if (response.statusCode == 200 && this.mounted) {
      print('Deleted');
    }
  }

  //Méthode qui permet de construie l'aspect visuel d'un commentaire (bulle)
  _buildCommentaire(dynamic message, bool isMe, bool isStudent, bool fromData) {
    String filePath;
    String url;
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
                child: fromData && !filePath.contains('m4a')
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
                                      size: 20, color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ))
                    : fromData && filePath.contains('.m4a')
                        ? InkWell(
                            onLongPress: () {
                              if (questionData['role'] == "P" ||
                                  questionData['role'] == "A") {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Avertissement',
                                          style:
                                              TextStyle(fontFamily: 'Arboria')),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Voulez-vous enlevez ce message?',
                                                style: TextStyle(
                                                    fontFamily: 'Arboria')),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Oui',
                                              style: TextStyle(
                                                  fontFamily: 'Arboria')),
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
                                              style: TextStyle(
                                                  fontFamily: 'Arboria')),
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
                            child: IconButton(
                                icon: Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                onPressed: () {
                                  if (this.mounted) {
                                    setState(() {
                                      play(url);
                                    });
                                  }
                                }))
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
                                          style:
                                              TextStyle(fontFamily: 'Arboria')),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Voulez-vous enlevez ce message?',
                                                style: TextStyle(
                                                    fontFamily: 'Arboria')),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Oui',
                                              style: TextStyle(
                                                  fontFamily: 'Arboria')),
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
                                              style: TextStyle(
                                                  fontFamily: 'Arboria')),
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

  //Méthode qui permet d'ouvrir la gallerie pour envoyer une photo
  _ouvrirGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null)
    _envoyerImage(image.path);
  }

  //Méthode qui permet d'ouvrir la caméra pour envoyer une photo
  _ouvrirCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image!=null)
    _envoyerImage(image.path);
  }

  //Méthode qui permet d'envoyer un commentaire
  _envoyerCommentaire(String text) async {
    if (text.trim().isNotEmpty) {
      var data = {
        "text": text.trim().toString(),
        "sender": questionData["givenId"].trim().toString(),
        "questionId": questionData["questionId"].toString(),
        "role": questionData["role"].toString()
      };
      try {
        var response = await http.post(
            "https://defiphoto-api.herokuapp.com/comments/noFile",
            body: data);
        if (response.statusCode == 200) {
          Timer(
              Duration(milliseconds: 1),
              () => _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent));
        }
      } catch (e) {
        if (e is SocketException) {}
      }
    }
  }
  //Méthode qui permet d'envoyer un image
  _envoyerImage(dynamic filePath) async {
    var reponse = await http.MultipartRequest(
        'POST', Uri.parse("https://defiphoto-api.herokuapp.com/comments/"))
      ..fields['sender'] = questionData["givenId"].trim().toString()
      ..fields['questionId'] = questionData["questionId"].toString()
      ..fields['role'] = questionData["role"].toString()
      ..files.add(await http.MultipartFile.fromPath('commentFile', filePath));
    var res = await reponse.send();
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
  //Méthode du "stream" qui permet de faire une mise à jour des messages en continu et de scroll la conversation
  //s'il y a un nouveau message
  void stream() async {
    Duration interval = Duration(milliseconds: 500);
    Stream<int> stream = Stream<int>.periodic(interval);
    await for (int i in stream) {
      if (this.mounted) {
        setState(() {
          if (!_isLoading) {
            currentMessageLenght = commentaires.length;
            if (currentMessageLenght > previousMessageLenght) {
              Timer(
                  Duration(milliseconds: 1),
                  () => _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent));
              previousMessageLenght = commentaires.length;
            }
          }
          questionData = ModalRoute.of(context).settings.arguments;
          _getCommentaires();
        });
      }
    }
  }
  
  //Méthode qui permet de scroll à la fin de la conversation lorsqu'on entre sur celle-ci
  Future<void> autoScrollStart() async {
    if (_scrollController.hasClients) {
      if (canScroll) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        canScroll = false;
      }
    }
  }

  //Méthode qui est appelé en premier, elle initialise le stream
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stream();
  }
  
  //Méthode qui permet de construire l'aspect visuel
  @override
  Widget build(BuildContext context) {
    bool isMe;
    bool isStudent;
    bool fromData;

    if (!_isLoading) autoScrollStart();

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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease);
                })
          ],
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
                        Visibility(
                            visible: _isLoading ? false : true,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Card(
                                  color: Color(0xFF2b3444),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Center(
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontFamily: 'Arboria'),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          questionData['text'])
                                                ],
                                              )))),
                                  elevation: 5,
                                ))),
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
                                      color: _isRecording
                                          ? Colors.red
                                          : Color(0xff444d5d),
                                      shape: BoxShape.circle),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.keyboard_voice,
                                      color: _isRecording
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (!_isRecording) {
                                          _startRecording();
                                        } else if (_isRecording) {
                                          _stopRecording();
                                        }
                                      });
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

//Classe et méthode qui permet d'appuyer sur une image pour la visualiser en plein écran
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
              initialScale: 0.5,
              minScale: 0.5,
            ))));
  }
}
