class UsuarioSchema{
    constructor(nome,login, password, permissao, email){
        this.nome = nome;
        this.login = login;
        this.password = password;
        this.permissao = permissao;
        this.email = email;
    
    }
    // caso a senha não tenha o padrão maior que 4 caracteres, uma letra maiuscula, uma minuscula e um numero ela retorna falso;
    validarSenha(){
        let requisito = this.password.length >=4 && /[A-Z]/.test(this.password) && /[a-z]/.test(this.password) && /\d/.test(this.password); 
        console.log(requisito)
        return requisito;
    }

    get nome(){
        return this._nome;
    }

    set nome(param){
        this._nome = param;
    }

    get login(){
        return this._login;
    }
    set login(param){
        this._login = param;
    }

    get password(){
        return this._password;
    }
    set password(param){
        this._password = param;
    }

    get permissao(){
        return this._permissao;
    }
    set permissao(param){
        this._permissao = param;
    }
    get email(){
        return this._email;
    }
    set email(param){
        this._email = param;
    }
}
// const teste1 = new UsuarioSchema('gustavo','gugudokara','T1est','pr').validarSenha();
module.exports = UsuarioSchema;