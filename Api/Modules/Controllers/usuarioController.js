const db = require('../../Config/connetDb.js');
const util = require('./util.js');

const GetTodosUsuarios =()=>{
    return new Promise((resolve, reject)=>{
        let sql = `SELECT tu.idUsuario,tu.nome, tu.login,tu.email FROM tbUsuario tu;`;
        util(sql,(err, result) =>{
            if(err){
                reject(err);
            }else{
                resolve(result);
            }
        })
    })
}
const logiUsuario = (login, password) =>{
    let sql = `SELECT nome,password FROM tbUsuario WHERE nome LIKE;`;
    util(sql);
}
const CriaUsuario = (nome, tipo, login, password, email) =>{
    let sql = `CALL spCriarUsuario("${nome}","${tipo}","${login}","${password}","${email}");`;
    util(sql);
}
const AtualizarNome = (nomeNovo, idUsuario) => {
    let sql = `UPDATE tbUsuario SET nome = '${nomeNovo}' WHERE idUsuario = ${idUsuario};`;
    util(sql);
}
const AtualizarEmail = (novoEmail, idUsuario) =>{
    let sql = `UPDATE tbUsuario SET email = '${novoEmail}' WHERE idUsuario = ${idUsuario};`;
    util(sql);
}
const AtualizarLogin = (idUsuario, idEvento,novaDescricao) =>{
    let sql = `CALL spEditarDescricao(${idUsuario},${idEvento},"${novaDescricao}");`;
    util(sql);
}
module.exports = {GetTodosUsuarios,
logiUsuario,
CriaUsuario,
AtualizarNome,
AtualizarLogin,
AtualizarEmail};
