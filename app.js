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

let IP = "192.168.242.128";
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

var con = mysql.createConnection({
  host: "192.168.28.65",
  user: "any_connect",
  password: "adarsh123",
  database: "reservation",
  //don't change this, this is the default port for mysql
  port: 3306,
  multipleStatements: true
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  con.query("SELECT * FROM res", function (err, result, fields) {
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

app.get('/login', (req, res) => {
  res.render('login');
});

app.post('/login', async (req, res) => {
    const { user_name, password } = req.body;
    req.session.user_name  = user_name;
    req.session.password = password;
    console.log(user_name, password);
    const query = `SELECT * FROM user WHERE user_name = '${user_name}' AND password = '${password}'`;
    const result = await run_query(query);
    console.log("result");
    console.log(result);
    
    if(result.length == 0){
      res.redirect('/login');
    }
    const mail_verified = result[0].email_verified;
    const mail_verified_bool = mail_verified.readUIntLE(0, 1);
    const super_u = result[0].super_user;
    req.session.super_user = super_u.readUIntLE(0, 1);
    console.log("super_user: ", req.session.super_user);
    req.session.time_slot_duration = result[0].time_slot_duration;
    console.log("allowed time slot duration ",  req.session.time_slot_duration);
    
    // If the user exists and the mail is verified then go to the home page else remain in the login page
    if(result.length > 0 && mail_verified_bool == 1){
      req.session.loggeduser = true;
      req.session.user= user_name;
      res.redirect('/');
    } else if (result.length > 0 && mail_verified_bool == 0){
      console.log("Please verify your email");
  
  
  
      req.session.email = result[0].email;
  
  
      req.session.otp = Math.floor(100000 + Math.random() * 900000);
    
      //sending the mail
      var mailOptions = {
        from: 'adarsh20274@iiitd.ac.in',
        to: req.session.email,
        subject: 'OTP for login',
        text: 'Your OTP is ' + req.session.otp
      };
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });
  
      res.redirect('/verification');
    } else {
      res.redirect('/login');
    }
});

app.get('/', async (req, res) => {
    res.render('home');
});

// app.use((req, res) => {
//     res.status(404).render('404');
// });
