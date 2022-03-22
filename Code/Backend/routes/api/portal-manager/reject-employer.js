const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
var nodemailer = require('nodemailer');
var generator = require('generate-password');

console.log("Reject Employer")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin and portal manager validation
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

            const mresult = await conn.query(`UPDATE employer SET Status = 'Rejected' WHERE Employer_ID = ${pool.escape(req.body.employerId)}`)

            console.log(mresult)

            const eresult = await conn.query(`SELECT Email from employer WHERE Employer_ID = ${pool.escape(req.body.employerId)}`)

            const email = eresult[0]["Email"]
            console.log(email)

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
            //     subject: 'Sorry',
            //     text: 'your account has been rejected'
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
                msg: 'Employer Account Rejected'
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
