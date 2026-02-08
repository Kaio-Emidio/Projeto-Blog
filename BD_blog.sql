CREATE DATABASE  IF NOT EXISTS `blog_terraria` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog_terraria`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: blog_terraria
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `ID_Autor` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Bio` text,
  `Senha_cripto` varchar(255) NOT NULL,
  `Data_Criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Autor`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `Nome_UNIQUE` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Kaio','kaioemidio.fe@gmail.com',NULL,'scrypt:32768:8:1$1P9Sn9xuo43117J8$15994b377673f9382fd1faff2fcae6001cef212b5b23cb47714e5f54c35d8b6dc9823ad154d00b746108ba978748adc13b399b250ebaef635692ed12339da60b','2026-02-07 19:21:40'),(2,'Emanuelle Alves','manu@gmail.com',NULL,'scrypt:32768:8:1$isWs9IWsccz0jqdr$b4face34998f88d22b986fa9c2ae573b884a665d8f495603e54c896c9a0997439c1e4a52d34e467dea6ed1c42d49398794bedd4d5d0a68b51b73431b68942f45','2026-02-08 01:28:27'),(3,'Alysson','alysson@gmail.com',NULL,'scrypt:32768:8:1$UGwBTLY3JXGIMAw7$544132040c0d7977e087b48ca65dee974a6448ff792af81d18ab11d2c191ca6e32c3913ed9be9cc16e1a4b3fb48c5684bb78b6adf5520fd32782b13a92f7e4b8','2026-02-08 01:29:28');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `ID_Categoria` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Descricao` text,
  PRIMARY KEY (`ID_Categoria`),
  UNIQUE KEY `Nome_UNIQUE` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Guias','Tutoriais para iniciantes e avançados'),(2,'Mods','Mods e expansões do jogo'),(3,'Construções','Projetos e ideias de construções'),(4,'Bosses','Estratégias para derrotar chefes'),(5,'Itens','Armas, armaduras e acessórios'),(6,'Exploração','Biomas, cavernas e mapas'),(7,'Multiplayer','Dicas para jogar em grupo'),(8,'Atualizações','Novidades e patches do jogo'),(9,'Fiação/Técnico','Mecânicas avançadas e automações'),(10,'Desafios','Runs especiais e desafios criativos');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `ID_Post` int NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(200) NOT NULL,
  `Slug` varchar(200) NOT NULL,
  `Conteudo` text NOT NULL,
  `ID_Categoria` int NOT NULL,
  `ID_Autor` int NOT NULL,
  `Data_Publicacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `Visualizacoes` int DEFAULT '0',
  `Status` enum('Rascunho','Publicado','Arquivado') DEFAULT 'Rascunho',
  PRIMARY KEY (`ID_Post`),
  UNIQUE KEY `Slug_UNIQUE` (`Slug`),
  KEY `fk_Categorias_idx` (`ID_Categoria`),
  KEY `fk_Autor_idx` (`ID_Autor`),
  KEY `idx_post_autor` (`ID_Autor`),
  KEY `idx_data` (`Data_Publicacao`),
  KEY `idx_categoria_data` (`ID_Categoria`,`Data_Publicacao`),
  FULLTEXT KEY `Titulo` (`Titulo`,`Conteudo`),
  CONSTRAINT `fk_Autor` FOREIGN KEY (`ID_Autor`) REFERENCES `autores` (`ID_Autor`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Categoria` FOREIGN KEY (`ID_Categoria`) REFERENCES `categorias` (`ID_Categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (9,'Guia Completo para Iniciantes em Terraria','guia-iniciantes-terraria','Este guia é perfeito para quem está começando em Terraria. Aprenda como coletar recursos, construir sua primeira casa, sobreviver às primeiras noites e se preparar para enfrentar seus primeiros chefes. Também explicamos progressão de equipamentos, biomas iniciais e como evoluir seu mundo com eficiência.',1,1,'2026-02-08 01:40:52',0,'Publicado'),(10,'Top 5 Mods Essenciais para Terraria','top-5-mods-terraria','Terraria se torna ainda melhor com mods! Neste post você vai conhecer os cinco mods mais populares da comunidade, incluindo melhorias de qualidade de vida, novos chefes, itens e sistemas completos que transformam a jogabilidade sem perder o espírito original do jogo.',2,2,'2026-02-08 01:40:52',0,'Publicado'),(11,'Como Construir uma Base Subterrânea Estilosa','base-subterranea-estilosa-terraria','Bases subterrâneas são práticas e seguras. Neste tutorial mostramos como organizar salas de NPCs, sistemas de armazenamento, decoração temática e proteção contra invasões, tudo mantendo um visual bonito e funcional.',3,3,'2026-02-08 01:40:52',0,'Publicado'),(12,'Como Derrotar o Olho de Cthulhu com Facilidade','derrotar-olho-de-cthulhu','O Olho de Cthulhu é um dos primeiros desafios de Terraria. Aqui você aprende a melhor arena, armas ideais, armaduras recomendadas e estratégias para vencer esse chefe rapidamente mesmo em dificuldades maiores.',4,1,'2026-02-08 01:40:52',0,'Publicado'),(13,'As Melhores Armas do Início ao Hardmode','melhores-armas-terraria','Descubra quais armas valem a pena usar desde o começo do jogo até o Hardmode. O artigo traz recomendações por classe (melee, ranged, magic e summoner) além de dicas de progressão e farm eficiente.',5,2,'2026-02-08 01:40:52',0,'Publicado'),(14,'Explorando a Selva e Suas Recompensas','explorando-selva-terraria','A Selva é um dos biomas mais perigosos de Terraria, mas também um dos mais valiosos. Neste post explicamos como explorá-la com segurança, quais inimigos esperar e quais itens raros você pode encontrar.',6,3,'2026-02-08 01:40:52',0,'Publicado'),(15,'Dicas para Jogar Terraria em Multiplayer','dicas-multiplayer-terraria','Jogar Terraria com amigos é muito mais divertido. Aqui você encontra dicas para dividir tarefas, construir bases cooperativas, enfrentar chefes em equipe e criar servidores estáveis para jogar online sem dor de cabeça.',7,1,'2026-02-08 01:40:52',0,'Publicado'),(16,'O Que Mudou na Última Atualização de Terraria','ultima-atualizacao-terraria','A nova atualização de Terraria trouxe mudanças importantes, novos itens, balanceamentos e melhorias visuais. Neste artigo você confere tudo que mudou e como isso impacta a jogabilidade.',8,2,'2026-02-08 01:40:52',0,'Publicado'),(17,'Automatizando Armadilhas com Fiação em Terraria','automacao-fiacao-terraria','Aprenda a usar fios, sensores e mecanismos para criar portas automáticas, armadilhas de farm e sistemas inteligentes dentro do seu mundo. Ideal para jogadores que gostam de engenharia dentro do jogo.',9,3,'2026-02-08 01:40:52',0,'Publicado'),(18,'Desafio Hardcore: Zerando Terraria Sem Morrer','desafio-hardcore-terraria','Neste desafio extremo, o jogador tenta concluir Terraria sem morrer nenhuma vez. O post traz estratégias, escolhas de equipamentos, rotas seguras e dicas para sobreviver ao máximo possível.',10,1,'2026-02-08 01:40:52',0,'Publicado');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-08  1:48:13
