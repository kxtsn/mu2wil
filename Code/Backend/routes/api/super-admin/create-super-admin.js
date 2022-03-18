const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
var nodemailer = require('nodemailer');
var generator = require('generate-password');

console.log("Create Super Admin")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin validation
    if (req.userData["role"] == 1) {

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

            const cresult = await conn.query(`SELECT * FROM super_admin WHERE Email = ${pool.escape(req.body.email)}`)

            console.log("The Inspect:" + cresult.length);

            if(cresult.length > 0) throw new Error("Email already exists in super admin");

            const mresult = await conn.query(`INSERT INTO super_admin (First_Name, Last_Name, Email) values(${pool.escape(req.body.firstName)}, ${pool.escape(req.body.lastName)}, ${pool.escape(req.body.email)})`)

            console.log(mresult)

            const sid = await conn.query(`SELECT Super_Admin_ID from super_admin WHERE Email = ${pool.escape(req.body.email)}`)

            const sids = sid[0]["Super_Admin_ID"]
            console.log(sid)


            var password = generator.generate({
                length: 10,
                numbers: true
            });
    
            console.log(password);
            
            const hashedpassword = await bcrypt.hash(password, 10)
            console.log(hashedpassword)

            const uresult = await conn.query(`INSERT INTO user (Role_ID, Email, Password, Super_Admin_ID) values( 1, ${pool.escape(req.body.email)}, ${pool.escape(hashedpassword)}, ${pool.escape(sids)})`)
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
                msg: 'Super Admin Account Created'
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
