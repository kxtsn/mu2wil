const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
const format = require('date-fns/format');

console.log("Create Testimonial")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin validation
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

            const sid = await conn.query(`SELECT Listing_ID, Student_ID FROM application WHERE Application_ID = ${pool.escape(req.body.applicationId)}`)

            const sids = sid[0]["Student_ID"]
            const lids = sid[0]["Listing_ID"]

            const eid = await conn.query(`SELECT Employer_ID FROM listing WHERE Listing_ID = ${pool.escape(lids)}`)

            const eids = eid[0]["Student_ID"]

            const mresult = await conn.query(`INSERT INTO employer_testimonial (Application_ID, Created_By, Created_On, Student_ID, Comment, File, Status) values(${pool.escape(req.body.applicationId)}, ${pool.escape(eids)}, now(), ${pool.escape(sids)}, ${pool.escape(req.body.comment)}, ${pool.escape(req.body.blob)}, 'Pending')`)

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
