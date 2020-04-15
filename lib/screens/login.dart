import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainPageStudent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import '../data/user.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isLoading = false;
  TextEditingController givenId = new TextEditingController();
  TextEditingController passwd = new TextEditingController();

 void signIn(String id , String password) async {
    var data = {
        "givenId" : id.trim().toString(),
        "password" : password.trim().toString()
    };
    var response = await http.post("https://defiphoto-api.herokuapp.com/users/login", body : data);
    if (response.statusCode == 200){
      Map authData = json.decode(response.body);
      var token =  authData["token"];
      var userData =  Jwt.parseJwt(token);
      
      if (this.mounted){
      setState(() {
      _isLoading =false;
      if(userData["role"]=="S"){
        Navigator.pushReplacementNamed(context,'/mainPageStudent',arguments: {
          'givenId': userData["givenId"],
            'firstName': userData["firstName"],
            'lastName': userData["lastName"],
            'email': userData["email"],
            'role': userData["role"],
            'stageName' : userData['stageName'],
            'yearDebut' : userData['schoolYearBegin'],
            'yearFin' : userData['schoolYearEnd'],
        });
      }
      if(userData["role"]=="P"){
        ////main page pour les profs
      }
      if(userData["role"]=="A"){
        ////main page pour l'admin
      }
      });
    }
    }
   else {
         return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, 
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Erreur'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Mauvais Id ou Mot de passe!'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Re-essayer'),
                                          onPressed: () {
                                            if (this.mounted){
                                            setState(() {
                                            _isLoading= false;
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
     
     
    
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Container(
          color:Colors.grey[900],
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Image.asset(
              'assets/logo.png',
              width: 181,
              height: 151.0,
              
            ),
            ),
            SizedBox(
              height: 30.0,
            ),
            new Card(
              color:Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  side: BorderSide(width: 0.5, color: Colors.grey)),
                child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
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
                          controller: givenId,
                          style: new TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: "Id d'utilisateur"),

                        ),
                      ),
                SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.black)
                          ],
                            ),

              child: TextField(
                          controller: passwd,
                          style: new TextStyle(fontSize: 20, color: Colors.black),
                          obscureText: true,
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: "Mot-de-passe"),
                        ),
                      ),
                      
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: ()   {
                          _isLoading = true;
                           setState(() {
                              signIn(givenId.text, passwd.text);
                           });
                          
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.cyan,
                          child: Text(
                            'CONNEXION',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
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
      ),
    ));
  }
}

