/* back banco de dados DbEvents*/
create database dbEvent;
use dbEvent;
create table tbUsuario
(
    idUsuario   int auto_increment
        primary key,
    nome        varchar(50)       not null,
    tipoUsuario enum ('Cr', 'Pr') null comment 'Cr - Cria o evento, Pr - Participa do evento',
    login       varchar(50)       not null,
    password    varchar(30)       not null,
    email       varchar(60)       not null
);

create table tbEvento
(
    idEvento        int auto_increment
        primary key,
    nomeEvento      varchar(50)    not null,
    descricaoEvento varchar(150)   not null,
    ingresso        decimal(10, 2) null,
    endereco        varchar(150)   not null,
    vagas           int            not null,
    dia             date           not null,
    hora            time           null,
    idUsuario       int            not null,
    constraint fk_tbusuarioiduser
        foreign key (idUsuario) references tbUsuario (idUsuario)
);

create definer = root@localhost trigger trDeletaEvento
    before delete
    on tbEvento
    for each row
BEGIN
    -- Deleta os registros na tabela tbEventoParticipantes que correspondem ao evento sendo deletado
    DELETE FROM tbEventoParticipantes WHERE idEvento = OLD.idEvento;
END;

create table tbEventoParticipantes
(
    idEventoParticipante  int auto_increment
        primary key,
    idEvento              int                                 not null,
    idParticipanteUsuario int                                 null comment 'retorna o idUsuario tabela Usuario enum Pr',
    DataInscricao         timestamp default CURRENT_TIMESTAMP null,
    constraint Fk_idEvento
        foreign key (idEvento) references tbEvento (idEvento),
    constraint Fk_idParticipanteUsuario
        foreign key (idParticipanteUsuario) references tbUsuario (idUsuario)
);

create definer = root@localhost trigger tgInsereParticiPante
    after insert
    on tbEventoParticipantes
    for each row
begin
        UPDATE tbEvento set vagas = vagas - 1
        where idEvento = NEW.idEvento;
        IF (SELECT vagas From tbEvento where idEvento = new.idEvento)< 0 then
            signal sqlstate '45000' set message_text = 'Palestra Lotada';
        end if;
    end;

create definer = root@localhost trigger trDeletaUsuario
    before delete
    on tbUsuario
    for each row
BEGIN
    DELETE FROM tbEventoParticipantes WHERE idParticipanteUsuario = OLD.idUsuario;
    DELETE FROM tbEvento WHERE idUsuario = OLD.idUsuario;
END;

create definer = root@localhost view vwEventoDia as
select `te`.`nomeEvento`      AS `nomeEvento`,
       `te`.`descricaoEvento` AS `descricaoEvento`,
       `te`.`ingresso`        AS `ingresso`,
       `te`.`dia`             AS `dia`,
       `te`.`hora`            AS `hora`
from `dbEvent`.`tbEvento` `te`;

create definer = root@localhost view vwParticipanteEvento as
select `us`.`nome` AS `nome`, `tE`.`nomeEvento` AS `nomeEvento`, `ep`.`DataInscricao` AS `DataInscricao`
from ((`dbEvent`.`tbEventoParticipantes` `ep` join `dbEvent`.`tbEvento` `tE`
       on ((`ep`.`idEvento` = `tE`.`idEvento`))) join `dbEvent`.`tbUsuario` `us`
      on ((`ep`.`idParticipanteUsuario` = `us`.`idUsuario`)));

create definer = root@localhost view vwPromoveEvento as
select `tU`.`nome`            AS `nome`,
       `tE`.`nomeEvento`      AS `nomeEvento`,
       `tE`.`descricaoEvento` AS `descricaoEvento`,
       `tE`.`dia`             AS `dia`,
       `tE`.`hora`            AS `hora`,
       `tE`.`vagas`           AS `vagas`
from (`dbEvent`.`tbEvento` `tE` join `dbEvent`.`tbUsuario` `tU` on ((`tE`.`idUsuario` = `tU`.`idUsuario`)));

create
    definer = root@localhost procedure spCriaEvento(IN spNomeEvento varchar(50), IN spDescricaoEvento varchar(255),
                                                    IN spIngresso decimal(10, 2), IN spEndereceo varchar(150),
                                                    IN spVagas int, IN spDia date, IN spHora time, IN spIdUsuario int)
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

create
    definer = root@localhost procedure spCriarUsuario(IN spNome varchar(50), IN spTipoUsuario enum ('Cr', 'Pr'),
                                                      IN spLogin varchar(50), IN spSenha varchar(30),
                                                      IN spEmail varchar(60))
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

create
    definer = root@localhost procedure spDeletaParticipante(IN spIdUsuario int, IN spIdParticipante int, IN spIdEvento int)
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

create
    definer = root@localhost procedure spEditarDescricao(IN spIdUsuario int, IN spIdeEvento int, IN spDescricao varchar(150))
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

create
    definer = root@localhost procedure spEditarEndereco(IN spIdUsuario int, IN spIdeEvento int, IN spEndereco varchar(255))
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

create
    definer = root@localhost procedure spEditarHora(IN spIdUsuario int, IN spIdeEvento int, IN spHora time)
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

create
    definer = root@localhost procedure spEditarIngresso(IN spIdUsuario int, IN spIdeEvento int, IN spIngresso decimal(10, 2))
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

create
    definer = root@localhost procedure spEditarVagas(IN spIdUsuario int, IN spIdeEvento int, IN spVagas int)
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

create
    definer = root@localhost procedure spEventoDia(IN spDia date)
begin 
    SELECT * from vwEventoDia ve where ve.dia = spDia;
end;

create
    definer = root@localhost procedure spEventoPesquisaParticipante(IN spNomeParticipante varchar(50))
begin
    select te.nomeEvento,te.dia, te.hora, tu.nome, tu.email,tp.DataInscricao from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where tu.nome like concat('%',spNomeParticipante,'%');
end;

create
    definer = root@localhost procedure spInscricaoEvento(IN spIdEvento int, IN spIdUsuario int)
begin
        INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
            values (spIdEvento,spIdUsuario);
        SELECT 'Inscrição feita com sucesso';
    end;

create
    definer = root@localhost procedure spListaParticipantesEvento(IN spNomeEvento varchar(50))
begin
    select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
end;

create
    definer = root@localhost procedure spPequisaEvento(IN spNome varchar(50))
begin
    SELECT te.nomeEvento,te.vagas ,te.dia, te.hora, te.ingresso FROM tbEvento te WHERE te.nomeEvento LIKE CONCAT('%',spNome,'%');
end;

create
    definer = root@localhost procedure spPromoveEventos(IN spNome varchar(50))
begin
    SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
        inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
end;

