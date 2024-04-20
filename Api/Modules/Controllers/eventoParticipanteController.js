const db = require('../../Config/connetDb.js')
const util = require('./util.js');

const EventoParticipantes = () =>{
    let sql = `SELECT * FROM vwParticipanteEvento;`;
    util(sql);
}
const ListaParticipantes = (nomeEvento) =>{
    let sql = `CALL spListaParticipantesEvento("${nomeEvento}");`;
    util(sql);
}
const InscricaoEvento = (novoIdEvento, novoIdUsuario) =>{
    let sql = `CALL spInscricaoEvento(${novoIdEvento},${novoIdUsuario});`;
    util(sql);
}
const DeletaParticipante =(idUsuario,idParticipante,idEvento)=>{
    let sql = `CALL spDeletaParticipante(${idUsuario},${idParticipante},${idEvento});`;
    util(sql);
}
module.exports = EventoParticipantes, ListaParticipantes,InscricaoEvento,DeletaParticipante;

