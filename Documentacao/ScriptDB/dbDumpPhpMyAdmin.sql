-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 21/04/2024 às 06:04
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbEvent`
--
CREATE DATABASE dbEvent;
USE dbEvent;

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCriaEvento` (IN `spNomeEvento` VARCHAR(50), IN `spDescricaoEvento` VARCHAR(255), IN `spIngresso` DECIMAL(10,2), IN `spEndereco` VARCHAR(150), IN `spVagas` INT, IN `spDia` DATE, IN `spHora` TIME, IN `spIdUsuario` INT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spEventoDia` (IN `spDia` DATE)   BEGIN
        SELECT * FROM vwEventoDia ve WHERE ve.dia = spDia;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spInscricaoEvento` (IN `spIdEvento` INT, IN `spIdUsuario` INT)   begin
            INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
                values (spIdEvento,spIdUsuario);
            SELECT 'Inscrição feita com sucesso';
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spListaParticipantesEvento` (IN `spNomeEvento` VARCHAR(50))   begin
        select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
        inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
        inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spPromoveEventos` (IN `spNome` VARCHAR(50))   begin
        SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
            inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
    end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbEvento`
--

CREATE TABLE `tbEvento` (
  `idEvento` int(11) NOT NULL,
  `nomeEvento` varchar(50) NOT NULL,
  `descricaoEvento` varchar(255) NOT NULL,
  `ingresso` decimal(10,2) DEFAULT NULL,
  `endereco` varchar(255) NOT NULL,
  `vagas` int(11) NOT NULL,
  `dia` date NOT NULL,
  `hora` time DEFAULT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbEvento`
--

INSERT INTO `tbEvento` (`idEvento`, `nomeEvento`, `descricaoEvento`, `ingresso`, `endereco`, `vagas`, `dia`, `hora`, `idUsuario`) VALUES
(1, 'IVETE SANGALO 3.0 - A FESTA', 'Show da maior cantora do brasil', 414.00, 'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 31375, '2024-08-31', '20:00:00', 1),
(2, 'Jorge Vercillo', 'cantor MPB', 259.00, 'Teatro Riachuelo Av. Nevaldo Rocha, 3775 - Loja 234 3° Piso - Tirol, Natal - RN, 59051-000', 1475, '2024-07-07', '20:00:00', 3),
(3, 'evento teste2', 'teste do evento2', 100.00, 'rua do teste', 10, '2024-04-10', '19:30:10', 1),
(4, 'NATIRUTS', 'Show da maior banda de Reague do brasil', 150.00, 'Arena das Dunas - Av. Prudente de Morais, 5121 - Lagoa Nova, Natal - RN', 20000, '2024-07-13', '21:00:00', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbEventoParticipantes`
--

CREATE TABLE `tbEventoParticipantes` (
  `idEventoParticipante` int(11) NOT NULL,
  `idEvento` int(11) NOT NULL,
  `idParticipanteUsuario` int(11) DEFAULT NULL COMMENT 'retorna o idUsuario tabela Usuario enum Pr',
  `DataInscricao` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'registra automaticamente a data/hora do participante inscrito no evento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbEventoParticipantes`
--

INSERT INTO `tbEventoParticipantes` (`idEventoParticipante`, `idEvento`, `idParticipanteUsuario`, `DataInscricao`) VALUES
(1, 2, 2, '2024-04-21 03:57:37'),
(2, 2, 4, '2024-04-21 03:57:37'),
(3, 4, 3, '2024-04-21 03:57:37');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbUsuario`
--

CREATE TABLE `tbUsuario` (
  `idUsuario` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipoUsuario` enum('Cr','Pr') DEFAULT NULL COMMENT 'Cr - Cria o evento, Pr - Participa do evento',
  `login` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbUsuario`
--

INSERT INTO `tbUsuario` (`idUsuario`, `nome`, `tipoUsuario`, `login`, `password`, `email`) VALUES
(1, 'Joaoteste', 'Cr', 'teste', 'senha', 'teste@teste'),
(2, 'Janine', 'Pr', 'maria', 'teste', 'maria@teste'),
(3, 'Alycson', 'Cr', 'teste', 'senha', 'teste@teste'),
(4, 'Gustavo', 'Pr', 'maria', 'teste', 'maria@teste');

--
-- Acionadores `tbUsuario`
--
DELIMITER $$
CREATE TRIGGER `delete_eventos` BEFORE DELETE ON `tbUsuario` FOR EACH ROW BEGIN
    DELETE FROM tbEventoParticipantes WHERE idParticipanteUsuario = OLD.idUsuario;
    DELETE FROM tbEvento WHERE idUsuario = OLD.idUsuario;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vwEventoDia`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vwEventoDia` (
`nomeEvento` varchar(50)
,`descricaoEvento` varchar(255)
,`ingresso` decimal(10,2)
,`dia` date
,`hora` time
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vwParticipanteEvento`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vwParticipanteEvento` (
`nome` varchar(50)
,`nomeEvento` varchar(50)
,`dia` date
,`DataInscricao` timestamp
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vwPromoveEvento`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vwPromoveEvento` (
`nome` varchar(50)
,`nomeEvento` varchar(50)
,`descricaoEvento` varchar(255)
,`dia` date
,`hora` time
,`vagas` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vwEventoDia`
--
DROP TABLE IF EXISTS `vwEventoDia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwEventoDia`  AS SELECT `te`.`nomeEvento` AS `nomeEvento`, `te`.`descricaoEvento` AS `descricaoEvento`, `te`.`ingresso` AS `ingresso`, `te`.`dia` AS `dia`, `te`.`hora` AS `hora` FROM `tbEvento` AS `te` ;

-- --------------------------------------------------------

--
-- Estrutura para view `vwParticipanteEvento`
--
DROP TABLE IF EXISTS `vwParticipanteEvento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwParticipanteEvento`  AS SELECT `us`.`nome` AS `nome`, `tE`.`nomeEvento` AS `nomeEvento`, `tE`.`dia` AS `dia`, `ep`.`DataInscricao` AS `DataInscricao` FROM ((`tbEventoParticipantes` `ep` join `tbEvento` `tE` on(`ep`.`idEvento` = `tE`.`idEvento`)) join `tbUsuario` `us` on(`ep`.`idParticipanteUsuario` = `us`.`idUsuario`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vwPromoveEvento`
--
DROP TABLE IF EXISTS `vwPromoveEvento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwPromoveEvento`  AS SELECT `tU`.`nome` AS `nome`, `tE`.`nomeEvento` AS `nomeEvento`, `tE`.`descricaoEvento` AS `descricaoEvento`, `tE`.`dia` AS `dia`, `tE`.`hora` AS `hora`, `tE`.`vagas` AS `vagas` FROM (`tbEvento` `tE` join `tbUsuario` `tU` on(`tE`.`idUsuario` = `tU`.`idUsuario`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tbEvento`
--
ALTER TABLE `tbEvento`
  ADD PRIMARY KEY (`idEvento`),
  ADD KEY `fk_tbusuarioiduser` (`idUsuario`);

--
-- Índices de tabela `tbEventoParticipantes`
--
ALTER TABLE `tbEventoParticipantes`
  ADD PRIMARY KEY (`idEventoParticipante`),
  ADD KEY `Fk_idEvento` (`idEvento`),
  ADD KEY `Fk_idParticipanteUsuario` (`idParticipanteUsuario`);

--
-- Índices de tabela `tbUsuario`
--
ALTER TABLE `tbUsuario`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tbEvento`
--
ALTER TABLE `tbEvento`
  MODIFY `idEvento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tbEventoParticipantes`
--
ALTER TABLE `tbEventoParticipantes`
  MODIFY `idEventoParticipante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tbUsuario`
--
ALTER TABLE `tbUsuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tbEvento`
--
ALTER TABLE `tbEvento`
  ADD CONSTRAINT `fk_tbusuarioiduser` FOREIGN KEY (`idUsuario`) REFERENCES `tbUsuario` (`idUsuario`);

--
-- Restrições para tabelas `tbEventoParticipantes`
--
ALTER TABLE `tbEventoParticipantes`
  ADD CONSTRAINT `Fk_idEvento` FOREIGN KEY (`idEvento`) REFERENCES `tbEvento` (`idEvento`),
  ADD CONSTRAINT `Fk_idParticipanteUsuario` FOREIGN KEY (`idParticipanteUsuario`) REFERENCES `tbUsuario` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
