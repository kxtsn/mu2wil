const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
var nodemailer = require('nodemailer');
var generator = require('generate-password');

console.log("Approve Employer")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin validation
    if (req.userData["role"] == 1 || req.userData["role"] == 2) {

        //Get connection from pool
        const conn = await connection();
        console.log(conn)

        var statusCode;

        try {

            statusCode = 504;
            //start transaction
            await conn.query("START TRANSACTION")

            //Change status code for error
            statusCode = 501;

            const mresult = await conn.query(`UPDATE employer SET Status = 'Approved' WHERE Employer_ID = ${pool.escape(req.body.employerId)}`)

            console.log(mresult)

            const eresult = await conn.query(`SELECT Email from employer WHERE Employer_ID = ${pool.escape(req.body.employerId)}`)

            const email = eresult[0]["Email"]
            console.log(email)


            // var password = generator.generate({
            //     length: 10,
            //     numbers: true
            // });
    
            // console.log(password);

            var password = "employer1!"
            
            const hashedpassword = await bcrypt.hash(password, 10)
            console.log(hashedpassword)

            const uresult = await conn.query(`INSERT INTO user (Role_ID, Email, Password, Employer_ID) values( 3, ${pool.escape(email)}, ${pool.escape(hashedpassword)}, ${pool.escape(req.body.employerId)})`)
            console.log(uresult)

            //need create email to try
            // var transporter = nodemailer.createTransport({
            //     service: 'gmail',
            //     auth: {
            //     user: 'g5mu2wil@gmail.com',
            //     pass: 'mu2wilG5'
            //     }
            // });

            // var mailOptions = {
            //     from: 'g5mu2wil@gmail.com',
            //     to: req.body.email,
            //     subject: 'Reset Password For MU2WIL <DO NOT SHARE THIS WITH ANYONE>',
            //     text: 'hi there, password: ' + password
            // };

            // transporter.sendMail(mailOptions, function(error, info){
            //     if (error) {
            //     console.log(error);
            //     } else {
            //     console.log('Email sent: ' + info.response);
            //     }
            // });

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Employer Account Approved'
            });

        } catch (err) {
            res.status(statusCode).send({
                msg: "Error: " +err
            });
        } finally {
            if (conn) await conn.release();
        }   
    } else {
        return res.status(401).send({
            msg: 'Unauthorized'
        });
    }
});

module.exports = router;
