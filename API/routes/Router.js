/* ROUTER */
const express = require('express');
const router = express.Router();
const dbService = require('../services/dbService');

// READ
// READ all terms from the terms table in the database
router.get('/terms', async function(req, res, next) {
    try {
        res.json(await dbService.getAllTerms(req.query.page));
    } catch (err) {
        console.error(`Error while getting terms `, err.message);
        next(err);
    }
});

// READ all customers from the customers table in the database
router.get('/customers', async function(req, res, next) {
    try {
        res.json(await dbService.getAllCustomers(req.query.page));
    } catch (err) {
        console.error(`Error while getting customers `, err.message);
        next(err);
    }
});

// READ all suppliers from the suppliers table in the database
router.get('/suppliers', async function(req, res, next) {
    try {
        res.json(await dbService.getAllSuppliers(req.query.page));
    } catch (err) {
        console.error(`Error while getting suppliers `, err.message);
        next(err);
    }
});

// READ bill_trans view
router.get('/bill-trans', async function(req, res, next) {
    try {
        res.json(await dbService.getBillTrans(req.query.page));
    } catch (err) {
        console.error(`Error getting bill_trans `, err.message);
        next(err);
    }
});

// READ all Chart of Accounts (COA) Table
router.get('/coa', async function(req, res, next) {
    try {
        res.json(await dbService.getCOA(req.query.page));
    } catch (err) {
        console.error(`Error getting bill_trans `, err.message);
        next(err);
    }
});

// READ all invoice transactions from invoice_trans view
router.get('/invoice-trans', async function(req, res, next) {
    try {
        res.json(await dbService.getInvoices(req.query.page));
    } catch (err) {
        console.error(`Error getting invoices `, err.message);
        next(err);
    }
})

// READ all received money transactions from received_money_trans view
router.get('/received-money-trans', async function(req, res, next) {
    try {
        res.json(await dbService.getReceivedMoney(req.query.page));
    } catch (err) {
        console.error(`Error getting received money transactions `, err.message);
        next(err);
    }
})

// READ all received money transactions from received_money_trans view
router.get('/spent-money-trans', async function(req, res, next) {
    try {
        res.json(await dbService.getSpentMoney(req.query.page));
    } catch (err) {
        console.error(`Error getting spent money transactions `, err.message);
        next(err);
    }
})

// READ all trial balance from trial_balance view
router.get('/trial-balance', async function(req, res, next) {
    try {
        res.json(await dbService.getTrialBalance(req.query.page));
    } catch (err) {
        console.error(`Error getting trial balance `, err.message);
        next(err);
    }
})

// READ all invoices
router.get('/invoices', async function(req, res, next) {
    try {
        res.json(await dbService.getAllInvoices(req.query.page));
    } catch (err) {
        console.error(`Error getting invoices `, err.message);
    }
})


// CREATE
// CREATE new terms to add to the database
router.post('/add-term', async function(req, res, next) {
    try {
        res.json(await dbService.newTerms(req.body));
    } catch (err) {
        console.error(`Error while adding new term `, err.message);
        next(err);
    }
});

// UPDATE terms in the database
router.put('/update-term/:id', async function(req, res, next) {
    try {
        res.json(await dbService.updateTerm(req.params.id, req.body));
    } catch (err) {
        console.error(`Error updating terms `, err.message);
        next(err);
    }
});

// TODO: ADD NEW ROUTES BELOW

module.exports = router;