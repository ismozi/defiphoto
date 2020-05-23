const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Comment = require('../models/comment');
const multer = require('multer');
const path = require('path');
const crypto = require('crypto');
const GridFsStorage = require('multer-gridfs-storage');
const Grid = require('gridfs-stream');


const mongoURI = 'mongodb+srv://admin:admin@cluster0-mrqmr.azure.mongodb.net/test?retryWrites=true&w=majority';
const conn = mongoose.createConnection(mongoURI,{ useNewUrlParser: true, useUnifiedTopology: true});

let gfs;

conn.once('open', () => {
  gfs = Grid(conn.db, mongoose.mongo);
  gfs.collection('comments');
});

let filename;
const storage = new GridFsStorage({
    url: mongoURI,
    file: (req, file) => {
      return new Promise((resolve, reject) => {
        crypto.randomBytes(16, (err, buf) => {
          if (err) {
            return reject(err);
          }
           filename = buf.toString('hex') + path.extname(file.originalname);
          const fileInfo = {
            filename: filename,
            bucketName: 'comments'

          };
          resolve(fileInfo);
        });
      });
    }
  });
const upload = multer({storage : storage});



router.get('/file/:filename', (req, res) => {
    gfs.files.findOne({ filename: req.params.filename }, (err, file) => {
      if (!file || file.length === 0) {
        return res.status(404).json({
          err: 'No file exists'
        });
      }
        const readstream = gfs.createReadStream(file.filename);
        readstream.pipe(res);
    });
  });



router.get('/', (req,res,next)=> {
    Comment.find()
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



router.post('/',upload.single('commentFile') ,(req,res,next)=> {
    console.log(req.file);
    const comment = new Comment({
        _id : new mongoose.Types.ObjectId(),
        sender : req.body.sender,
        questionId : req.body.questionId,
        commentFile: req.file.path,
        role : req.body.role,
        fileName : filename

    });
    comment.save()
    .then(result => {
        console.log(result);
        res.status(200).json({
            message : 'POSTed a Comment',
            comment : comment,
            fileInfo :filename
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});

router.post('/noFile' ,(req,res,next)=> {
    console.log(req.file);
    const comment = new Comment({
        _id : new mongoose.Types.ObjectId(),
        text : req.body.text,
        sender : req.body.sender,
        questionId : req.body.questionId,
        role : req.body.role
        
    });
    comment.save()
    .then(result => {
        console.log(result);
        res.status(200).json({
            message : 'POSTed a Comment',
            comment : comment
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});


router.get('/:questionId',(req,res,next)=>{
    const id = req.params.questionId;
    Comment.find({questionId :id})
    .exec()
    .then(doc => {
        console.log(doc);
        if(doc){
        res.status(200).json(doc);
        } else{
            res.status(404).json({message : 'No such COMMENT for this ID'})
        }
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});




router.delete('/:commentId',(req,res,next)=>{
    const id = req.params.commentId
    Comment.remove({_id: id})
    .exec()
    .then(result => {
        res.status(200).json({
            commentDeleted : id,
            deleted : "yes"
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({error : err})
    });
});



module.exports = router;



