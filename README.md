# Medi-Captions

## Project Files
1. `app.js` is the main file which contains the files for running the React app.
2. `backend.js` contains the files for running the backend server (connecting the database using get and post requests).
3. `FHIRResources.sql` contains the SQL queries for creating the database and tables.
4. `dataGen.sql` contains the SQL queries for populating the database with data.
5. `api.js` contains the code for connecting the backend with the frontend.

## Steps to Run the Database
1. Clone the repository
2. Run all the SQL queries in the file `FHIRResources.sql` in your MySQL Workbench (This will create the database and all the tables)
3. Run all the SQL queries in the file `dataGen.sql` in your MySQL Workbench (This will populate the database with data)
4. Ensure that your credentials are set correctly in the `creds.js` file, so the code can connect to the database.

## Steps to Run the Project
1. Clone the repository
2. Use "npm install"
3. Use "npm axios" to install axios module
4. Use "node app" or "nodemon app" to run the project

## Important Note
1. Make sure you have installed nodejs and npm in your system.
2. Make sure you have installed axios module in your system.
3. Do not change the variable names in the code.
4. Try to maintain the code structure.
5. Do not change the database name, table names and column names.
