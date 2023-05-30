const sequelize = require('../DB/connect')
const bcrypt = require('bcrypt')
const Sequelize = require('sequelize')
const crypto = require('crypto')
const technicians = sequelize.define('technicians', {
    username: {type: Sequelize.STRING},
    email: {type:Sequelize.STRING},
    password: {type:Sequelize.STRING},
    token: {type:Sequelize.STRING},
    codetech: {type:Sequelize.STRING},
    isVerified: {type:Sequelize.BOOLEAN, default: false},
   
});

technicians.sync().then(() => {
    
  });

module.exports= technicians;
