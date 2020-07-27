-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: the_wild_orchestra
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `CITY`
--

DROP TABLE IF EXISTS `CITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CITY` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CITY`
--

LOCK TABLES `CITY` WRITE;
/*!40000 ALTER TABLE `CITY` DISABLE KEYS */;
INSERT INTO `CITY` VALUES (1,'Paris'),(2,'Strasbourg'),(3,'Orléans'),(4,'Rennes');
/*!40000 ALTER TABLE `CITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONCERT`
--

DROP TABLE IF EXISTS `CONCERT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONCERT` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `id_location` int NOT NULL,
  `id_project` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CONCERT_id_location` (`id_location`),
  KEY `fk_CONCERT_id_project` (`id_project`),
  CONSTRAINT `fk_CONCERT_id_location` FOREIGN KEY (`id_location`) REFERENCES `LOCATION` (`id`),
  CONSTRAINT `fk_CONCERT_id_project` FOREIGN KEY (`id_project`) REFERENCES `PROJECT` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONCERT`
--

LOCK TABLES `CONCERT` WRITE;
/*!40000 ALTER TABLE `CONCERT` DISABLE KEYS */;
INSERT INTO `CONCERT` VALUES (1,'2020-09-04','20:30:00',1,1),(2,'2020-09-16','20:30:00',2,2),(3,'2020-09-23','20:30:00',3,2),(4,'2020-10-10','20:30:00',5,1),(5,'2020-10-16','20:30:00',2,3),(6,'2020-10-31','15:00:00',4,1),(10,'2020-12-10','15:00:00',3,1);
/*!40000 ALTER TABLE `CONCERT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INSTRUMENT`
--

DROP TABLE IF EXISTS `INSTRUMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INSTRUMENT` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instrument` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INSTRUMENT`
--

LOCK TABLES `INSTRUMENT` WRITE;
/*!40000 ALTER TABLE `INSTRUMENT` DISABLE KEYS */;
INSERT INTO `INSTRUMENT` VALUES (1,'violon'),(2,'alto'),(3,'violoncelle'),(4,'piano'),(5,'clarinette'),(6,'flûte');
/*!40000 ALTER TABLE `INSTRUMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOCATION`
--

DROP TABLE IF EXISTS `LOCATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOCATION` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_city` int NOT NULL,
  `concert_hall` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_LOCATION_id_city` (`id_city`),
  CONSTRAINT `fk_LOCATION_id_city` FOREIGN KEY (`id_city`) REFERENCES `CITY` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCATION`
--

LOCK TABLES `LOCATION` WRITE;
/*!40000 ALTER TABLE `LOCATION` DISABLE KEYS */;
INSERT INTO `LOCATION` VALUES (1,1,'La Scala'),(2,1,'Philharmonie de Paris'),(3,2,'Cité de la musique et de la danse'),(4,3,'Théâtre d\'Orléans'),(5,4,'Le Triangle');
/*!40000 ALTER TABLE `LOCATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MUSICIAN`
--

DROP TABLE IF EXISTS `MUSICIAN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MUSICIAN` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(60) NOT NULL,
  `lastname` varchar(60) NOT NULL,
  `id_instrument` int NOT NULL,
  `photo` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_MUSICIAN_id_instrument` (`id_instrument`),
  CONSTRAINT `fk_MUSICIAN_id_instrument` FOREIGN KEY (`id_instrument`) REFERENCES `INSTRUMENT` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MUSICIAN`
--

LOCK TABLES `MUSICIAN` WRITE;
/*!40000 ALTER TABLE `MUSICIAN` DISABLE KEYS */;
INSERT INTO `MUSICIAN` VALUES (1,'Patricia','Beauchamp',1,'solo-violinist-619154_1920.jpg'),(2,'Aurore','Babin',1,'girl-3961381_1920.jpg'),(3,'Victor','Gervais',2,'violinist-407185_1920.jpg'),(4,'Serge','Moreau',3,'cello-521172_1920.jpg'),(5,'Joanna','Lagacé',6,'flautist-5029109_1920.jpg'),(6,'Pierre','Raymond',4,'piano-player-1589152_1920.jpg'),(7,'Gabriel','Berger',5,'clarinetist-786605_1920.jpg');
/*!40000 ALTER TABLE `MUSICIAN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROJECT`
--

DROP TABLE IF EXISTS `PROJECT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROJECT` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROJECT`
--

LOCK TABLES `PROJECT` WRITE;
/*!40000 ALTER TABLE `PROJECT` DISABLE KEYS */;
INSERT INTO `PROJECT` VALUES (1,'Wild Nuova'),(2,'Musica'),(3,'Space');
/*!40000 ALTER TABLE `PROJECT` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-27 10:57:56
