-- MySQL dump 10.13  Distrib 9.1.0, for macos14 (arm64)
--
-- Host: localhost    Database: eventaide_db
-- ------------------------------------------------------
-- Server version	9.1.0

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CoHosts`
--

LOCK TABLES `CoHosts` WRITE;
/*!40000 ALTER TABLE `CoHosts` DISABLE KEYS */;
INSERT INTO `CoHosts` VALUES (4,1,3,'2024-12-03 14:23:42',2),(5,3,4,'2024-12-03 20:12:28',3),(6,3,2,'2024-12-03 20:12:37',3),(9,4,3,'2024-12-08 10:32:19',2),(10,5,3,'2024-12-10 19:12:40',2),(11,5,4,'2024-12-10 19:13:51',2),(12,14,2,'2024-12-16 09:08:47',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event_Venue`
--

LOCK TABLES `Event_Venue` WRITE;
/*!40000 ALTER TABLE `Event_Venue` DISABLE KEYS */;
INSERT INTO `Event_Venue` VALUES (2,1,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn will be used as a sight seeing place\"}','2024-12-07 22:42:07','2024-12-07 22:54:23'),(4,3,3,'{\"jj\": \"kk\", \"ll\": \"kk\"}','2024-12-07 22:59:50','2024-12-07 22:59:50'),(6,4,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn 4\"}','2024-12-08 10:34:22','2024-12-08 10:34:48'),(7,5,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\"}','2024-12-10 19:13:57','2024-12-10 19:13:57'),(9,11,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn will be used as the formal dinner place\"}','2024-12-11 17:03:47','2024-12-11 17:04:23'),(10,14,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\"}','2024-12-16 09:09:08','2024-12-16 09:09:08');
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
  `cover_photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `created_by` (`created_by`),
  KEY `fk_last_updated_by` (`last_updated_by`),
  CONSTRAINT `Events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `fk_last_updated_by` FOREIGN KEY (`last_updated_by`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES (1,'sample 1','sampl1 X 10',NULL,'2024-12-02 03:30:00','2024-12-28 10:51:00',2,'draft','public','2024-12-01 18:28:16','2024-12-08 09:03:35',2,NULL),(2,'hello','hello 123',NULL,'2024-12-20 00:07:00','2024-12-28 00:07:00',4,'draft','private','2024-12-03 18:19:12','2024-12-03 18:19:12',4,NULL),(3,'sample event','sample description',NULL,'2024-12-04 02:11:00','2024-12-04 04:11:00',3,'draft','public','2024-12-03 20:11:47','2024-12-10 15:24:42',3,NULL),(4,'sample 3','sample 3',NULL,'2024-12-25 16:31:00','2024-12-26 16:31:00',2,'ongoing','public','2024-12-08 10:31:55','2024-12-08 10:35:47',2,NULL),(5,'Club Fair','Club Fair in Bracu',NULL,'2025-01-05 09:00:00','2025-01-07 17:00:00',2,'draft','public','2024-12-10 19:07:50','2024-12-10 19:23:13',2,NULL),(10,'singing song','at the multipurpose hall with r',NULL,'2024-12-19 10:20:00','2024-12-19 14:20:00',2,'draft','private','2024-12-11 08:20:34','2024-12-11 08:20:34',2,NULL),(11,'book fair','at bracu',NULL,'2024-12-26 23:01:00','2024-12-27 23:01:00',2,'draft','public','2024-12-11 17:01:13','2024-12-11 17:06:52',2,NULL),(12,'spain','journey to spain',NULL,'2024-12-19 14:43:00','2024-12-20 14:43:00',5,'draft','private','2024-12-16 08:44:55','2024-12-16 08:44:55',5,NULL),(13,'spain2','spain journey 2',NULL,'2024-12-26 14:54:00','2024-12-27 14:54:00',5,'draft','private','2024-12-16 08:57:00','2024-12-16 08:57:00',5,'images/event_13_spain-madrid.png'),(14,'madrid','tour de madrid',NULL,'2024-12-18 15:02:00','2024-12-19 15:02:00',5,'draft','public','2024-12-16 09:02:26','2024-12-16 09:09:50',5,'images/event_14_banner.png');
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
-- Table structure for table `Refunds`
--

DROP TABLE IF EXISTS `Refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Refunds` (
  `refund_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `payment_transaction_id` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `session_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','processed','failed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_registration_details` text,
  `deleted_transaction_details` text,
  PRIMARY KEY (`refund_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `refunds_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Refunds`
--

LOCK TABLES `Refunds` WRITE;
/*!40000 ALTER TABLE `Refunds` DISABLE KEYS */;
INSERT INTO `Refunds` VALUES (1,27,1,'sdfsfsdfsdf',5,14,13,0.00,'pending','2024-12-16 12:53:22','2024-12-16 12:53:22','{\'registration_id\': 27, \'user_id\': 5, \'event_id\': 14, \'session_id\': 13, \'status\': \'pending\', \'registered_at\': datetime.datetime(2024, 12, 16, 18, 7, 58)}','{\'transaction_id\': 1, \'registration_id\': 27, \'event_id\': 14, \'session_id\': 13, \'payment_method\': \'bkash\', \'payment_transaction_id\': \'sdfsfsdfsdf\', \'amount\': Decimal(\'0.00\'), \'status\': \'pending\', \'created_at\': datetime.datetime(2024, 12, 16, 18, 8, 37), \'updated_at\': datetime.datetime(2024, 12, 16, 18, 8, 37)}'),(2,28,2,'dfsfds',5,14,13,0.00,'pending','2024-12-16 12:54:34','2024-12-16 12:54:34','{\'registration_id\': 28, \'user_id\': 5, \'event_id\': 14, \'session_id\': 13, \'status\': \'pending\', \'registered_at\': datetime.datetime(2024, 12, 16, 18, 54, 16)}','{\'transaction_id\': 2, \'registration_id\': 28, \'event_id\': 14, \'session_id\': 13, \'payment_method\': \'bkash\', \'payment_transaction_id\': \'dfsfds\', \'amount\': Decimal(\'0.00\'), \'status\': \'pending\', \'created_at\': datetime.datetime(2024, 12, 16, 18, 54, 16), \'updated_at\': datetime.datetime(2024, 12, 16, 18, 54, 16)}'),(3,29,3,'sfdsdfd',5,14,13,0.00,'pending','2024-12-16 12:55:24','2024-12-16 12:55:24','{\'registration_id\': 29, \'user_id\': 5, \'event_id\': 14, \'session_id\': 13, \'status\': \'pending\', \'registered_at\': datetime.datetime(2024, 12, 16, 18, 54, 40)}','{\'transaction_id\': 3, \'registration_id\': 29, \'event_id\': 14, \'session_id\': 13, \'payment_method\': \'bkash\', \'payment_transaction_id\': \'sfdsdfd\', \'amount\': Decimal(\'0.00\'), \'status\': \'pending\', \'created_at\': datetime.datetime(2024, 12, 16, 18, 54, 40), \'updated_at\': datetime.datetime(2024, 12, 16, 18, 54, 40)}');
/*!40000 ALTER TABLE `Refunds` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registrations`
--

LOCK TABLES `Registrations` WRITE;
/*!40000 ALTER TABLE `Registrations` DISABLE KEYS */;
INSERT INTO `Registrations` VALUES (13,2,1,5,'pending','2024-12-10 17:37:10'),(17,3,1,5,'pending','2024-12-10 17:43:48'),(18,3,1,3,'pending','2024-12-10 17:49:29'),(21,2,5,10,'pending','2024-12-10 19:23:26'),(22,2,1,4,'pending','2024-12-11 08:17:53'),(24,2,3,1,'pending','2024-12-11 16:59:26'),(25,2,1,3,'pending','2024-12-15 09:13:34'),(26,2,1,6,'pending','2024-12-15 09:41:22');
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
  `event_venue_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `capacity` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `registration_fee` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`session_id`),
  KEY `event_id` (`event_id`),
  KEY `event_venue_id` (`event_venue_id`),
  CONSTRAINT `Sessions_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `Sessions_ibfk_2` FOREIGN KEY (`event_venue_id`) REFERENCES `Event_Venue` (`event_venue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sessions`
--

LOCK TABLES `Sessions` WRITE;
/*!40000 ALTER TABLE `Sessions` DISABLE KEYS */;
INSERT INTO `Sessions` VALUES (1,3,NULL,'opening ceremony','opening ceremony','2024-12-08 15:24:00','2024-12-08 17:26:00',5000,'2024-12-08 06:22:11','2024-12-08 06:22:11',0.00),(3,1,NULL,'opening','opening','2024-12-10 12:41:00','2024-12-11 12:41:00',2,'2024-12-08 06:42:03','2024-12-08 06:42:03',0.00),(4,1,NULL,'performing','performing','2024-12-11 14:44:00','2024-12-13 02:44:00',2,'2024-12-08 06:42:44','2024-12-08 06:42:44',0.00),(5,1,NULL,'movie screening','movie screening','2024-12-11 12:43:00','2024-12-12 12:43:00',2,'2024-12-08 06:43:29','2024-12-08 06:43:29',0.00),(6,1,NULL,'photo session','photo session at the rooftop','2024-12-17 14:43:00','2024-12-17 17:43:00',100,'2024-12-08 08:43:56','2024-12-08 08:43:56',0.00),(7,4,NULL,'inaguration','samople','2024-12-25 16:35:00','2024-12-25 19:35:00',100,'2024-12-08 10:35:16','2024-12-08 10:35:16',0.00),(8,3,NULL,'dancing','in the hall by a group','2024-12-11 22:23:00','2024-12-10 23:23:00',500,'2024-12-10 15:23:46','2024-12-10 15:23:46',0.00),(9,3,NULL,'honululu','movie showing in big screen','2024-12-13 21:24:00','2024-12-14 21:24:00',80,'2024-12-10 15:24:34','2024-12-10 15:24:34',0.00),(10,5,NULL,'inaguration','inaguration ceremony','2025-01-05 09:10:00','2025-01-05 09:45:00',5000,'2024-12-10 19:15:01','2024-12-10 19:15:01',0.00),(11,11,NULL,'opening ceremony','for 5 mins','2024-12-26 23:05:00','2024-12-26 23:10:00',10,'2024-12-11 17:06:22','2024-12-11 17:06:22',0.00),(12,1,NULL,'sample x','ddd','2024-12-14 16:19:00','2024-12-27 16:19:00',40,'2024-12-15 10:19:57','2024-12-15 10:19:57',0.00),(13,14,NULL,'inaguration','inaguration - 500 ','2024-12-19 15:09:00','2024-12-20 15:09:00',1000,'2024-12-16 09:09:45','2024-12-16 13:04:50',100.00),(15,14,NULL,'lulu','lulululu','2024-12-20 19:10:00','2024-12-21 19:10:00',400,'2024-12-16 13:10:33','2024-12-16 13:10:33',40.00);
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

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `registration_id` int NOT NULL,
  `event_id` int NOT NULL,
  `session_id` int NOT NULL,
  `payment_method` enum('bkash','nagad','card') NOT NULL,
  `payment_transaction_id` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','completed','failed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `registration_id` (`registration_id`),
  KEY `event_id` (`event_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `Registrations` (`registration_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `Sessions` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Transactions` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'juju','jubair@juju.com','scrypt:32768:8:1$qKsxj7dStAnSHyT0$2d404fcfbbfd1a99986cf708b60e292f8c425045f282000b22ef1260d474c053154b3cf9ed3d560ec7869bf95d1a84ce52d21d347db01165b6aff13306a8d6c0','customer',0,'2024-12-01 15:12:42'),(2,'sami','sami@gmail.com','scrypt:32768:8:1$zUF9fyCaGLT41giK$955662877bc6574009a3755b5e6fd71e4c62b9ecfc92d50146e9d0f2f05d2aa89a03dd71bf633d50ef8f8e856cb01c4d69e4b15b51e978f9b471b80a0d2d57af','both',0,'2024-12-01 15:36:02'),(3,'sami1','sami1@gmail.com','scrypt:32768:8:1$XLU6uoXWnzOtDusN$a23a810521c6cc0f0f0f585ce6f9e240ff03d4dad018b6aa0fc03812cabde0343bb4541c5a2a45bf27f1d9223eec8797e1715ff8fc5441099ba883c29d627241','both',0,'2024-12-03 13:51:10'),(4,'sami2','sami2@gmail.com','scrypt:32768:8:1$MrMZ4YCppzqhwAHa$b3285fbc93da93c87d4659d7c91f68760cc5932486218214305d681c7acaab0fe193163a072e6eb8fc08bbf2e38e7eacbbff6a20f8a1f8ff32b01be2eea48e84','both',0,'2024-12-03 18:06:43'),(5,'sami55','sami55@gmail.com','scrypt:32768:8:1$RCa4PsDlmAgrBkUt$a7d25fbe8cffe715db024e398be68fdb05b470b944be1b2703e2c62fd81d64d47d875cce0e5932c1a4280a2b0ec82984e71e559d913e5b8058bbb2066522f3d2','both',0,'2024-12-16 08:11:59');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venues`
--

LOCK TABLES `Venues` WRITE;
/*!40000 ALTER TABLE `Venues` DISABLE KEYS */;
INSERT INTO `Venues` VALUES (1,'aftabnagar gate','aftabnagar','{\"air\": \"bad\", \"color\": \"red\", \"green?\": \"no\"}','2024-12-07 19:52:08','2024-12-07 19:52:08',''),(2,'aftabnagar gate','aftabnagar','{\"air\": \"bad\", \"color\": \"red\", \"green?\": \"no\"}','2024-12-07 19:56:46','2024-12-07 19:56:46',''),(3,'hello12','helolo','{\"jj\": \"kk\", \"ll\": \"kk\"}','2024-12-07 20:10:30','2024-12-07 20:24:30','90.25583370623923,23.580060757229617'),(4,'hello','helolo','{\"jj\": \"kk\", \"ll\": \"kk\"}','2024-12-07 20:15:02','2024-12-07 20:15:02','90.25583370623923,23.580060757229617'),(5,'hello','helolo','{\"jj\": \"kk\", \"ll\": \"kk\"}','2024-12-07 20:15:05','2024-12-07 20:15:05','90.25583370623923,23.580060757229617'),(6,'burigonga2','buringoga','{\"water\": \"black\"}','2024-12-07 20:41:41','2024-12-07 20:42:36','90.47761416420127,23.667719531948876'),(7,'Bracu','Merul Badda','{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\"}','2024-12-07 20:44:36','2024-12-07 20:44:36','90.4244298633626,23.773089860903312');
/*!40000 ALTER TABLE `Venues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16 19:16:27
