const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
//const uuid = require('uuid');
const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');
const util = require('util');

//user needs to be logged in
console.log("Reset Password")
router.post('/', isLoggedIn, async function (req, res, next) {
  
        
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

            const hashedpassword = await bcrypt.hash(req.body.password, 10)
            console.log(hashedpassword)

            const mresult = await conn.query(`UPDATE user SET Password = ${pool.escape(hashedpassword)} WHERE Email = ${pool.escape(req.body.email)}`)
            console.log(mresult)
            
            await conn.query("COMMIT");
            
            res.status(201).send({
                msg: 'Password reset complete for account: ' + req.body.email
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
});


module.exports = router;
