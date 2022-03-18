const express = require('express');
const router = express.Router();
//const uuid = require('uuid');
const jwt = require('jsonwebtoken');
const { pool, connection, query }= require('../../../lib/database.js');

//NOT TESTED
console.log("Register Employer Account")
router.post('/', async function(req, res, next) {

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

        const cresult = await conn.query(`SELECT * FROM employer WHERE Email = ${pool.escape(req.body.email)} AND Company_Name = ${pool.escape(req.body.companyName)}`)

        console.log("The Inspect:" + cresult.length);

        if(cresult.length > 0) throw new Error("Company and email already exists in our employer database");

        const mresult = await conn.query(`INSERT INTO employer (First_Name, Last_Name, Email, Contact_Number, Company_Name, Telephone, Website, Country, Address1, Address2, Postal_Code, Company_Code, Status) values(${pool.escape(req.body.firstName)}, ${pool.escape(req.body.lastName)}, ${pool.escape(req.body.email)}, ${pool.escape(req.body.contactNo)}, ${pool.escape(req.body.companyName)}, ${pool.escape(req.body.telephone)}, ${pool.escape(req.body.website)}, ${pool.escape(req.body.country)}, ${pool.escape(req.body.address1)}, ${pool.escape(req.body.address2)}, ${pool.escape(req.body.postal)}, ${pool.escape(req.body.companyCode)},'Pending')`)

        console.log(mresult)

            await conn.query("COMMIT");
            
            res.status(201).send({
                msg: req.body.companyName + ' has been registered.' 
            });

    } catch (error) {
        console.log(error);
    }
});

module.exports = router;