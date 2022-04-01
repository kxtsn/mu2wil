const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("Update Student")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin validation
    if (req.userData["role"] == 1 || req.userData["role"] == 2) {

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

            const mresult = await conn.query(`UPDATE student SET First_Name = ${pool.escape(req.body.firstName)}, Last_Name = ${pool.escape(req.body.lastName)}, Murdoch_Student_ID = ${pool.escape(req.body.murdochId)} WHERE Student_ID = ${pool.escape(req.body.studentId)}`)
            console.log(mresult)
            await conn.query("COMMIT");
            
            res.status(201).send({
                msg: 'Student Updated. Student_ID: ' + req.body.studentId
            });
        }
        catch (err) {
            await conn.query("ROLLBACK");
            res.status(statusCode).send({
                msg: "Error: " + err
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
