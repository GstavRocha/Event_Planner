const db = require('../../Config/connetDb.js')
const util = require('./util.js');
const EventoParticipantes = () =>{
    let sql = `SELECT * FROM tbEventoParticipantes;`;
    db.query(sql, function(err, result){
      const evento = result[0].idEvento;
      const participante = result[0].idParticipanteUsuario;
      let sql3 = `SELECT * FROM tbEventoParticipantes WHERE idParticipanteUsuario = ${participante};`;
      util(sql3); 
    })

}
const DeletaParticipante =(participante)=>{
    let sql = `DELETE FROM tbEventoParticipantes WHERE idParticipanteUsuario = ${participante};`;
    util(sql)
// FALTA VERIFICAR A TRIGGER TA ATRAPALHANDO
    let sqlTbEvento = `SELECT * FROM tbEvento`
    db.query(sqlTbEvento, function(err, result){
        let evento = result[0].idEvento;
        let sqlsoma = `UPDATE tbEvento SET vagas = vagas + 1 WHERE idEvento = ${evento};`;
        util(sqlsoma)
    })

}
DeletaParticipante(8);
// EventoParticipantes();
