/*
* Author: Faisal Sami
* mail: faisalsami78@gmail.com
* https://github.com/faisalsami/odoo-xmlrpc
* 
* Modify by nguyenvantien2009
* http://nguyenvantien2009.com
*/
var xmlrpc = require('xmlrpc');
var url = require('url');

var Odoo = function (config) {
    config = config || {};

    var urlparts = url.parse(config.url);
    this.host = urlparts.hostname;
    this.port = config.port || urlparts.port;
    this.db = config.db;
    this.username = config.username;
    this.password = config.password;
    this.secure = true;
    if (urlparts.protocol !== 'https:') {
        this.secure = false
    }
    var uid = 0;

    /**
     * connect to XML-RPC of Odoo base on setting in config.
     */
    this.connect = async () => {
        var clientOptions = {
            host: this.host,
            port: this.port,
            path: '/xmlrpc/2/common'
        }

        var client = this.secure === false
            ? xmlrpc.createClient(clientOptions)
            : xmlrpc.createSecureClient(clientOptions);

        var params = [
            this.db
            , this.username
            , this.password
            , {}    // empty object.
        ];

        return new Promise((resolve, reject) => {
            client.methodCall('authenticate', params, (error, value) => {
                if (error) {
                    reject(error)
                }
                if (!value) {
                    reject({ message: "No UID returned from authentication." })
                }
                uid = value;
                resolve(value);
            });
        })
    };

    /**
     * Execute a method from model in Odoo.
     * 
     * @param {String} model Model name in Odoo.
     * @param {String} method Name of method in Odoo.
     * @param {Array<Object>} params Params in to execute from Odoo.
     */
    this.execute_kw = async (model, method, params) => {
        var clientOptions = {
            host: this.host,
            port: this.port,
            path: '/xmlrpc/2/object'
        }

        var client = this.secure === false
            ? xmlrpc.createClient(clientOptions)
            : xmlrpc.createSecureClient(clientOptions);

        var fparams = [
            this.db
            , uid
            , this.password
            , model
            , method
            , params
        ];

        return new Promise((resolve, reject) => {
            client.methodCall('execute_kw', fparams, (error, value) => {
                error ? reject(error) : resolve(value)
            });
        })
    };

    /**
     * call workflow in odoo.
     * 
     * @param {String} model Model name in Odoo
     * @param {String} method Method name in Odoo
     * @param {Object[]} params List parameters to call xml-rpc.
     */
    this.exec_workflow = async (model, method, params) => {
        var clientOptions = {
            host: this.host
            , port: this.port
            , path: '/xmlrpc/2/object'
        }

        var client = this.secure === false
            ? xmlrpc.createClient(clientOptions)
            : xmlrpc.createSecureClient(clientOptions);

        var fparams = [
            this.db
            , uid
            , this.password
            , model
            , method
            , params
        ];

        return new Promise((resolve, reject) => {
            client.methodCall('exec_workflow', fparams, (error, value) => {
                error ? reject(error) : resolve(value);
            });
        })
    };


    this.render_report = async (report, params) => {
        var clientOptions = {
            host: this.host
            , port: this.port
            , path: '/xmlrpc/2/report'
        }

        var client = this.secure === false
            ? xmlrpc.createClient(clientOptions)
            : xmlrpc.createSecureClient(clientOptions);

        var fparams = [
            this.db
            , uid
            , this.password
            , report
            , params
        ];

        return new Promise((resolve, reject) => {
            client.methodCall('render_report', fparams, (error, value) => {
                error ? reject(error) : resolve(value)
            });
        })
    };
};

module.exports = Odoo;
