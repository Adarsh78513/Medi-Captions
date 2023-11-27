// Ensure that the credentials are correct for the MySQL database
MySQLUsername = 'root';
MySQLPassword = 'root';
MySQLDatabase = 'fhirdatabase';
MySQL_IP = 'localhost';
MySQL_Port = 3306;
compIP = 'localhost';
compPort = 8080;


// Export the variables
module.exports = {
  MySQLUsername,
  MySQLPassword,
  MySQLDatabase,
  MySQL_IP,
  MySQL_Port,
  compIP,
  compPort
}