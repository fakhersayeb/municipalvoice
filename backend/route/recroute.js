const express = require('express');
const router = express.Router();
const Rec = require('../model/recmodel')
const db = require('../DB/connect')
const Sequelize = require('sequelize');
var Odoo = require('odoo-xmlrpc');

const createrec = async ({ eqid,titre,details,statut,image,image2,image3 }) => {
    return await Rec.create({ eqid,titre,details,statut,image,image2,image3 });
  };
  var odoo = new Odoo({
    url: 'https://tbge-test.odoo.whitecapetech.com',
    db: 'tbge',
    username: 'pfe@mail.com',
    password: 'pfe@2021'
});

router.post('/claim',(req,res)=>{
    adresse=req.body.adresse;
    
    var nb;
    var inParams = [];
    inParams.push([['name', '=', adresse]]);
    inParams.push(['id']); //fields
   // inParams.push(0); //offset
   // inParams.push(5); //limit
    var params = [];
    params.push(inParams);
    odoo.execute_kw('maintenance.equipment', 'search_read', params, function (err, value) {
        if (err) { return  }
        
       let data= JSON.stringify(value);
       
        nb=data.substring(7,12);
        
        createrec({
            eqid: nb,
            titre:req.body.name,
            details:req.body.commentaire,
            statut:req.body.id,
            image:req.body.image,
            image2:req.body.image2,
            image3:req.body.image3
        }).then(function(rec){
        if(rec){
          
            res.send(rec);
        }
        });
        
    })

})
module.exports=router;


