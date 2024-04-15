create database dbEventPlanner;
use dbEventPlanner;
create table tbUsuario(
    idUsuario int not null  auto_increment primary key,
    nome varchar(60) not null,
    cpf varchar(14) not null,
    tipoUsuario enum('Adm','Ger','Part') not null comment 'Admin - Administrador, Ger - criador de eventos, Part - participante de eventos'
);
create table tbEvento(
    idEvento int not null  auto_increment primary key,
    tituloEvento varchar(60) not null,
    capacidade int()
    idUsuario int not null,
    dateEvent DATE not null,
);