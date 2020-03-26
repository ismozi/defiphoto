const express = require('express');
const router = express.Router();
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const jwt = require('jsonwebtoken');

const User = require('../models/user')

router.post('/signup', (req,res,next)=>{
    User.find({email : req.body.email})
    .exec()
    .then(user => {
        if (user.length >= 1){
            return res.status(409).json({
                message : 'User Exists!'
            });
        }
        else{
            bcrypt.hash(req.body.password, 10, (err,hash)=> {
                if (err){
                    return res.status(500).json({
                        error : err
                    });
                } else {
                    const user = new User({
                        _id : new mongoose.Types.ObjectId(),
                        givenId : req.body.givenId,
                        firstName : req.body.firstName,
                        lastName : req.body.lastName,
                        email : req.body.email,
                        password : hash,
                        role : req.body.role,
                    });
                    user
                    .save()
                    .then(result => {
                        console.log(result);
                        res.status(201).json({
                            message : "User Created!"
                        });
                    })
                    .catch(err => {
                        console.log(err);
                        res.status(500).json({error : err});
                    });
                }
            });
        }
    });  
});


router.post('/login', (req,res,next) => {

    User.find({givenId : req.body.givenId})
    .exec()
    .then(user => {
        if (user.length < 1){
            return res.status(401).json({
                message : 'Auth failed'
            });
        }
        else{
            bcrypt.compare(req.body.password, user[0].password, (err,result)=>{
                if(err){
                    return res.status(401).json({
                        message : 'Auth failed'
                    }); 
                }
                if(result){
                    const token =jwt.sign({
                        _id : user[0]._id,
                        givenId : user[0].givenId,
                        firstName :  user[0].firstName,
                        lastName :  user[0].lastName,
                        email : user[0].email,
                        role :  user[0].role
                    }, "vagrant2020" , {
                        expiresIn : "1h"
                    });
                    return res.status(200).json({
                        message : 'Auth successful',
                        token : token
                    }); 
                }
                else{
                    return res.status(401).json({
                        message : 'Auth failed'
                    });   
                }
            });
        }
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err});
    });

});






router.delete('/:userId', (req,res,next)=>{
    User.remove({givenId : req.params.userId})
    .exec()
    .then(result => {
        res.status(200).json({
            message : "User deleted!"
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err});
    });
});


module.exports = router;