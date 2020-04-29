
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'modelVueProf.dart';



class PageProfQuestion extends StatefulWidget {
  Professeur professeur;
  SolidController solidController;
  int currentTabIndex;
  static final List<String> listSection = ['Matière et produit', 'Équipement', 'Tâches et exigences', 'Individu', 'Environnement de travail', 'Ressources humaines'];

  PageProfQuestion({@required this.professeur,this.solidController});

  @override
  _PageProfQuestionState createState() => _PageProfQuestionState();
}

class _PageProfQuestionState extends State<PageProfQuestion>
    with TickerProviderStateMixin {

  static final int LENGTH = 6;
 // static final List<String> listSection = ['Matière et produit', 'Équipement', 'Tâches et exigences', 'Individu', 'Environnement de travail', 'Ressources humaines'];
  static double iconSize=26;
  List<ScrollController> _listScroll=List(LENGTH);
  TabController tabController;
  int tabIndex;
  bool isHide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(
      length: LENGTH,
      vsync: this,
    )..addListener(() {tabListener();});
    tabController.animateTo(0,);
    widget.solidController=new SolidController();
    chargerScroll();
    //solidController.hide();

  }

  void tabListener() {
     if (!tabController.indexIsChanging) {
      setState(() {
        tabIndex = tabController.index;
        widget.currentTabIndex=tabController.index;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    scrollDispose();
    super.dispose();

  }

  void scrollDispose() {
    for(int i=0;i<_listScroll.length;i++){
      _listScroll[i].dispose();
    }

  }

  void chargerScroll(){
    for(int i=0;i<LENGTH;i++)
    _listScroll[i]=new ScrollController()..addListener((){

    });

  }

  @override
  Widget build(BuildContext context) {

    widget.solidController..addListener((){
      if(widget.solidController.isOpened){isHide=false;}
      else{isHide=true;}
    });

    return  NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[SliverOverlapAbsorber(
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
                title: Text('${PageProfQuestion.listSection[tabController.index]}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,fontStyle: FontStyle.italic),),
                leading: SizedBox(
                  width: 0.1,
                ),
                forceElevated: innerBoxIsScrolled,
                elevation: 10,
                actions: <Widget>[
                  IconButton(
                    onPressed: (){
                      _listScroll[tabController.index].animateTo(4301, duration: Duration(milliseconds: 2100), curve: Curves.easeInCirc);

                    },
                    icon: Icon(Icons.vertical_align_bottom),
                    tooltip: 'Aller en bas de la page',
                    iconSize: iconSize,
                  ),
                  IconButton(
                    icon: Icon(Icons.vertical_align_top),
                    onPressed: (){
                      _listScroll[tabController.index].animateTo(0, duration: Duration(milliseconds: 2100), curve: Curves.easeInCirc);
                    },
                    tooltip: 'Revenir en haut de la page',
                    iconSize: iconSize,

                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.sort,
                    size: iconSize,),
                  SizedBox(width: 10,),],
                centerTitle: true,
                pinned: false,
                floating: true,
                snap: true,
              ),

            ),],
        body: TabBarView(
          children: _listScroll.map((s)=>BodyQuestion(scrollController: s,)).toList(),
          controller: tabController,

        ),
      );

  }

}

class BodyQuestion extends Container{

  ScrollController scrollController;
  List list;
  static const double ITEM_TAILLE=92;

  BodyQuestion({this.scrollController, this.list}):super(
    child: DraggableScrollbar.semicircle(
           alwaysVisibleScrollThumb: false,
           scrollbarAnimationDuration: Duration(milliseconds: 2500),
          scrollbarTimeToFade: Duration(milliseconds: 1400),
          controller: scrollController,
         labelTextBuilder: (value)=>Text('${value ~/ITEM_TAILLE}',style: TextStyle(color: Colors.cyan),),
         child:ListView.builder(
             controller: scrollController,
             itemBuilder: (context,index)=>ListTile(title: Text('Question $index'),onTap: (){
               print(scrollController.position);
             },),
              itemCount: 100,

   ) //todo mettre le widget pour les questions
    ),

    );



}
