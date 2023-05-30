var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let id = await odoo.execute_kw('res.partner', 'unlink', [
        [15]
    ]);
    console.log("Result: ", id);
})();