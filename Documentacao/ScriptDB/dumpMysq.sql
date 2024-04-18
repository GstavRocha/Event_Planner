-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dbEvent
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbEvento`
--

DROP TABLE IF EXISTS `tbEvento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbEvento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `nomeEvento` varchar(50) NOT NULL,
  `descricaoEvento` varchar(150) NOT NULL,
  `ingresso` decimal(10,2) DEFAULT NULL,
  `endereco` varchar(150) NOT NULL,
  `vagas` int NOT NULL,
  `dia` date NOT NULL,
  `hora` time DEFAULT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_tbusuarioiduser` (`idUsuario`),
  CONSTRAINT `fk_tbusuarioiduser` FOREIGN KEY (`idUsuario`) REFERENCES `tbUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbEvento`
--

LOCK TABLES `tbEvento` WRITE;
/*!40000 ALTER TABLE `tbEvento` DISABLE KEYS */;
INSERT INTO `tbEvento` VALUES (1,'evento','modelode de evento',100.00,'rua do teste',100,'2024-04-17',NULL,1),(2,'evento teste','teste do evento',100.00,'rua do teste',10,'2024-04-17',NULL,1),(3,'evento teste','teste do evento',100.00,'rua do teste',10,'2024-04-17','19:30:10',1),(4,'evento teste23','teste do evento23',10.00,'rua do test',99,'2024-04-10','08:30:10',3),(5,'evento','mo',100.00,'rua do teste',100,'2024-04-25',NULL,1),(6,'festa','model de evento 4',10.00,'rua do teste',10,'2024-04-21',NULL,1),(7,'casa','model de evento 3',10.00,'rua do teste',8,'2024-04-22',NULL,1),(8,'casas','model de evento 3',10.00,'rua do teste',93,'2024-04-23',NULL,1);
/*!40000 ALTER TABLE `tbEvento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbEventoParticipantes`
--

DROP TABLE IF EXISTS `tbEventoParticipantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbEventoParticipantes` (
  `idEventoParticipante` int NOT NULL AUTO_INCREMENT,
  `idEvento` int NOT NULL,
  `idParticipanteUsuario` int DEFAULT NULL COMMENT 'retorna o idUsuario tabela Usuario enum Pr',
  `DataInscricao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEventoParticipante`),
  KEY `Fk_idEvento` (`idEvento`),
  KEY `Fk_idParticipanteUsuario` (`idParticipanteUsuario`),
  CONSTRAINT `Fk_idEvento` FOREIGN KEY (`idEvento`) REFERENCES `tbEvento` (`idEvento`),
  CONSTRAINT `Fk_idParticipanteUsuario` FOREIGN KEY (`idParticipanteUsuario`) REFERENCES `tbUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbEventoParticipantes`
--

LOCK TABLES `tbEventoParticipantes` WRITE;
/*!40000 ALTER TABLE `tbEventoParticipantes` DISABLE KEYS */;
INSERT INTO `tbEventoParticipantes` VALUES (2,4,3,'2024-04-17 23:17:46'),(3,8,5,'2024-04-18 15:25:19'),(4,8,6,'2024-04-18 15:25:20'),(5,8,7,'2024-04-18 15:25:22'),(6,8,12,'2024-04-18 15:25:23'),(7,8,15,'2024-04-18 15:25:24'),(8,8,16,'2024-04-18 15:25:25'),(9,8,17,'2024-04-18 15:25:26');
/*!40000 ALTER TABLE `tbEventoParticipantes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tgInsereParticiPante` AFTER INSERT ON `tbEventoParticipantes` FOR EACH ROW begin
        UPDATE tbEvento set vagas = vagas - 1
        where idEvento = NEW.idEvento;
        IF (SELECT vagas From tbEvento where idEvento = new.idEvento)< 0 then
            signal sqlstate '45000' set message_text = 'Palestra Lotada';
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deletaParticipante` AFTER DELETE ON `tbEventoParticipantes` FOR EACH ROW begin
        UPDATE tbEvento
            set vagas = vagas + 1
        where idEvento = OLD.idEvento;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbUsuario`
--

DROP TABLE IF EXISTS `tbUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbUsuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipoUsuario` enum('Cr','Pr') DEFAULT NULL COMMENT 'Cr - Cria o evento, Pr - Participa do evento',
  `login` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbUsuario`
--

LOCK TABLES `tbUsuario` WRITE;
/*!40000 ALTER TABLE `tbUsuario` DISABLE KEYS */;
INSERT INTO `tbUsuario` VALUES (1,'Joaoteste','Cr','teste','senha','teste@teste'),(2,'mariateste','Pr','maria','teste','maria@teste'),(3,'Joaoteste2','Cr','teste','senha','teste@teste'),(4,'João Silva','Cr','joao.silva','senha123','joao.silva@example.com'),(5,'Maria Oliveira','Pr','maria.oliveira','senha456','maria.oliveira@example.com'),(6,'Pedro Santos','Cr','pedro.santos','senha789','pedro.santos@example.com'),(7,'Ana Pereira','Pr','ana.pereira','senha321','ana.pereira@example.com'),(8,'Lucas Fernandes','Cr','lucas.fernandes','senha654','lucas.fernandes@example.com'),(9,'Carolina Almeida','Pr','carolina.almeida','senha987','carolina.almeida@example.com'),(10,'Gabriel Lima','Cr','gabriel.lima','senha1234','gabriel.lima@example.com'),(11,'Juliana Costa','Pr','juliana.costa','senha5678','juliana.costa@example.com'),(12,'Rafael Souza','Cr','rafael.souza','senha9012','rafael.souza@example.com'),(13,'Amanda Rocha','Pr','amanda.rocha','senha3456','amanda.rocha@example.com'),(14,'Mateus Santos','Cr','mateus.santos','senha7890','mateus.santos@example.com'),(15,'Isabela Silva','Pr','isabela.silva','senha12345','isabela.silva@example.com'),(16,'Diego Oliveira','Cr','diego.oliveira','senha67890','diego.oliveira@example.com'),(17,'Fernanda Costa','Pr','fernanda.costa','senha23456','fernanda.costa@example.com'),(18,'Vinícius Almeida','Cr','vinicius.almeida','senha78901','vinicius.almeida@example.com'),(19,'Carla Lima','Pr','carla.lima','senha23456','carla.lima@example.com'),(20,'Gustavo Pereira','Cr','gustavo.pereira','senha89012','gustavo.pereira@example.com'),(21,'Luana Oliveira','Pr','luana.oliveira','senha34567','luana.oliveira@example.com'),(22,'Bruno Santos','Cr','bruno.santos','senha89012','bruno.santos@example.com'),(23,'Mariana Lima','Pr','mariana.lima','senha45678','mariana.lima@example.com');
/*!40000 ALTER TABLE `tbUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vwEventoDia`
--

DROP TABLE IF EXISTS `vwEventoDia`;
/*!50001 DROP VIEW IF EXISTS `vwEventoDia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwEventoDia` AS SELECT 
 1 AS `nomeEvento`,
 1 AS `descricaoEvento`,
 1 AS `ingresso`,
 1 AS `dia`,
 1 AS `hora`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwParticipanteEvento`
--

DROP TABLE IF EXISTS `vwParticipanteEvento`;
/*!50001 DROP VIEW IF EXISTS `vwParticipanteEvento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwParticipanteEvento` AS SELECT 
 1 AS `nome`,
 1 AS `nomeEvento`,
 1 AS `dia`,
 1 AS `hora`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwPromoveEvento`
--

DROP TABLE IF EXISTS `vwPromoveEvento`;
/*!50001 DROP VIEW IF EXISTS `vwPromoveEvento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwPromoveEvento` AS SELECT 
 1 AS `nome`,
 1 AS `nomeEvento`,
 1 AS `descricaoEvento`,
 1 AS `dia`,
 1 AS `hora`,
 1 AS `vagas`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'dbEvent'
--
/*!50003 DROP PROCEDURE IF EXISTS `spCriaEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spCriaEvento`(in spNomeEvento VARCHAR(50),
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEventoDia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEventoDia`( in spDia DATE)
begin 
    SELECT * from vwEventoDia ve where ve.dia = spDia;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEventoPesquisaParticipante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEventoPesquisaParticipante`(in spNomeParticipante varchar(50))
begin
    select te.nomeEvento,te.dia, te.hora, tu.nome, tu.email,tp.DataInscricao from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where tu.nome like concat('%',spNomeParticipante,'%');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spInscricaoEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spInscricaoEvento`(in spIdEvento int, in spIdUsuario int)
begin
        INSERT INTO tbEventoParticipantes(idEvento, idParticipanteUsuario)
            values (spIdEvento,spIdUsuario);
        SELECT 'Inscrição feita com sucesso';
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spListaParticipantesEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListaParticipantesEvento`(in spNomeEvento varchar(50))
begin
    select te.nomeEvento,tu.nome, tu.email from tbEventoParticipantes tp
    inner join tbUsuario tu on tp.idParticipanteUsuario = tu.idUsuario
    inner join tbEvento te on tp.idEvento = te.idEvento where te.nomeEvento like concat('%',spNomeEvento,'%');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spPromoveEventos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spPromoveEventos`(in spNome varchar(50))
begin
    SELECT tU.nome, tE.nomeEvento,tE.descricaoEvento, tE.ingresso,tE.dia, tE.hora, tE.vagas  from tbEvento tE
        inner join tbUsuario tU on tE.idUsuario = tU.idUsuario where tU.nome like concat('%',spNome,'%');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vwEventoDia`
--

/*!50001 DROP VIEW IF EXISTS `vwEventoDia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwEventoDia` AS select `te`.`nomeEvento` AS `nomeEvento`,`te`.`descricaoEvento` AS `descricaoEvento`,`te`.`ingresso` AS `ingresso`,`te`.`dia` AS `dia`,`te`.`hora` AS `hora` from `tbEvento` `te` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwParticipanteEvento`
--

/*!50001 DROP VIEW IF EXISTS `vwParticipanteEvento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwParticipanteEvento` AS select `us`.`nome` AS `nome`,`tE`.`nomeEvento` AS `nomeEvento`,`tE`.`dia` AS `dia`,`tE`.`hora` AS `hora` from ((`tbEventoParticipantes` `ep` join `tbEvento` `tE` on((`ep`.`idEvento` = `tE`.`idEvento`))) join `tbUsuario` `us` on((`ep`.`idParticipanteUsuario` = `us`.`idUsuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwPromoveEvento`
--

/*!50001 DROP VIEW IF EXISTS `vwPromoveEvento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwPromoveEvento` AS select `tU`.`nome` AS `nome`,`tE`.`nomeEvento` AS `nomeEvento`,`tE`.`descricaoEvento` AS `descricaoEvento`,`tE`.`dia` AS `dia`,`tE`.`hora` AS `hora`,`tE`.`vagas` AS `vagas` from (`tbEvento` `tE` join `tbUsuario` `tU` on((`tE`.`idUsuario` = `tU`.`idUsuario`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18 12:49:48
