
import'../data/user.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final String type;
  

  Message({
    this.sender,
    this.time,
    this.text,
    this.type
    
  });
}

// YOU - current user
final User currentUser = User(
  id: '0',
  firstName: 'Current User',

);

// USERS
final User professeur = User(
  id: '1',
  firstName: 'Professeur',
);

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo de ton environnement de travail',
    type: 'E'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo de ton environnement de travail',
    type: 'E'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo des matières que tu utilises',
    type: 'M'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo des tâches que tu réalises',
    type: 'T'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I'
  ),

   Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo de ton équipement de travail',
    type: 'E1'
  ),

  Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo de ressources humaines',
    type: 'R'
  ),
  
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: professeur,
    time: '5:30 PM',
    text: 'Envoi moi une photo de ton environnement de travail',
   
  ),
  
];
