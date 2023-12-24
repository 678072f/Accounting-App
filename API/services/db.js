// Include files
const mysql = require('mysql2/promise');
const config = require('../config');

// Define query funtion for running SQL queries
async function query(sql, params) {
    const connection = await mysql.createConnection(config.db);
    const [results, ] = await connection.execute(sql, params);

    return results;
}

// Export query module
module.exports = {
    query
}