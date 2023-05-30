var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let rs = await odoo.execute_kw('res.partner', 'fields_get', [
        [], [], [], ['string', 'help', 'type']
    ]);
    console.log("Result: ", rs);
})();