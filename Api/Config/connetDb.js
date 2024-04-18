const mysql = require('mysql');
const host = 'localhost';
const usuario = 'root';
const passWord = 'D@nidani1985';
const db = 'dbEvent';
const port = 3306;

let conectDb = {
    host: host,
    user: usuario,
    password: passWord,
    database: db,
    port: port
};

function conexaoBancoDados(param){
    let conn;
    try{
        conn = mysql.createConnection(param);
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
        conn.end()
    }
}
module.exports = conexaoBancoDados(conectDb);