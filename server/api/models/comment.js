const mongoose =  require('mongoose');

const commentSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    text : {type : String, required : false},
    sender : {type : String, required : true},
    commentFile : {type : String , required : false},
    questionId : {type : String, required : true}
    //could add date and time
});

module.exports = mongoose.model('Comment', commentSchema)