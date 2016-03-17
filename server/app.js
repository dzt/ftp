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
crawler.interval = 10000;
crawler.maxConcurrency = 1;

crawler.on("fetchcomplete", function(queueItem) {

request(url, function(err, resp, html, rrr, body) {
        
        if (!err && resp.statusCode == 200) {

            var $ = cheerio.load(html);
            var parsedResults = {

                items: []

            };

            $('a.grid-link').each(function(i, element) {
                
                var productURL = "https://fuckthepopulation.com" + $(this).attr('href');
                var productName = $(this).find("p.grid-link__title").text();
                var productPrice = $(this).find("span.product-single__price").text();
                var availability = $(this).find("span.badge__text").text();
                var price = $(this).find("p.grid-link__meta").text();

                var sizes = $(this).find("select.single-option-selector").text();

                //var productImage = $(this).find("img").attr('src');

                console.log(productURL);

                if (availability == "") availability = "Available";

                request(productURL, function(err, resp, html, rrr, body) {

                    fs.writeFile('output.json', JSON.stringify(parsedResults, null, 4), function(err) {

                    });

                    var $ = cheerio.load(html);

                    var metadata = {
                        id: md5(productName),
                        title: productName,
                        productURL: productURL,
                        price: price,
                        availability: availability,
                        //image: productImage,
                        images: [],
                        sizes: sizes

                    };

                    console.log(metadata);
                    parsedResults.items.push(metadata);

                });

            });
        }
    });
});

app.listen(process.env.PORT || 3000, function() {
    console.log("Server is listening on port %d in %s mode", this.address().port, app.settings.env);
});
