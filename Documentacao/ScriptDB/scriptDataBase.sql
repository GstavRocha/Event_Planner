create database dbEventPlanner;
use dbEventPlanner;
create table tbUsuario(
    idUsuario int not null auto_increment primary key ,
    nome varchar(60)  not null,
    tipoUsuario enum('Cr','Pr') comment 'Cr - Cria o evento, Pr - Participa do evento',
    password varchar(60) not null,
    login varchar(25) not null,
    email varchar(60) not null
);
create table tbEvento(
    idEvento int auto_increment not null primary key,
    nomeEvento varchar(60) not null,
    vagas int not null,
    dia date not null,
    mes date not null,
    ano year not null
);
create table tbEventoParticipantes(
    idEventoParticipantes int auto_increment not null primary key,
    idEvento int not null,
    idPromotorUsuario int not null comment 'retorna o idUsuario tabela Usuario, enum Cr',
    idParticipanteUsuario int not null comment 'retorna o idUsuario tabela Usuario enum Pr',
    dataInscricao date not null
);
