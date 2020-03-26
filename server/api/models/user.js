const mongoose =  require('mongoose');

const userSchema = mongoose.Schema({
    _id :  mongoose.Schema.Types.ObjectId,
    givenId : {type : String, required : true},
    firstName : {type : String, required : true},
    lastName : {type : String, required : true},
    email : {type : String, required : true, match : /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/},
    password : {type : String, required : true},
    role :{type : String, required : true},
    createdAt : mongoose.Schema.Types.Date,
    schoolYearBegin :{type : String, required : false},
    schoolYearEnd : {type : String, required : false},
    //internships

    //could add date and time
});

module.exports = mongoose.model('User', userSchema)