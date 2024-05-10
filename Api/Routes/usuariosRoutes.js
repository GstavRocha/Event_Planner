const controller = require('../Modules/Controllers/usuarioController.js');
const express = require('express');
const util = require('./utils.js');

const router = express.Router();
router.get('/usuarios', async(req, res)=>{
    res.send(await controller.GetTodosUsuarios());
    console.log(res.statusCode);
});
router.post('/criausuarios/:n/:t/:l/:p/:e', async(req,res)=>{
    let {params} = util(req);
    let  {n: nome,t: tipo, l:login, p:password, e:email } = params;
    res.send(await controller.CriaUsuario(
        nome, tipo, login, password, email
    ))
    console.log(res.statusCode)
});
router.put('/editnom/:n/:i', async(req, res)=>{
    let {params} = util(req);
    let {n:nome,i:idUsuario} = params;
    res.send(await controller.AtualizarNome(
        nome, idUsuario
    ))
    console.log(res.statusCode)
});

router.put('/editlog/:l/:i', async(req, res)=>{
    let {params} = util(req);
    let {l: login, i: idUsuario} = params;
    res.send(await controller.AtualizarLogin(
        login, idUsuario
    ))
    console.log(res.statusCode)
});
router.put('/editem/:e/:i', async(req, res)=>{
    let {params} = util(req);
    let {e: email, i:idUsuario} = params;
    res.send(await controller.AtualizarEmail(
        email, idUsuario
    ))
    console.log(res.statusCode)
});

module.exports = router;