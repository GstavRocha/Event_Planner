const mysql = require('mysql');
const protecao = require('./protection.js')
require('dotenv').config();

const hst = protecao.local;
const usr = protecao.usr;
const pass = protecao.pass;
const dbase = protecao.dbacc;
const prt = protecao.dbprt;
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