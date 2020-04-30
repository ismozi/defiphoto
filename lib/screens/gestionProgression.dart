import 'dart:convert';
import 'package:http/http.dart' as http;

List<int> gestionProgression(Map userData) {
  Map questionData = {};
  List commentaires = [{}];
  List questions = [{}];
  List commentairesMe = [{}];
  int compteurM = 0;
  int compteurE = 0;
  int compteurT = 0;
  int compteurI = 0;
  int compteurE1 = 0;
  int compteurR = 0;

  _getCommentaires() async {
    String id = questionData["questionId"];
    var response =
        await http.get("https://defiphoto-api.herokuapp.com/comments/");
    if (response.statusCode == 200) {
      commentaires = json.decode(response.body);
    }
  }

  _getQuestions() async {
    String id = userData["givenId"];
    var response;

    id = userData["givenId"];

    response =
        await http.get("https://defiphoto-api.herokuapp.com/questions/$id");

    if (response.statusCode == 200) {
      questions = json.decode(response.body);
    }
  }

  _getData() async{
    _getQuestions();
    _getCommentaires();
  }

  _getCommentaireMe() {
    for (int i=0; i < commentaires.length; i++) {
      
      if (commentaires[i]['sender']==userData['givenId']){
        commentairesMe.add(commentaires[i]);
      }

    }
  }

  _updateCompteur(){
    for (int i=0;i<questions.length;i++){
      for(int index=0;index<commentaires.length;index++){
        if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='M'){
          compteurM++;
          i++;


        } else if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='E'){
          compteurE++;
           i++;


        } else if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='T'){
          compteurT++;
           i++;


        } else if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='I'){
          compteurI++;
           i++;


        } else if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='E'){
          compteurE1++;
           i++;


        } else if((commentaires[index]['questionId']==questions[i]['questionId'])&&questions[i]['type']=='R'){
          compteurR++;
           i++;


        }
      }
    }
    print(compteurM);
    print(compteurE);
    print(compteurT);
    print(compteurI);
    print(compteurE1);
    print(compteurR);

  }
}
