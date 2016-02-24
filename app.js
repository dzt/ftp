var express = require('express'),
app = express(),
fs = require('fs'),
request = require('request'),
Crawler = require('simplecrawler'),
twilio = require('twilio'),
cheerio = require('cheerio'),
md5 = require('md5');

var url = "http://shop.fuckthepopulation.com/";

var crawler = Crawler.crawl(url);
crawler.interval = 10000;
crawler.maxConcurrency = 1;

crawler.on("fetchcomplete", function(queueItem) {

request(url, function(err, resp, html, rrr, body) {
        
        if (!err && resp.statusCode == 200) {

        	var $ = cheerio.load(html);
        	var parsedResults = {

        		items: []

        	};

        	var product = $('li.product');

        	product.each(function(i, element) {

        		var nextElement = $(this).next();
                var prevElement = $(this).prev();

                // var productLink = product.find('a').att();

                console.log($(this).attr('id'));

        	});

		}
	});
});

app.listen(process.env.PORT || 3000, function(){
    console.log("Server is listening on port %d in %s mode", this.address().port, app.settings.env);
});
