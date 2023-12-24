// Dependencies
const db = require('./db');
const helper = require('../helper');
const config = require('../config');

// Functions
// GET all terms
async function getMultipleTerms(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM terms LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta
    }
}

// GET all customers
async function getMultipleCustomers(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM customers LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta
    }
}

// POST new terms
async function newTerms(term) {
    const result = await db.query(
        `INSERT INTO terms
        (code, description, due_days, discount_days, discount)
        VALUES
        ('${term.code}', '${term.description}', '${term.due_days}', '${term.discount_days}', '${term.discount}')`
    );

    let message = 'Error adding new term!';

    if (result.affectedRows) {
        message = 'Term added successfully!';
    }

    return {message};
}

// PUT terms
async function updateTerm(code, term) {
    const result = await db.query(
        `UPDATE terms
        SET description="${term.description}", due_days="${term.due_days}", discount_days="${term.discount_days}", discount="${term.discount}"
        WHERE code=${code}`
    );

    let message = 'Error updating term!';

    if (result.affectedRows) {
        message = 'Term updated successfully.';
    }

    return {message};
}

/* ADD FUNCTIONS BELOW */

module.exports = {
    getMultipleTerms,
    getMultipleCustomers,
    newTerms,
    updateTerm,
}