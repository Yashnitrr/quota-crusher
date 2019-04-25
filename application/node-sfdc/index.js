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
 * Creating prefix for all APIs /api/v1
 */
app.use('/api/v1/', routes());

app.use(apiErrorHandler({ detailed: process.env.NODE_ENV !== 'production' }));

/**
 * Function can be used for health-check or testing API
 */
app.get('/ping', (req, res) => {
    return res.status(200).json({
        success: true,
        message: 'SDFC is live and running'
    });
});


const server = app.listen(port, () => {
    const port = server.address().port;
    console.log(`App listening on port ${port}`);
});

module.exports = server
