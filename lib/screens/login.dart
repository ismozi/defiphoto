import 'package:flutter/material.dart';
import 'home.dart';


class Login extends StatelessWidget {
  

@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          elevation: 0.5,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                
              },
              child: Text("Register"),
              splashColor: Colors.amber,
              highlightColor: Colors.amber,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                  
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Username",
                        hintText: "Username"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    
                    obscureText: true,
                    decoration: 
                    
                    InputDecoration(
                        border: InputBorder.none,
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 10.0,
                  color: Colors.cyanAccent,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    color: Colors.cyanAccent,
                    child: Text("LOGIN"),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text('Mot-de-passe oublié?', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ));
  } }