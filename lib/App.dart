import 'package:flutter/material.dart';
import 'package:test_flutter/screens/Progression.dart';
import 'screens/home.dart';
import 'screens/Progression.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
      ),
      
      home: MainPage(),
    
    );
  }
}