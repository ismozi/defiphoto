


import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'drawerProfV2.dart';
import 'modelVueProf.dart';
import 'widgetProf.dart';

class PageProfQuestion extends StatefulWidget {
  Professeur professeur;

  PageProfQuestion({@required this.professeur});

  @override
  _PageProfQuestionState createState() => _PageProfQuestionState();
}

class _PageProfQuestionState extends State<PageProfQuestion>
    with TickerProviderStateMixin {
  TabController tabController;
  int appBarTitle;
  static final int LENGTH = 6;
  static final List<String> listSection = [
    'Matière et produit',
    'Équipement',
    'Tâches et exigences',
    'Individu',
    'Environnement de travail',
    'Ressources humaines'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: LENGTH,
      vsync: this,
    )..addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          appBarTitle = tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        marginBottom: 65,
        elevation: 10,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black87,
        curve: Curves.elasticIn,
        tooltip: 'Action',
        children: [
          SpeedDialChild(
            child: Icon(Icons.question_answer),
            label: 'Ajouter une question au groupe',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () {},
            backgroundColor: Colors.cyan[300],
            elevation: 12,
          ),
          SpeedDialChild(
            child: Icon(Icons.question_answer),
            label: 'Ajouter une question a un stage en particulier',
            labelStyle: TextStyle(color: Colors.black),
            onTap: () {},
            backgroundColor: Colors.cyan[200],
            elevation: 12,
          ),
          SpeedDialChild(
            child: Icon(Icons.question_answer),
            label: "Ajouter une question a un groupe d'élève",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () {},
            backgroundColor: Colors.cyan[100],
            elevation: 12,
          ),
        ],

      ),
      appBar: ProfAppBar('Mes Questions', false, widget.professeur, context),
      drawer: DrawerProfWrap.side(drawer: DrawerProf(widget.professeur, context: context),radius: 40,),
      endDrawer: DrawerProfWrap.sideEnd(drawer: EndDrawerProf(professeur: widget.professeur),radius: 40,),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                bottom: TabBar(
                  // TODO ameliorer le tabBar
                  controller: tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.group_work),
                      text: 'M',
                    ),
                    Tab(
                      icon: Icon(Icons.business_center),
                      text: 'É',
                    ),
                    Tab(
                      icon: Icon(Icons.assignment),
                      text: 'T',
                    ),
                    Tab(icon: Icon(Icons.person), text: 'I'),
                    Tab(icon: Icon(Icons.language), text: 'E'),
                    Tab(
                      icon: Icon(Icons.group),
                      text: 'R',
                    ),
                  ],
                ),
                title: Text('${listSection[tabController.index]}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                leading: SizedBox(
                  width: 0.1,
                ),
                forceElevated: innerBoxIsScrolled,
                elevation: 10,
                actions: <Widget>[Container()],
                centerTitle: true,
                pinned: false,
                floating: true,
                snap: true,
              ),

            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
          controller: tabController,
        ),
      ),
      bottomSheet: ProfBottomSheet(),

    );
  }
}