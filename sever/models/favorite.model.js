const mongoose = require('mongoose');
const FavoriteSchema = mongoose.Schema(
  { userId: String, foodId: String },
  { versionKey: false, collection: 'favorite' }
);
module.exports = mongoose.model('Favorite', FavoriteSchema);
