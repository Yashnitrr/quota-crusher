const express = require('express');
const morgan = require('morgan');
const config = require('./config/config');
const graphqlHTTP = require('express-graphql');
const { buildSchema } = require('graphql');
const defaultSchema = require('./schema/schema');

// Construct a schema, using GraphQL schema language
var schema = buildSchema(defaultSchema);

// import required controllers
const { ping, testExpress, user } = require('./controller');

// The root provides a resolver function for each API endpoint
var root = {
    express: testExpress().expressPing,
    ping: ping,
    users: user().getAll,
    user: user().getOne
};

var app = express();

app.use(morgan('combined'));

app.use('/graphql', graphqlHTTP({
    schema: schema,
    rootValue: root,
    graphiql: true,
}));

const server = app.listen(process.env.PORT || config.PORT || 4000, () => {
    const port = server.address().port;
    console.log(`GraphQl Server listening on port ${port}`);
});

module.exports = server;