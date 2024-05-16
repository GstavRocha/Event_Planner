require('dotenv').config();
const model = require('../Models/UsuarioSchemal.js');
const controller = require('../Controllers/usuarioController.js');
const util = require('../../Routes/utils.js')
const express = require('express');
const brc = require('bcrypt');
const jwt = require('jsonwebtoken');
const {response} = require("express");

const auth = express.Router();

// const teste = new model('gustavo','gugudokara','T1est','pr').validarSenha();
// const model(usuario,login, pass2 ,)
const usuario = new model();

auth.get('/login/:l/:p', async(req, res, next) =>{
    let {params} = util(req)
    let {l:login, p:password} = req.params;
    let loginResultado = await controller.loginUsuario(login,password);
    res.json(loginResultado);
    console.log(res.statusCode);
});
auth.get('/tipo/:id', async(req, res) =>{
    let {params} = util(req)
    let {id:id} = req.params;
    let tipoUsuario = await controller.tipoUsuario(id);
    res.send(tipoUsuario);
    console.log(res.statusCode);

})
auth.post('/login/:l/:p', async (req,res)=>{
    let {params} = util(req);
    let {l:login, p:password} = req.params;
    let check = await controller.loginUsuario(login,password);
    // const token = jwt.sign({})
    if(check.length === 2){
         return res.status(401).json({error: "usuario não encontrado"});
    }else{
         return res.status(200).json({resultado:"usuario logado"});

    }
});

module.exports = auth;
// https://www.geeksforgeeks.org/jwt-authentication-with-node-js/
// https://dvmhn07.medium.com/jwt-authentication-in-node-js-a-practical-guide-c8ab1b432a49
// https://medium.com/@filipefilpe/nodejs-autentica%C3%A7%C3%A3o-com-jwt-6e274fb205dc