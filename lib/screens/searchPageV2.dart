
import 'package:flutter/material.dart';
import 'modelVueProf.dart';
import 'pageEtudiantV2.dart';


class SearchPage extends SearchDelegate<Etudiant> {
  List<Etudiant> listEtudiant;
  List<Etudiant> recentEtudiant;
  int indexEtudiants;
  bool found = false;
  String hintText;

  SearchPage({this.listEtudiant, this.recentEtudiant, this.hintText}) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
    //  todo transitionAnimation
  );

  @override
  List<Widget> buildActions(BuildContext context) => [IconButton(
        icon: Icon(Icons.clear,),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        tooltip: 'Annuler la recherche',
      ), IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          recentEtudiant.clear();
        },
        tooltip: 'Supprimer les recherche recentes',
      )];// TODO: implement buildActions

  @override
  Widget buildLeading(BuildContext context)=> IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        if (found == true) {
          showSuggestions(context);
        } else {
          close(context, null);
        }
      },
    );// TODO: implement buildLeading

  @override
  Widget buildResults(BuildContext context) =>PageEtudiants(
      etudiant: listEtudiant[indexEtudiants]);

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions changer la facon dont l

    found = false;
    List<Etudiant> suggestionList = query.isEmpty ? recentEtudiant : listEtudiant.where((p) => p.nomComplet.startsWith(query)).toList();
    String textInfo = query.isEmpty ? 'Recherche récente' : 'Resultat( ${suggestionList.length} )';

    return ListView(
      children: <Widget>[
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10,),
            Text(textInfo,style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: suggestionList.isEmpty && query.isNotEmpty?Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.30,),
                Icon(Icons.search,size: 200,),
                Text('Aucun résulat correspondant à cette recherche:" $query "  ')
              ],
            ),
          ):ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) => ListTile(
              trailing: Icon(Icons.arrow_forward),
              leading: query.isEmpty ? Icon(Icons.restore) : Icon(Icons.person),
              subtitle: Text('Id Élève : ${suggestionList[index].idDonne}',style: TextStyle(fontStyle: FontStyle.italic),),
              title: RichText(
                strutStyle: StrutStyle(fontSize: 19),
                text: TextSpan(
                    text: suggestionList[index]
                        .nomComplet
                        .substring(0, query.length),
                    style: TextStyle(
                      //color: Colors.black,
                      fontWeight: FontWeight.w200,fontSize: 18

                    ),
                    children: [
                      TextSpan(
                          text: suggestionList[index]
                              .nomComplet
                              .substring(query.length),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ))
                    ]),
              ),
              onTap: () {
                int cpt = 0;
                for (int i = 0; i < recentEtudiant.length; i++) {
                  if (suggestionList[index].idSearch ==
                      recentEtudiant[i].idSearch) {
                    cpt++;
                  }
                }
                if (cpt == 0) {
                  recentEtudiant.add(suggestionList[index]);
                }
                indexEtudiants = suggestionList[index].idSearch;
                found = true;
                showResults(context);
              },
            ),
            itemCount: suggestionList.length,
            padding: EdgeInsets.all(2),
          ),
        ),
      ],
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
    );// TODO: implement appBarTheme




}