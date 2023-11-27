const express = require('express');
const bodyParser = require('body-parser');
const exphbs = require('express-handlebars');
const nodemailer = require('nodemailer');
const morgan = require('morgan');
const buffer = require('buffer');

console.log('This is home.js');
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
  con.query("SELECT * FROM patient", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
  });
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

  res.send('Login successful!');

  res.redirect('/home');
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

  res.send('Registeration successful!');

  res.redirect('/login');
});

// Upload!!!
app.get('/upload', (req, res) => {
  res.render('upload');
});

// Caption!!!
app.get('/caption', (req, res) => {
  res.render('caption');
});

// Home!!!
app.get('/', async (req, res) => {
    // run query
    const query = "SELECT * FROM patient;";
    const result = await run_query(query);
    console.log(query);
    console.log(result);
    res.render('home');
});

// MoreDetails!!!
app.get('/moredetail', async (req, res) => {
  res.render('moredetail');
});
// app.use((req, res) => {
//     res.status(404).render('404');
// });
