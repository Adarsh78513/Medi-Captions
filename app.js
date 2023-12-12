const express = require('express');
const bodyParser = require('body-parser');
const exphbs = require('express-handlebars');
const nodemailer = require('nodemailer');
const morgan = require('morgan');
const buffer = require('buffer');
const multer = require('multer');
const path = require('path');
var mysql = require('mysql2');
var session = require('express-session');
const { get } = require('http');

const { exec } = require('child_process');

const { MySQLUsername, MySQLPassword, MySQLDatabase, MySQL_IP, MySQL_Port, compIP, compPort } = require('./creds.js');
const { CLIENT_RENEG_LIMIT } = require('tls');


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

// Storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadPath = path.join(__dirname, 'images'); // Destination folder 'images'
    cb(null, uploadPath);
  },
  filename: function (req, file, cb) {
    const username = req.body.username; // Assuming username is sent in the request body
    const originalname = file.originalname; // Original file name
    const ext = path.extname(originalname); // File extension

    // Creating the filename - [username]_[originalname].[filetype]
    const fileName = `${username}_${Date.now()}${ext}`;
    cb(null, fileName);
  }
});


const upload = multer({ storage });


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

// app.post('/upload', upload.single('image'), (req, res) => {
//   const username = req.body.username; // Assuming username is sent in the request body
//   const fileName = req.file.filename; // Get the filename generated by multer
//   const imagePath = `images/${fileName}`; // Adjust the path as per your project

//   const sql = `INSERT INTO Images (username, image_name, image_path) VALUES (?, ?, ?)`;
//   const values = [username, fileName, imagePath];

//   con.query(sql, values, (err, result) => {
//     if (err) {
//       console.error("Error inserting image data:", err);
//       // res.status(500).send("Error uploading image data");
//     } else {
//       console.log("Image data inserted successfully!");
//       res.render('caption');
//       // res.status(200).send("Image uploaded and data stored successfully");
//     }
//   });
// });

// Caption!!!
app.get('/caption', isPractitioner , (req, res) => {
  res.render('caption');
  // Save image to image directory

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
  const query = "SELECT PN.FamilyName, PN.GivenName, PN.MiddleName, P.Gender, P.BirthDate FROM Practitioner P JOIN PractitionerName PN ON P.PractitionerID = PN.PractitionerID WHERE P.PractitionerID = " + req.session.user_id + ";"
  const result = await run_query(query);
  console.log(query);
  console.log(result[0]);
  res.render('moredetail', {username: req.session.loggeduser, result: result[0]});
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
  const query_name = "SELECT * FROM patientname WHERE PatientID = " + req.session.user_ID + ";";
  const result_name = await run_query(query_name);
  console.log(query_name);
  console.log(result_name);
  const query = "SELECT * FROM patient WHERE PatientID = " + req.session.user_ID + ";";
  const result = await run_query(query);
  console.log(query);
  console.log(result);
  const query_address = "SELECT * FROM PatientAddress WHERE PatientID = " + req.session.user_ID + ";";
  const result_address = await run_query(query_address);
  console.log(query_address);
  console.log(result_address);
  const query_contact = "SELECT * FROM PatientContact WHERE PatientID = " + req.session.user_ID + ";";
  const result_contact = await run_query(query_contact);
  console.log(query_contact);
  console.log(result_contact);
  const query_telecom = "SELECT * FROM PatientTelecom WHERE PatientID = " + req.session.user_ID + ";";
  const result_telecom = await run_query(query_telecom);
  console.log(query_telecom);
  console.log(result_telecom);
  const query_family_history = "SELECT FMH.FamilyMemberHistoryID, FMH.PatientID, FMH.Date, FMH.Status, FMH.Name, FMH.Relationship, FMH.Gender, FMH.BornDate, FMH.Age, FMH.DeceasedBoolean, FMH.DeceasedDate, FMH.Note, FMC.FamilyMemberConditionID, FMC.ConditionCode, FMC.Outcome, FMC.OnsetAge, FMC.Note AS ConditionNote FROM FamilyMemberHistory FMH LEFT JOIN FamilyMemberCondition FMC ON FMH.FamilyMemberHistoryID = FMC.FamilyMemberHistoryID WHERE FMH.PatientID = " + req.session.user_ID + ";";
  const result_family_history = await run_query(query_family_history);
  console.log(query_family_history);
  console.log(result_family_history);
  const query_detected_issue = "SELECT * FROM DetectedIssue WHERE PatientID = " + req.session.user_ID + ";";
  const result_detected_issue = await run_query(query_detected_issue);
  console.log(query_detected_issue);
  console.log(result_detected_issue);
  res.render('user', {username: req.session.loggeduser, result_problem: result_problem, result_name: result_name[0], result: result[0], result_address: result_address[0], result_contact: result_contact[0], result_telecom: result_telecom[0], family_history: result_family_history[0], detected_issue: result_detected_issue[0]});
});

app.get('/patientf', isPractitioner, async (req, res) => {
  res.render('patientf');
});

app.get('/previouscaptions', isPractitioner, async (req, res) => {
  const queery_all_caption = "SELECT P.PatientID, P.Active, P.Gender, P.BirthDate, P.DeceasedBoolean, P.DeceasedDateTime, P.MaritalStatus, P.MultipleBirthBoolean, P.MultipleBirthInteger, P.Photo, P.Username, P.Password, I.image_name, I.image_path, I.uploaded_at FROM Patient P JOIN Images I ON P.Username = I.username;";
  const result_all_caption = await run_query(queery_all_caption);
  console.log(queery_all_caption);
  console.log(result_all_caption);
  res.render('previouscaptions');
});



// app.use((req, res) => {
//     res.status(404).render('404');
// });



function runPythonScript(scriptPath, args) {
  return new Promise((resolve, reject) => {
    const pythonProcess = exec(`python ${scriptPath} ${args.join(' ')}`, (error, stdout, stderr) => {
      if (error) {
        reject(error);
      } else {
        resolve(stdout);
      }
    });

    pythonProcess.on('error', (error) => {
      reject(error);
    });
  });
}

async function callPythonFunction() {
  try {
    const result = await runPythonScript('example.py', ['arg1', 'arg2']);
    console.log('Python script output:', result.trim());
  } catch (error) {
    console.error('Error calling Python script:', error);
  }
}

// app.post('/upload', async (req, res) => {
//   let a = 5;
//   let b = 10;
//   console.log('hello')
//   let c = await runPythonScript('example.py', [a, b]);
//    console.log(c);
// });


app.post('/upload', upload.single('image'), async (req, res) => {
  const username = req.body.username; // Assuming username is sent in the request body
  const fileName = req.file.filename; // Get the filename generated by multer
  const imagePath = `images/${fileName}`; // Adjust the path as per your project

  const sql = `INSERT INTO Images (username, image_name, image_path) VALUES (?, ?, ?)`;
  const values = [username, fileName, imagePath];

  console.log("HELLO CODE")

  let output = await runPythonScript('example.py', [imagePath]);

  console.log(output);

  const indexOfModel = output.indexOf("Model");
  let textAfterModel = "";
  if (indexOfModel !== -1) {
      textAfterModel = output.substring(indexOfModel + "Model".length).trim();
      console.log(textAfterModel);
  } else {
      console.log("The word 'Model' was not found in the input text.");
  }


  res.render('caption', {caption: textAfterModel});

  // con.query(sql, values, (err, result) => {
  //   if (err) {
  //     console.error("Error inserting image data:", err);
  //     // res.status(500).send("Error uploading image data");
  //   } else {
  //     console.log("Image data inserted successfully!");
  //     res.render('caption');
  //     // res.status(200).send("Image uploaded and data stored successfully");
  //   }
  // });
});

