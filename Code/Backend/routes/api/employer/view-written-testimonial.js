const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("View Company Written Testimonials")
router.get('/', isLoggedIn, async function (req, res, next) {
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

            const mresult = await conn.query(`select et.*, s.First_Name, s.Last_Name, e.Company_Name from employer_testimonial et, student s, employer e WHERE et.Created_By = e.Employer_ID AND et.Student_ID = s.Student_ID AND et.Created_By = ${pool.escape(uids)} AND et.Status != "Deleted"`)

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
