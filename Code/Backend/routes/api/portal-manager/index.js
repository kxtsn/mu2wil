var router = require('express').Router();

console.log("In api/portal-manager")

router.use('/create-student', require('./create-student'));
router.use('/approve-employer', require('./approve-employer'));
router.use('/view-all-student', require('./view-all-student'));
router.use('/view-all-listing', require('./view-all-listing'));
router.use('/view-all-application', require('./view-all-application'));
router.use('/view-all-employer', require('./view-all-employer'));
router.use('/view-all-student-testimonial', require('./view-all-student-testimonial'));
router.use('/view-all-employer-testimonial', require('./view-all-employer-testimonial'));
router.use('/update-graduate', require('./update-graduate'));
router.use('/reject-employer', require('./reject-employer'));
router.use('/reject-listing', require('./reject-listing'));
router.use('/approve-listing', require('./approve-listing'));
router.use('/reject-student-testimonial', require('./reject-student-testimonial'));
router.use('/approve-student-testimonial', require('./approve-student-testimonial'));
router.use('/reject-employer-testimonial', require('./reject-employer-testimonial'));
router.use('/approve-employer-testimonial', require('./approve-employer-testimonial'));
router.use('/delete-testimonial', require('./delete-testimonial'));
router.use('/update-student', require('./update-student'));
router.use('/delete-student', require('./delete-student'));

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