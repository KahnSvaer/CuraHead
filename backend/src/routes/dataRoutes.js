// src/routes/dataRoutes.js
const express = require('express');
const router = express.Router();

// Sample GET endpoint
router.get('/data', (req, res) => {
    res.status(200).json({
        message: 'This is a sample data response',
        data: {
            key: 'value',
            description: 'Sample data description',
        },
    });
});

module.exports = router;
