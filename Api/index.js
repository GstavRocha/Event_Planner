const express = require('express');
const cors = require('cors');
const app = express();
const eventosRoutes = require('./Routes/eventosRoutes.js')
const port = 3000;

app.use(cors());
app.get('/',(req, res)=>{
    res.send('Hello World');
})
eventosRoutes(app);


app.listen(port,()=>{
    console.log(' Servido online');
})