const express = require('express');
const cors = require('cors');
const app = express();
const eventosRoutes = require('./Routes/eventosRoutes.js');
const usuariosRoutes = require('./Routes/usuariosRoutes.js');
<<<<<<< Updated upstream
const eventoPariticpante = require('./Routes/eventoParicipanteRoute.js')
=======
const eventoPariticpante = require('./Routes/eventoParicipanteRoute.js');
const autenticacao = require('./Modules/MiddleWare/usuarioMid.js');
>>>>>>> Stashed changes
const port = 3000;
require('dotenv').config();

require('dotenv').config();

app.use(cors());
app.get('/',(req, res)=>{
    res.send('Hello World');
})
app.use('/controllers/',eventosRoutes,usuariosRoutes,eventoPariticpante);
<<<<<<< Updated upstream

=======
// app.use('/mid',autenticacao);
>>>>>>> Stashed changes
app.listen(port,()=>{
    console.log(' Servido online');
})
