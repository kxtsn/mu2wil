const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("Delete Testimonials")
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

            const sresult = await conn.query(`DELETE FROM student_testimonial WHERE Status = 'Deleted')`)
            console.log(sresult)

            const eresult = await conn.query(`DELETE FROM employer_testimonial WHERE Status = 'Deleted')`)
            console.log(eresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Testimonials Deleted'
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
