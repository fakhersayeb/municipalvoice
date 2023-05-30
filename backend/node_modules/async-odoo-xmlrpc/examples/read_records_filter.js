var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    let start = new Date().getTime();
    await odoo.connect();
    let id = await odoo.execute_kw('res.partner', 'search', [
        [['is_company', '=', false],['customer', '=', true]],
        0, 1
    ]);
    let rs = await odoo.execute_kw('res.partner', 'read', [
        14
        , ['name', 'country_id', 'comment']
    ])
    console.log("During ", new Date().getTime() - start);
    console.log("Result: ", rs);
})();