const Favorite = require('../models/favorite.model');

const express = require('express');
var router = express.Router();

router.post('/', (req, res) => {
  const favorite = new Favorite({
    userId: req.body.userId,
    foodId: req.body.foodId,
  });
  favorite
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
  Favorite.find({ userId: req.query.userId })
    .then((data) => {
      res.send(data);
    })

    .catch((error) => {
      res.status(500).send({
        message: error.message,
      });
    });
});

module.exports = router;
