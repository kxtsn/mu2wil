var router = require('express').Router();

router.use('/auth', require('./auth'));
router.use('/super-admin', require('./super-admin'));
router.use('/portal-manager', require('./portal-manager'));
router.use('/student', require('./student'));
router.use('/employer', require('./employer'));
router.use('/util', require('./util'));

module.exports = router;