

import 'dart:ui';

import 'package:draggable_scrollbar/draggable_scrollbar.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sider_bar/sider_bar.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'modelVueProf.dart';
import 'pageEtudiantV2.dart';



class PageProfEleve extends StatefulWidget {
  Professeur professeur;
  bool isSnackBarOn;
  PageProfEleve({@required this.professeur});

  @override
  _PageProfEleveState createState() => _PageProfEleveState();
}

class _PageProfEleveState extends State<PageProfEleve>
    with TickerProviderStateMixin {
  bool isReversed;
  List<String> listeLettre;
  List<int> listePosition;
  ScrollController _scrollController;
  SolidController _solidController;
  SlidableController _slidableController;
  AlphaBar alphaBar;
  int id;
  bool snack;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiserDonner();


  }

  void initialiserDonner() {
    isReversed = false;
    _scrollController = ScrollController();
    _solidController = SolidController();
    _slidableController = SlidableController();
    id = widget.professeur.anneScolaireActuelle.idPosition;
    filtrerList();
    alphaBar= new  AlphaBar(listeLettre, listePosition, _scrollController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_scrollController.dispose();
    //_solidController.dispose();
  }

  void filtrerList() {
    widget.professeur.anneScolaireActuelle.listEtudiant
        .sort((a, b) => a.nom.compareTo(b.nom));
    chargerList();
  }

  List getLettrePosition(bool lettre) {
    List<String> listLettre = [];
    List<int> listePosition = [];
    listLettre.add(widget.professeur.anneScolaireActuelle.listEtudiant[0].nom
        .substring(0, 1)
        .toUpperCase());
    listePosition.add(0);

    List listTemp = [];

    for (int i = 1;
        i < widget.professeur.anneScolaireActuelle.listEtudiant.length;
        i++) {
      if (widget.professeur.anneScolaireActuelle.listEtudiant[i].nom
              .substring(0, 1)
              .toUpperCase() !=
          widget.professeur.anneScolaireActuelle.listEtudiant[i - 1].nom
              .substring(0, 1)
              .toUpperCase()) {
        listePosition.add(i);

        listLettre.add(widget
            .professeur.anneScolaireActuelle.listEtudiant[i].nom
            .substring(0, 1)
            .toUpperCase());
      }
    }

    if (lettre == true) {
      listTemp = listLettre;
      //  print('${listLettre.length}');
    } else {
      listTemp = listePosition;
    }

    return listTemp;
  }

  void chargerList() {
    for (int i = 0;
        i < widget.professeur.anneScolaireActuelle.listEtudiant.length;
        i++) {
      widget.professeur.anneScolaireActuelle.listEtudiant
          .elementAt(i)
          .setIdSearch(i);
    }
    listeLettre = getLettrePosition(true);
    listePosition = getLettrePosition(false);
  }

  int savoirList(int index, List<Etudiant> listEtudiant, List<int> listPos, List<String> listString) {
    int debut, fin;
    int size;

    if (index == 0) {
      debut = 0;
      fin = debut + 1;

      size = listEtudiant.sublist(listPos[debut], listPos[fin]).length;
    } else {
      if (index <= listString.length - 2) {
        debut = index;
        fin = debut + 1;
        size = listEtudiant.sublist(listPos[debut], listPos[fin]).length;
      } else if (index == listString.length - 1) {
        size = listEtudiant.sublist(listPos[index]).length;
      }
    }

    return size;
  }

  Widget buildItem(BuildContext context, int i)=>StickyHeader(
    header: MyHeader('${listeLettre[i]}', context),
    content: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) =>Padding(
          padding:
          EdgeInsets.only(left: 68, right: 20, bottom: 18.5),
          child: Stack(children: [
            AnimateCardEtudiant(CardEtudiant(
                widget.professeur.anneScolaireActuelle
                    .listEtudiant[index + listePosition[i]],
                context),slidableController: _slidableController,),
            Positioned(
                top: 10,
                child: AnimatedCircleEtud(widget
                    .professeur
                    .anneScolaireActuelle
                    .listEtudiant[index + listePosition[i]]
                    .afficherInital()))
          ]),
        ),
      itemCount: savoirList(i, widget.professeur.anneScolaireActuelle.listEtudiant, listePosition, listeLettre),
      physics: NeverScrollableScrollPhysics(),

      //   itemExtent: 200,
    ),
  );

  @override
  Widget build(BuildContext context) => NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(elevation: 10,
                  leading: SizedBox(width: 0.1,),
                  actions: <Widget>[Container(),
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha),
                    onPressed: (){},
                    tooltip: '',

                    //disabledColor: Colors.red,
                  ),
                  ],
                  forceElevated: innerBoxIsScrolled,
                  expandedHeight: 20,
                  pinned: false,
                  snap: true,
                  floating: true,
                  title: Text('Année Actuelle : ${widget.professeur.anneScolaireActuelle.afficherAnne()}',
                    style: TextStyle(fontSize: 18.3,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),),
                  centerTitle: true,

                ))],
        body: SafeArea(
          bottom: true,
          top: true,
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [ListView.builder(
                     controller: _scrollController,
                     scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                     itemCount: listePosition.length,
                     itemBuilder: buildItem,
                  ), alphaBar])


            ),
         physics: NeverScrollableScrollPhysics(),
        );

}

class AnimateCardEtudiant extends StatefulWidget {
  CardEtudiant cardEtudiant;
  SlidableController slidableController;

  AnimateCardEtudiant(this.cardEtudiant,{this.slidableController});

  @override
  _AnimateCardEtudiantState createState() => _AnimateCardEtudiantState();
}

class _AnimateCardEtudiantState extends State<AnimateCardEtudiant>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0)).animate(curvedAnimation);
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: animation,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                offset: new Offset(0.0, 10.0),
              )
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.156484375,
          width: MediaQuery.of(context).size.width * (540 / MediaQuery.of(context).size.width),
          child: Slidable(
              actionPane: SlidableBehindActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                  icon: Icons.close,
                  onTap: () {},
                  caption: 'Fermer',
                ),
                IconSlideAction(
                  caption: 'Nouvelle Question',
                  onTap: () {},
                  icon: Icons.question_answer,
                ),
                IconSlideAction(
                  icon: Icons.more_horiz,
                  onTap: () {},
                  caption: 'Plus',
                ),
                IconSlideAction(
                  caption: 'Supprimer',
                  icon: Icons.delete,
                  color: Colors.red[900],
                   onTap: () {
                    showDialog(context: context, builder: (context)=>AlertDialog(
                 title: Text('Voulez-vous vraiment supprimer cet eleve'),
                 actions: <Widget>[
                   FlatButton.icon(onPressed: (){
                     Navigator.pop(context);
                     }, icon: Icon(Icons.cancel), label: Text('Annuler')),
                   FlatButton.icon(onPressed: (){
                      Navigator.pop(context);
                       }, icon: Icon(Icons.delete), label: Text('Supprimer')),
                  ],
                     )).then((onValue){

                       Scaffold.of(context).showSnackBar(SnackBar(duration:Duration(milliseconds: 4550),
                                  content: Text("L'élève a ete supprimer avec succès"),),);

                    });


                  },
                ),
              ],
              actionExtentRatio: .227,
              closeOnScroll: true,
              controller: widget.slidableController,
              child: widget.cardEtudiant),
        ));
  }


}

class AnimatedCircleEtud extends StatefulWidget {
  String content;
  static double TAILLE=100;
  AnimatedCircleEtud(this.content);

  @override
  _AnimatedCircleEtudState createState() => _AnimatedCircleEtudState();
}

class _AnimatedCircleEtudState extends State<AnimatedCircleEtud>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1290));
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutQuad);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FractionalTranslation(
        translation: Offset(-0.5, 0.2),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent, width: 1.0)),
          height: AnimatedCircleEtud.TAILLE,
          width: AnimatedCircleEtud.TAILLE,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/originals/f9/31/ec/f931ecb9fec522ec42a65e278ebe0080.gif'),
            child: Text(
              '${widget.content}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.2),
            ),
          ),
        ),
      ),
    );
  }
}

class CardEtudiant extends Card {
  Etudiant etudiant;
  BuildContext context;
  SlidableController controller;

  CardEtudiant(this.etudiant, this.context, {this.controller})
      : super(
            elevation: 5,
            child: InkWell(
              onTap: () {Navigator.of(context).push(PageTransition(
                child: PageEtudiants(etudiant: etudiant,),
                  type:PageTransitionType.slideLeft,
                  duration: Duration(milliseconds: 1490),
                  curve: Curves.elasticIn,),);},
              onDoubleTap: () {},
              onLongPress: () {},
              splashColor: Colors.cyan[100],
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: AnimatedCircleEtud.TAILLE/2 +5),
                    child: Center(child: Text('${etudiant.nomComplet}')),
                  ),

              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)));
}

class MyHeader extends Container {
  String text;
  BuildContext context;
  static final double HEIGHT = 0.02;

  MyHeader(this.text, this.context)
      : super(
          height: MediaQuery.of(context).size.height * HEIGHT,
          width: double.infinity,
          //decoration:BoxDecoration(), // gradient
          child: ClipPath(
            // todo  clipper: MyCustomClipper(),
            child: Text(
              '$text',
              style: TextStyle(
                  color: Colors.cyan[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.5),
            ),
          ),


        );
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path;



    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AlphaBar extends StatefulWidget {

  List<String> listeLettre;
  List<int> listPostion;
  ScrollController scrollController;


  AlphaBar(this.listeLettre, this.listPostion, this.scrollController);

  @override
  _AlphaBarState createState() => _AlphaBarState();
}

class _AlphaBarState extends State<AlphaBar>
    with SingleTickerProviderStateMixin {
  //todo mettre le siderbar dedans

  Animation animation;
  AnimationController animationController;

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 1600));
    CurvedAnimation curvedAnimation= CurvedAnimation(curve: Curves.slowMiddle,parent: animationController,);
    animation= Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
    animationController.forward();

  }

  @override
  void didUpdateWidget(AlphaBar oldWidget) {
        super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SideBar(
          list: widget.listeLettre, // todo arranger laffichage
          color: Colors.transparent,
          textColor: Colors.cyanAccent.withOpacity(0.5),
          valueChanged: (value){
            int index=widget.listeLettre.indexOf(value);
            int facteur=2;

            //todo trouver la methode pour deplacer
            //if(index==0){facteur=1;}
            // else if(index<=1){facteur=listePosition[index]-listePosition[index-1];}

            int a = index*130*facteur;
            double position = a.toDouble();
            widget.scrollController.jumpTo(position);

          },),




    );
  }
}
