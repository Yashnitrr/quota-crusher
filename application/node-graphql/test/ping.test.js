let chai = require('chai');
let chaiHttp = require('chai-http');
let should = chai.should();
const expect = chai.expect;

let server = require('../index');

chai.use(chaiHttp);

describe('GET /ping', () => {
    it('Should return a valid response', (done) => {
        let req = {
            query: '{ ping, express }'
        }
        
        chai.request(server).post('/graphql').send(req).end((err, res) => {
            res.should.have.status(200);
            
            done();
        });
    });
}); 