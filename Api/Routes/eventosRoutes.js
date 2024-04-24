const controller = require('../Modules/Controllers/eventosController.js');

module.exports = (app) => {

    /*app.get('/controllers/eventos', (req, res) => {
        controller.Eventos().then(eventos => res.send(eventos));        
    });*/

    app.get('/controllers/eventos', async (req, res) => {
        const eventos = await controller.Eventos();
        res.send(eventos);
    });

    app.get('/controllers/promoveEventos', async (req, res) => {
        const viewEventos = await controller.PromoveEvento();
        res.send(viewEventos);
    })

    app.get('/controllers/eventosdias/:a/:m/:d', async (req, res) => {
        let ano = req.params.a;
        let mes = req.params.m;
        let dia = req.params.d;
        const eventosdia = await controller.EventoDia(dia, mes, ano);
        res.send(eventosdia);
    })
    app.get('/controllers/pesquisa/:n', async (req, res) => {
        let nome = req.params.nome;
        const pesquisaEvento = await controller.PesquisaEvento(nome);
        res.send(pesquisaEvento)
    })
    app.post('/controllers/cria/:n/:d/:i/:e/:v/:di/:m/:a/:h/:mi/:id', async (req, res) => {
        let nome = req.params.n;
        let descricao = req.params.d;
        let ingresso = req.params.i;
        let endereco = req.params.e;
        let vagas = req.params.v;
        let dia = req.params.di;
        let mes = req.params.m;
        let ano = req.params.a;
        let hora = req.params.h;
        let minutos = req.params.mi;
        //Esse tem que vim automático
        let idUsuario = req.params.id;
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
    })
    app.get('/controllers/:pesquisar', async (req, res) => {
        let pesquisar = req.params.pesquisar;
        const pesquisarEventos = await controller.PesquisaEvento(pesquisar);
        res.send(pesquisarEventos);
    })

    app.delete('/controllers/:evdel', async (req, res) => {
        let deletar = req.params.evdel;
        const deletarEvento = await controller.DeletaEvento(deletar);
        res.send(deletarEvento);
    })

    app.put('/controllers/editdescricao/:u/:e/:desc', async (req, res) => {
        let usuario = req.params.u;
        let evento = req.params.e;
        let descricao = req.params.desc;
        const editar = await controller.EditaDescricao(usuario, evento, descricao);
        res.send(editar);
    })
    app.put('/controllers/editendereco/:u/:e/:ender', async (req, res) => {
        let usuario = req.params.u;
        let evento = req.params.e;
        let endereco = req.params.ender;
        const editar = await controller.EditarEndereco(usuario, evento, endereco);
        res.send(editar);
    })
    app.put('/controllers/edithora/:u/:e/:h/:m', async (req, res) => {
        let usuario = req.params.u;
        let evento = req.params.e;
        let hora = req.params.h;
        let minutos = req.params.m;
        const editarHora = await controller.EditarHora(usuario, evento, hora, minutos);
        res.send(editarHora);
    })
    app.put('/controllers/editingress/:u/:e/:ingress', async (req, res) => {
        let usuario = req.params.u;
        let evento = req.params.e;
        let ingresso = req.params.ingress;
        const editarIngresso = await controller.EditarIngresso(usuario, evento, ingresso);
        res.send(editarIngresso);
    })
    app.put('/controllers/editvagas/:u/:e/:vagas', async (req, res) => {
        let usuario = req.params.u;
        let evento = req.params.e;
        let vagas = req.params.vagas
        const editarVagas = await controller.EditarVagas(usuario, evento, vagas);
        res.send(editarVagas);
    })

};

// https://expressjs.com/en/4x/api.html#res.json
