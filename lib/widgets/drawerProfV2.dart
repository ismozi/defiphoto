


import 'package:flutter/material.dart';

import 'modelVueProf.dart';
import 'pageLoading.dart';
import 'pageProfEleveV2.dart';
import 'pageProfilProf.dart';
import 'pageQuestionV2.dart';

class DrawerProfWrap extends Container{

  BuildContext context;
  Drawer drawer;
  double  radius= 30;

  DrawerProfWrap.side({this.drawer,this.context,this.radius}):super(child: SafeArea(
    left: true,
    top: true,
    bottom: true,
    child: ClipRRect(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius),topRight: Radius.circular(radius) ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: drawer,
    ),
  ),);
  DrawerProfWrap.sideEnd({this.drawer,this.context,this.radius}):super(child: SafeArea(
    bottom: true,
    left: true,
    top: true,
    child: ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),bottomLeft: Radius.circular(radius) ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: drawer,
    ),
  ),);
}

class DrawerProf extends Drawer {
  Professeur prof;
  BuildContext context;
  static double sizedBoxH = 40; // TODO voir le mediaQuery
  static TextStyle textStyle =TextStyle(fontStyle: FontStyle.italic,fontSize: 12,color: Colors.grey[600]);

  DrawerProf(this.prof, {@required this.context})
      : super(
    elevation: 20,
    // TODO METTRE LE WIDGET
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child:  ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
            child: Container(
              child:   Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://i.ytimg.com/vi/QQsf3TOT2Ls/hqdefault.jpg'),
                      radius: 55.0,
                    ),
                  ),
                  Positioned(
                      top: 12,
                      child: Container(
                          child: Text('${prof.nom}',
                              style: TextStyle(fontSize: 22)))),

                  Positioned(

                      top: 50,

                      left: 1,

                      child: Container(

                          child: Text('${prof.anneScolaireActuelle.afficherAnne()}',

                              style: TextStyle(fontSize: 13)))),

                ],

              ),
              width: double.maxFinite,),
          ),

        ),
        SizedBox(
          height: sizedBoxH,
        ),
        Text('Acceuil',style: textStyle,),
        Divider(),
        ListTileDrawer(
          iconData: Icons.school,
          // TODO ou home
          basic: false,
          nom: "Mes élèves",
          description: "Accéder à votre liste d'élèves",
          duration: Duration(seconds: 5),
          widget: PageProfEleve(
            professeur: prof,
          ),
          context: context,
          isOnTap: true,
        ),
        ListTileDrawer(
          iconData: Icons.wb_incandescent,
          description:
          'Accéder aux question poser à tout le groupe, section  METIER',
          nom: 'Mes questions',
          basic: false,
          duration: Duration(seconds: 8),
          widget: PageProfQuestion(
            professeur: prof,
          ),
          context: context,
          isOnTap: true,
        ),
        ListTileDrawer(
          duration: Duration(seconds: 7),
          basic: false,
          nom: 'Mon profil',
          description: 'Accéder à mon profil',
          iconData: Icons.account_circle,
          widget: PageProfProfil(professeur: prof),
          context: context,
          isOnTap: true,
        ),
        SizedBox(
          height: sizedBoxH,
        ),
        Text('Assitance',style: textStyle,),
        Divider(),
        ListTileDrawer(
          iconData: Icons.help_outline,
          nom: 'Aide',
          basic: true,
          duration: Duration(seconds: 3),
          widget: Container(),
          // TODO METTRE LA PAGE AIDE PROF
          context: context,
          isOnTap:false,
          description: 'Obtenez les réponses à vos questions ! ',
        ),
        ListTileDrawer(
          duration: Duration(seconds: 10),
          basic: true,
          nom: 'Signaler un problème',
          iconData: Icons.report_problem,
          description: "Y'a t-il un problème? Dites-le nous !",
          context: context,
          isOnTap: false,
        ),
        SizedBox(
          height: sizedBoxH,
        ),
        SizedBox(
          height: sizedBoxH,
        ),
        Text('Déconnexion',style: textStyle,),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings_power),
          onTap: () {},
          title: Text('Déconnextion'),
        ),
        SizedBox(
          height: sizedBoxH,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text('Ecole'), Text('Défi-Photo')],
        )
      ],
    ),
  );
}

class EndDrawerProf extends Drawer {
  Professeur professeur;

  EndDrawerProf({@required this.professeur})
      : super(
      elevation: 15,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: SafeArea(
                child: Row(
                  children: <Widget>[
                    Text('Notification',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(),
            Container(),
          ],
        ),
      ));
}

class ListTileDrawer extends ListTile {
  IconData iconData;

  // TODO: Si c plus simple String routeName;
  String nom;
  String description;
  BuildContext context;
  Duration duration;
  bool basic;
  Widget widget;
  bool isOnTap;

  ListTileDrawer(
      {this.iconData,
        this.nom,
        this.description,
        this.context,
        this.basic,
        this.duration,
        this.widget,
        this.isOnTap})
      : super(
      leading: Icon(iconData),
      title: Text(nom,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.4),),
      subtitle: Text(description,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12.4),),
      onTap: isOnTap? (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loading(basic, duration, widget)));
      }:(){});
}
