const Cart = require('../models/cart.model');

const express = require('express');
var router = express.Router();

router.post('/', (req, res) => {
  const cart = new Cart({
    userId: req.body.userId,
    product: req.body.product,
    checkout: false,
  });
  cart
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

router.get('/', (req, res) => {
  Cart.find({ userId: req.query.userId })
    .then((data) => {
      res.send(data);
    })

    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

router.post('/checkout', (req, res) => {
  const userId = req.body.userId;
  Cart.updateMany({ userId }, { $set: { checkout: true } })
    .then((data) => res.send(data))
    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

module.exports = router;
