const db = require('../../Config/connetDb.js');
const util = require('./util.js');

const GetTodosUsuarios =()=>{
    let sql = `SELECT tu.nome, tu.login,tu.email FROM tbUsuario tu;`;
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
module.exports = GetTodosUsuarios,
CriaUsuario,
AtualizarNome,
AtualizarLogin,
AtualizarEmail;
