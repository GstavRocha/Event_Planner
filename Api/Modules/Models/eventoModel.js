export class Eventos{
    constructor(
        idEvento,
        idUsuario,
        nomeEvento,
        descricao,
        ingresso, 
        endereco, 
        vagas, 
        dia, 
        mes, 
        ano, 
        hora){
            this.idEvento = idEvento;
            this.idUsuario = idUsuario;
            this.nomeEvento = nomeEvento;
            this.descricao = descricao;
            this.ingresso = ingresso;
            this.endereco = endereco;
            this.vagas = vagas;
            this.dia = dia;
            this.mes = mes;
            this.ano = ano;
            this.hora = hora;
        }

}