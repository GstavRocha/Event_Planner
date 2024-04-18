const db = require('../../Config/connetDb.js')

function executaSql(sql, param, res, errMsg){
    db.query(sql, param,(err, result)=>{
        if(err){
            res.status(500).json({erro: errMsg , detalhe: err})
        }else{
            res.status(200).json(result)
        }
    })
}
module.exports = executaSql;