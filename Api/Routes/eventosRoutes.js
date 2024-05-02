const controller = require('../Modules/Controllers/eventosController.js');
const express = require('express')
const router = express.Router();
const util = require('./utils.js');

router.get('/eventos', async (req, res) => {
    res.send(await controller.Eventos());
    console.log(res.statusCode);
});
router.get('/promove', async (req, res) => {
    res.send(await controller.PromoveEvento());
    console.log(res.statusCode)
});
router.get('/eventosdias/:a/:m/:d', async (req, res) => {
    let {params} = util(req);
    let{a: ano, m: mes, d: dia } = params;
    res.send(await controller.EventoDia(
        ano,mes,dia
    ));
    console.log(res.statusCode)
});
router.get('/pesquisa/:n', async (req, res) => {
    let {params} = util(req);
    let{n: nomeEvento} = params;
    res.send(await controller.PesquisaEvento(
        nomeEvento
    ));
    console.log(res.statusCode);
});
router.post('/cria/:n/:d/:i/:e/:v/:di/:m/:a/:h/:mi/:id', async (req, res) => {
    let {params} = util(req);
    let{n:nome, d: descricao , i:ingresso, e:endereco, v:vagas, d:dia, m:mes, a:ano, h:hora, m:minutos} = params;
    const criaEvento = await controller.CriaEvento(
        nome,
        descricao,
        ingresso,
        endereco,
        vagas,
        dia,
        mes,
        ano,
        hora,
        minutos,
        idUsuario)
    res.send(criaEvento);
    console.log(res.statusCode);
});
router.get('/eventos/:p', async (req, res) => {
    let {params} = util(req);
    let {p:pesquisar} = params;
    res.send(await controller.PesquisaEvento(
        pesquisar
    ));
    console.log(res.statusCode);
});
router.delete('/eventos/:d', async (req, res) => {
    let {params} = util(req);
    let{d:deletar} = params;
    res.send(await controller.DeletaEvento(
        deletar
    ));
    console.log(res.statusCode);
    
});

router.put('/editdescricao/:u/:e/:d', async (req, res) => {
    let {params} = util(req);
    let{u: idUsuario, e:idEvento, d: descricao} = params;
    res.send(await controller.EditaDescricao(
        idUsuario, idEvento, descricao
    ));
    res.send(editar);
    console.log(res.statusCode);
});
router.put('/editendereco/:u/:e/:en', async (req, res) => {
    let {params} = util(req);
    let{u:idUsuario , e:idEvento , en:endereco} = params
    res.send(await controller.EditarEndereco(
        idUsuario, idEvento, endereco
    ));
    console.log(res.statusCode);
});
router.put('/edithora/:u/:e/:h/:m', async (req, res) => {
    let {params} = util(req);
    let{u:idUsuario, e:idEvento, h:hora, m:minutos} = params;
    res.send(await controller.EditarHora(
        idUsuario, idEvento, hora, minutos
    ));
    console.log(res.statusCode);
});
router.put('/editingress/:u/:e/:i', async (req, res) => {
    let {params} = util(req);
    let{u:idUsuario,e:idEvento,i:ingresso} = params;
    res.send(await controller.EditarIngresso(
        idUsuario, idEvento, ingresso
    ));
    console.log(res.statusCode);
});
router.put('/editvagas/:u/:e/:v', async (req, res) => {
    let{params} = util(req);
    let { u: idUsuario, e: idEvento, v:vagas } = params;
    res.send(await controller.EditarVagas(
        idUsuario, idEvento, vagas
    ))
    console.log(res.statusCode);
});
module.exports = router;
