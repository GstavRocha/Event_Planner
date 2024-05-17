require('dotenv').config();
const controller = require('../Controllers/usuarioController.js');
const util = require('../../Routes/utils.js');
const express = require('express');
const jwt = require('jsonwebtoken');
const {response} = require("express");
const User = require('../Models/UsuarioSchemal.js');

const auth = express.Router();

// const teste = new model('gustavo','gugudokara','T1est','pr').validarSenha();
// const model(usuario,login, pass2 ,)
const usuario = new User();

auth.get('/login/:l/:p', async(req, res, next) =>{
    let {params} = util(req)
    let {l:login, p:password} = req.params;
    let check = await controller.loginUsuario(login,password);
    usuario.nome(check[0].nome);
    console.log(res.statusCode);
    return res.json(check);
});
auth.get('/tipo/:id', async(req, res) =>{
    let {params} = util(req)
    let {id:id} = req.params;
    let tipoUsuario = await controller.tipoUsuario(id);
    res.send(tipoUsuario);
    console.log(res.statusCode);

})
auth.post('/login/:l/:p', async (req, res) => {
    try {
        let { l: login, p: password } = req.params;
        let check = await controller.loginUsuario(login, password);

        if (typeof check === 'string') {
            check = JSON.parse(check);
        }

        if (!check || check.length === 0 || check[0].login !== login || check[0].password !== password) {
            return res.status(401).json({ error: 'Não Autorizado' });
        }

        let token = jwt.sign({ id: check[0].idUsuario }, process.env.SECRET_KEY, {
            expiresIn: '1h'
        });

        return res.status(200).json({ header: token });
    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

module.exports = auth;

// https://www.geeksforgeeks.org/jwt-authentication-with-node-js/
// https://dvmhn07.medium.com/jwt-authentication-in-node-js-a-practical-guide-c8ab1b432a49
// https://medium.com/@filipefilpe/nodejs-autentica%C3%A7%C3%A3o-com-jwt-6e274fb205dc