// Require environment variables for credentials
require('dotenv').config()

// Import environment variables
const HOST = process.env.HOST
const USER = process.env.USER
const PASSWORD = process.env.PASSWORD
const DB = process.env.DB

// Database connection parameters
const config = {
    db: {
        host: HOST,
        user: USER,
        password: PASSWORD,
        database: DB,
        connectTimeout: 60000
    },
    listPerPage: 10,
};

module.exports = config;