# Accounting App Project

This project contains the API for an app I am creating to perform accounting tasks for my business. It is an on-going project, beginning with a database, API, and then front-end interface.

# Dependencies

This project has the following dependencies:
- Node.js
- Express
- mysql2

# Installation and Running

In order to run the app, you will need to have Node.js installed. To run the API, use the following command:
```node index.js```

This will run the API on http://localhost:3000

To set up the project:

```npm init -y```

```npm i express```

```npm i mysql2```

This project is based on a mySQL database (DB = database). You will need to set that up on your own. SQL code is provided for the database structure used in my project (also see the 'DB Strcture' image attached for a visual). mySQL Version 7+ is required for the included code to work.

For the API to connect to the database, you will also need to setup a .env file with the following parameters:
1. HOST="{hostname of your DB Server}"
2. USERNAME="{username for your DB}"
3. PASSWORD="{password for your DB}"
4. DB="{Database Name}"

Save the .env file in the API directory.

The project file structure is as follows:
- API
    - node_modules (contains dependencies for Node.js).
    - routes
        - ddPhoto.js
    - services
        - db.js
        - ddPhoto.js
    - .env
    - config.js
    - helper.js
    - index.js
    - package-lock.json
    - package.json
- SQL
    - Tables
        - ERP.sql
    - Views
        - ViewBuild.sql
- README.md
- LICENSE
- DB Structure.png

# Credits

This app was created by Daniel Duhon.