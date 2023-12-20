# Medi-Captions

## Project Files
1. `app.js` is the main file which contains the files for running the React app.
2. `backend.js` contains the files for running the backend server (connecting the database using get and post requests).
3. `FHIRResources.sql` contains the SQL queries for creating the database and tables.
4. `dataGen.sql` contains the SQL queries for populating the database with data.
5. `api.js` contains the code for connecting the backend with the frontend.

## Mendatory Steps to Run the Project
### Steps to Run the Database
1. Clone the repository
2. Run all the SQL queries in the file `FHIRResources.sql` in your MySQL Workbench (This will create the database and all the tables)
3. Run all the SQL queries in the file `dataGen.sql` in your MySQL Workbench (This will populate the database with data)
4. Ensure that your credentials are set correctly in the `creds.js` file, so the code can connect to the database.

### Steps to Run the Project
1. Clone the repository
2. Use `npm install`
3. Use `npm install multer` 
3. Use `npm axios` to install axios module
4. Use `node app` or `nodemon app` to run the project

### How to Login
* For logging in as a patient, use the following credentials:
    * Username: `user1`
    * Password: `password1`
* For logging in as a practitioner, use the following credentials:
    * Username: `practitioner1`
    * Password: `password1`
* Note: Without logging in, you cannot access the website.

## Important Note
1. Make sure you have installed nodejs and npm in your system.
2. Make sure you have installed axios module in your system.
3. Do not change the variable names in the code.
4. Try to maintain the code structure.
5. Do not change the database name, table names and column names.

## Introduction

### Login Page
![Screenshot 2023-12-20 at 7 19 57 PM](https://github.com/Adarsh78513/Medi-Captions/assets/88873670/1c083439-c22b-4fd2-b39c-438267042c12)

### Home Page
<img width="1470" alt="Screenshot 2023-12-20 at 7 20 39 PM" src="https://github.com/Adarsh78513/Medi-Captions/assets/88873670/51426a7e-179c-49d3-bfaa-351c06389346">

### Upload Image
<img width="735" alt="Screenshot 2023-12-20 at 7 23 42 PM" src="https://github.com/Adarsh78513/Medi-Captions/assets/88873670/f22f82e3-1226-4748-ab0f-39a1a36dc972">

### Caption Page
<img width="1469" alt="Screenshot 2023-12-20 at 7 24 19 PM" src="https://github.com/Adarsh78513/Medi-Captions/assets/88873670/b01a19a1-0082-424b-b477-64ec2c6165c2">

