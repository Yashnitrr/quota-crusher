const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const routes = require('./routes/v1');
const apiErrorHandler = require('./helpers/error-handler');
const config = require('./config/config.json');


const port = process.env.PORT || config.PORT || 3000;
const app = express();

/* 
    Injecting all the middleware
*/
app.use(morgan('combined'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

/**
 * Prepend all the routes by /api/v1
 */
app.use('/api/v1/', routes());


app.use(apiErrorHandler({ detailed: process.env.NODE_ENV !== 'production' }));

/**
 * Returns an success status with a valid JSON output
 * route can be used for health-checks and testing apis
 */
app.get('/ping', (req, res) => {
    return res.status(200).json({
        success: true,
        message: 'Express application is live and running'
    });
});


const server = app.listen(port, () => {
    const port = server.address().port;
    console.log(`App listening on port ${port}`);
});

module.exports = server;