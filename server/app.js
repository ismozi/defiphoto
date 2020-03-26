//Import and init. Express to use its functionalities
const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');


//init users functions
const userRoutes = require ('./api/routes/users');
const questionRoutes = require('./api/routes/questions');
const commentRoutes = require('./api/routes/comments');

//coonection to MongoDB
mongoose.connect('mongodb+srv://admin:admin@cluster0-mrqmr.azure.mongodb.net/test?retryWrites=true&w=majority',{ useNewUrlParser: true, useUnifiedTopology: true});

mongoose.Promise = global.Promise;
// Using Express, create a method which takes a request and returns a response in a json form
// app.use((req,res,next)=>{
//     res.status(200).json({
//         message : "You did it!"
//     });
// });

//debugger
app.use(morgan('dev'));

app.use('/uploads',express.static('uploads'));

//json reader
app.use(bodyParser.urlencoded({extended : false}));
app.use(bodyParser.json());

//overwrite headers for CORS problems
app.use((req,res,next)=>{
    res.header('Access-Control-Allow-Origin','*'),
    res.header('Access-Control-Allow-Headers','*')
    if (req.method === 'OPTIONS'){
        res.header('Access-Control-Allow-Methods','PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});


//Listening to users and sending responses from users.js
app.use('/users', userRoutes);
app.use('/questions', questionRoutes);
app.use('/comments', commentRoutes)




app.use((req,res,next)=> {
    const error  = new Error('Not Found');
    error.status = 404;
    next(error);
});

app.use((error,req,res,next)=> {
    res.status(error.status || 500);
    res.json({
        error : {
            message : error.message
        }
    });
});

module.exports=app;