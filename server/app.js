	require('dotenv').load();

	var express  = require('express');
	var app      = express();
	var port     = process.env.PORT || 8080;
	var mongoose = require('mongoose');
	var passport = require('passport');
	var flash    = require('connect-flash');
	var morgan = require('morgan');
	var cookieParser = require('cookie-parser');
	var bodyParser = require('body-parser');
	var session = require('express-session');
	var ejs = require('ejs');
	var notify = require('push-notify');
	var fs = require('fs');
	var path = require('path');


	var Status = require('./status');
	var ObjectId = require('mongoose').Types.ObjectId; 

	mongoose.connect(process.env.MONGOLAB_URI);

	var app = express();

	app.use(morgan('dev'));
	app.use(cookieParser());
	app.use(bodyParser.json());
	app.use(bodyParser.urlencoded({ extended: true }));
	app.set('view engine', 'ejs'); 
	app.use(session({ secret: 'EverybodyScreamsFTP' })); 
	app.use(passport.initialize());
	app.use(passport.session()); 
	app.use(flash());


	require('./passport')(passport);

	app.get('/', function(req, res) {
		res.render('index.ejs'); 
	});
	app.get('/login', function(req, res) {
		res.render('login.ejs', { message: req.flash('loginMessage') });
	});
	app.post('/login', passport.authenticate('local-login', {
		successRedirect : '/dashboard', 
		failureRedirect : '/login', 
		failureFlash : true 
	}));
	app.get('/signup', function(req, res) {
		res.render('signup.ejs', { message: req.flash('signupMessage') });
	});

	/*
	app.post('/signup', passport.authenticate('local-signup', {
		successRedirect : '/dashboard', 
		failureRedirect : '/signup', 
		failureFlash : true 
	}));
	*/

	app.get('/dashboard', isLoggedIn, function(req, res) {

		Status.findById({ _id: new ObjectId("56f93de17156c094585a3b25") }, function(err, status) {
		  if (err) throw err;

		  var json = {
		  	"status": status.status,
		  	"imageURL": status.imageURL,
		  	"message": status.message
		  };

			res.render('dashboard.ejs', {
				user : req.user,
				status: json
			});

		});
	});

	app.get('/logout', function(req, res) {
		req.logout();
		res.redirect('/');
	});

	app.get('/status', function(req, res) {

		Status.findById({ _id: new ObjectId("56f93de17156c094585a3b25") }, function(err, status) {
		  if (err) throw err;

		  var json = {
		  	"status": status.status,
		  	"imageURL": status.imageURL,
		  	"message": status.message
		  };

		  res.json(json);
		});


	});

	app.post('/updateStore', isLoggedIn, function(req, res) {

		console.log(req.file.path);

		Status.findById({ _id: new ObjectId("56f93de17156c094585a3b25") }, function(err, status) {
		  if (err) throw err;

		  status.status = req.body.stat;
		  status.imageURL = req.body.image;
		  status.message = req.body.message;

		  status.save(function(err) {
		    if (err) throw err;

		    console.log('Status successfully updated!');
		  });

		});

        res.redirect('/status');

	});

	app.post('/push', isLoggedIn, function(req, res) {

		res.send('<p>This feature is disabled and push notification are done through <a href="https://onesignal.com/">onesignal</a></p>');

	});


	function isLoggedIn(req, res, next) {
		if (req.isAuthenticated())
			return next();
		res.redirect('/');
	}



	app.listen(process.env.PORT || 3000, function(){
	  console.log("Express server listening on port %d in %s mode", this.address().port, app.settings.env);
	});
