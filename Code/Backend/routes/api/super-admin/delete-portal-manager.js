const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

console.log("Delete Portal Manager")
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

            const e = await conn.query(`SELECT Email FROM portal_manager WHERE Portal_Manager_ID = ${pool.escape(req.body.managerId)}`)

            const email = e[0]["Email"]

            const uresult = await conn.query(`DELETE FROM user WHERE Email = ${pool.escape(email)}`)
            console.log(util.inspect(uresult))

            const mresult = await conn.query(`DELETE FROM portal_manager WHERE Portal_Manager_ID = ${pool.escape(req.body.managerId)})`)
            console.log(mresult)

            await conn.query("COMMIT");

            res.status(201).send({
                msg: 'Portal Manager Account Deleted'
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
