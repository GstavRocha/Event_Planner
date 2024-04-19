/* back banco de dados DbEvents*/
create database dbEvent;
use dbEvent;
create table if not exists tbUsuario
(
    idUsuario   int auto_increment
        primary key,
    nome        varchar(50)       not null,
    tipoUsuario enum ('Cr', 'Pr') null comment 'Cr - Cria o evento, Pr - Participa do evento',
    login       varchar(50)       not null,
    password    varchar(30)       not null,
    email       varchar(60)       not null
);

create table if not exists tbEvento
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

create table if not exists tbEventoParticipantes 
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

create definer = root@localhost trigger deletaParticipante
    after delete
    on tbEventoParticipantes
    for each row
begin
        UPDATE tbEvento
            set vagas = vagas + 1
        where idEvento = OLD.idEvento;
    end;

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

create or replace definer = root@localhost view vwEventoDia as
select `te`.`nomeEvento`      AS `nomeEvento`,
       `te`.`descricaoEvento` AS `descricaoEvento`,
       `te`.`ingresso`        AS `ingresso`,
       `te`.`dia`             AS `dia`,
       `te`.`hora`            AS `hora`
from `dbEvent`.`tbEvento` `te`;

create or replace definer = root@localhost view vwParticipanteEvento as
select `us`.`nome` AS `nome`, `tE`.`nomeEvento` AS `nomeEvento`, `tE`.`dia` AS `dia`, `tE`.`hora` AS `hora`
from ((`dbEvent`.`tbEventoParticipantes` `ep` join `dbEvent`.`tbEvento` `tE`
       on ((`ep`.`idEvento` = `tE`.`idEvento`))) join `dbEvent`.`tbUsuario` `us`
      on ((`ep`.`idParticipanteUsuario` = `us`.`idUsuario`)));

create or replace definer = root@localhost view vwPromoveEvento as
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
    definer = root@localhost procedure spPromoveEventos(IN spNome varchar(50))
begin
    SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
        inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
end;

