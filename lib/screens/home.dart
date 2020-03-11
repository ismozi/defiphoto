import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'fabbottomappbar.dart';
import 'menu.dart';
import 'fabwithicons.dart';
import 'layout.dart';
import 'listViewWidget.dart';
import 'pageQuestion.dart';

Widget appBarTitle =
    Text('Matières et produits', style: TextStyle(fontSize: 15));

class MainPage extends StatefulWidget {
  Home createState() => new Home();
}

class Home extends State<MainPage> {
  String _lastSelected = 'TAB: 0';
  String show = 'False';
  bool showOverlay = false;
  List<String> txt1 = [
    "Question sur les produits 1",
    "Question sur les produits 2"
  ];
  int nbItem = 2;

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';

      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontSize: 15));

        txt1 = ["Question sur les produits 1", "Question sur les produits 2"];
        nbItem = txt1.length;
      }
      if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));

        txt1 = [
          "Question sur l'équipement 1",
          "Question sur l'équipement 2",
          "Question sur l'équipement 3"
        ];
        nbItem = txt1.length;
      }
      if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));

        txt1 = ["Question sur les tâches 1"];
        nbItem = txt1.length;
      }
      if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));

        txt1 = ["Question sur les individus 1", "Question sur les individus 2"];
        nbItem = txt1.length;
      }
      if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));

        txt1 = [
          "Question sur l'environnement 1",
          "Question sur l'environnement 2",
          "Question sur l'environnement 3",
          "Question sur l'environnement 4",
          "Question sur l'environnement 5",
          "Question sur l'environnement 6"
        ];
        nbItem = txt1.length;
      }
      if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));

        txt1 = [
          "Question sur les ressources humaines 1",
          "Question sur les ressources humaines 2"
        ];
        nbItem = txt1.length;
      }
    });
  }

  void overlay() {
    setState(() {
      if (showOverlay) {
        showOverlay = false;
        show = 'FALSE';
      } else if (!showOverlay) {
        showOverlay = true;
        show = 'TRUE';
      }
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(color:Colors.grey[900],child:NavDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Défi photo",
                ),
                Opacity(
                  opacity: 0.65,
                  child: appBarTitle,
                )
              ]),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ]),
      body: listViewWidget(
        txt: txt1,
        nbItem: nbItem,
      ),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        selectedColor: Colors.cyan,
        notchedShape: CircularNotchedRectangle(),
        backgroundColor: Colors.grey[900],
        items: [
          FABBottomAppBarItem(text: "M"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "T"),
          FABBottomAppBarItem(text: "I"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "R"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => (pageQuestion())));
          },
          backgroundColor: Colors.cyan,
          child: Icon(Icons.question_answer)),
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mic, Icons.camera];
    return AnchoredOverlay(
      child: FloatingActionButton(
        onPressed: () {
          overlay();
        },
        tooltip: 'Increment',
        child: Icon(Icons.question_answer),
        elevation: 2.0,
      ),
      showOverlay: showOverlay,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
    );
  }
}
