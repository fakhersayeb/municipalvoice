const express = require('express');
const app = express();
const cors = require ('cors');
const bodyparser = require ('body-parser');
const db = require('./DB/connect')
const port = 8080 || process.env.port  
const odoo= require('./odoo/odoo')
app.use(cors());
app.use(bodyparser.json({limit: "50mb"}));
app.use(bodyparser.urlencoded({limit: "50mb", extended: true, parameterLimit:50000}));
app.get('/',(req,res)=>{
  res.send('Bienvenue dans cette application!');
 
})
app.use('/',require('./route/userroute'))
app.use('/',require('./route/techroute'))
app.use('/',require('./route/recroute'))
app.use('/',require('./route/reproute'))
app.use('/',require('./odoo/odoo'))
app.listen(port,() =>{
   
})
