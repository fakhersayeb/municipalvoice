var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async () => {
    await odoo.connect();
    let rs = await odoo.execute_kw('res.partner', 'search_count', [
        [['is_company', '=', false], ['customer', '=', false]]
    ]);
    console.log("Result: ", rs);
})();