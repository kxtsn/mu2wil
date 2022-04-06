const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("View Student Written Testimonials")
router.get('/', isLoggedIn, async function (req, res, next) {
    //employer validation
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

            const uid = await conn.query(`SELECT Student_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)

            const uids = uid[0]["Student_ID"]

            const mresult = await conn.query(`select st.*, s.First_Name, s.Last_Name, e.Company_Name from student_testimonial st, student s, employer e WHERE st.Created_By = s.Student_ID AND st.Employer_ID = e.Employer_ID AND st.Created_By = ${pool.escape(uids)} AND st.Status != "Deleted"`)

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
