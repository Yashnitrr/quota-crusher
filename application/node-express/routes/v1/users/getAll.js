'use strict';

const db = require('../../../services/redis-db');

/**
 * Gets all the existing users from Database
 * @param {object} req 
 * @param {object} res 
 * @param {function} next 
 */
module.exports = (req, res, next) => {
    return db.getAllFromHash('users').then(users => {
        res.status(200).json({
            success: true,
            data: users,
            message: 'Successfully Fetched User List'
        });
    }).catch(next);
    
}