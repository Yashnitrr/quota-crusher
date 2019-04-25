'use strict';
const jsforce = require('jsforce');
const config = require('../config/config');
var conn = new jsforce.Connection();

/**
 * Creates SFDC Connection using th username and password from Environment or Config
 */
function makeConnection() {
    return new Promise((resolve, reject) => {
        conn.login(process.env.SFDC_USERNAME || config.SFDC_USERNAME, process.env.SFDC_PASSWORD || config.SFDC_PASSWORD, function (err, res) {
            if (err) {
                console.log("Cannot connect to SFDC. Error occurred");
                return reject(err);
            }
            console.log("Connected to SFDC Successfully");
            return resolve();
        });
    });
}


module.exports = () => {
    /**
     * fires given query on SFDC and returns appropriate result
     * @param {string} query 
     */
    this.query = async (query) => {
        if (!conn.instanceUrl) {
            try {
                let connectionStatus = await makeConnection();
            } catch (error) {
                console.log(error);
                return;
            }
        }
        return new Promise((resolve, reject) => {
            conn.query(query, function (err, res) {
                if (err) { return reject(err); }
                return resolve(res);
            });
        });
    }
    return this;
};