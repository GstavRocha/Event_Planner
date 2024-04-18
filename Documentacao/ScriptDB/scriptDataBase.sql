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
 PŔOCEDURE CORRIGIDA
create procedure spCriaEvento(in spNomeEvento VARCHAR(50),
                              in spDescricaoEvento varchar(255),
                              in spIngresso DECIMAL(10,2),
                              in spEndereceo varchar(150),
                              in spVagas int,
                              in spDia DATE,
                              IN spHora TIME,
                              in spIdUsuario int)
begin
    declare usuariocria CHAR(2);
    select tipoUsuario INTO usuariocria from tbUsuario where idUsuario = spIdusuario;
    if usuariocria = 'Cr' THEN
        INSERT INTO tbEvento(nomeEvento, descricaoEvento, ingresso, endereco, vagas, dia, hora, idUsuario)
        VALUES (spNomeEvento, spDescricaoEvento, spIngresso, spEndereceo, spVagas, spDia,spHora, spIdUsuario) ;
        SELECT 'Evento Criado Com Sucesso';
    else
        SELECT 'Você Não tem permissão para criar um evento';
    end if;
end;
PARA TESTAR A procedure
call spCriaEvento('evento teste2', 'teste do evento2',100.00,'rua do teste', 10, '2024-04-10','19:30:10',1);
call spCriaEvento('evento teste', 'teste do evento2',100.00,'rua do teste', 10, '2024-04-10','19:30:10',2);

alter table tbEventoParticipantes
    drop foreign key Fk_idUsuario;
alter table tbEventoParticipantes drop column idPromoveEvento;
alter table  tbEvento drop column mes;
alter table tbEvento drop column ano;
alter table tbEvento drop column descricao;

GATILHOS
DELIMITER //
create trigger tgInsereParticiPante
    AFTER INSERT ON tbEventoParticipantes for each row
    begin
        UPDATE tbEvento set vagas = vagas - 1
        where idEvento = NEW.idEvento;
        IF (SELECT vagas From tbEvento where idEvento = new.idEvento)< 0 then
            signal sqlstate '45000' set message_text = 'Palestra Lotada';
        end if;
    end;
insert into tbEventoParticipantes(idEvento, idParticipanteUsuario) values (2,1)
alter table tbEventoParticipantes modify column DataInscricao timestamp default CURRENT_TIMESTAMP;

create trigger deletaParticipante AFTER delete on tbEventoParticipantes
    for each row
    begin
        UPDATE tbEvento
            set vagas = vagas + 1
        where idEvento = OLD.idEvento;
    end;
DELIMITER ;