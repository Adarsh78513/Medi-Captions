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

let IP = "127.0.0.1";
let PORT = 8080;
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

// var con = mysql.createConnection({
//   host: "192.168.28.65",
//   user: "any_connect",
//   password: "adarsh123",
//   database: "reservation",
//   //don't change this, this is the default port for mysql
//   port: 3306,
//   multipleStatements: true
// });

// con.connect(function(err) {
//   if (err) throw err;
//   console.log("Connected!");
//   con.query("SELECT * FROM res", function (err, result, fields) {
//     if (err) throw err;
//     console.log(result);
//   });
// });

// function run_query(query){
//   return new Promise((resolve, reject) => {
//     con.query(query, (err, result) => {
//       if(err) reject(err);
//       resolve(result);
//     });
//   });
// }

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
    res.render('home');
});

// app.use((req, res) => {
//     res.status(404).render('404');
// });
