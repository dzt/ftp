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


        	$('li.product').each(function(i, element) {
                
                var productID = $(this).attr('id');
                var productURL = "http://shop.fuckthepopulation.com" + $(this).find("a").attr('href');
                var productName = $(this).find("h2").text();
                var productPrice = $(this).find("h3").text();

                console.log(productName);
                console.log(productID);
                console.log(productPrice);
                console.log(productURL);

        	});

		}
	});
});

app.listen(process.env.PORT || 3000, function(){
    console.log("Server is listening on port %d in %s mode", this.address().port, app.settings.env);
});
