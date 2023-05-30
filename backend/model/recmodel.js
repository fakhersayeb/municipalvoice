const sequelize = require('../DB/connect')
const bcrypt = require('bcrypt')
const Sequelize = require('sequelize')
const crypto = require('crypto')
const claim = sequelize.define('claim', {
    eqid: {type: Sequelize.STRING},
    titre: {type:Sequelize.STRING},
    details: {type:Sequelize.STRING},
    statut: {type:Sequelize.STRING},
    image: {type:Sequelize.STRING(10485760)},
    image2: {type:Sequelize.STRING(10485760)},
    image3: {type:Sequelize.STRING(10485760)},
    
    
});

claim.sync({}).then(() => {
    
  });

module.exports= claim;
