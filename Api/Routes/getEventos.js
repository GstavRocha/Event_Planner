const controller = require('../Modules/Controllers/eventosController.js');

module.exports = (app) => {
    app.get('/controllers/eventos', (req, res) => {
        let eventos = controller.Eventos();
        res.send(eventos);
    });

    app.get('/controllers/vw',(req, res)=>{
        let viewEventos = controller.PromoveEvento();
        res.send(viewEventos);
    })

    app.get('/controllers/eventosdias/:a/:m/:d',(req, res)=>{
        const ano = req.params.a;
        const mes = req.params.m;
        const dia = req.params.d;
        let eventosdia = controller.EventoDia(dia,mes,ano);
        res.send(eventosdia);
    })
};
