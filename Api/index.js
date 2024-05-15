const express = require('express');
const cors = require('cors');
const app = express();
const eventosRoutes = require('./Routes/eventosRoutes.js');
const usuariosRoutes = require('./Routes/usuariosRoutes.js');
const eventoPariticpante = require('./Routes/eventoParicipanteRoute.js');
const auth = require('../Api/Modules/Auth/AuthRoute.js')
const autenticacao = require('./Modules/MiddleWare/usuarioMid.js');
const port = 3000;
require('dotenv').config();

app.use(cors());
app.get('/',(req, res)=>{
    res.send('Hello World');
})
app.use('/controllers/',eventosRoutes,usuariosRoutes,eventoPariticpante);

app.use('/auth/', auth);

app.use('/mid',autenticacao);
app.listen(port,()=>{
    console.log(' Servido online');
})
