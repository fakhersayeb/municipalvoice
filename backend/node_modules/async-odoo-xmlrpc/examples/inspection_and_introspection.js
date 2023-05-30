var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async () => {
    await odoo.connect();
    let id = await odoo.execute_kw('ir.model', 'create', [{
        'name': 'Custom Model2',
        'model': 'x_custom_model_2',
        'state': 'manual'
    }]);
    let fields = await odoo.execute_kw('x_custom_model_2', 'fields_get', [
        [], [], [], ['string', 'help', 'type']
    ])
    console.log("Result ID: ", id);
    console.log("Result get fields: ", fields);
})();