const db = require('../../Config/connetDb.js')
const util = require('./util.js');

const EventoParticipantes = () =>{
    let sql = `SELECT * FROM vwParticipanteEvento;`;
    return util(sql);
}
const ListaParticipantes = (nomeEvento) =>{
    let sql = `CALL spListaParticipantesEvento("${nomeEvento}");`;
    return util(sql);
}
const InscricaoEvento = (idEvento, idUsuario) =>{
    let sql = `CALL spInscricaoEvento(${idEvento},${idUsuario});`;
    return util(sql);
}
const DeletaParticipante =(idUsuario,idParticipante,idEvento)=>{
    let sql = `CALL spDeletaParticipante(${idUsuario},${idParticipante},${idEvento});`;
    return util(sql);
}
module.exports = {EventoParticipantes, ListaParticipantes,InscricaoEvento,DeletaParticipante};

