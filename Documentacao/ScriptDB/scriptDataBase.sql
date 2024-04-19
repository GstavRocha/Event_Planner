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
    descricaoEvento VARCHAR(255) NOT NULL,
    ingresso decimal(10, 2),
    endereco VARCHAR(255) NOT NULL,
    vagas INT NOT NULL,
    dia DATE NOT NULL,

    hora TIME,
    idUsuario INT NOT NULL

 

);

CREATE TABLE tbEventoParticipantes (
    idEventoParticipante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idEvento INT not null,
    idParticipanteUsuario INT comment 'retorna o idUsuario tabela Usuario enum Pr',
    DataInscricao timestamp default CURRENT_TIMESTAMP comment 'registra automaticamente a data/hora do participante inscrito no evento'
);

ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idEvento FOREIGN KEY (idEvento) REFERENCES tbEvento(idEvento);
ALTER TABLE tbEventoParticipantes ADD constraint  Fk_idParticipanteUsuario FOREIGN KEY (idParticipanteUsuario) REFERENCES tbUsuario(idUsuario);
alter table tbEvento add constraint fk_tbusuarioiduser FOREIGN KEY (idUsuario) REFERENCES tbUsuario(idUsuario);


insert tbUsuario( nome, tipoUsuario, login, password, email)
            values
            ( 'Joaoteste', 'Cr', 'teste','senha', 'teste@teste'),
            ('Janine','Pr','maria','teste','maria@teste'),
            ( 'Alycson', 'Cr', 'teste','senha', 'teste@teste'),
            ('Gustavo','Pr','maria','teste','maria@teste');

select * from tbUsuario;



/* VIEWS */
create view vwParticipanteEvento as
SELECT us.nome,tE.nomeEvento,tE.dia,tE.hora from tbEventoParticipantes ep
inner join tbEvento tE on ep.idEvento = tE.idEvento
inner join tbUsuario us on ep.idParticipanteUsuario = us.idUsuario;

create view vwPromoveEvento as
select tU.nome,tE.nomeEvento,tE.descricaoEvento , tE.dia, tE.hora, tE.vagas from tbEvento tE
inner join tbUsuario tU on tE.idUsuario = tU.idUsuario;

create view vwEventoDia as
       SELECT te.nomeEvento, te.descricaoEvento ,te.ingresso,te.dia,te.hora from tbEvento te;



 /* PŔOCEDURES */

  DELIMITER //

    CREATE PROCEDURE spCriaEvento(
    IN spNomeEvento VARCHAR(50),
    IN spDescricaoEvento VARCHAR(255),
    IN spIngresso DECIMAL(10,2),
    IN spEndereco VARCHAR(150),
    IN spVagas INT,
    IN spDia DATE,
    IN spHora TIME,
    IN spIdUsuario INT
)
BEGIN
    DECLARE usuariocria CHAR(2);
    SELECT tipoUsuario INTO usuariocria FROM tbUsuario WHERE idUsuario = spIdUsuario;
    
    IF usuariocria = 'Cr' THEN
        INSERT INTO tbEvento(nomeEvento, descricaoEvento, ingresso, endereco, vagas, dia, hora, idUsuario)
        VALUES (spNomeEvento, spDescricaoEvento, spIngresso, spEndereco, spVagas, spDia, spHora, spIdUsuario);
        SELECT 'Evento Criado Com Sucesso';
    ELSEIF usuariocria = 'Pr' THEN
        SELECT 'Você não tem permissão para criar um evento';
    ELSE
        SELECT 'Usuário não encontrado ou tipo de usuário inválido';
    END IF;
END;//

DELIMITER ;


DELIMITER //

    CREATE PROCEDURE spInscricaoEvento(in spIdEvento int, in spIdUsuario int)
        begin
            INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
                values (spIdEvento,spIdUsuario);
            SELECT 'Inscrição feita com sucesso';
    end //

DELIMITER ;


DELIMITER //

    CREATE PROCEDURE spEventoDia(IN spDia DATE)
    BEGIN
        SELECT * FROM vwEventoDia ve WHERE ve.dia = spDia;
    END //

DELIMITER ;

DELIMITER //

    create procedure spPromoveEventos(in spNome varchar(50))
    begin
        SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
            inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
    end //

DELIMITER ;


DELIMITER //

    create procedure spListaParticipantesEvento(in spNomeEvento varchar(50))
    begin
        select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
        inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
        inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
    end //

DELIMITER ;

DELIMITER //

 PŔOCEDURES

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

CREATE PROCEDURE spInscricaoEvento(in spIdEvento int, in spIdUsuario int)
    begin
        INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
            values (spIdEvento,spIdUsuario);
        SELECT 'Inscrição feita com sucesso';
    end;

create procedure spEventoDia ( in spDia DATE)
begin
    SELECT * from vwEventoDia ve where ve.dia = spDia;
end;

create procedure spPromoveEventos(in spNome varchar(50))
begin
    SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
        inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
end;
create procedure spListaParticipantesEvento(in spNomeEvento varchar(50))
begin
    select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
end;


create procedure spEventoPesquisaParticipante(in spNomeParticipante varchar(50))
begin
    select te.nomeEvento,te.dia, te.hora, tu.nome, tu.email,tp.DataInscricao from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where tu.nome like concat('%',spNomeParticipante,'%');

end //

DELIMITER ;

/* PARA TESTAR AS PROCEDURES */
CALL spCriaEvento('IVETE SANGALO 3.0 - A FESTA', 'Show da maior cantora do brasil', 414.00, 'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 11,'2024-08-31','20:00:00', 2);
CALL spCriaEvento('IVETE SANGALO 3.0 - A FESTA', 'Show da maior cantora do brasil', 414.00, 'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 11,'2024-08-31','20:00:00', 3);

call spCriaEvento('NATIRUTS', 'Show da maior banda de Reague do brasil',150.00,'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 20000,'2024-07-13','21:00', 3);
call spInscricaoEvento(2,2);
call spInscricaoEvento(2,4);


/* GATILHOS */

end;

PARA TESTAR AS PROCEDURES
call spCriaEvento('evento teste2', 'teste do evento2',100.00,'rua do teste', 10, '2024-04-10','19:30:10',1);
call spCriaEvento('evento teste', 'teste do evento2',100.00,'rua do teste', 10, '2024-04-10','19:30:10',2);
call spInscricaoEvento(4,3);

ALTERAÇÕES NA TABELA

alter table tbEventoParticipantes
    drop foreign key Fk_idUsuario;
alter table tbEventoParticipantes drop column idPromoveEvento;
alter table  tbEvento drop column mes;
alter table tbEvento drop column ano;
alter table tbEvento drop column descricao;
alter table tbEventoParticipantes modify column DataInscricao timestamp default CURRENT_TIMESTAMP;

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
create trigger deletaParticipante AFTER delete on tbEventoParticipantes
    for each row
    begin
        UPDATE tbEvento
            set vagas = vagas + 1
        where idEvento = OLD.idEvento;
    end;
DELIMITER ;




insert into tbEventoParticipantes(idEvento, idParticipanteUsuario) values (2,1)

VIEWS
create view vwParticipanteEvento as
SELECT us.nome,tE.nomeEvento,tE.dia,tE.hora from tbEventoParticipantes ep
inner join tbEvento tE on ep.idEvento = tE.idEvento
inner join tbUsuario us on ep.idParticipanteUsuario = us.idUsuario;

create view vwPromoveEvento as
select tU.nome,tE.nomeEvento,tE.descricaoEvento , tE.dia, tE.hora, tE.vagas from tbEvento tE
inner join tbUsuario tU on tE.idUsuario = tU.idUsuario;

create view vwEventoDia as
       SELECT te.nomeEvento, te.descricaoEvento ,te.ingresso,te.dia,te.hora from tbEvento te;


