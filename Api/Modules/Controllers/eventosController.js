const util = require('./util.js')

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
    util(sql);

}
const DeletaEvento = (idEvento) =>{
    let sql = `DELETE FROM tbEvento WHERE idUsuario = ${idEvento};`;
    util(sql);
}
module.exports = Eventos, EventoDia, PromoveEvento, CriaEvento, DeletaEvento;
