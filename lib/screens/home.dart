import 'package:flutter/material.dart';
import 'fabbottomappbar.dart';
import 'menu.dart';
import 'fabwithicons.dart';
import 'layout.dart';
import 'listViewWidget.dart';

Widget appBarTitle =
    Text('Matières et produits', style: TextStyle(fontSize: 15));

class MainPage extends StatefulWidget {
  Home createState() => new Home();
}

class Home extends State<MainPage> {
  String _lastSelected = 'TAB: 0';
  String show = 'False' ;
  bool showOverlay = false;

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';

      if (index == 0) {
        appBarTitle =
            Text('Matières et produits', style: TextStyle(fontSize: 15));
      }
      if (index == 1) {
        appBarTitle = Text('Équipement', style: TextStyle(fontSize: 15));
      }
      if (index == 2) {
        appBarTitle = Text('Tâches', style: TextStyle(fontSize: 15));
      }
      if (index == 3) {
        appBarTitle = Text('Individu', style: TextStyle(fontSize: 15));
      }
      if (index == 4) {
        appBarTitle = Text('Environnement', style: TextStyle(fontSize: 15));
      }
      if (index == 5) {
        appBarTitle =
            Text('Ressources humaines', style: TextStyle(fontSize: 15));
      }
    });
  }

  void overlay(){
   setState(() {
   if (showOverlay){
     showOverlay=false;
     show='FALSE';
    }
    else if (!showOverlay){
     showOverlay=true;
     show='TRUE';
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
      drawer: NavDrawer(),
      appBar: AppBar(
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
      body: listViewWidget(),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _selectedTab,
        selectedColor: Colors.cyanAccent,
        items: [
          FABBottomAppBarItem(text: "M"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "T"),
          FABBottomAppBarItem(text: "I"),
          FABBottomAppBarItem(text: "E"),
          FABBottomAppBarItem(text: "R"),
        ],
      ),
      
      
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mic, Icons.camera];
    return AnchoredOverlay(
      
      child: FloatingActionButton(
        onPressed: () {overlay();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
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
 
 