import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'fabbottomappbar.dart';
import 'menu.dart';
import 'fabwithicons.dart';
import 'layout.dart';
import 'listViewWidget.dart';
import 'pageQuestion.dart';
import '../models/user.dart';

Widget appBarTitle =
    Text('Matières et produits', style: TextStyle(fontSize: 15));

class MainPage extends StatefulWidget {
 
  mainPage createState() => new mainPage();
}

class mainPage extends State<MainPage> {
  
  String _lastSelected = 'TAB: 0';
  String show = 'False';
  bool showOverlay = false;

  String type='M';
 

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';

      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontSize: 15));
            type='M';
      }
      if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));
        type='E1';
      }
      if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));
        type='T';
      }
      if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));
        type='I';
      }
      if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));
        type='E';
      }
      if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));
            type='R';
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
       type: type
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
