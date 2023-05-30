var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let access = await odoo.execute_kw('res.partner', 'check_access_rights', [
        ['read', false]
    ]);
    console.log("Result: ", access);
})();