const express = require('express');
const router = express.Router();
const verifyToken = require('./authMiddleware.js'); // Certifique-se de usar o caminho correto

router.get('/teste', verifyToken, (req, res) => {
    res.status(200).json({ message: 'Rota protegida acessada' });
});
module.exports = router;