const express = require('express');
//import Router from Express to manage routes easily
const router = express.Router();

router.get('/', (req,res,next)=> {
    res.status(200).json({
        message : 'GET Request from USERS'
    });
});

router.post('/', (req,res,next)=> {
    res.status(200).json({
        message : 'POST Request from USERS'
    });
});


router.get('/:userId',(req,res,next)=>{
    const id = req.params.userId;
    if (id == '1'){
        res.status(200).json({
            message : 'Rony ? Is that you ?'
        });
    } else{
        res.status(200).json({
            message : 'You searched for a User ID',
            id : id
        });
    }
});

router.patch('/:userId',(req,res,next)=>{
    const id = req.params.userId;
    if (id == '1'){
        res.status(200).json({
            message : 'Rony ? You wanna update yourself ?'
        });
    } else{
        res.status(200).json({
            message : 'You updated a User',
            id : id
        });
    }
});

router.delete('/:userId',(req,res,next)=>{
    const id = req.params.userId;
    if (id == '1'){
        res.status(200).json({
            message : 'Rony ? You wanna delete yourself ?'
        });
    } else{
        res.status(200).json({
            message : 'You deleted a User',
            id : id
        });
    }
});


module.exports = router;