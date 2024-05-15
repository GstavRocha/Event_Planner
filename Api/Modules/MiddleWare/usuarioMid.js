const usuario = require('../Controllers/usuarioController.js');
const jwt = require('jsonwebtoken');
const express = require('express');
const PRIVATE_KEY = 'EventPlanner';
const cors = require('cors');
const SECRET_KEY = process.env.SECRET_JWT;

const middle = express.Router();
// middle.use(cors());

module.exports = middle;
