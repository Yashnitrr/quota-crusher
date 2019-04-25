var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/abc', function(req, res, next) {
  res.render('index.html', { title: 'Express' });
});

module.exports = router;
