'use strict';

const api = require('../helpers/api-helper');
const config = require('../config/config.json');

module.exports = () => {
    
    /**
     * hits the /api/v1/users endpoint of express microservice internally and returns all the users as output
     */
    this.getAll = async () => {
        try {
            let resp = await api().get(`${config.EXPRESS_URL}/api/v1/users/`);
            let tmpUsers = JSON.parse(resp)['data'];
            let users = [];
            for(let email in tmpUsers){
                users.push({
                    name: tmpUsers[email],
                    email: email
                });
            }
            return users;
        } catch (error) {
            return 'Error Occurred';
        }
    },

    /**
     * hits the /api/v1/users/:email endpoint of the express microservice and returns the user details
     * @param {string} email    - email of the required user
     */
    this.getOne = async (email) => {
        try {
            let resp = await api().get(`${config.EXPRESS_URL}/api/v1/users/${email.email}`);
            let user = {
                email: email.email,
                name: JSON.parse(resp)['data']
            }
            return user;

        } catch (error) {
            return "Error Occurred"
        }
    }

    return this;
}