const extrairParametros = (req) =>{
    let params = req.params;
    // let contador = Object.keys(params).length;
    console.log(params)
    return{params};

}
module.exports = extrairParametros;