import 'package:flutter/material.dart';
import 'screens/home.dart';

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