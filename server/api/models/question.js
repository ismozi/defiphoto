const mongoose =  require('mongoose');

const questionSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    text : {type : String, required : true},
    type : {type : String, required : true},
    sender : {type : String, required : true},
    recievers : {type : [String], required : true},
    isAns : {type : Boolean, default : false ,required : true},
});

module.exports = mongoose.model('Question', questionSchema)