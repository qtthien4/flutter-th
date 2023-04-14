var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var cookieParser = require('cookie-parser');

var users = require('./routes/users');
var foods = require('./routes/foods');
var categories = require('./routes/categories');
var orders = require('./routes/orders');
var users = require('./routes/users');
var cart = require('./routes/cart');
const cors = require('cors');

var app = express();
const port = 3123;
app.use(express.static('image'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(
  cors({
    origin: '*',
    methods: ['GET', 'POST', 'DELETE', 'UPDATE', 'PUT', 'PATCH'],
  })
);

mongoose
  .connect('mongodb://localhost:27017/foodDB', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log('Successfully connected to the database');
  })
  .catch((err) => {
    console.log('Could not connect to the database. Exiting now...', err);
    process.exit();
  });

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

app.use('/api/v1/users', users);
app.use('/api/foods', foods);
app.use('/api/categories', categories);
app.use('/api/orders', orders);
app.use('/api/cart', cart);
// app.use('/api/users', users);
// app.use('/api/test', test);

module.exports = app;
