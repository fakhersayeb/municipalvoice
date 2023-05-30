var Odoo = require('../src/index');
var config = require('./config');
var odoo = new Odoo(config);

(async() => {
    await odoo.connect();
    let ids = await odoo.execute_kw('account.invoice', 'search', [
        [['type', '=', 'out_invoice'], ['state', '=', 'open']]
    ]);
    let rs = await odoo.render_report('account.report_invoice', ids)
    console.log("Result: ", rs);
})();