'use strict';

const sfdc = require('../../../services/sfdc-connector');

/**
 * Executes a ststic query and returns the appropriate result from SFDC
 * @param {object} req 
 * @param {object} res 
 * @param {function} next 
 */
module.exports = async (req, res, next) => {
    try {
        var account = await sfdc().query('SELECT Id, Name FROM Account');
    } catch (err) {
        next();
    }
    return res.status(200).json(account);
}