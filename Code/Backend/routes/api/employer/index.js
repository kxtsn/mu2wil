var router = require('express').Router();

console.log("In api/employer")

router.use('/register-employer', require('./register-employer'));
router.use('/view-own-listing', require('./view-own-listing'));
router.use('/view-student-application', require('./view-student-application'));
router.use('/view-company-testimonial', require('./view-company-testimonial'));
router.use('/view-written-testimonial', require('./view-written-testimonial'));

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