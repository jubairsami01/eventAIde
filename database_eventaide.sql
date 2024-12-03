-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: eventaide_db
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.20.04.1

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
-- Table structure for table `Analytics`
--

DROP TABLE IF EXISTS `Analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Analytics` (
  `analytics_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `metric` varchar(255) NOT NULL,
  `value` float DEFAULT NULL,
  `recorded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`analytics_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Analytics_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Analytics`
--

LOCK TABLES `Analytics` WRITE;
/*!40000 ALTER TABLE `Analytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `Analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CoHosts`
--

DROP TABLE IF EXISTS `CoHosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CoHosts` (
  `cohost_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`cohost_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_added_by` (`added_by`),
  CONSTRAINT `CoHosts_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `CoHosts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `fk_added_by` FOREIGN KEY (`added_by`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CoHosts`
--

LOCK TABLES `CoHosts` WRITE;
/*!40000 ALTER TABLE `CoHosts` DISABLE KEYS */;
INSERT INTO `CoHosts` VALUES (4,1,3,'2024-12-03 14:23:42',2);
/*!40000 ALTER TABLE `CoHosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event_Venue`
--

DROP TABLE IF EXISTS `Event_Venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Event_Venue` (
  `event_venue_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `venue_id` int NOT NULL,
  `customized_details` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_venue_id`),
  KEY `event_id` (`event_id`),
  KEY `venue_id` (`venue_id`),
  CONSTRAINT `Event_Venue_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `Event_Venue_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `Venues` (`venue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event_Venue`
--

LOCK TABLES `Event_Venue` WRITE;
/*!40000 ALTER TABLE `Event_Venue` DISABLE KEYS */;
/*!40000 ALTER TABLE `Event_Venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `venue` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created_by` int NOT NULL,
  `status` enum('draft','ongoing','completed') NOT NULL DEFAULT 'draft',
  `visibility` enum('public','private') NOT NULL DEFAULT 'private',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_updated_by` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `created_by` (`created_by`),
  KEY `fk_last_updated_by` (`last_updated_by`),
  CONSTRAINT `Events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `fk_last_updated_by` FOREIGN KEY (`last_updated_by`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES (1,'lululululu','playing lulu X 10',NULL,'2024-12-02 03:30:00','2024-12-02 10:51:00',2,'draft','private','2024-12-01 18:28:16','2024-12-03 10:37:42',2);
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `Notifications_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notifications`
--

LOCK TABLES `Notifications` WRITE;
/*!40000 ALTER TABLE `Notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registrations`
--

DROP TABLE IF EXISTS `Registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registrations` (
  `registration_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `session_id` int DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`registration_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `Registrations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `Registrations_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `Registrations_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `Sessions` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registrations`
--

LOCK TABLES `Registrations` WRITE;
/*!40000 ALTER TABLE `Registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sessions`
--

DROP TABLE IF EXISTS `Sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sessions` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `event_venue_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `capacity` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`session_id`),
  KEY `event_id` (`event_id`),
  KEY `event_venue_id` (`event_venue_id`),
  CONSTRAINT `Sessions_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `Sessions_ibfk_2` FOREIGN KEY (`event_venue_id`) REFERENCES `Event_Venue` (`event_venue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sessions`
--

LOCK TABLES `Sessions` WRITE;
/*!40000 ALTER TABLE `Sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Social_Media_Shares`
--

DROP TABLE IF EXISTS `Social_Media_Shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Social_Media_Shares` (
  `share_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `event_id` int NOT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `action` enum('shared','copied') NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`share_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `Social_Media_Shares_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `Social_Media_Shares_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Social_Media_Shares`
--

LOCK TABLES `Social_Media_Shares` WRITE;
/*!40000 ALTER TABLE `Social_Media_Shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `Social_Media_Shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('host','customer','both') NOT NULL DEFAULT 'customer',
  `is_verified` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'juju','jubair@juju.com','scrypt:32768:8:1$qKsxj7dStAnSHyT0$2d404fcfbbfd1a99986cf708b60e292f8c425045f282000b22ef1260d474c053154b3cf9ed3d560ec7869bf95d1a84ce52d21d347db01165b6aff13306a8d6c0','customer',0,'2024-12-01 15:12:42'),(2,'sami','sami@gmail.com','scrypt:32768:8:1$zUF9fyCaGLT41giK$955662877bc6574009a3755b5e6fd71e4c62b9ecfc92d50146e9d0f2f05d2aa89a03dd71bf633d50ef8f8e856cb01c4d69e4b15b51e978f9b471b80a0d2d57af','customer',0,'2024-12-01 15:36:02'),(3,'sami1','sami1@gmail.com','scrypt:32768:8:1$XLU6uoXWnzOtDusN$a23a810521c6cc0f0f0f585ce6f9e240ff03d4dad018b6aa0fc03812cabde0343bb4541c5a2a45bf27f1d9223eec8797e1715ff8fc5441099ba883c29d627241','customer',0,'2024-12-03 13:51:10');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Venues`
--

DROP TABLE IF EXISTS `Venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venues` (
  `venue_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `details_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location_data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`venue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venues`
--

LOCK TABLES `Venues` WRITE;
/*!40000 ALTER TABLE `Venues` DISABLE KEYS */;
/*!40000 ALTER TABLE `Venues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testsample`
--

DROP TABLE IF EXISTS `testsample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testsample` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testsample`
--

LOCK TABLES `testsample` WRITE;
/*!40000 ALTER TABLE `testsample` DISABLE KEYS */;
INSERT INTO `testsample` VALUES (1,'Philip Vasquez','kimoscar@example.com'),(2,'Linda Ellis','aromero@example.com'),(3,'Jared Jones','mrodriguez@example.org'),(4,'Christopher Hill','afranklin@example.com'),(5,'Patrick Gregory','mossrobert@example.net'),(6,'Jessica Archer','rodriguezjesse@example.org'),(7,'Shawn Nunez','elizabeth28@example.com'),(8,'Cathy Poole','austiningram@example.org'),(9,'Aaron Reid','simmonskevin@example.org'),(10,'Regina Holloway','mason51@example.net');
/*!40000 ALTER TABLE `testsample` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-03 15:05:56
