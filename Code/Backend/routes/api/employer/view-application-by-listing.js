const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("View Own Applications By Listing")
router.post('/', isLoggedIn, async function (req, res, next) {
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

            const uid = await conn.query(`SELECT Employer_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)

            const uids = uid[0]["Employer_ID"]

            console.log("hello")

            const mresult = await conn.query(`SELECT a.Application_ID, l.Title, l.Description, s.First_Name, s.Last_Name, s.Email, s.Murdoch_Student_ID, s.Student_ID, a.Status
            FROM application a, listing l, student s
            WHERE a.Listing_ID = l.Listing_ID 
            AND a.Student_ID = s.Student_ID 
            AND a.Status != "Cancelled" AND l.Listing_ID = ${pool.escape(req.body.listingId)}`)

            console.log("hello1")
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
