
import'../data/user.dart';

class Message {
  final User sender;
  // final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final String type;
  final String idConvo;
  

  Message({
    this.sender,
    // this.time,
    this.text,
    this.type,
    this.idConvo    
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
    text: 'Envoi moi une photo de ton environnement de travail',
    type: 'E',
    idConvo: '1a'
  ),

   Message(
    sender: professeur,
    text: 'Envoi moi une photo de ton environnement de travail',
    type: 'E',
    idConvo: '1b'
  ),

   Message(
    sender: professeur,
    text: 'Envoi moi une photo des matières que tu utilises',
    type: 'M',
    idConvo: '1c'
  ),

   Message(
    sender: professeur,

    text: 'Envoi moi une photo des tâches que tu réalises',
    type: 'T',
    idConvo: '1d'
  ),

   Message(
    sender: professeur,
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I',
    idConvo: '1e'
  ),

   Message(
    sender: professeur,
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I',
    idConvo: '1f'
  ),

   Message(
    sender: professeur,
    
    text: 'Envoi moi une photo de ton équipement de travail',
    type: 'E1',
    idConvo: '1g'
  ),

  Message(
    sender: professeur,

    text: 'Envoi moi une photo de ressources humaines',
    type: 'R',
    idConvo: '1h'
  ),
  
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: professeur,
    
    text: 'Envoi moi une photo de ton environnement de travail',
    idConvo:'1a'
  ),

  Message(
    sender: professeur,
   
    text: 'Envoi moi une photo de ton environnement de travail',
    type: 'E',
    idConvo: '1b'
  ),

   Message(
    sender: professeur,
    
    text: 'Envoi moi une photo des matières que tu utilises',
    type: 'M',
    idConvo: '1c'
  ),

   Message(
    sender: professeur,
    
    text: 'Envoi moi une photo des tâches que tu réalises',
    type: 'T',
    idConvo: '1d'
  ),

   Message(
    sender: professeur,
    
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I',
    idConvo: '1e'
  ),

   Message(
    sender: professeur,
  
    text: 'Envoi moi une photo des individus avec qui tu travailles',
    type: 'I',
    idConvo: '1f'
  ),

   Message(
    sender: professeur,
    
    text: 'Envoi moi une photo de ton équipement de travail',
    type: 'E1',
    idConvo: '1g'
  ),

  Message(
    sender: professeur,
    
    text: 'Envoi moi une photo de ressources humaines',
    type: 'R',
    idConvo: '1h'
  ),
  
  
  
  
];
