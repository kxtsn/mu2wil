const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');
const format = require('date-fns/format');

console.log("Edit Listing")
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

            var closingDate = null;
            if (req.body.closingDate != null) {
                const cDate = new Date(req.body.closingDate);
                closingDate = format(cDate, 'yyyy-MM-dd HH:mm:ss');
            }
         
            const mresult = await conn.query(`UPDATE listing SET Title = ${pool.escape(req.body.title)}, Description = ${pool.escape(req.body.description)}, Closing_Date = ${pool.escape(closingDate)}, Available_Slot = ${pool.escape(req.body.slot)}, Status = 'Pending' WHERE Listing_ID = ${pool.escape(req.body.listingId)}`)
            
            console.log(mresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Listing Edited'
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
