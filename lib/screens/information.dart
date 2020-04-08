import 'package:flutter/material.dart';

class Inpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Aide"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Description"),
                Tab(text: "Metier"),
                Tab(text: "Fonctionnement"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                
                child: ListView(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child:Text("Que dois-tu faire ?",
                      
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                        
                      
                    ),),
                    
                    
                    Card(
                      color: Colors.grey[750],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Choisis une des tâches que tu réalises régulièrement en stage, par exemple ta tâche principale.\n\nÀ l'aide de photographies prises dans ton milieu de stage, tu vas décrire une tâche que tu réalises régulièrement en détaillant les différents déterminants organisés selon Métier.\n\nLis les consignes pour les différentes photographies que tu as à prendre dans ton milieu de stage. Lorsque tu aurais pris les photos demandées, il faudra que tu insères les photos dans l'application aux endroits définies. Pour certaines sections, ilte faudra également répondre aux questions posées.")
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[ 
                    Padding(padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                    child: Text("Qu'est-ce que l'acronyme Métier ?",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 29,
                          fontWeight: FontWeight.w800,
                        ),
                        
                      ),
                    ),
                    
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(text: "\n\n"),
                          TextSpan(text: "Matières et produits"),
                        ],
                      ),
                    ),
                    Text("\n"),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Prends en photo les produits avec lesquels tu travailles. Si tu travailles avec des produits de différente taille, de différent poids, n'hésites pas à les photographier pour montrer les différences entre ces produits (produits grands ou petits, produits lourds ou légers)")
                            ],
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(text: "\n\n"),
                          TextSpan(text: "Équipements"),
                        ],
                      ),
                    ),
                    Text("\n"),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Prends en photo les équipements que tu utilises en lieu De Stage (les outils, les machines,...)"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(text: "\n\n"),
                          TextSpan(text: "Tâches et exigences"),
                        ],
                      ),
                    ),
                    Text("\n"),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Demande à l'un de tes collègues de te photographier pendant que tu réalises la tâche que tu as choisie de nous montrer. Raconte-nous ce que tu dois faire quand tu réalises cette tâche (dans l'ordre chronologique)"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.redAccent,
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                ),
              ),
              Container(
              
                child: ListView(
                  children: <Widget>[
                    Card_cust(
                        "Page de Connexion",
                        Colors.cyanAccent.shade100,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pageconnexion()))
                            }),
                    Card_cust(
                        "Mot de passe oublié",
                        Colors.redAccent.shade200,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Motoub()))
                            }),
                    Card_cust(
                        "Page d'acceuil",
                        Colors.deepPurpleAccent.shade100,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => acceuil()))
                            }),
                    Card_cust(
                        "Menu",
                        Colors.white,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => menu()))
                            }),
                    Card_cust(
                        "Répondre à une question",
                        Colors.deepOrangeAccent,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => question()))
                            }),
                    Card_cust(
                        "Ajouter et supprimer une photo",
                        Colors.limeAccent,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ajoutp()))
                            }),
                    Card_cust(
                        "Ajouter et supprimer commentaire",
                        Colors.indigoAccent,
                        () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ajoutcom()))
                            }),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.redAccent,
                      alignment: Alignment.bottomLeft,
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

class Card_cust extends StatelessWidget {
  String txt;
  Color c;
  Function ontap;
  Card_cust(this.txt, this.c, this.ontap);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: c,
      elevation: 5,
      margin: EdgeInsets.all(7),
      child: InkWell(
        splashColor: Colors.red,
        onTap: ontap,
        child: Container(
          width: 300,
          height: 200,
          child: Center(
            child: Text(
              txt,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Custom extends StatelessWidget {
  IconData icon;
  String text;
  Function ontap;
  Custom(this.icon, this.text, this.ontap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: InkWell(
            onTap: ontap,
            splashColor: Colors.red,
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Text(text),
                    ],
                  ),
                  Icon(Icons.arrow_right),
                ],
              ),
            )));
  }
}

class acceuil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page d'acceuil")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "La page d'accueil te permet de voir ton niveau d'avncement pour chaque section. Elle contient à gauche la première lettre de la section et à droite ta progression. Plus le bleu est vers la gauche et plus tu as completé la section."),
                    ],
                  ),
                ),
              ),
            ),
            Text("\n"),
            Image(
              image: NetworkImage(
                  "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/90993749_174112196878403_1717710073398034432_n.png?_nc_cat=104&_nc_sid=b96e70&_nc_ohc=Wy56pw2djmIAX_L-XQO&_nc_ht=scontent.fymy1-1.fna&oh=303cf75ba67c31cf9542ea43c1de7468&oe=5EA31943"),
              alignment: Alignment.center,
            ),
            Text("\n"),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "La page d'accueil te permet aussi de voir les derniers commentaires ajoutés par ton enseignant. Si tu cliques sur voir le commentaire, cela t'amènera au commentaire."),
                      ],
                    ),
                  ),
                )),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: "Voir le commentaire",
                  ),
                ],
              ),
            ),
            Text("\n"),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Page d'acceuil te permet de voir ton profile : Tu peux cliquer sur l'icône en haut à gauche.",
                        ),
                      ],
                    ),
                  ),
                )),
            Text("\n"),
            Icon(
              Icons.person,
              color: Colors.blue,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}

class pageconnexion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page de Connexion")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 20, 5),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "Il suffit d'entrer le courril et le mot de passe. L'élève peut aussi se connecter avec son Google ou Micosoft."),
                      ],
                    ),
                  ),
                )),
            Text("\n"),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "Si l'élève a oublié son mot de passe, il peut cliquer sur « Mot de passe oublié ? », ce qui affichera la page de mot de passe oublié. Voir la prochaine page.")
                      ],
                    ),
                  ),
                )),
            Text("\n"),
            Image(
                alignment: Alignment.topCenter,
                image: NetworkImage(
                    "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91251359_637768830346797_4315823004354347008_n.png?_nc_cat=102&_nc_sid=b96e70&_nc_ohc=2AImj0Q7YH8AX96-Wuq&_nc_ht=scontent.fymy1-1.fna&oh=92c3d14b1c8ee531e8e603a712f82e65&oe=5EA719DA")),
          ],
        ),
      ),
    );
  }
}

class Motoub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mot de passe oublié")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              " Il suffit d'entrer le courrile, ce qui enverra une confirmation au courriel de l'étudiant pour changer son mot de passe.")
                    ],
                  ),
                ),
              ),
            ),
            Text("\n"),
            Image(
              alignment: Alignment.topCenter,
              image: NetworkImage(
                  "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91286848_657307605109219_3501446464289112064_n.png?_nc_cat=100&_nc_sid=b96e70&_nc_ohc=uJrY2QzkL60AX-EpWq7&_nc_ht=scontent.fymy1-1.fna&oh=a6aa9c262d9f429db83c7eec9c092252&oe=5EA44381"),
            )
          ],
        ),
      ),
    );
  }
}

class menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Si tu cliques sur les trois lignes en haut à gauche "),
                      WidgetSpan(
                        child: Icon(Icons.menu, color: Colors.blue),
                      ),
                      TextSpan(
                          text:
                              " , aussi appelé « Menu hamburger », tu pourras voir le menu apparaître.")
                    ],
                  ),
                ),
              ),
            ),
            Text("\n"),
            Image(
                alignment: Alignment.topCenter,
                image: NetworkImage(
                    "https://scontent.fymy1-2.fna.fbcdn.net/v/t1.15752-9/91327877_270936320583871_6873951628030902272_n.png?_nc_cat=111&_nc_sid=b96e70&_nc_ohc=21YltQCmzQ4AX944a_K&_nc_ht=scontent.fymy1-2.fna&oh=39f88d894b9a766fdc5b5f8bf21a8173&oe=5EA62F69"))
          ],
        ),
      ),
    );
  }
}

class question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Répondre à une question"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Pour répondre à une question, tu n’as qu’à cliquer sur la question à laquelle tu veux répondre. Ceci affichera le formulaire qui te permettra d’ajouter une réponse, de la modifier ou de la supprimer, d’ajouter ou de supprimer une ou des photos et de voir, d’ajouter ou de supprimer des commentaires."),
                    ],
                  ))),
            ),
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Tu dois cilquer sur le Tu dois cliquer sur le bouton « Ajouter une réponse » :"),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 500,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-2.fna.fbcdn.net/v/t1.15752-9/91853890_2918761084883798_6104739057084923904_n.png?_nc_cat=111&_nc_sid=b96e70&_nc_ohc=3h9Orm-lI4gAX9IahtB&_nc_ht=scontent.fymy1-2.fna&oh=01fba007cd5e43e4e709f1ea65aa31f7&oe=5EA547E6")),
            ),
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Ensuite, tu entres ta réponse où c’est écrit : « Votre réponse » et quand tu as fini tu cliques sur le bouton « Enregistrer » en bas à droite. Si tu souhaites annuler ce que tu as écrit ou revenir quitter la page, tu n’as qu’à cliquer sur le « X » en bas à gauche."),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 400,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-2.fna.fbcdn.net/v/t1.15752-9/91457370_2746244928762810_4904936631527538688_n.png?_nc_cat=111&_nc_sid=b96e70&_nc_ohc=w0BO_2brOlcAX-c75W-&_nc_ht=scontent.fymy1-2.fna&oh=23490c42057c7122371a2a4b11b33c8f&oe=5EA618EA")),
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Après avoir entré ta réponse et que tu as cliqué sur Enregistrer, tu peux toujours l’a modifié en cliquant sur le bouton « Modifier la réponse » :"),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 95,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91297002_2314121498887347_1188608482358591488_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_ohc=n0760HqG8zAAX9RZauE&_nc_ht=scontent.fymy1-1.fna&oh=df41a8b444d4e2669b400c995e9b58bc&oe=5EA5B3F8")),
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Si tu souhaites supprimer la réponse que tu as mises, tu peux cliquer sur le « x » rouge à droite de ta réponse :"),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 300,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91284024_228984274954595_2277564837162647552_n.png?_nc_cat=100&_nc_sid=b96e70&_nc_ohc=A2OlYuQTRbAAX-_I-_Q&_nc_ht=scontent.fymy1-1.fna&oh=be906a13e54548cc923dee478f78c153&oe=5EA6AB09")),
            ),
          ],
        ),
      ),
    );
  }
}

class ajoutp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter et supprimer une photo")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Pour ajouter une photo, tu dois cliquer sur le bouton « Ajouter une photo » :"),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 500,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91218954_211365656758753_3293103673843908608_n.png?_nc_cat=100&_nc_sid=b96e70&_nc_ohc=SZS-VbMRicsAX8svE2P&_nc_ht=scontent.fymy1-1.fna&oh=3808e563386be17393757dd1d53b9b53&oe=5EA39B17")),
            ),
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Une fois cliqué, tu auras le choix entre prendre une photo ou choisir une photo dans ta galerie. Tu n’as cliqué sur celui que tu désires. Tu pourras, ainsi, choisir une photo parmi ta galerie ou prendre la photo immédiatement."),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
              height: 400,
              child: Image(
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                      "https://scontent.fymy1-2.fna.fbcdn.net/v/t1.15752-9/91319659_211793736583532_72277204305707008_n.png?_nc_cat=101&_nc_sid=b96e70&_nc_ohc=Mt1_beaNbyQAX-5m2bj&_nc_ht=scontent.fymy1-2.fna&oh=4c5fde11a8e6bf7c22b4a55079d6b759&oe=5EA4AA4A")),
            ),
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Si tu souhaites supprimer la photo que tu as mise, tu peux simplement cliquer sur « Supprimer la photo » et en mettre une autre en recliquant sur l'image avec une caméra."),
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
                height: 400,
                child: Image(
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                        "https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91228623_506295060043120_3990446143254298624_n.png?_nc_cat=107&_nc_sid=b96e70&_nc_ohc=_Ng-7OpwFU0AX-m2K1C&_nc_ht=scontent.fymy1-1.fna&oh=6baa893e0cd8a333927b6ba1ed6fda0a&oe=5EA5A056"))),
          ],
        ),
      ),
    );
  }
}

class ajoutcom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter et supprimer commentaire")),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Text("\n"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Pour ajouter un commentaire, tu dois cliquer sur l’endroit où c’est écrit « Écrivez votre commentaire ». Après avoir écrit ton commentaire, tu dois cliquer sur le bouton « Envoyer ».")
                    ],
                  ))),
            ),
            Text("\n"),
            SizedBox(
                height: 150,
                child: Image(
                    alignment: Alignment.topCenter,
                    image: NetworkImage("https://scontent.fymy1-1.fna.fbcdn.net/v/t1.15752-9/91346569_520159135540405_5337108601766936576_n.png?_nc_cat=109&_nc_sid=b96e70&_nc_ohc=a0PZQneFVOoAX-8DDDN&_nc_ht=scontent.fymy1-1.fna&oh=7f6fa5cb6579bc4f82545dc4b7bb53c4&oe=5EA46FEB"))),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text:
                              " Si tu souhaites supprimer ton commentaire, tu peux cliquer sur « Supprimer ». ")
                    ],
                  ))),
            ),
            Text("\n"),
        
            SizedBox(
                height: 150,
                child: Image(
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                        "https://scontent.fymy1-2.fna.fbcdn.net/v/t1.15752-9/91328853_563621967839192_2757462518354935808_n.png?_nc_cat=110&_nc_sid=b96e70&_nc_ohc=xM5TeDV-j3sAX_WPWGW&_nc_ht=scontent.fymy1-2.fna&oh=c48f5cd5d62afb05213cf8f3cfa3a47a&oe=5EA7549B")))],        ),
      ),
    );
  }
}
