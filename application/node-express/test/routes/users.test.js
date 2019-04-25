let chai = require('chai');
let chaiHttp = require('chai-http');
let should = chai.should();
const expect = chai.expect;

let server = require('../../index');

describe('/users function', () => {

    describe('Get One Users Function', () => {
        it('Should return User when given appropriate email', () => {
            let email = 'johndoe@google.com';
            chai.request(server).get(`/api/v1/users/${email}`).end((err, res) => {
                res.should.have.status(200);
            });
        });
    });

    describe('Get All users Function', () => {
        it('Should return all the users from Database', () => {
            chai.request(server).get(`/api/v1/users/`).end((err, res) => {
                res.should.have.status(200);
            });
        });
    });

    describe('Insert new users Function', () => {
        it('Create a new user in database and return success', () => {
            let user = {
                email: "janedoe@google.com",
                name: "Jane Doe" 
            }
            chai.request(server).post(`/api/v1/users/`).send(user).end((err, res) => {
                res.should.have.status(200);
            });
        });
    });

});
