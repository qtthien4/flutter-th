const mongoose = require('mongoose');
const CartSchema = mongoose.Schema(
  {
    product: {
      title: String,
      description: String,
      image: String,
      price: String,
    },
    userId: String,
    checkout: Boolean,
  },
  { versionKey: false, collection: 'cart' }
);
module.exports = mongoose.model('Cart', CartSchema);
