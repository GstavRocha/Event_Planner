require('dotenv').config();
const model = require('../Models/UsuarioSchemal.js');
const controller = require('../Controllers/usuarioController.js');
const util = require('../../Routes/utils.js')
const express = require('express');
const brc = require('bcrypt');
const jwt = require('jsonwebtoken');


let usuario = 'gustavo';
let login = 'gugudokara';
let pass1 = 'pass2';
let pass2 = 'T1est';
let tipo = 'Cr';
let email = 'teste@teste';
const auth = express.Router();

// const teste = new model('gustavo','gugudokara','T1est','pr').validarSenha();
// const model(usuario,login, pass2 ,)

auth.get('/login/:l/:p', async(req, res, next) =>{
    let {params} = util(req)
    let {l:login, p:password} = req.params;
    let loginResultado = await controller.loginUsuario(login,password);
    res.json(loginResultado);
    console.log(res.statusCode);
});
auth.post('/login', async (req,res)=>{
    const{login, password} = req.body;
    const check = await controller.loginUsuario(login)
    if(req.statusCode == 404){
        console.error('preste atenção', error);
    }
});

module.exports = auth;
// https://www.geeksforgeeks.org/jwt-authentication-with-node-js/
// https://dvmhn07.medium.com/jwt-authentication-in-node-js-a-practical-guide-c8ab1b432a49
// https://medium.com/@filipefilpe/nodejs-autentica%C3%A7%C3%A3o-com-jwt-6e274fb205dc