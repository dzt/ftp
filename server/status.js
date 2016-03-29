var mongoose = require('mongoose');

var statusSchema = mongoose.Schema({

    status: { type: String, required: true, unique: true },
    imageURL: { type: String, required: true, unique: true },
    message: { type: String, required: true, unique: true }

});

module.exports = mongoose.model('Status', statusSchema);