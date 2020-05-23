const mongoose =  require('mongoose');

const userSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    givenId : {type : String, required : true},
    firstName : {type : String, required : true},
    lastName : {type : String, required : true},
    email : {type : String, required : true, match : /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/},
    password : {type : String, required : true},
    role :{type : String, required : true},
    schoolYearBegin :{type : String, required : true},
    schoolYearEnd : {type : String, required : true},
    profId : {type : String, required : false},
    stageName : {type : String, required : false},
    stageDesc : {type : String, required : false},
    stageBegin : {type : String, required : false},
    stageEnd : {type : String, required : false},
});

module.exports = mongoose.model('User', userSchema)