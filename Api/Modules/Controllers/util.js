const db = require('../../Config/connetDb');

const util = (sql) =>{
    return new Promise((resolve, reject)=>{
        db.query(sql, function(err, result, fields){
            if(err){
                console.error(err);
                reject(err);
                return;
            }
            const jsonResult = JSON.stringify(result);
            resolve(jsonResult);
        });
    });
}
// obter id evento;
// db.query(sqlTbEvento, function(err, result){
//     let evento = result[0].idEvento;
//     let sqlsoma = `UPDATE tbEvento SET vagas = vagas + 1 WHERE idEvento = ${evento};`;
//     util(sqlsoma)
// })
// db.query(sql, function(err, result, fields){
//     if(err)throw err;
//     const jsonResult = JSON.stringify(result);
//     console.log(jsonResult, 'teste');
//     return result;
// })
// db.end();

module.exports = util;

