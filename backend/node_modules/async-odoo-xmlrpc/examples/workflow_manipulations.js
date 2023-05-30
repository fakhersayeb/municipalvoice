var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let customer = await odoo.execute_kw('res.partner', 'search_read', [
        [['customer', '=', true]]
        , [ 'property_account_receivable',
            'property_payment_term',
            'property_account_position'
        ], 0, 1
    ]);
    console.log(customer);
    let id = await odoo.execute_kw('account.invoice', 'create', [
        {
            'partner_id': customer[0]['id'],
            'account_id': customer[0]['property_account_receivable'][0],
            'invoice_line': [0, False, {'name': "AAA"}]
        }
    ]);
    let res = await odoo.exec_workflow('account.invoice', 'invoice_open', [id]);
    console.log("Result: ", res);
})();