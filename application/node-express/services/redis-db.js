const config = require('../config/config.json');
const redis = require('redis');
const client = redis.createClient(process.env.REDIS_PORT || config.REDIS_PORT, process.env.REDIS_HOST || config.REDIS_HOST);

client.on('connect', function() {
    console.log("Successfully connected to redis");
});

client.on("error", function (err) {
    console.log("Error Connecting to redis");
    console.log("Error " + err);
});


/**
 * gets the value of a key from redis
 * @param {string} keyName      - name of the key whose value has to be fetched.
 */
exports.getKey = (keyName) => {
    return new Promise((resolve, reject) => {
        client.get(keyName, (err, reply) => {
            if (err) {
                return reject(err)
            } else {
                return resolve(reply);
            }
        });
    });
}


/**
 * sets a key-value pair in redis database with a proper expiry
 * @param {string} keyName  - name of the key whose value has to be set
 * @param {string} value    - value of the key
 * @param {number} expiry   - TTL in seconds default 1hr
 */
exports.setKey = (keyName, value, expiry = 3600) => {
    return client.set(keyName, value, 'EX', expiry);
}


/**
 * Adds a key-value pair to a provided hash
 * If the hash doesn't exist,it will create the hash
 * @param {string} hashName     - name of the Hash
 * @param {string} keyName      - key name
 * @param {string} value        - key value
 */
exports.addToHash = (hashName, keyName, value) => {
    return client.hset(hashName, keyName, value);
}


/**
 * Fetches a value of a key from a particular hash
 * @param {string} hashName     - name of the hash 
 * @param {string} keyName      - name of the Key whose value is to be fetched
 */
exports.getFromHash = (hashName, keyName) => {
    return new Promise((resolve, reject) => {
        client.hget(hashName, keyName, (err, reply) => {
            if (err || !reply) {
                return reject()
            } else {
                return resolve(reply);
            }
        });
    });
}

/**
 * Fetches all the items (key-value pairs) from a hash
 * @param {string} hashName     - name of the hash
 */
exports.getAllFromHash = (hashName) => {
    return new Promise((resolve, reject) => {
        client.hgetall(hashName, (err, reply) => {
            if (err || !reply) {
                return reject()
            } else {
                return resolve(reply);
            }
        });
    });
}
