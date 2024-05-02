const util = require('./util.js');
const db = require('../../Config/connetDb.js');

const Eventos= () =>{
    let sql = 'SELECT * FROM tbEvento;';
    return util(sql);
};

const PromoveEvento = () =>{
    let sql = 'SELECT * FROM vwPromoveEvento;';
    return util(sql);
}

const EventoDia = (dia,mes,ano)=> {
    let sqlEventoDia = `CALL spEventoDia("${ano}-${mes}-${dia}")`;
    return util(sqlEventoDia);
};
const CriaEvento = (
    nome, 
    descricao, 
    ingresso, 
    endereco, 
    vagas, 
    dia, 
    mes, 
    ano, 
    hora,
    minutos,
    idUsuario
) => {
    let sql = `CALL spCriaEvento("${nome}","${descricao}",${ingresso},"${endereco}",${vagas},"${ano}-${mes}-${dia}","${hora}:${minutos}:00",${idUsuario})`;
    return util(sql);;
}
const DeletaEvento = (idEvento) =>{
    let sql = `DELETE FROM tbEvento WHERE idEvento = ${idEvento};`;
    return util(sql);
}
const PesquisaEvento = (nomeEvento) =>{
    let sql = `CALL spPequisaEvento("${nomeEvento}");`;
    return util(sql);
}
const EditaDescricao = (idUsuario,idEvento, descricao) =>{
    let sql = `call spEditarDescricao(${idUsuario},${idEvento},"${descricao}");`;
    return util(sql);
}
const EditarEndereco = (idUsuario, idEvento, endreco) =>{
    let sql = `CALL spEditarEndereco(${idUsuario},${idEvento},"${endreco}");`;
    return util(sql)
}
const EditarHora = (idUsuario,idEvento, hora, minutos) =>{
    let sql = `CALL spEditarHora(${idUsuario},${idEvento},"${hora}:${minutos}:00");`;
    return util(sql) 
}
const EditarIngresso = (idUsuario, idEvento, ingresso) =>{
    let sql = `CALL spEditarIngresso(${idUsuario},${idEvento},${ingresso});`;
    return util(sql);
}
const EditarVagas = (idUsuario, idEvento, vagas) =>{
    let sql = `CALL spEditarVagas(${idUsuario},${idEvento},${vagas});`;
    return util(sql);
}
module.exports = {Eventos, 
EventoDia, 
PromoveEvento, 
CriaEvento, 
DeletaEvento,
PesquisaEvento,
EditaDescricao,
EditarEndereco,
EditarHora,
EditarIngresso,
EditarVagas};
