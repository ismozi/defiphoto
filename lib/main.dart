import 'package:flutter/material.dart';
import 'package:test_flutter/screens/information.dart';
import 'screens/mainPageStudent.dart';
import 'screens/login.dart';
import 'screens/pageCommentaire.dart';
import 'screens/information.dart';
import 'screens/profile_tabbar.dart';


void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
   
  
  routes: <String, WidgetBuilder> {
    '/login': (BuildContext context) => new Login(),
    '/mainPageStudent' : (BuildContext context) => new MainPage(),
    '/mainPageProf' : (BuildContext context) => new MainPage(),
    '/progression' : (BuildContext context) => new InfoEleve(),
    '/pageCommentaire' :(BuildContext context) => new pageCommentaire(),
    '/aide' : (BuildContext context) => new Inpage()

  },

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        secondaryHeaderColor: Colors.white,
        brightness: Brightness.dark
      ),
      
      initialRoute: '/login',
    
    );
  }
}