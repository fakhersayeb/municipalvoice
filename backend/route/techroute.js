const express = require('express');
const router = express.Router();
const Tech = require('../model/techmodel')
const db = require('../DB/connect')
const Sequelize = require('sequelize');
const jwt = require('jsonwebtoken');
var nodemailer = require('nodemailer');
const passport = require('passport');
const passportJWT = require('passport-jwt');
var generator = require('generate-password');
let ExtractJwt = passportJWT.ExtractJwt;
let JwtStrategy = passportJWT.Strategy;
const bcrypt = require('bcrypt')
const crypto = require('crypto')
const saltRounds = 10;
let jwtOptions = {};

jwtOptions.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
jwtOptions.secretOrKey = 'wowwow';
// lets create our strategy for web token
let strategy = new JwtStrategy(jwtOptions, function(jwt_payload, next) {
 
  let tech = getTech({ id: jwt_payload.id });

  if (tech) {
    next(null, tech);
  } else {
    next(null, false);
  }
});
// use the strategy
passport.use(strategy);
router.use(passport.initialize());
const createTech = async ({ username,email, password }) => {
  return await Tech.create({ username,email, password });
};
const getTech = async obj => {
  return  Tech.findOne({
    where: obj,
  });
};
router.get('/getalltech', (req, res) => 
  Tech.findAll()
    .then(techs => { 
        
        res.json(techs);
      })
    .catch(err => ''));

    router.post('/gettech',(req,res)=>{
     const m=req.body.title;

       Tech.findOne({
        where: {
        email:m
               }
   }).then(tech=>  res.send(tech.username));
   })
   router.post('/getemailtech',(req,res)=>{
     const m=req.body.mailto;
    Tech.findOne({
      where: {
          email:m
             }
 }).then(tech=> res.send(tech.email));
 })
    
 
    router.post('/inscritech', async(req, res) => {
     Tech.findOne({
        where: {
            email: req.body.email
               }
   }).then(function (tech) {
    
        if (tech) {
        res.status(401).send('Cette adresse e-mail est déjà associée à un autre compte.');
       } 
       else{
        let payload = {subject: Tech._id}
        const token = jwt.sign(payload,
         'secretKey',{expiresIn: '1h'}
        )
       bcrypt.hash(req.body.password, saltRounds, function (err,   hash) {
        createTech({
          username: req.body.username,
          email: req.body.email,
          password: hash,
          token: token,
         
          }).then(function(data) {
           if (data) {
           res.send(data);
           data.update({token:token},{where: {email: req.body.email} })
           
           const url= `localhost:8080`
           var mailOptions = {
            from: 'fakhersayeb00@gmail.com',
            to: data.email,
            subject: 'Email de confirmation',
            text: 'Bonjour ' + 'Veuillez vérifier votre compte en cliquant sur ce lien: \nhttp:\/\/' + url + '\/confirmation2\/' +data.token + '\n\nMerci!\n',
          };
          
          transporter.sendMail(mailOptions, function(error, info){
            if (error) {
              
            } else {
             
              res.status(200).json(info.response)
            }
          });  
          
           }
          
         });
        });
        
        }
       })
      });
    router.get('/confirmation2/:token',async(req,res)=>{
      
                    Tech.update({isVerified:true},{where: {token: req.params.token} })
                       
                    res.status(200).send('<body style="background-color:orange;"></br></br></br></br></br></br></br></br></br><center><div class="card" style="width: 18rem;"><img class="card-img-top" src="https://img.icons8.com/color/452/instagram-verification-badge.png" width="200" height="200" alt="Card image cap"> <div class="card-body"/> <h1 style="color:blue;"><b><i>Votre compte a été vérifié avec succès</i></b></h1></div></div></center>');
                      
                
  
    })
    
    
    router.post('/authtech', async(req,res)=>{
     Tech.findOne({
        where: {
            email: req.body.email
               }
   }).then(function (tech) {
       if (!tech) {
          res.send('utilisateur ne pas trouvé')
       } 
       else if(!tech.isVerified){
        res.status(401).send('Votre email ne pas été vérifié. Veuillez cliquer sur renvoyer ');
       }
       else {
bcrypt.compare(req.body.password, tech.password, function (err, result) {
      if (result == true) {
          res.status(200).send('utilisateur trouvé')
         
      } else {
       res.send('Incorrect mot de passe');
      
      }
    });
    
   }
});
              
    })
    var transporter = nodemailer.createTransport({
      service: 'gmail',
     // address: '74.125.206.109',
      port: 465,
      auth: {
        user: 'fakhersayeb00@gmail.com',
        pass: 'fakher?A123'
      }
    });
    
    router.post('/sendmailtech',async(req,res)=>{
      const { email } = req.body;
      let tech = await getTech({ email: email });
      if(tech){
        res.status(200).json({ message: 'Email correct' });
        
        var password = generator.generate({
          length: 10,
          numbers: true
        });
    var mailOptions = {
        from: 'fakhersayeb00@gmail.com',
        to: email,
        subject: 'Nouveau mot de passe',
        text: 'votre nouveau mot de passe est '+password,
      };
      
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          
        } else {
         
          res.status(200).json(info.response)
        }
      });  
      }
      else{
        res.status(401).json({ message: 'Email incorrect' });  
      }
    })
    router.put('/changetech',async(req,res)=>{
     hashpass = await bcrypt.hash(req.body.password, saltRounds);
     Tech.findOne({
      where: {
          email: req.body.email
             }
 }).then( function (tech){
   if (!tech) {
  res.send('utilisateur ne pas trouvé')
}
else {
  tech.update({password:hashpass},{where: {email: req.body.email} })
  res.status(200).json({ message :  'mot de passe changé' });
}
 })
    })
    router.put('/changeemailtech',async(req,res)=>{
      
      Tech.findOne({
       where: {
           username:req.body.username
              }
  }).then( function (tech){
    if (!tech) {
   res.send('utilisateur ne pas trouvé')
 }
 else {
   user.update({email:req.body.email},{where: {username:req.body.username} })
   res.status(200).json({ message :  'email changé' });
 }
  })
     })

       router.put('/changenametech',async(req,res)=>{
     
     Tech.findOne({
      where: {
          email: req.body.email
             }
 }).then( function (tech){
   if (!tech) {
  res.send('utilisateur ne pas trouvé')
}
else {
  tech.update({username:req.body.username},{where: {email: req.body.email} })
  res.status(200).json({ message :  'nom et prénom changés' });
}
 })
    }) 
module.exports = router;