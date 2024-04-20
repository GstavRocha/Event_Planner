const controller = require('../Modules/Controllers/eventosController.js');

module.exports = (app) => {
    app.get('/controllers', (req, res) => {
        let eventos = controller.Eventos();
        res.send(eventos);
    });

    app.get('/controllers/vw',(req, res)=>{
        let viewEventos = controller.PromoveEvento();
        res.send(viewEventos);
    })
};
