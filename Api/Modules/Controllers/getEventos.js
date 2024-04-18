const db = require('../../Config/connetDb.js');
const assert = require('express-validator');

const getEventos = async function(req, res, next) {
    try{
        const sqlVwEventodia = `SELECT * FROM tbEventos;`;
        const [eventos] = await db.execute(sqlVwEventodia);

        return res.status(200).json({ eventos });
    }catch(err){
        console.error(err, 'o Erro');
    }
}

getEventos().then(console.log).catch(console.error);