const express = require('express');
const bodyParser = require('body-parser');
const exphbs = require('express-handlebars');
const nodemailer = require('nodemailer');
const morgan = require('morgan');
const buffer = require('buffer');
var mysql = require('mysql2');
var session = require('express-session');
const { get } = require('http');
const { MySQLUsername, MySQLPassword, MySQLDatabase, MySQL_IP, MySQL_Port, compIP, compPort } = require('./creds.js');

// var http = require('http');

// http.createServer(function (req, res) {
//   res.writeHead(200, {'Content-Type': 'text/html'});
//   res.end('Hello World!!!!');
// }).listen(8080);

const app = express();

// app.listen(8080, () => {
//     console.log('Server is running on port 8080');
//     console.log('server is running on host: ' + process.env.HOST);
// });

let IP = compIP;
let PORT = compPort;
app.listen(PORT, IP, function(){
  console.log('Server is running on port ' + PORT);
  console.log('server is running on host: ' + IP);
  console.log('http://' + IP + ':'+ PORT);
});


app.set('view engine', 'ejs');

app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));
app.use(session({
  secret: 'keyboard cat',
  resave: true,
  saveUninitialized: true
}));
app.use(express.static(__dirname + '/public'));

// authentication dummay email id for sending mail
var transporter = nodemailer.createTransport({
  service: 'gmail',
  secure: true,
  host: 'smtp.gmail.com',
  port: 465,
  auth: {
    user: 'adarsh20274@iiitd.ac.in',
    pass: 'drffanqmquxixxqh'
  }
});

const isAuthenticated = (req, res, next) => {
  // console.log(req.session.loggeduser);
  if(req.session.loggeduser){
      return next();
  }
  res.redirect('/login');
  return;
};

const isPractitioner = (req, res, next) => {
  // console.log(req.session.loggeduser);
  if(req.session.user_type == 'practitioner'){
      return next();
  }
  res.redirect('/login');
  return;
};

const isPatient = (req, res, next) => {
  // console.log(req.session.loggeduser);
  if(req.session.user_type == 'patient'){
      return next();
  }
  res.redirect('/login');
  return;
};

var con = mysql.createConnection({
  host: MySQL_IP,
  user: MySQLUsername,
  password: MySQLPassword,
  database: MySQLDatabase,
  //don't change this, this is the default port for mysql
  port: MySQL_Port,
  multipleStatements: true
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  // con.query("SELECT * FROM patient", function (err, result, fields) {
  //   if (err) throw err;
  //   console.log(result);
  // });
});

function run_query(query){
  return new Promise((resolve, reject) => {
    con.query(query, (err, result) => {
      if(err) reject(err);
      resolve(result);
    });
  });
}

// Get and post requests below....

// Login!!!
app.get('/login', (req, res) => {
  res.render('login');
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  console.log('Username:', username);
  console.log('Password:', password);
  // check if the user is a practitioner or a patient
  sql = "SELECT * FROM patient WHERE username = '" + username + "' AND password = '" + password + "';";
  sql_practitioner = "SELECT * FROM practitioner WHERE username = '" + username + "' AND password = '" + password + "';";
  console.log(sql);
  console.log(sql_practitioner);
  con.query(sql, function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    if(result.length > 0){
      req.session.loggeduser = username;
      req.session.user_type = 'patient';
      console.log("The user is a patient");
      req.session.user_ID = result[0].PatientID;
      res.redirect('/user');
    }
    else{
      con.query(sql_practitioner, function (err, result, fields) {
        if (err) throw err;
        console.log(result);
        if(result.length > 0){
          req.session.loggeduser = username;
          req.session.user_type = 'practitioner';
          req.session.user_id = result[0].PractitionerID;
          res.redirect('/');
        }
        else{
          res.redirect('/login');
        }
      });
    }
  });
});

// Register!!!
app.get('/register', (req, res) => {
  res.render('register');
});

app.post('/register', (req, res) => {
  const { username, email, password } = req.body;

  console.log('Username:', username);
  console.log('EmailID:', email);
  console.log('Password:', password);
  res.redirect('/login');
});

// Upload!!!
app.get('/upload',isPractitioner, (req, res) => {
  res.render('upload');
});

// Caption!!!
app.get('/caption', isPractitioner , (req, res) => {
  res.render('caption');
});

// Home!!!
app.get('/', isPractitioner, async (req, res) => {
    // run query
    const query = "SELECT * FROM patient;";
    const result = await run_query(query);
    // console.log(query);
    // console.log(result);
    res.render('home');
});

// MoreDetails!!!
app.get('/moredetail', isPractitioner, async (req, res) => {
  res.render('moredetail');
});

app.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/login');
});

// User!!!
app.get('/user', isPatient, async (req, res) => {
  // Everything from the problem table
  const query_problem = "SELECT * FROM problem WHERE PatientID = " + req.session.user_ID + ";";
  const result_problem = await run_query(query_problem);
  console.log(query_problem);
  console.log(result_problem);
  res.render('user', {username: req.session.loggeduser, result_problem: result_problem});
});

app.get('/patientf', isPractitioner, async (req, res) => {
  res.render('patientf');
});

app.get('/previouscaptions', isPractitioner, async (req, res) => {
  res.render('previouscaptions');
});


app.use((req, res) => {
    res.status(404).render('404');
});
