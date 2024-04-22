const controller = require('../Modules/Controllers/eventosController.js');

module.exports = (app) => {
    app.get('/controllers/eventos', (req, res) => {
        let eventos = controller.Eventos();
        res.send(eventos);
    });

    app.get('/controllers/promoveEventos',(req, res)=>{
        let viewEventos = controller.PromoveEvento();
        res.send(viewEventos);
    })

    app.get('/controllers/eventosdias/:a/:m/:d',(req, res)=>{
        let ano = req.params.a;
        let mes = req.params.m;
        let dia = req.params.d;
        let eventosdia = controller.EventoDia(dia,mes,ano);
        res.send(eventosdia);
    })
    app.get('/controllers/pesquisa/:n', (req, res)=>{
        let nome = req.params.nome;
        let pesquisaEvento = controller.PesquisaEvento(nome);
        res.send(pesquisaEvento)
    })
    app.post('/controllers/cria/:n/:d/:i/:e/:v/:di/:m/:a/:h/:mi/:id',(req, res)=>{
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
        let criaEvento = controller.CriaEvento(
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
    app.get('/controllers/:pesquisar',(req,res)=>{
        let pesquisar = req.params.pesquisar;
        let pesquisarEventos = controller.PesquisaEvento(pesquisar);
        res.send(pesquisarEventos);
    })

    app.delete('/controllers/:evdel',(req, res)=>{
        let deletar = req.params.evdel;
        let deletarEvento = controller.DeletaEvento(deletar);
        res.send(deletarEvento);
    })

    app.put('/controllers/editdescricao/:u/:e/:desc',(req, res)=>{
        let usuario = req.params.u;
        let evento = req.params.e;
        let descricao = req.params.desc;
        let editar = controller.EditaDescricao(usuario,evento,descricao);
        res.send(editar);
    })
    app.put('/controllers/editendereco/:u/:e/:ender', (req, res)=>{
        let usuario = req.params.u;
        let evento = req.params.e;
        let endereco = req.params.ender;
        let editar = controller.EditarEndereco(usuario,evento,endereco);
        res.send(editar);
    })
    app.put('/controllers/edithora/:u/:e/:h/:m', (req, res) =>{
        let usuario = req.params.u;
        let evento = req.params.e;
        let hora = req.params.h;
        let minutos = req.params.m;
        let editarHora = controller.EditarHora(usuario,evento,hora, minutos);
        res.send(editarHora);
    })
    app.put('/controllers/editingress/:u/:e/:ingress',(req, res)=>{
        let usuario = req.params.u;
        let evento = req.params.e;
        let ingresso = req.params.ingress;
        let editarIngresso = controller.EditarIngresso(usuario,evento, ingresso);
        res.send(editarIngresso);
    })
    app.put('/controllers/editvagas/:u/:e/:vagas', (req, res)=>{
        let usuario = req.params.u;
        let evento = req.params.e;
        let vagas = req.params.vagas
        let editarVagas = controller.EditarVagas(usuario,evento,vagas);
        res.send(editarVagas);
    })

};

// https://expressjs.com/en/4x/api.html#res.json
