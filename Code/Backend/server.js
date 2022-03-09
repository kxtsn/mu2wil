const express = require('express');
const app = express();
const cors = require('cors');

// set up port
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use(cors());

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers',
      'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  );
  if (req.method === 'OPTIONS') {
      res.header('Access-Control-Allow-Methods', 'PUT, POST, DELETE, PATCH, GET');
      return res.status(200).json({});
  }
  next(); // this will not block the incoming request;

});

// add routes
app.use('/', require('./routes/index'));

// run server
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));