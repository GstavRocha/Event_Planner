const mysql = require('mysql');
require('dotenv').config({path:'../.env'});



const hst = 'localhost';	
const usr = 'root';	
const pass = '';	
const dbase = 'dbEvent';	
const prt = 3306;	
// console.log(process.env.LOCALHOST);
let conectDb = {	
    host: hst,	
    user: usr,	
    password: pass,	
    database: dbase,	
    port: prt	
};	

let conn;	
try{	
    conn = mysql.createConnection(conectDb);	
    conn.connect((err) =>{	
        if(err){	
            console.error('Erro ao conectar', err);	
            return;	
        }	
        console.log('conectado ao Banco de Dados')	
    })	
}catch(err){	
    console.error(err,'ERROR')	
}finally{	
    conn.on('end', function() {	
        console.log('Conexão encerrada.');	
    });	
}	
module.exports = conn;