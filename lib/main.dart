import 'package:flutter/material.dart';
import 'screens/mainPageStudent.dart';
import 'screens/login.dart';
import 'screens/progression.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
  
  routes: <String, WidgetBuilder> {
    '/screen1': (BuildContext context) => new Login(),
    '/screen2' : (BuildContext context) => new MainPage(),
    '/screen3' : (BuildContext context) => new Progression()
  },

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark
      ),
      
      home: Login(),
    
    );
  }
}