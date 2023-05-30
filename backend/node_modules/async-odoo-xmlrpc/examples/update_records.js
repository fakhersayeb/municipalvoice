var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let resUpdate = await odoo.execute_kw('res.partner', 'write', [
        [14]
        , {'name': 'New Partner Updated.'}
    ]);
    let res = await odoo.execute_kw('res.partner', 'read', [
        [14]
    ]);
    console.log("Result: ", res);
})();