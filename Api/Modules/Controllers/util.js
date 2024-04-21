const db = require('../../Config/connetDb');

const util = async (params) =>{
    db.connect(function(){
        db.query(params, function(err, result,fields){
            if(err) throw err;
            console.log(result);
            console.error(err);
            console.log("Requisição Sucess")
            return result;
        })
        /* db.end(); */   
    })
}
// obter id evento;
// db.query(sqlTbEvento, function(err, result){
//     let evento = result[0].idEvento;
//     let sqlsoma = `UPDATE tbEvento SET vagas = vagas + 1 WHERE idEvento = ${evento};`;
//     util(sqlsoma)
// })

module.exports = util;

