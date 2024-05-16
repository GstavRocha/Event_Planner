const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
    let token = req.header('Authorization');

    if (!token) {
        return res.status(401).json({ error: 'Token vazio' });
    }
    // if (token.startsWith('Bearer ')) {
    //     token = token.slice(7, token.length);
    // }
    try {
        let decoded = jwt.verify(token, process.env.SECRET_KEY);
        req.idUsuario = decoded.id;
        console.log(`ID do usuário verificado: ${req.idUsuario}`);
        next();
    } catch (erro) {
        console.error('Erro na verificação do token:', erro);
        res.status(401).json({ error: 'Token inválido' });
    }
};
module.exports = verifyToken;
