CREATE DATABASE dbEventPlanner;

USE dbEventPlanner;

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
    ingresso DECIMAL(10, 2),
    endereco VARCHAR(150) NOT NULL,
    vagas INT NOT NULL,
    dia DATE NOT NULL,
    mes DATE NOT NULL,
    ano YEAR NOT NULL,
    hora TIME
);

CREATE TABLE tbEventoParticipantes (
    idEventoParticipante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idEvento INT not null,
    idPromoveEvento INT comment 'retorna o idUsuario tabela Usuario, enum Cr',
    idParticipanteUsuario INT comment 'retorna o idUsuario tabela Usuario enum Pr',
    DataInscricao TIMESTAMP comment 'registra automaticamente a data/hora do participante inscrito no evento'
);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idEvento FOREIGN KEY (idEvento) REFERENCES tbEvento(idEvento);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idUsuario FOREIGN KEY (idPromoveEvento) REFERENCES tbUsuario(idUsuario);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idParticipanteUsuario
FOREIGN KEY (idParticipanteUsuario) REFERENCES tbUsuario(idUsuario);

alter table tbEvento add column idUsuario int not null;
alter table tbEvento add constraint fk_tbusuarioiduser FOREIGN KEY (idUsuario) REFERENCES tbUsuario(idUsuario);
Alter table tbEvento add column descricao varchar(255) not null;
alter table tbEvento MODIFY COLUMN ingresso decimal(10,2);

insert tbUsuario( nome, tipoUsuario, login, password, email)
values
    ( 'Joaoteste', 'Cr', 'teste','senha', 'teste@teste'),
    ('mariateste','Pr','maria','teste','maria@teste');
select * from tbUsuario;
create procedure spCriaEvento(in spIdusuario int,
                              in spDescricao varchar(255),
                              in spIngresso decimal(10,2),
                              in spEndereco varchar(150),
                              in spVagas INT,
                              in spNomeEvento VARCHAR(50),
                              in spDia DATE,
                              in spMes DATE,
                              in spAno Year)
begin
    declare usuariocria CHAR(2);
    select tipoUsuario INTO usuariocria from tbUsuario where idUsuario = spIdusuario;
    if usuariocria = 'Cr' THEN
        INSERT INTO tbEvento(nomeEvento, descricaoEvento, ingresso, endereco, vagas, dia, mes, ano)
            values(spNomeEvento,spDescricao, spIngresso, spEndereco, spVagas, spDia,spMes,spAno);
        SELECT 'Evento Criado Com Sucesso';
    else
        SELECT 'Você Não tem permissão para criar um evento';
    end if;
end;
alter table tbEventoParticipantes
    drop foreign key Fk_idUsuario;
alter table tbEventoParticipantes drop column idPromoveEvento;