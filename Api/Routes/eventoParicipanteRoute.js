const controller = require('../Modules/Controllers/eventoParticipanteController.js');
const express = require('express');
const util = require('./utils.js');

const router = express.Router();
router.get('/part', async (req,res) =>{
    res.send(await controller.EventoParticipantes());
    console.log(res.statusCode);
});
router.get('/parts/:n', async(req, res)=>{
    let {params} = util(req);
    let {n: nome} = params;
    res.send(await controller.ListaParticipantes(
        nome
    ))
    console.log(res.statusCode);
});
router.post('/partic/:i/:p', async(req, res) =>{
    let {params} = util(req);
    let { i: idEvento, p:idUsuario} = params;
    res.send( await controller.InscricaoEvento(
        idEvento, idUsuario
    ))
    console.log(res.statusCode);
});
router.delete('/delpart/:i/:p/:e', async (req, res) =>{
    let {params} = util(req);
    let{i: idUsuario, p:idParticipante, e:idEvento} = params;
    res.send( await controller.DeletaParticipante(
        idUsuario, idEvento, idParticipante
    ))
    console.log(res.statusCode);
});
module.exports = router;