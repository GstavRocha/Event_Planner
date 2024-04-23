const express = require('express');
const app = express();
const eventosRoutes = require('./Routes/eventosRoutes.js');
const usuarioRoutes = require('./Routes/usuarioRoutes.js')
const port = 3000;
const jwt = require('jsonwebtoken');
require('dotenv-safe').config();
app.get('/',(req, res)=>{
    res.send('Hello World');
})
usuarioRoutes(app);
eventosRoutes(app);
app.listen(port,()=>{
    console.log(' Servido online');
})