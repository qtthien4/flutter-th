const User = require('../models/user.model');
const Favorite = require('../models/favorite.model');
const auth = require('./authenticate');
const express = require('express');
var router = express.Router();

router.post('/register', (req, res) => {
  const user = new User({
    email: req.body.email,
    password: req.body.password,
  });
  user
    .save()
    .then((data) => {
      res.send(data);
    })
    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

router.post('/login', (req, res) => {
  User.findOne({
    email: req.body.email,
    password: req.body.password,
  })
    .then((data) => {
      res.send(data);
    })
    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

router.post('/favorite', (req, res) => {
  const favorite = new Favorite({
    userId: res.body.userId,
    foodId: res.body.foodId,
  });
  favorite
    .save()
    .then(() => {
      res.send({ message: 'Oke' });
    })

    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

router.put('/:userId', (req, res) => {
  const user = new User({
    email: req.body.email,
    password: req.body.password,
  });
  user.findOneAndUpdate({ id: req.params.userId }, user).then(() => {
    res.send({ message: 'Oke' });
  });
});

module.exports = router;
