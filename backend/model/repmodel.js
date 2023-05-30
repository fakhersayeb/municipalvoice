const sequelize = require('../DB/connect')
const bcrypt = require('bcrypt')
const Sequelize = require('sequelize')
const crypto = require('crypto')
const rep = sequelize.define('repair', {
    code: {type: Sequelize.STRING},
    details: {type:Sequelize.STRING},
    image: {type:Sequelize.STRING(10485760)},
    image2: {type:Sequelize.STRING(10485760)},
    image3: {type:Sequelize.STRING(10485760)},
    
    
});

rep.sync({}).then(() => {
    
  });

module.exports= rep;
