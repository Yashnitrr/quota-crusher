'use strict';

const db = require('../../../services/redis-db');

/**
 * Creates a new user in database and returns a valid JSON as response
 * @param {object} req 
 * @param {object} res 
 * @param {function} next 
 */
module.exports = (req, res, next) => {
    db.addToHash('users', req.body.email, req.body.name)
    return res.status(200).json({
        success: true,
        message: 'Successfully Added User'
    });
}