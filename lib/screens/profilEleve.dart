import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'customDrawer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class profilEleve extends StatefulWidget {
  profilEleveState createState() => new profilEleveState();
}

class profilEleveState extends State<profilEleve> {
  Map userData = {};
  String idStudent;
  String name;
  String lastName;
  String stage;
  String stageDebut;
  String stageFin;
  String mail;
  String schoolYearBegin;
  String schoolYearEnd;
  String stageDesc;
  String role;
  String profId;
  
  Uint8List imageBytes;

  var users;

  var imageProfil;

  _setInfo() {
    idStudent = userData["givenId"];
    name = userData["firstName"];
    lastName = userData["lastName"];
    mail = userData["email"];
    schoolYearBegin = userData["yearDebut"];
    schoolYearEnd = userData["yearFin"];
    stage = userData["stageName"];
    stageDesc = userData["stageDesc"];
    stageDebut = userData["stageDebut"];
    stageFin = userData["stageFin"];
    role = userData["role"];
    profId = userData["profId"];
  }

  pickImage(String source) async {
    Navigator.of(context).pop();
    var image;
    if(source=='gallerie'){image = await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 640,maxHeight:480);}
    if(source=='pellicule'){image = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 640,maxHeight:480);}
    try {
      saveImageProfil(image);
    } catch (e) {}
  }

  saveImageProfil(var image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (image != null) {
      prefs.setString('profileImage', null);
      String encodedImage = base64Encode(image.readAsBytesSync());
      prefs.setString('profileImage', encodedImage);
      setState(() {
        RestartWidget.restartApp(context);
      });
    }
  }

  getImageProfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String base64Image = prefs.getString('profileImage');
    if (base64Image == null) {
      imageProfil = AssetImage('assets/avatar.jpg');
    } else if (base64Image != null) {
      imageBytes = base64Decode(base64Image);
      imageProfil = MemoryImage(imageBytes);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        userData = ModalRoute.of(context).settings.arguments;
        getImageProfil();
        _setInfo();
      });
    });
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
                  colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
        ),
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Profil", style: TextStyle(fontFamily: 'Arboria')),
            ]),
      ),
      body: Container(
        color: Color(0xff141a24),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index > 0) return null;
                  return Padding(
                    padding: EdgeInsets.fromLTRB(30, 15, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: MaterialButton(
                                  onPressed: () {
                                    return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return SimpleDialog(
                                            title: const Text(
                                                'Choisir une option',style: TextStyle(
                                                    fontFamily: 'Arboria')),
                                            children: <Widget>[
                                              SimpleDialogOption(
                                                onPressed: () async =>
                                                    pickImage('gallerie'),
                                                child: const Text(
                                                    'À partir de la gallerie',style: TextStyle(
                                                    fontFamily: 'Arboria')),
                                              ),
                                              SimpleDialogOption(
                                                onPressed: () async =>
                                                    pickImage('pellicule'),
                                                child: const Text(
                                                    'À partir de la pellicule',style: TextStyle(
                                                    fontFamily: 'Arboria')),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: imageProfil,
                                    radius: (55.0),
                                  ))
                              
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 25,
                          color: Colors.grey[800],
                        ),
                        SizedBox(height: 10),
                        Text('ID',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontFamily: 'Arboria',
                                color: Colors.grey)),
                        SizedBox(height: 10),
                        Text('$idStudent',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Text('Prénom',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontFamily: 'Arboria',
                                color: Colors.grey)),
                        SizedBox(height: 10),
                        Text('$name',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Text('Nom',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontFamily: 'Arboria',
                                color: Colors.grey)),
                        SizedBox(height: 10),
                        Text('$lastName',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Text('Enseignant',
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontFamily: 'Arboria',
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(userData['nomProf'] ?? "",
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.accessibility_new,
                              color: Colors.grey[400],
                            ),
                            Text('Stage',
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontFamily: 'Arboria',
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('$stage' + '\n' + '$stageDesc',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment_ind,
                              color: Colors.grey[400],
                            ),
                            Text('Année scolaire',
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontFamily: 'Arboria',
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('$schoolYearBegin - $schoolYearEnd',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment_ind,
                              color: Colors.grey[400],
                            ),
                            Text('Année de Stage',
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontFamily: 'Arboria',
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('$stageDebut - $stageFin',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 22,
                                fontFamily: 'Arboria')),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.mail,
                                  color: Colors.grey[400],
                                ),
                                Text('Courriel',
                                    style: TextStyle(
                                        letterSpacing: 2.0,
                                        fontFamily: 'Arboria',
                                        color: Colors.grey)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Text('$mail',
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontSize: 22,
                                    fontFamily: 'Arboria')),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
