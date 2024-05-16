const db = require('../../Config/connetDb.js');
const util = require('./util.js');

const GetTodosUsuarios =()=>{
    let sql = `SELECT tu.nome, tu.login,tu.email FROM tbUsuario tu;`;
    return util(sql);
}
// usará para fazer o login com jwt
const loginUsuario = (login, password) =>{
    let sql = `SELECT idUsuario,login,password,tipoUsuario FROM tbUsuario WHERE login = "${login}" AND password = "${password}";`;
    return util(sql);
}
const tipoUsuario = (idUsuario) =>{
    let sql = `SELECT idUsuario, login,tipoUsuario password FROM tbUsuario WHERE idUsuario = ${idUsuario};`;
    return util(sql);
}
// Vair para o Middle
const CriaUsuario = (nome, tipo, login, password, email) =>{
    let sql = `CALL spCriarUsuario("${nome}","${tipo}","${login}","${password}","${email}");`;
    return util(sql);
}
const AtualizarNome = (nomeNovo, idUsuario) => {
    let sql = `UPDATE tbUsuario SET nome = '${nomeNovo}' WHERE idUsuario = ${idUsuario};`;
    return util(sql);
}
const AtualizarEmail = (novoEmail, idUsuario) =>{
    let sql = `UPDATE tbUsuario SET email = '${novoEmail}' WHERE idUsuario = ${idUsuario};`;
    return util(sql);
}
const AtualizarLogin = (novoLogin,idUsuario) =>{
    let sql = `UPDATE tbUsuario SET login = '${novoLogin}' WHERE idUsuario = ${idUsuario};`;
    return util(sql)
}
module.exports = {GetTodosUsuarios,
loginUsuario,
CriaUsuario,
AtualizarNome,
AtualizarLogin,
tipoUsuario,
AtualizarEmail};

