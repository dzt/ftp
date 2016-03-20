var express = require('express'),
    app = express(),
    fs = require('fs'),
    request = require('request'),
    Crawler = require('simplecrawler'),
    twilio = require('twilio'),
    cheerio = require('cheerio'),
    md5 = require('md5');

var url = "https://fuckthepopulation.com/collections/all";

var crawler = Crawler.crawl(url);
crawler.interval = 2000;
crawler.maxConcurrency = 1;

var parsedResults = {

    items: []

};

crawler.on("fetchcomplete", function(queueItem) {

request(url, function(err, resp, html, rrr, body) {
        
        if (!err && resp.statusCode == 200) {

            var $ = cheerio.load(html);

            $('a.grid-link').each(function(i, element) {
                
                var productURL = "https://fuckthepopulation.com" + $(this).attr('href');
                var productName = $(this).find("p.grid-link__title").text();
                var productPrice = $(this).find("span.product-single__price").text();
                var availability = $(this).find("span.badge__text").text();
                var sizes = $(this).find("select.single-option-selector").text();
                var productImage = $(this).find("img").attr('src');

                if (availability == "") availability = "Available";

                request(productURL, function(err, resp, html, rrr, body) {

                    console.log(metadata);

                    var $ = cheerio.load(html);

                    var metadata = {
                        id: md5(productName),
                        title: productName,
                        productURL: productURL,
                        price: $('.product-single__price').text(),
                        availability: availability

                    };

                    parsedResults.items.push(metadata);
                    //console.log(parsedResults);
                    console.log(parsedResults);
                    console.log("--------------------------------");
                    
                });

            });
        }
    });
});

app.get('/test', function(req, res) {

    res.json(parsedResults);

});



app.listen(process.env.PORT || 3000, function() {
    console.log("Server is listening on port %d in %s mode", this.address().port, app.settings.env);
});
