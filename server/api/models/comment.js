const mongoose =  require('mongoose');

const commentSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    text : {type : String, required : false},
    sender : {type : String, required : true},
    commentFile : {type : String , required : false},
    questionId : {type : String, required : true},
    fileName : {type : String , required : false},
    role : {type : String, required : true}
});

module.exports = mongoose.model('Comment', commentSchema)