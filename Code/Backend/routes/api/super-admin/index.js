var router = require('express').Router();

console.log("In api/super-admin")

router.use('/create-portal-manager', require('./create-portal-manager'));
router.use('/create-super-admin', require('./create-super-admin'));
router.use('/view-all-super-admin', require('./view-all-super-admin'));
router.use('/view-all-portal-manager', require('./view-all-portal-manager'));

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