'use strict';

const request = require('request');

module.exports = () => {
    /**
     * Performs GET API call on provided URL
     * @param {string} url      - URL for GET API Call
     * @param {object} params   - query parameters
     * @param {object} headers  - request headers
     */
    this.get = (url, params, headers) => {
        return new Promise((resolve, reject) => {
            request(url, (err, res, body) => {
                if (err) {
                    return reject(err);
                }
                return resolve(res.body);
            });
        });
    }

    /**
     * Performs POST API call on provided URL
     * @param {string} url      - URL for GET API Call
     * @param {object} params   - query parameters
     * @param {object} body     - Request body/payload
     * @param {object} headers  - request headers
     */
    this.post = (url, params, body, headers) => {

    }

    /**
     * Performs PUT API call on provided URL
     * @param {string} url      - URL for GET API Call
     * @param {object} params   - query parameters
     * @param {object} body     - Request body/payload
     * @param {object} headers  - request headers
     */
    this.put = (url, params, body, headers) => {

    }

    /**
     * Performs DELETE API call on provided URL
     * @param {string} url      - URL for GET API Call
     * @param {object} params   - query parameters
     * @param {object} body     - Request body/payload
     * @param {object} headers  - request headers
     */
    this.delete = (url, params, body, headers) => {

    }

    return this;
}