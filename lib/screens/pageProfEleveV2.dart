
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'drawerProfV2.dart';
import 'modelVueProf.dart';
import 'pageEtudiantV2.dart';
import 'widgetProf.dart';



class PageProfEleve extends StatefulWidget {
  Professeur professeur;

  PageProfEleve({@required this.professeur});

  @override
  _PageProfEleveState createState() => _PageProfEleveState();
}

class _PageProfEleveState extends State<PageProfEleve>
    with TickerProviderStateMixin {
  bool isReversed;
  List<DropdownMenuItem<AnneScolaireProf>> listeDDitem;
  List<String> listeLettre;
  List<int> listePosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isReversed = false;
    listeDDitem = getNomAnneScolaire();
    filtrerList();

  }

  void filtrerList(){

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

  void changerAnne(AnneScolaireProf asActuelle) {
    setState(() {
      this.widget.professeur.setAnneScolaireActuelle(asActuelle.idPosition);
      chargerList();
    });
  }

  List<DropdownMenuItem<AnneScolaireProf>> getNomAnneScolaire() {
    List<DropdownMenuItem<AnneScolaireProf>> listeTemp = [];

    for (int i = 0; i < widget.professeur.anneScolaires.length; i++) {
      listeTemp.add(DropdownMenuItem<AnneScolaireProf>(
        value: widget.professeur.anneScolaires.elementAt(i),
        child:
        Text(widget.professeur.anneScolaires.elementAt(i).afficherAnne()),
      ));
    }

    return listeTemp;
  }

  int savoirList(int index, List<Etudiant> listEtudiant, List<int> listPos,
      List<String> listString) {
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



  @override
  Widget build(BuildContext context) {
    print('${150/MediaQuery.of(context).size.height}');
    return Scaffold(
      appBar: ProfAppBar('Mes Élèves', false, widget.professeur, context),
      drawer: DrawerProfWrap.side(drawer: DrawerProf(widget.professeur, context: context),radius: 40,),
      endDrawer: DrawerProfWrap.sideEnd(drawer: EndDrawerProf(professeur: widget.professeur),radius: 40,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        elevation: 14,
        tooltip: 'Ajouter un élève',
        backgroundColor: Colors.cyan[300],
        onPressed: () {
          // TODO navigation vers une page pour ajouter l'éleve
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[SliverOverlapAbsorber(
              handle:
              NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                // TODO  modifer le sliver appBarr
                // title: RichText(),
                leading: SizedBox(
                  width: 0.1,
                ),
                actions: <Widget>[Container()],
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 100,
              ))];},
        body: SafeArea(bottom: true, top: true,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: listePosition.length,
            itemBuilder: (context, i) => StickyHeader(
              header: MyHeader('${listeLettre[i]}', context),
              content: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 72,right: 20,bottom: 18.5),
                    child: Stack(children: [
                      AnimateCardEtudiant(CardEtudiant(widget.professeur.anneScolaireActuelle.listEtudiant[index + listePosition[i]], context)),
                      Positioned(
                          top: 10,
                          child: AnimatedCircleEtud(widget.professeur.anneScolaireActuelle.listEtudiant[index + listePosition[i]].afficherInital())

                      )

                    ]),
                  );
                },
                itemCount: savoirList(i, widget.professeur.anneScolaireActuelle.listEtudiant, listePosition, listeLettre),
                physics: NeverScrollableScrollPhysics(),

                //   itemExtent: 200,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      bottomSheet: ProfBottomSheet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    );
  }
}

class AnimateCardEtudiant extends StatefulWidget {

  CardEtudiant cardEtudiant;
  AnimateCardEtudiant(this.cardEtudiant);


  @override
  _AnimateCardEtudiantState createState() => _AnimateCardEtudiantState();
}

class _AnimateCardEtudiantState extends State<AnimateCardEtudiant> with SingleTickerProviderStateMixin {

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2120));
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0)).animate(curvedAnimation);
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
            boxShadow: <BoxShadow>[BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
              offset: new Offset(0.0, 10.0),
            )],
          ),
          height: MediaQuery.of(context).size.height* 0.146484375,
          width: MediaQuery.of(context).size.width*(540/MediaQuery.of(context).size.width),
          child: widget.cardEtudiant

      ),



    );
  }

}

class AnimatedCircleEtud extends StatefulWidget {

  String content;

  AnimatedCircleEtud(this.content);

  @override
  _AnimatedCircleEtudState createState() => _AnimatedCircleEtudState();
}

class _AnimatedCircleEtudState extends State<AnimatedCircleEtud> with SingleTickerProviderStateMixin{

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
              border: Border.all(color:Colors.transparent,width: 1.0)
          ),
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pinimg.com/originals/f9/31/ec/f931ecb9fec522ec42a65e278ebe0080.gif'),
            child: Text('${widget.content}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 28.2),),
          ),
        ),


      ),

    );
  }
}

class CardEtudiant extends Card {
  Etudiant etudiant;
  BuildContext context;

  CardEtudiant(this.etudiant, this.context)
      : super(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PageEtudiants(etudiant: etudiant,)));
        },
        onDoubleTap: (){},
        onLongPress: (){     },
        splashColor: Colors.cyan[100],
        child:
        Container(
            child:Center(
                child:Text('${etudiant.nomComplet}')
            )
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22)));
}

class MyHeader extends Container {
  String text;
  BuildContext context;
  static final double HEIGHT=0.02;

  MyHeader(this.text,this.context):super(height: MediaQuery.of(context).size.height * HEIGHT,
    width: double.infinity,
    child: ClipPath(
      // todo  clipper: MyCustomClipper(),
      child: Text('$text', style: TextStyle(
          color: Colors.cyan[200], fontWeight: FontWeight.bold,fontSize: 18.5),
      ),
    ),);


}

class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;




}