const jwt = require('jsonwebtoken')
const validator = require("email-validator");

module.exports = {
    ValidateRegister: (req, res, next) => {
        //validate email address 
        if (!req.body.email || validator.validate(req.body.email)){
            return res.status(400).send({
                msg: 'Please enter a valid email'
            });
        }
        //validate password of minimum 6 characters
        if (!req.body.password || req.body.password.length < 6){
            return res.status(400).send({
                msg: 'Please enter a password with min 6 charaters'
            });
        }
    next();
    },

    isLoggedIn: (req, res, next) => {
        try {
            const token = req.headers.authorization.split(' ')[1];
            const decoded = jwt.verify(
              token,
              'togeneratestrongserect'
            );
            req.userData = decoded;
            console.log(req.userData);
            next();
          } catch (err) {
            return res.status(401).send({
              msg: 'Your session is not valid!' + err
            });
          }
        }
}