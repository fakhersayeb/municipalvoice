const express = require('express');
const router = express.Router();
const User = require('../model/usermodel')
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
const crypto = require('crypto');

const saltRounds = 10;
let jwtOptions = {};

jwtOptions.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
jwtOptions.secretOrKey = 'wowwow';
// lets create our strategy for web token
let strategy = new JwtStrategy(jwtOptions, function(jwt_payload, next) {
  
  let user = getUser({ id: jwt_payload.id });

  if (user) {
    next(null, user);
  } else {
    next(null, false);
  }
});
// use the strategy
passport.use(strategy);
router.use(passport.initialize());
const createUser = async ({ nom,prenom,email,adresse, password }) => {
  return await User.create({ nom,prenom,email,adresse, password });
};
const getUser = async obj => {
  return  User.findOne({
    where: obj,
  });
};
router.get('/getall', (req, res) => 
  User.findAll()
    .then(users => {
        
        res.json(users);
      })
    .catch(err => ''));
   
    
    router.post('/get',(req,res)=>{
      const m=req.body.title;
   
       User.findOne({
        where: {
        email:m
               }
   }).then(user=>res.send(user.username));
   })
   router.post('/getemail',(req,res)=>{
    const m=req.body.mailto;
    User.findOne({
      where: {
         email:m
             }
 }).then(user=> res.send(user.email));
 })

   
    router.post('/inscri', async(req, res) => {
      User.findOne({
        where: {
            email: req.body.email
               }
   }).then(function (user) {
    
        if (user) {
        res.status(401).send('Cette adresse e-mail est déjà associée à un autre compte.');
       } 
       else{
        let payload = {subject: User._id}
        const token = jwt.sign(payload,
         'secretKey',{expiresIn: '1h'}
        )
       bcrypt.hash(req.body.password, saltRounds, function (err,   hash) {
        createUser({
          nom: req.body.nom,
          prenom:req.body.prenom,
          email: req.body.email,
          adresse:req.body.adresse,
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
            text: 'Bonjour ' + 'Veuillez vérifier votre compte en cliquant sur ce lien: \nhttp:\/\/' + url + '\/confirmation\/' +data.token + '\n\nMerci!\n',
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
    router.get('/confirmation/:token',async(req,res)=>{
 User.update({isVerified:true},{where: {token: req.params.token} })
 res.status(200).send('<body style="background-color:orange;"></br></br></br></br></br></br></br></br></br><center><div class="card" style="width: 18rem;"><img class="card-img-top" src="https://img.icons8.com/color/452/instagram-verification-badge.png" width="200" height="200" alt="Card image cap"> <div class="card-body"/> <h1 style="color:blue;"><b><i>Votre compte a été vérifié avec succès</i></b></h1></div></div></center>');
    
  
    })
    
    
    router.post('/auth', async(req,res)=>{
      User.findOne({
        where: {
            email: req.body.email
               }
   }).then(function (user) {
       if (!user) {
          res.send('utilisateur ne pas trouvé')
       } 
       else if(!user.isVerified){
        res.status(401).send('Votre email ne pas été vérifié. Veuillez cliquer sur renvoyer ');
       }
       else {
bcrypt.compare(req.body.password, user.password, function (err, result) {
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
        pass: 'azert?A123'
      }
    });
    
    router.post('/sendmail',async(req,res)=>{
      const { email } = req.body;
      let user = await getUser({ email: email });
      if(user){
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
    router.put('/change',async(req,res)=>{
     hashpass = await bcrypt.hash(req.body.password, saltRounds);
     User.findOne({
      where: {
          email: req.body.email
             }
 }).then( function (user){
   if (!user) {
  res.send('utilisateur ne pas trouvé')
}
else {
  user.update({password:hashpass},{where: {email: req.body.email} })
  res.status(200).json({ message :  'mot de passe changé' });
}
 })
    })
    router.put('/changeemail',async(req,res)=>{
      
      User.findOne({
       where: {
           username:req.body.username
              }
  }).then( function (user){
    if (!user) {
   res.send('utilisateur ne pas trouvé')
 }
 else {
   user.update({email:req.body.email},{where: {username:req.body.username} })
   res.status(200).json({ message :  'email changé' });
 }
  })
     })

       router.put('/changename',async(req,res)=>{
     
     User.findOne({
      where: {
          email: req.body.email
             }
 }).then( function (user){
   if (!user) {
  res.send('utilisateur ne pas trouvé')
}
else {
  user.update({username:req.body.username},{where: {email: req.body.email} })
  res.status(200).json({ message :  'nom et prénom changés' });
}
 })
    }) 
module.exports = router;