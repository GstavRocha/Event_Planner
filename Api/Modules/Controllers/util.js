const db = require('../../Config/connetDb');

const util = async (params) =>{
    db.connect(function(){
        db.query(params, function(err, result,fields){
            if(err) throw err;
            console.log(result)
            return result;
        })
    
    })
}
module.exports = util;

