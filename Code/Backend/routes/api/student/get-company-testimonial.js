const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("View Company Testimonials")
router.post('/', isLoggedIn, async function (req, res, next) {
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

            const mresult = await conn.query(`select st.Application_ID, st.Student_Testimonial_ID, st.Created_On, st.Comment, st.File, s.First_Name as Student_First_Name, s.Last_Name as Student_Last_Name, e.* from student_testimonial st, student s, employer e WHERE st.Created_By = s.Student_ID AND st.Employer_ID = e.Employer_ID AND st.Employer_ID = ${pool.escape(req.body.employerId)} AND st.Status = "Approved"`)

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
