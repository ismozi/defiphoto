import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Container(
          color:Colors.grey[900],
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: ListView(
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
                          style:
                              new TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: "Nom d'utilisateur"),
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
                          style:
                              new TextStyle(fontSize: 20, color: Colors.black),
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
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => MainPage()));
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
                      Center(
                        child: Text('Mot-de-passe oublié?',
                            style: TextStyle(color: Colors.white)),
                      )
                    ])))
          ],
        ),
      ),
    ));
  }
}
