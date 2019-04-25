'use strict'

const routes = require('express').Router({ mergeParams: true });

/**
 * creates mappings for all the /api/v1 routes
 */
module.exports = () => {
    routes.use('/users', require('./users')());
    return routes;
};