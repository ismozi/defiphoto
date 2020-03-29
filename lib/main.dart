import 'package:flutter/material.dart';
import 'screens/mainPageStudent.dart';
import 'screens/login.dart';
import 'screens/progression.dart';
import 'screens/pageCommentaire.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
  
  routes: <String, WidgetBuilder> {
    '/login': (BuildContext context) => new Login(),
    '/mainPageStudent' : (BuildContext context) => new MainPage(),
    '/progression' : (BuildContext context) => new Progression(),
    '/pageQuestion' :(BuildContext context) => new pageCommentaire()
  },

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark
      ),
      
      home: Login(),
    
    );
  }
}