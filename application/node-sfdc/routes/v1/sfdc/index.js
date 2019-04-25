'use strict'
const routes = require('express').Router({ mergeParams: true });

/**
 * mapping of all the routes for /sfdc
 */
module.exports = () => {
    routes.get('/', require('./get'));
    return routes;
}