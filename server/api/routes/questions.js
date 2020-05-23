const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Question = require('../models/question');


router.get('/', (req,res,next)=> {
    Question.find()
    .exec()
    .then(docs => {
        console.log(docs);
        res.status(200).json(docs);
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});


router.get('/:studentId',(req,res,next)=>{
    const id = req.params.studentId;
    Question.find({recievers : id})
    .exec()
    .then(doc => {
        console.log(doc);
        if(doc){
        res.status(200).json(doc);
        } else{
            res.status(404).json({message : 'No such QUESTION for this ID'})
        }
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});


router.post('/auProfs',(req,res,next)=>{
    Question.find({sender : req.body.sender , recievers : req.body.recievers})
    .exec()
    .then(doc => {
        console.log(doc);
        if(doc){
        res.status(200).json(doc);
        } else{
            res.status(404).json({message : 'No such QUESTION for this ID'})
        }
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});

router.get('/sender/:studentId',(req,res,next)=>{
    const id = req.params.studentId;
    Question.find({sender : id})
    .exec()
    .then(doc => {
        console.log(doc);
        if(doc){
        res.status(200).json(doc);
        } else{
            res.status(404).json({message : 'No such QUESTION for this ID'})
        }
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});


router.post('/', (req,res,next)=> {
    const question = new Question({
        _id : new mongoose.Types.ObjectId(),
        text : req.body.text,
        type : req.body.type,
        sender : req.body.sender,
        recievers : req.body.recievers,
    });
    question.save()
    .then(result => {
        console.log(result);
        res.status(200).json({
            message : 'POST Request from QUESTIONS',
            question : question
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});



router.patch('/:questionId',(req,res,next)=>{
    const id = req.params.questionId;
    const updateOps = {};
    for (const ops of req.body){
        updateOps[ops.propName] = ops.value;
    }
    Question.update({_id : id}, {$set : updateOps })
    .exec()
    .then( result => {
        console.log(result);
        res.status(200).json({
            questionUpdated : id,
            Updated : "yes",
        });
        })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});



router.delete('/:questionId',(req,res,next)=>{
    const id = req.params.questionId
    Question.remove({_id: id})
    .exec()
    .then(result => {
        res.status(200).json({
            questionDeleted : id,
            deleted : "yes"
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});



module.exports = router;