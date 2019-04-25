'use strict';

const api = require('../helpers/api-helper');
const config = require('../config/config.json');

module.exports = () => {
    /**
     * Simple function that returns the response of /ping endpoint of express micro-service
     */
    this.expressPing = async () => {
        try {
            let resp = await api().get(`${config.EXPRESS_URL}/ping`);
            let message = JSON.parse(resp)['message'];
            return message;
        } catch (error) {
            return 'Error Occurred';
        }
    }

    return this;
}