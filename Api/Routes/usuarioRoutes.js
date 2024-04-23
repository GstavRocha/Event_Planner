const controller = require('../Modules/Controllers/usuarioController.js');
const model = require('../Modules/Models/usuarioModel.js')
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
require('dotenv-safe').config();

module.exports = (app) =>{
    app.use(bodyParser.json());
    // app.post('/controllers/login', (req, res, next) =>{
    //     const{login, password} = req.body;
    //     console.log(login,password);
    //     res.json({})

    // })
    app.get('/controllers/usuarios', async(req, res)=>{
        try{
            let usuario = await controller.GetTodosUsuarios();
            console.log(usuario);
            res.json(usuario);

        }catch(erro){
            console.log(erro)
            res.status(500).json({error: 'Erro ao obter usuário'});
        }
    })
}
