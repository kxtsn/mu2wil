var nodemailer = require('nodemailer');
var generator = require('generate-password');
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
//const uuid = require('uuid');
const jwt = require('jsonwebtoken');
const { pool, connection, query }= require('../../../lib/database.js');

//NOT TESTED
console.log("Forget Password - not tested")
router.post('/', async function(req, res, next) {

    try{
        var password = generator.generate({
            length: 10,
            numbers: true,
            symbols: true
        });

        console.log(password);

        //need create email to try
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'g5mu2wil@gmail.com',
              pass: 'mu2wilG5'
            }
        });

        var mailOptions = {
            from: 'g5mu2wil@gmail.com',
            to: req.body.email,
            subject: 'Reset Password For MU2WIL <DO NOT SHARE THIS WITH ANYONE>',
            text: 'hi there, password: ' + password
        };

        transporter.sendMail(mailOptions, function(error, info){
            if (error) {
              console.log(error);
            } else {
              console.log('Email sent: ' + info.response);
            }
          });
        
        const hashedpassword = await bcrypt.hash(req.body.password, 10)
        console.log(hashedpassword)

        const mresult = await conn.query(`UPDATE user SET Password = ${pool.escape(hashedpassword)} WHERE Email = ${pool.escape(req.body.email)}`)
            console.log(mresult)
            
            res.status(201).send({
                msg: 'Email has been sent to: ' + req.body.email
            });

    } catch (error) {
        console.log(error);
    }
});

module.exports = router;