require('dotenv').config();
const protecao = {
    local: process.env.LOCALHOST,
    usr: process.env.USERACCESS,
    pass: process.env.DBPASSWORD,
    dbacc: process.env.DBNAME,
    dbprt: process.env.DBPORT,
    secret: process.env.SECRET_KEY
}
function validador(bancoPass, bancoNome, bancoUsuario){
    if(bancoPass === undefined){
        console.log('senha do banco invalida');
    }
    if(bancoNome === undefined){
        console.log('nome de banco invalido');
    }
    if(bancoUsuario === undefined){
        console.log('verifique o usuario de acesso ao banco de dados');
    }
}

try {
    validador(protecao.pass, protecao.dbacc,protecao.usr);
}catch (erro){
    console.log(erro, 'Variáveis não configuradas');
}
// console.log(protecao.secret)
module.exports = protecao;