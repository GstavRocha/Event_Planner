const util = require('./util.js');
const db = require('../../Config/connetDb.js');

const Eventos= () =>{
    let sql = 'SELECT * FROM tbEvento;';
    util(sql);
};

const PromoveEvento = () =>{
    let sql = 'SELECT * FROM vwPromoveEvento;';
    util(sql);
}

const EventoDia = (dia,mes,ano)=> {
    let sqlEventoDia = `CALL spEventoDia("${ano}-${mes}-${dia}")`;
    util(sqlEventoDia);
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
    idUsuario
) => {
    let sql = `CALL spCriaEvento("${nome}","${descricao}",${ingresso},"${endereco}",${vagas},"${ano}-${mes}-${dia}","${hora}",${idUsuario})`;
    util(sql);;
}
const DeletaEvento = (idEvento) =>{
    let sql = `DELETE FROM tbEvento WHERE idEvento = ${idEvento};`;
    util(sql);
}
const PesquisaEvento = (nomeEvento) =>{
    let sql = `CALL spPequisaEvento("${nomeEvento}");`;
    util(sql);
}
const EditaDescricao = (idUsuario,idEvento, descricao) =>{
    let sql = `call spEditarDescricao(${idUsuario},${idEvento},"${descricao}");`;
    util(sql);
}
const EditarEndereco = (idUsuario, idEvento, endreco) =>{
    let sql = `CALL spEditarEndereco(${idUsuario},${idEvento},"${endreco}");`;
    util(sql)
}
const EditarHora = (idUsuario,idEvento, hora, minutos) =>{
    let sql = `CALL spEditarHora(${idUsuario},${idEvento},"${hora}:${minutos}:00");`;
    util(sql) 
}
const EditarIngresso = (idUsuario, idEvento, ingresso) =>{
    let sql = `CALL spEditarIngresso(${idUsuario},${idEvento},${ingresso});`;
    util(sql);
}
const EditarVagas = (idUsuario, idEvento, vagas) =>{
    let sql = `CALL spEditarVagas(${idUsuario},${idEvento},${vagas});`;
    util(sql);
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
