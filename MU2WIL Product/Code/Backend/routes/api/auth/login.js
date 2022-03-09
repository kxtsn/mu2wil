const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
//const uuid = require('uuid');
const jwt = require('jsonwebtoken');
const { pool, connection, query }= require('../../../lib/database.js');

console.log("Login")
router.post('/', async function(req, res, next) {
  console.log("Load Login")
    console.log(req.body.username + " attempted login");
    try{
      //Getting database pool connection
      pool.getConnection((err, connection) => {
        if(err) throw err;//provide error details in terminal if encountered
        console.log('connected as id ' + connection.threadId);
        connection.beginTransaction(function(err){//Set up transaction for connection to allow multi-query rollback
          if(err) {
            connection.rollback(function(){
              connection.release();
              //release conncetion on rollback
            });
          } else {
            connection.query(
              `SELECT * FROM user WHERE Email = ${pool.escape(req.body.email)};`,
              (err, result) => {
                if (err) {
                  //throw err;
                  return res.status(400).send({
                    msg: "Email or password is incorrect!"
                  });
                }
                if (!result.length) {
                  return res.status(401).send({
                    msg: 'Email or password is incorrect!'
                  });
                }
                //Check password
                console.log(result[0]['Password'])
                bcrypt.compare(req.body.password, result[0]['Password'],(bErr, bResult) => {
                  //wrong password
                  if (bErr) {
                    //throw err;
                    return res.status(401).send({
                      msg: 'Email or password is incorrect! ' + bErr
                    });
                  }
                  if(bResult) {
                    const email = result[0].Email;
                    const role = result[0].Role_ID;
                    const token = jwt.sign({id:result[0].User_ID, role:result[0].Role_ID},'togeneratestrongserect', {expiresIn: '8h'});
                    connection.query(`UPDATE user SET Last_Login = now() WHERE User_ID = ${pool.escape(result[0].User_ID)};`, (err, result) => {
                      if (err) {
                        connection.rollback(function() {
                          connection.release();
                          //Failure
                          return res.status(401).send({
                            msg: 'Email or password is incorrect!'
                          });
                      });
                      } else {
                        connection.commit(function() {
                          connection.release();
                          //success
                          return res.status(200).send({
                            msg: 'Logged In!', token, email: email, role: role
                          });
                      });
                      }
                    });
                  } else {
                    connection.rollback(function() {
                      connection.release();
                      //Failure
                      return res.status(401).send({
                        msg: 'Email or password is incorrect!'
                      });
                  });
                  }
                });
              }
            );
        }
      });
    });
  }catch (error) {
    console.log(error);
  }
});

module.exports = router;