const Sequelize = require('sequelize')

const sequelize = new Sequelize('postgres://utilisateur:pgadmin@localhost:5432/projet')
sequelize.authenticate()
.then(() => {

})
.catch(err => {

});
module.exports = sequelize;
    
