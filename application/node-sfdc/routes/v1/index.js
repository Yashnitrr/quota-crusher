'use strict'

const routes = require('express').Router({ mergeParams: true });

/**
 * mapping of all the routes from /api/v1
 */
module.exports = () => {
    routes.use('/sfdc', require('./sfdc')());
    return routes;
};