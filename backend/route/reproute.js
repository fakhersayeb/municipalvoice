const express = require('express');
const router = express.Router();
const Rep = require('../model/repmodel')
const db = require('../DB/connect')
const Sequelize = require('sequelize');


const createrep = async ({ code,details,image,image2,image3 }) => {
    return await Rep.create({ code,details,image,image2,image3 });
  };
  
router.post('/repair',(req,res)=>{
   
        createrep({
            code: req.body.adresse,
            details:req.body.commentaire,
            image:req.body.image,
            image2:req.body.image2,
            image3:req.body.image3
        }).then(function(rep){
        if(rep){
            
            res.send('réparation envoyée');
        }
        });
        
    

})
module.exports=router;


