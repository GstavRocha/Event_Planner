const express = require('express');
const app = express();
const eventosRoutes = require('./Routes/eventosRoutes.js')
const port = 3000;

app.get('/',(req, res)=>{
    res.send('Hello World');
})
eventosRoutes(app);
app.listen(port,()=>{
    console.log(' Servido online');
})