const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("Update Super Admin")
router.post('/', isLoggedIn, async function (req, res, next) {
    console.log(JSON.stringify(req.userData["role"]));
    //super admin validation
    if (req.userData["role"] == 1) {

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

            const mresult = await conn.query(`UPDATE super_admin SET First_Name = ${pool.escape(req.body.firstName)}, Last_Name = ${pool.escape(req.body.lastName)} WHERE Super_Admin_ID = ${pool.escape(req.body.adminId)}`)
            console.log(mresult)
            await conn.query("COMMIT");
            
            res.status(201).send({
                msg: 'Admin Updated. Admin_ID: ' + req.body.adminId
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
