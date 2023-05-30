const sequelize = require('../DB/connect')
const bcrypt = require('bcrypt')
const Sequelize = require('sequelize')
const crypto = require('crypto')
const users = sequelize.define('users', {
    nom: {type: Sequelize.STRING},
    prenom: {type: Sequelize.STRING},
    email: {type:Sequelize.STRING},
    adresse: {type:Sequelize.STRING},
    password: {type:Sequelize.STRING},
    token: {type:Sequelize.STRING},
    isVerified: {type:Sequelize.BOOLEAN, default: false},
    
});

users.sync().then(() => {
    
  });

module.exports= users;
