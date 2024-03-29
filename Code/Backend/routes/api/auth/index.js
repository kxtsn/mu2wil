var router = require('express').Router();

console.log("In api/auth")

router.use('/login', require('./login'));
router.use('/reset-password', require('./reset-password'));
router.use('/forget-password', require('./forget-password'));

router.use(function(err, req, res, next){
  if(err.name === 'ValidationError'){
    return res.status(422).json({
      errors: Object.keys(err.errors).reduce(function(errors, key){
        errors[key] = err.errors[key].message;

        return errors;
      }, {})
    });
  }

  return next(err);
});

module.exports = router;