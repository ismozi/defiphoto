import 'package:flutter/material.dart';

class Inpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
          ),
          title: Text("Aide", style: TextStyle(fontFamily: 'Arboria')),
          bottom: TabBar(
            tabs: [
              Tab(text: "MÉTIER"),
              Tab(text: "Fonctionnement"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              color: Color(0xff141a24),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Qu'est-ce que l'acronyme MÉTIER ?",
                      style: TextStyle(
                        fontFamily: 'Arboria',
                        fontSize: 29,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 16),
                    child: Text(
                      "Matières et produits",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "Prends en photo les produits avec lesquels tu travailles. Si tu travailles avec des produits de différente taille, de différent poids, n'hésites pas à les photographier pour montrer les différences entre ces produits (produits grands ou petits, produits lourds ou légers)")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Équipement",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "Prends en photo les équipements que tu utilises en lieu De Stage (les outils, les machines,...)")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Tâches et exigences",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "Demande à l'un de tes collègues de te photographier pendant que tu réalises la tâche que tu as choisie de nous montrer. Raconte-nous ce que tu dois faire quand tu réalises cette tâche (dans l'ordre chronologique)")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xff141a24),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Comment fonctionne l'application?",
                      style: TextStyle(
                        fontFamily: 'Arboria',
                        fontSize: 29,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 16),
                    child: Text(
                      "Page d'acceuil",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "Sur ta page d'acceuil, tu peux voir ta progression pour chaque catégorie (M-É-T-I-E-R) ainsi que ta progression totale. La progression représente le pourcentage de question auxquelles tu as répondu.")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Navigation",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "Pour naviguer dans l'application, tu dois utiliser le menu hamburger qui est disponible en haut gauche de ta page d'acceuil. Dans ce menu, tu vera toute les sections de l'application auxquelles tu a accès.")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Questions de stage",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "En appuyant sur l'option «Question de stage» dans ton menu, tu arrivera sur une page avec les catégories de l'acronyme MÉTIER. En cliquant sur une catégorie, la page t'affichera les questions que ton enseignant t'a posé pour cette catégorie.  Si tu clique sur l'icone de volume d'une question, tu pourra entendre celle-ci. Pour répondre à la question tu dois appuyer sur celle-ci. ")
                          ],
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Page des commentaires",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "En appuyant sur une question, tu seras amener sur la page des commentaires. Sur cette page, tu pourras répondre à la question de ton enseignant. S'il te demande d'envoyer des photos, tu peux le faire en choisisant des photos de ta gallerie ou en prenant la photo directement dans l'application. Pour envoyer un message vocal, tu dois appuyer sur l'icone du microphone. En appuyant une fois, tu activeras le microphone et en cliquant une deuxième fois, tu désactivera le microphone et ton message s'enverra automatiquement au professeur")
                          ],
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Poser des questions",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "En appuyant sur l'option «Poser des questions» dans ton menu, tu arriveras sur une page ou tes questions posé seront affichés. Si tu n'en a pas encore posé, la page sera vide. Pour poser une question à ton enseigant, tu dois appuyer sur le bouton «+» en bas à droite de ton écran, ceci t'amènera sur une nouvelle page. Dans cette nouvelle page, tu peux écrire la question que tu as à poser et indiquer dans quelle catégorie elle se situe. ")
                          ],
                        ),
                      ),
                    ),
                  ),Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Profil",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "En appuyant sur l'option «Profil» dans ton menu, tu accèderas à toutes tes informations")
                          ],
                        ),
                      ),
                    ),
                  ),Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text(
                      "Se déconnecter",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 23,
                          fontFamily: 'Arboria'),
                    ),
                  ),
                  Card(
                    color: Color(0xFF222b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontFamily: 'Arboria'),
                          children: [
                            TextSpan(
                                text:
                                    "En appuyant sur l'option «Se déconnecter» dans ton menu, tu sera déconnecter de l'application")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

