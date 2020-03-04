import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
      ),
      
      home: Login(),
    
    );
  }
}