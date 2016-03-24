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
	app.post('/signup', passport.authenticate('local-signup', {
		successRedirect : '/dashboard', 
		failureRedirect : '/signup', 
		failureFlash : true 
	}));
	app.get('/dashboard', isLoggedIn, function(req, res) {
		res.render('dashboard.ejs', {
			user : req.user
		});
	});
	app.get('/logout', function(req, res) {
		req.logout();
		res.redirect('/');
	});

	function isLoggedIn(req, res, next) {
		if (req.isAuthenticated())
			return next();
		res.redirect('/');
	}


	app.listen(8080, function(){
	  console.log('Admin Panel is running on port ' + app.get('port'));
	});
