var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let result = await odoo.execute_kw('res.partner', 'search_read', [
        [['is_company', '=', false],['customer', '=', true]]
        , ['name', 'country_id', 'comment']  // fields
        , 0, 5 // offset, limit
    ]);
    console.log("Result: ", result);
})();