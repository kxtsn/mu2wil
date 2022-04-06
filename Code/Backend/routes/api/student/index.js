var router = require('express').Router();

console.log("In api/student")

router.use('/view-own-application', require('./view-own-application'));
router.use('/view-approved-listing', require('./view-approved-listing'));
router.use('/view-own-testimonial', require('./view-own-testimonial'));
router.use('/view-written-testimonial', require('./view-written-testimonial'));
router.use('/delete-testimonial', require('./delete-testimonial'));
router.use('/edit-testimonial', require('./edit-testimonial'));
router.use('/create-testimonial', require('./create-testimonial'));
router.use('/create-application', require('./create-application'));
router.use('/cancel-application', require('./cancel-application'));
router.use('/get-student-detail', require('./get-student-detail'));
router.use('/get-company-testimonial', require('./get-company-testimonial'));

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