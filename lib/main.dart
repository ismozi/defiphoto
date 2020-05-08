import 'package:flutter/material.dart';
import 'screens/questionsStage.dart';
import 'screens/login.dart';
import 'screens/mainPageProf.dart';
import 'screens/mainPageAdmin.dart';
import 'screens/pageCommentaire.dart';
import 'screens/pageAide.dart';
import 'screens/ajoutUtilisateur.dart';
import 'screens/mainPageEleve.dart';
import 'screens/profilEleve.dart';



void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RestartWidget(child: MaterialApp(
   debugShowCheckedModeBanner: false,
   
  
  routes: <String, WidgetBuilder> {
    '/login': (BuildContext context) => new Login(),
    '/questionsStage' : (BuildContext context) => new questionStage(),
    '/mainPageAdmin' : (BuildContext context) => new mainPageAdmin(),
    '/profilEleve' : (BuildContext context) => new profilEleve(),
    '/ajoutUtilisateur' : (BuildContext context) => new ajoutUtilisateur(),
    '/pageCommentaire' :(BuildContext context) => new pageCommentaire(),
    '/pageAide' : (BuildContext context) => new pageAide(),
    '/mainPageProf' : (BuildContext context) => new mainPageProf(),
    '/mainPageEleve' : (BuildContext context) => new mainPageEleve(),



  },

      theme: new ThemeData(
        primarySwatch: Colors.cyan,
        secondaryHeaderColor: Colors.white,
        brightness: Brightness.dark
      ),
      
      initialRoute: '/login',
    
    ));
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}