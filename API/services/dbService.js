// Dependencies
const db = require('./db');
const helper = require('../helper');
const config = require('../config');

// Functions
// GET
// GET all terms
async function getAllTerms(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM terms LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta,
    }
}

// GET all customers
async function getAllCustomers(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM customers LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta,
    }
}

// GET all suppliers
async function getAllSuppliers(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM suppliers LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta,
    }
}

// GET bill_trans
async function getBillTrans(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM bill_trans LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta,
    }
}

// GET coa
async function getCOA(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM coa LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page};

    return {
        data,
        meta,
    }
}

// GET invoice_trans
async function getInvoices(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM invoice_trans LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page}

    return {
        data,
        meta,
    }
}

// GET received_money_trans
async function getReceivedMoney(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM received_money_trans LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page}

    return {
        data,
        meta,
    }
}

// GET spent_money_trans
async function getSpentMoney(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM spent_money_trans LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page}

    return {
        data,
        meta,
    }
}

// GET trial_balance
async function getTrialBalance(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM trial_balance LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page}

    return {
        data,
        meta,
    }
}

// GET Invoices
async function getAllInvoices(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        `SELECT * FROM invoices LIMIT ${offset}, ${config.listPerPage}`
    );
    const data = helper.emptyOrRows(rows);
    const meta = {page}

    return {
        data,
        meta,
    }
}

// POST
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

// PUT
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

// DELETE

module.exports = {
    getAllTerms,
    getAllCustomers,
    getAllSuppliers,
    getBillTrans,
    getCOA,
    getInvoices,
    getReceivedMoney,
    getSpentMoney,
    getTrialBalance,
    getAllInvoices,
    newTerms,
    updateTerm,
}