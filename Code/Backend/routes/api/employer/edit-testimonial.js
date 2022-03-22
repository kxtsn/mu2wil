const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
const format = require('date-fns/format');
const e = require('express');

console.log("Edit Testimonial")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //employer validation
    if (req.userData["role"] == 4) {

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

            const mresult = await conn.query(`UPDATE employer_testimonial SET Comment =  ${pool.escape(req.body.comment)}, File =  ${pool.escape(req.body.blob)}, Status = 'Pending' WHERE Employer_Testimonial_ID = ${pool.escape(req.body.testimonialId)}`)

            console.log(mresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Testimonial Edited'
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
