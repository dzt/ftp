var express = require('express'),
app = express(),
fs = require('fs'),
twilio = require('twilio'),
cheerio = require('cheerio'),
md5 = require('md5');

app.listen(process.env.PORT || 3000, function(){
    console.log("Server is listening on port %d in %s mode", this.address().port, app.settings.env);
});
