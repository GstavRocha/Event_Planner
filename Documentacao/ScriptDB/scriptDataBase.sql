CREATE DATABASE dbEvent;

USE dbEvent;

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
SELECT us.nome,tE.nomeEvento,tE.dia, ep.DataInscricao from tbEventoParticipantes ep
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
DELIMITER ;

DELIMITER //
CREATE PROCEDURE spInscricaoEvento(in spIdEvento int, in spIdUsuario int)
    begin
        INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
            values (spIdEvento,spIdUsuario);
        SELECT 'Inscrição feita com sucesso';
    end;
DELIMITER ;

DELIMITER //
create procedure spEventoDia ( in spDia DATE)
begin
    SELECT * from vwEventoDia ve where ve.dia = spDia;
end;
DELIMITER ;

DELIMITER //
create procedure spPromoveEventos(in spNome varchar(50))
begin
    SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
        inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
end;
DELIMITER ;

DELIMITER //
create procedure spListaParticipantesEvento(in spNomeEvento varchar(50))
begin
    select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
end;
DELIMITER ;

DELIMITER //
create procedure spEventoPesquisaParticipante(in spNomeParticipante varchar(50))
begin
    select te.nomeEvento,te.dia, te.hora, tu.nome, tu.email,tp.DataInscricao from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where tu.nome like concat('%',spNomeParticipante,'%');

end ;
DELIMITER ;

DELIMITER //
create procedure spDeletaParticipante(in spIdUsuario int, in spIdParticipante int,in spIdEvento int)
begin
    declare usuariocria CHAR(2);
    select tipoUsuario into usuariocria from tbUsuario where idUsuario = spIdUsuario;
    if usuariocria = 'Cr' then
        DELETE FROM tbEventoParticipantes where idParticipanteUsuario = spIdParticipante;
        UPDATE tbEvento set vagas = vagas + 1 where idEvento = spIdEvento;
        SELECT 'Remoção feita com sucesso';
    else
        SELECT 'Você não tem permissão para remover';
    end if;
end;
DELIMITER ;

DELIMITER $$
create procedure spPesquisaEvento(in spNome VARCHAR(50))
begin
    SELECT te.nomeEvento,te.vagas ,te.dia, te.hora, te.ingresso FROM tbEvento te WHERE te.nomeEvento LIKE CONCAT('%',spNome,'%');
end $$

DELIMITER ;

CREATE PROCEDURE spCriarUsuario(
    spNome VARCHAR(50),
    spTipoUsuario ENUM('Cr', 'Pr'),
    spLogin VARCHAR(50),
    spSenha VARCHAR(30),
    spEmail VARCHAR(60)
)
BEGIN
    DECLARE nomeVerifica INT;
    DECLARE emailVerifica INT;


    SELECT COUNT(*) INTO nomeVerifica FROM tbUsuario WHERE nome = spNome;
    SELECT COUNT(*) INTO emailVerifica FROM tbUsuario WHERE email = spEmail;

    IF nomeVerifica > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O nome já está em uso';
    END IF;

    IF emailVerifica > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O email já está em uso';
    END IF;

    INSERT INTO tbUsuario(nome, tipoUsuario, login, password, email)
    VALUES (spNome, spTipoUsuario, spLogin, spSenha, spEmail);

END;
DELIMITER ;

DELIMITER //
create procedure spEditarDescricao(in spIdUsuario int, in spIdeEvento int, in spDescricao varchar(150))
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.descricaoEvento = spDescricao where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

DELIMITER //
create procedure spEditarEndereco(in spIdUsuario int, in spIdeEvento int, in spEndereco varchar(255))
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.endereco = spEndereco where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

DELIMITER //
create procedure spEditarHora(in spIdUsuario int, in spIdeEvento int, in spHora TIME)
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.hora = spHora where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

DELIMITER //
create procedure spEditarIngresso(in spIdUsuario int, in spIdeEvento int, in spIngresso DECIMAL(10,2))
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.ingresso = spIngresso where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

DELIMITER //
create procedure spEditarIngresso(in spIdUsuario int, in spIdeEvento int, in spIngresso DECIMAL(10,2))
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.ingresso = spIngresso where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

DELIMITER //
create procedure spEditarVagas(in spIdUsuario int, in spIdeEvento int, in spVagas int)
begin
    declare editadescricao CHAR(2);
    select tu.tipoUsuario into editadescricao from tbUsuario tu where idUsuario = spIdUsuario;
    if editadescricao = 'Cr' then
        UPDATE tbEvento te SET te.vagas = spVagas where te.idEvento = spIdeEvento;
        SELECT 'Alteração feita com sucesso';
    else
        SELECT 'Você não tem permissão para fazer essa operação';
    end if;

end;
DELIMITER ;

/* PARA TESTAR AS PROCEDURES */
CALL spCriaEvento('IVETE SANGALO 3.0 - A FESTA', 'Show da maior cantora do brasil', 414.00, 'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 31375,'2024-08-31','20:00:00', 1);
CALL spCriaEvento('Jorge Vercillo', 'cantor MPB', 259.00, 'Teatro Riachuelo Av. Nevaldo Rocha, 3775 - Loja 234 3° Piso - Tirol, Natal - RN, 59051-000', 1475,'2024-07-07','20:00:00', 3);
call spCriaEvento('evento teste2', 'teste do evento2',100.00,'rua do teste', 10, '2024-04-10','19:30:10',1);
call spCriaEvento('NATIRUTS', 'Show da maior banda de Reague do brasil',150.00,'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 20000,'2024-07-13','21:00', 3);

call spInscricaoEvento(2,2);
call spInscricaoEvento(2,4);
call spInscricaoEvento(4,3);


/* GATILHOS */

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
DELIMITER ;
DELIMITER //

CREATE TRIGGER delete_eventos before DELETE ON tbUsuario
FOR EACH ROW
BEGIN
    DELETE FROM tbEventoParticipantes WHERE idParticipanteUsuario = OLD.idUsuario;
    DELETE FROM tbEvento WHERE idUsuario = OLD.idUsuario;
END;
//
DELIMITER ;
