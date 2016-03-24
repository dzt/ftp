module.exports = function (app, passport) {

    app.post('/api/signup', function (req, res, next) {
        passport.authenticate('local-signup', function (err, user, info) {
            if (err) {
                return res.json({
                    result: -1,
                    message: 'Please check your input and try again.'
                });
            }

            if (!user) {
                return res.json({
                    result: 0,
                    message: 'The email is already registered.'
                });
            }

            if (user) {
                return res.json({
                    result: 1,
                    message: 'Signup seccess!'
                });
            }
        })(req, res, next);
    });

    /*  sign in api */
    app.post('/api/signin', function (req, res, next) {
        passport.authenticate('local-signin', function (err, user, info) {
            if (err) {
                return res.json({
                    result: -1,
                    message: 'Please check your input and try again.'
                });
            }

            if (!user) {
                return res.json({
                    result: 0,
                    message: 'Email or Password wrong.'
                });
            }

            if (user) {
                return res.json({
                    result: 1,
                    message: 'Sign In seccess!'
                });
            }
        })(req, res, next);
    });
};