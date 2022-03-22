const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
const format = require('date-fns/format');

console.log("Create Application")
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

            const sid = await conn.query(`SELECT Student_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)

            const sids = sid[0]["Student_ID"]

            const mresult = await conn.query(`INSERT INTO application (Listing_ID, Student_ID, Status) values(${pool.escape(req.body.listingId)}, ${pool.escape(sids)}, 'Pending')`)

            console.log(mresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Application Created'
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
