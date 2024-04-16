CREATE DATABASE dbEventos;

USE dbEventos;

CREATE TABLE tbUsuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    tipoUsuario ENUM('Cr', 'Pr') comment 'Cr - Cria o evento, Pr - Participa do evento', 
    login VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    email varchar(60) NOT NULL
);

CREATE TABLE tbEvento (
    idEvento INT PRIMARY KEY AUTO_INCREMENT  ,
    nomeEvento VARCHAR(50) NOT NULL,
    descricaoEvento VARCHAR(150) NOT NULL,
    ingresso DECIMAL(10, 2) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    vagas INT NOT NULL,
    dia DATE NOT NULL,
    mes DATE NOT NULL,
    ano YEAR NOT NULL,
    hora TIME
);

CREATE TABLE tbEventoParticipantes (
    idEventoParticipante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,  
    idEvento INT,
    idPromoveEvento INT comment 'retorna o idUsuario tabela Usuario, enum Cr',
    idParticipanteUsuario INT comment 'retorna o idUsuario tabela Usuario enum Pr',
    DataInscricao TIMESTAMP comment 'registra automaticamente a data/hora do participante inscrito no evento'
);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idEvento FOREIGN KEY (idEvento) REFERENCES tbEvento(idEvento);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idUsuario FOREIGN KEY (idPromoveEvento) REFERENCES tbUsuario(idUsuario);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idParticipanteUsuario
FOREIGN KEY (idParticipanteUsuario) REFERENCES tbUsuario(idUsuario);

