'use strict';

const db = require('../../../services/redis-db');

/**
 * Returns one user from the database depending on the email passed in request
 * @param {object} req 
 * @param {object} res 
 * @param {function} next 
 */
module.exports = async(req, res, next) => {
    let user = {}
    try {
        user = await db.getFromHash('users', req.params.email);
    } catch (error) {
       console.log(error); 
    //    next();
    }
    
    return res.status(200).json({
        success: true,
        data: user,
        message: 'Successfully Fetched User'
    });
}