'use strict'
const routes = require('express').Router({ mergeParams: true });

/**
 * Creates mapping for all the /user routes
 */
module.exports = () => {
    routes.get('/', require('./getAll'));
    routes.get('/:email', require('./getOne'));
    routes.post('/', require('./post'));
    return routes;
}