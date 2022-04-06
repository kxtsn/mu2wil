const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("View Approved Listing")
router.get('/', isLoggedIn, async function (req, res, next) {
    //student validation
    if (req.userData["role"] == 3 ) {

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

            const mresult = await conn.query(`SELECT l.*, (SELECT COUNT(*) FROM application a WHERE a.Listing_ID = l.Listing_ID AND a.Status != "Failed" AND a.Status != "Cancelled") as Applicants, CASE WHEN ((SELECT Count(*) FROM application a WHERE a.Listing_ID = l.Listing_ID AND a.Student_ID = 1 AND a.Status != "Cancelled" AND a.Status != "Failed") > 0 ) THEN "true" ELSE "false" END AS Applied FROM listing l WHERE l.Status = 'Approved'`)

            console.log(util.inspect(mresult))

            res.status(201).send({
                result: mresult
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
