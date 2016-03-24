var express = require('express'); 
var routes = require('./routes');
var mongoose = require('mongoose'); 
var passport = require('passport');

require('./models/user');
require('./passport')(passport);

mongoose.connect('mongodb://localhost:27017/passport-example', function(err, res) {
  if(err) throw err;
  console.log('Connected to Database');
});

var app = express();

app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.logger('dev'));

app.use(express.cookieParser());
app.use(express.urlencoded());
app.use(express.json());
app.use(express.methodOverride());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.session({ secret: 'lmaofuck12Ihatewebdev' }));
app.use(passport.initialize());
app.use(passport.session());
app.use(app.router);

if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);

app.get('/login', routes.login);

app.get('/register', routes.register);

app.get('/dashboard', routes.dashboard);

app.get('/logout', function(req, res) {
  req.logout();
  res.redirect('/');
});

app.listen(app.get('port'), function(){
  console.log('FUCKTHEPOPULATION Admin Panel is running on port ' + app.get('port'));
});