var router = require('express').Router();

console.log("In api/employer")

router.use('/register-employer', require('./register-employer'));
router.use('/get-company-detail', require('./get-company-detail'));

//application
router.use('/view-student-application', require('./view-student-application'));
router.use('/view-application-by-listing', require('./view-application-by-listing'));
router.use('/reject-application', require('./reject-application'));
router.use('/accept-application', require('./accept-application'));

//listing
router.use('/edit-listing', require('./edit-listing'));
router.use('/create-listing', require('./create-listing'));
router.use('/close-listing', require('./close-listing'));
router.use('/view-own-listing', require('./view-own-listing'));
router.use('/delete-listing', require('./delete-listing'));

//testimonials
router.use('/view-company-testimonial', require('./view-company-testimonial'));
router.use('/view-written-testimonial', require('./view-written-testimonial'));
router.use('/create-testimonial', require('./create-testimonial'));
router.use('/delete-testimonial', require('./delete-testimonial'));
router.use('/edit-testimonial', require('./edit-testimonial'));

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