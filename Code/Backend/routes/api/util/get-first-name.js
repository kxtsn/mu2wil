const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
//const uuid = require('uuid');
//const jwt = require('jsonwebtoken');
const { pool, connection, query } = require('../../../lib/database.js');
const { isLoggedIn } = require('../../../middleware/uservalidation.js');

console.log("In get first name")

router.get('/', isLoggedIn, async function (req, res, next) {

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

            const rresult = await conn.query(`SELECT Role_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)

            const roleId = rresult[0]["Role_ID"]

            const firstName = null;

            if(roleId == 1){
                const idresult = await conn.query(`SELECT Super_Admin_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)
                const id = idresult[0]["Super_Admin_ID"]
                console.log(id)

                nameResult = await conn.query(`SELECT First_Name From super_admin WHERE Super_Admin_ID = ${pool.escape(id)}`)
                firstName = nameResult[0]["First_Name"]
                console.log(firstName)

            } else if (roleId == 2){
                const idresult = await conn.query(`SELECT Portal_Manager_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)
                const id = idresult[0]["Portal_Manager_ID"]
                console.log(id)

                nameResult = await conn.query(`SELECT First_Name From portal_manager WHERE Portal_Manager_ID = ${pool.escape(id)}`)
                firstName = nameResult[0]["First_Name"]
                console.log(firstName)

            } else if (roleId == 3){
                const idresult = await conn.query(`SELECT Student_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)
                const id = idresult[0]["Student_ID"]
                console.log(id)

                nameResult = await conn.query(`SELECT First_Name From student WHERE Student_ID = ${pool.escape(id)}`)
                firstName = nameResult[0]["First_Name"]
                console.log(firstName)

            } else if (roleId == 4){
                const idresult = await conn.query(`SELECT Employer_ID FROM user WHERE User_ID = ${pool.escape(req.userData["id"])}`)
                const id = idresult[0]["Employer_ID"]
                console.log(id)

                nameResult = await conn.query(`SELECT First_Name From employer WHERE Employer_ID = ${pool.escape(id)}`)
                firstName = nameResult[0]["First_Name"]
                console.log(firstName)
            } else {
                await conn.query("ROLLBACK");
                res.status(statusCode).send({
                    msg: err
                });
            }

            console.log(firstName)

            res.status(201).send({
                result: firstName 
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
