const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
//const uuid = require('uuid');
//const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');

console.log("Check email exist")
router.post('/', isLoggedIn, async function (req, res, next) {
        //Get connection from pool
        const conn = await connection();
        console.log(conn)
        
        var statusCode;
        var bool = false;

        try {
            statusCode = 504;
            //start transaction
            await conn.query("START TRANSACTION")

            //Change status code for error
            statusCode = 501;

            const mresult = await conn.query(`SELECT * FROM user WHERE Email = ${pool.escape(req.body.email)}`)
            console.log(mresult)

            if(mresult.length === 0){
                bool = false;
            } else {
                bool = true;
            }

            console.log(bool);

            res.status(201).send({
                result: bool
            });
            
        } catch (err) {
            await conn.query("ROLLBACK");
            res.status(statusCode).send({
                msg: err
            });
        } finally {
            if (conn) await conn.release();
        }
});

module.exports = router;
