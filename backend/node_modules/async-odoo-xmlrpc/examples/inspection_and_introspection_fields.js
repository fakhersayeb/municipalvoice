var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async () => {
    await odoo.connect();
    // let id = await odoo.execute_kw('ir.model', 'create', [{
    //     'name': 'Custom Model3',
    //     'model': 'x_custom_model_3',
    //     'state': 'manual'
    // }]);
    let ids = await odoo.execute_kw('ir.model', 'search', [
        [['model', '=', 'x_custom_model_3']]
        , 0, 1
    ]);
    let field = await odoo.execute_kw('ir.model.fields', 'create', [{
        'model_id': ids[0],
        'name': 'x_col_name',
        'ttype': 'char',
        'state': 'manual',
        'required': true,
    }]);
    let insertId = await odoo.execute_kw('x_custom_model_3', 'create', [{
        'x_col_name': "Name for testing"
    }]);
    let res = await odoo.execute_kw('x_custom_model_3', 'read', [[insertId]]);
    console.log("Result get fields: ", fields);
})();