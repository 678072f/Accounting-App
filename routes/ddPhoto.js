const express = require('express');
const router = express.Router();
const ddPhoto = require('../services/ddPhoto');

router.get('/terms', async function(req, res, next) {
    try {
        res.json(await ddPhoto.getMultipleTerms(req.query.page));
    } catch (err) {
        console.error(`Error while getting terms `, err.message);
        next(err);
    }
});

router.get('/customers', async function(req, res, next) {
    try {
        res.json(await ddPhoto.getMultipleCustomers(req.query.page));
    } catch (err) {
        console.error(`Error while getting customers `, err.message);
        next(err);
    }
});

router.post('/add-term', async function(req, res, next) {
    try {
        res.json(await ddPhoto.newTerms(req.body));
    } catch (err) {
        console.error(`Error while adding new term `, err.message);
        next(err);
    }
});

router.put('/update-term/:id', async function(req, res, next) {
    try {
        res.json(await ddPhoto.updateTerm(req.params.id, req.body));
    } catch (err) {
        console.error(`Error updating terms `, err.message);
        next(err);
    }
});

/* ADD NEW ROUTES BELOW */

module.exports = router;