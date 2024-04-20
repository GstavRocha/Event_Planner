const express = require('express');
const app = express();
const rotaEventos = require('./Routes/getEventos.js')
const port = 3000;

app.get('/',(req, res)=>{
    res.send('Hello World');
})
rotaEventos(app);
app.listen(port,()=>{
    console.log(' Servido online');
})