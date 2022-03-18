var router = require('express').Router();

console.log("In api/portal-manager")

router.use('/create-student', require('./create-student'));
router.use('/approve-employer', require('./approve-employer'));


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