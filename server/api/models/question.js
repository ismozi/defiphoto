const mongoose =  require('mongoose');

const questionSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    text : {type : String, required : true},
    type : {type : String, required : true},
    sender : {type : String, required : true},
    reciever : {type : String, required : false},
    recievers : {type : [String], required : false},
  
    //could add date and time
});

module.exports = mongoose.model('Question', questionSchema)