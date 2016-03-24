var LocalStrategy = require('passport-local').Strategy;

//load user model
var User = require('../app/models/user');

module.exports = function (passport) {

    //serialize the user
    passport.serializeUser(function (user, done) {
        done(null, user.id);
    });

    //deserialize the user
    passport.deserializeUser(function (id, done) {
        User.findById(id, function (err, user) {
            done(err, user);
        });
    });

    /*  sign in */
    passport.use('local-signin', new LocalStrategy({
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
    }, function (req, email, password, done) {
        if (email)
            email = email.toLowerCase();

        process.nextTick(function () {
            User.findOne({
                'local.email': email
            }, function (err, user) {
                if (err)
                    return done(err);

                if (!user)
                    return done(null, false, req.flash('message', 'No user found.'));

                if (!user.validPassword(password))
                    return done(null, false, req.flash('mesaage', 'Email or Password wrong.'));

                else
                    return done(null, user);
            });
        });
    }));

    /*  sign up */
    passport.use('local-signup', new LocalStrategy({
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
    }, function (req, email, password, done) {
        if (email)
            email = email.toLowerCase();

        process.nextTick(function () {
            if (!req.user) {
                User.findOne({
                    'local.email': email
                }, function (err, user) {
                    if (err)
                        return done(err);

                    if (user) {
                        return done(null, false, req.flash('message', 'The email is already registered.'));
                    } else {
                        var newUser = new User();
                        newUser.local.email = email;
                        newUser.local.password = newUser.generateHash(password);

                        newUser.save(function (err) {
                            if (err)
                                return done(err);

                            return done(null, newUser);

                        });
                    }
                })
            }
        });
    }));
};