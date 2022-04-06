const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
const format = require('date-fns/format');
const fs = require("fs");

console.log("Create Testimonial")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //student validation
    if (req.userData["role"] == 3) {

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

            const lid = await conn.query(`SELECT Listing_ID, Student_ID FROM application WHERE Application_ID = ${pool.escape(req.body.applicationId)}`)

            const lids = lid[0]["Listing_ID"]
            const sids = lid[0]["Student_ID"]

            console.log("hi")

            const eid = await conn.query(`SELECT Employer_ID FROM listing WHERE Listing_ID = ${pool.escape(lids)}`)
            console.log("hi1")
            const eids = eid[0]["Employer_ID"]
            console.log("HIHI")


            const buf = Buffer.from(req.body.blob);
            console.log(buf)

            console.log("HII")
            
            const mresult = await conn.query(`INSERT INTO student_testimonial (Application_ID, Created_By, Created_On, Employer_ID, Comment, File, Status) VALUES (${pool.escape(req.body.applicationId)}, ${pool.escape(sids)},  now(), ${pool.escape(eids)}, ${pool.escape(req.body.comment)}, ${pool.escape(buf)}, "Pending")`)
            console.log("hi2")

            console.log(mresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Testimonial Created'
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
