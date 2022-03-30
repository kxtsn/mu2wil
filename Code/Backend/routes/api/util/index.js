var router = require('express').Router();

console.log("In api/util")

router.use('/get-first-name', require('./get-first-name'));
router.use('/check-email-exist', require('./check-email-exist'));

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