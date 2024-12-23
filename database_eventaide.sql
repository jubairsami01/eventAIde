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
-- Table structure for table `Chats`
--

DROP TABLE IF EXISTS `Chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Chats` (
  `chat_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `message` text NOT NULL,
  `sender` enum('user','llm') NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chats`
--

LOCK TABLES `Chats` WRITE;
/*!40000 ALTER TABLE `Chats` DISABLE KEYS */;
INSERT INTO `Chats` VALUES (1,5,1,'hello','user','2024-12-16 17:51:24'),(2,5,1,'hello','user','2024-12-16 17:55:12'),(3,5,1,'hello','user','2024-12-16 17:56:18'),(4,5,1,'hello','user','2024-12-16 17:57:39'),(5,5,1,'hii','user','2024-12-16 18:03:04'),(6,5,1,'How can I help you with the event planning?','llm','2024-12-16 18:03:07'),(7,5,1,'where is the event location?','user','2024-12-16 18:04:01'),(8,5,1,'The event will be held at Bracu, located at Merul Badda.','llm','2024-12-16 18:04:04'),(9,5,1,'total number of registrations in the event?','user','2024-12-16 18:13:17'),(10,5,1,'7','llm','2024-12-16 18:13:20'),(11,5,1,'who updated the event last?','user','2024-12-16 18:23:25'),(12,5,1,'sami','llm','2024-12-16 18:23:28'),(13,5,1,'how many sessions are there?','user','2024-12-16 18:27:31'),(14,5,1,'5','llm','2024-12-16 18:27:34'),(15,5,1,'how many seats left for photo session?','user','2024-12-16 18:28:51'),(16,5,1,'There are 98 seats left for the photo session. The photo session will be held on December 17, 2024 from 2:43 PM to 5:43 PM at Bracu, Merul Badda. The capacity for the photo session is 100 and there are currently 2 people registered.','llm','2024-12-16 18:28:54'),(17,5,1,'when will be movie screening take place?','user','2024-12-16 18:31:07'),(18,5,1,'The movie screening will take place on December 11, 2024 from 12:43 PM to 12:43 PM at the event venue, Bracu.','llm','2024-12-16 18:31:10'),(19,2,14,'where is the event location?','user','2024-12-16 18:47:24'),(20,2,14,'The event will be held at Bracu, Merul Badda.','llm','2024-12-16 18:47:27'),(21,2,1,'hello, how many sessions will be in the event?','user','2024-12-17 03:08:20'),(22,2,1,'There will be **5** sessions in the event.','llm','2024-12-17 03:08:40'),(23,2,1,'event taa kothay hobey?','user','2024-12-17 03:23:46'),(24,2,1,'**Assistant:** The event will be held at Bracu, Merul Badda.','llm','2024-12-17 03:23:48'),(25,3,16,'describe the event in short','user','2024-12-17 03:35:16'),(26,3,16,'The \"programming contest fall 24\" event will be held at Bracu on December 20, 2024, from 9:25 AM to 12:25 PM. The event aims to inspire future coders and will feature three sessions: an inauguration ceremony, a programming contest, and a prize-giving ceremony. The contest will take place on the 9th floor, and the prize-giving ceremony will be held in the Bracu auditorium.','llm','2024-12-17 03:35:20'),(27,3,16,'what is the exact location of the contest?','user','2024-12-17 03:35:54'),(28,3,16,'The contest will take place on the 9th floor of Bracu.','llm','2024-12-17 03:35:57'),(29,3,16,'will there be any foods?','user','2024-12-17 03:36:14'),(30,3,16,'This question cannot be answered from the given source.','llm','2024-12-17 03:36:17'),(31,3,16,'in which lab the programming contest will take place?','user','2024-12-17 03:37:04'),(32,3,16,'This question cannot be answered from the given source.','llm','2024-12-17 03:37:07'),(33,2,16,'what is the exact location of the event?','user','2024-12-17 03:38:41'),(34,2,16,'The event will be held at the 9th floor of Bracu, Merul Badda.','llm','2024-12-17 03:38:44'),(35,2,16,'what is the contest classroom?','user','2024-12-17 03:39:03'),(36,2,16,'The contest will take place at the 9F-24L room.','llm','2024-12-17 03:39:06'),(37,2,1,'what is the registration charge for photo session?','user','2024-12-17 04:21:34'),(38,2,1,'The registration charge for the photo session is **free**.','llm','2024-12-17 04:21:37'),(39,2,16,'where will be the prize giving ceremony take place?','user','2024-12-17 05:45:09'),(40,2,16,'The prize giving ceremony will be held at the bracu auditorium.','llm','2024-12-17 05:45:12'),(41,2,16,'where will the inaguration ceremony take place?','user','2024-12-17 06:38:34'),(42,2,16,'The inaguration ceremony will take place at the 9th floor of Bracu, Merul Badda.','llm','2024-12-17 06:38:58'),(43,2,16,'how can i get benefitted from this event','user','2024-12-17 11:19:23'),(44,2,16,'This event is a great opportunity to network with other coders and learn from industry experts. You will also have the chance to compete in a programming contest and win prizes. Additionally, the event will feature a career fair where you can meet with potential employers and learn about job opportunities.','llm','2024-12-17 11:19:26'),(45,2,16,'will there be really a career fair? are you sure?','user','2024-12-17 11:23:00'),(46,2,16,'Yes, I am sure. The event will feature a career fair where you can meet with potential employers and learn about job opportunities.','llm','2024-12-17 11:23:03'),(47,2,11,'what are the co-ordinates of the venue location?','user','2024-12-17 11:24:43'),(48,2,11,'90.4244298633626,23.773089860903312','llm','2024-12-17 11:24:50'),(49,6,16,'hey what is the event all about','user','2024-12-19 03:45:01'),(50,6,16,'The event is a programming contest that will be held on December 20th, 2024 from 9:25 AM to 12:25 PM at Bracu. The contest will be 2 hours long and will be followed by a price giving ceremony. The event is open to all students and there is no registration fee. The contest will be held in the 9F-24L classroom or lab.','llm','2024-12-19 03:45:05'),(51,6,16,'hello','user','2024-12-19 03:45:33'),(52,6,16,'**Assistant:** Hello there! How can I assist you today?','llm','2024-12-19 03:45:36'),(53,6,16,'which programming language can i use','user','2024-12-19 03:45:58'),(54,6,16,'I\'m sorry, but I cannot find the answer to your question in the provided context.','llm','2024-12-19 03:46:00'),(55,5,16,'what is the event all about?','user','2024-12-19 04:51:51'),(56,5,16,'The event is named \"programming contest fall 24\". It will be held on December 20, 2024, from 9:25 AM to 12:25 PM at Bracu. The event is about to inspire future coders. The venue is located at Merul Badda. The event has 3 sessions: inaguration ceremony, the contest, and price giving ceremony.','llm','2024-12-19 04:51:55'),(57,5,16,'in which floor the contest will take place?','user','2024-12-22 09:15:26'),(58,5,16,'The contest will take place at the 9th floor.','llm','2024-12-22 09:15:28'),(59,5,16,'tell me a joke','user','2024-12-22 09:15:53'),(60,5,16,'I am sorry, I am not supposed to generate responses that are not related to the event. Would you like to ask anything about the event?','llm','2024-12-22 09:15:56'),(61,5,18,'where the event will take place?','user','2024-12-23 09:11:53'),(62,5,18,'The event will take place at Bracu, Merul Badda. The match will take place at the ground floor hall.','llm','2024-12-23 09:11:56'),(63,5,18,'tell me a joke','user','2024-12-23 09:13:53'),(64,5,18,'I\'m sorry, I don\'t have any jokes for you at the moment. Would you like to know anything else about the event?','llm','2024-12-23 09:13:57');
/*!40000 ALTER TABLE `Chats` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CoHosts`
--

LOCK TABLES `CoHosts` WRITE;
/*!40000 ALTER TABLE `CoHosts` DISABLE KEYS */;
INSERT INTO `CoHosts` VALUES (4,1,3,'2024-12-03 14:23:42',2),(5,3,4,'2024-12-03 20:12:28',3),(6,3,2,'2024-12-03 20:12:37',3),(9,4,3,'2024-12-08 10:32:19',2),(10,5,3,'2024-12-10 19:12:40',2),(11,5,4,'2024-12-10 19:13:51',2),(12,14,2,'2024-12-16 09:08:47',5),(13,16,5,'2024-12-17 03:27:05',2),(14,16,3,'2024-12-17 03:27:49',2),(15,18,2,'2024-12-23 09:05:14',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event_Venue`
--

LOCK TABLES `Event_Venue` WRITE;
/*!40000 ALTER TABLE `Event_Venue` DISABLE KEYS */;
INSERT INTO `Event_Venue` VALUES (2,1,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn will be used as a sight seeing place\"}','2024-12-07 22:42:07','2024-12-07 22:54:23'),(4,3,3,'{\"jj\": \"kk\", \"ll\": \"kk\"}','2024-12-07 22:59:50','2024-12-07 22:59:50'),(6,4,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn 4\"}','2024-12-08 10:34:22','2024-12-08 10:34:48'),(7,5,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\"}','2024-12-10 19:13:57','2024-12-10 19:13:57'),(9,11,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn will be used as the formal dinner place\"}','2024-12-11 17:03:47','2024-12-11 17:04:23'),(10,14,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\"}','2024-12-16 09:09:08','2024-12-16 09:09:08'),(11,16,7,'{\"9F-24L\": \"Exact venue of the event, the contest will take place at this classroom or lab\", \"4th floor\": \"Department of Computer Science and Engineering (CSE)\", \"6th floor\": \"Cafeteria, where participants can grab a bite and socialize\", \"9th floor\": \"The contest will take place at this floor\", \"13th floor\": \"Rooftop lawn, a perfect spot for relaxation and networking during breaks\", \"Alumni Lounge\": \"A space for alumni to reconnect and share their experiences with current participants\", \"BRACU Auditorium\": \"The prize-giving ceremony will be held here, celebrating the winners and participants\", \"Multipurpose Hall\": \"A versatile space for workshops, guest lectures, and panel discussions related to the contest\", \"Ayesha Abed Library\": \"A quiet space for participants to study and prepare before the contest\", \"Rooftop Jogging Track\": \"A place for participants to unwind and get some exercise after a long day of coding\"}','2024-12-17 03:28:09','2024-12-22 07:35:17'),(13,18,7,'{\"4th floor\": \"department of cse\", \"6th floor\": \"cafeteria\", \"13th floor\": \"rooftop lawn\", \"match will take place\": \"ground floor hall\"}','2024-12-23 09:06:38','2024-12-23 09:07:44');
/*!40000 ALTER TABLE `Event_Venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventFeedbacks`
--

DROP TABLE IF EXISTS `EventFeedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EventFeedbacks` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_responded` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`feedback_id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `eventfeedbacks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `eventfeedbacks_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
  CONSTRAINT `eventfeedbacks_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventFeedbacks`
--

LOCK TABLES `EventFeedbacks` WRITE;
/*!40000 ALTER TABLE `EventFeedbacks` DISABLE KEYS */;
INSERT INTO `EventFeedbacks` VALUES (1,5,1,4,'hello','2024-12-23 18:53:25','2024-12-23 19:01:59',0),(2,5,18,2,'hello, how can i play?','2024-12-23 19:25:38','2024-12-23 20:21:03',1),(3,2,18,1,'hello maan. amazing!','2024-12-23 20:13:58','2024-12-23 20:13:58',0);
/*!40000 ALTER TABLE `EventFeedbacks` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES (1,'sample 1','sampl1 X 10',NULL,'2024-12-02 03:30:00','2024-12-28 10:51:00',2,'draft','public','2024-12-01 18:28:16','2024-12-08 09:03:35',2,NULL),(2,'hello','hello 123',NULL,'2024-12-20 00:07:00','2024-12-28 00:07:00',4,'draft','private','2024-12-03 18:19:12','2024-12-03 18:19:12',4,NULL),(3,'sample event','sample description',NULL,'2024-12-04 02:11:00','2024-12-04 04:11:00',3,'draft','public','2024-12-03 20:11:47','2024-12-10 15:24:42',3,NULL),(4,'sample 3','sample 3',NULL,'2024-12-25 16:31:00','2024-12-26 16:31:00',2,'ongoing','public','2024-12-08 10:31:55','2024-12-08 10:35:47',2,NULL),(5,'Club Fair','Club Fair in Bracu',NULL,'2025-01-05 09:00:00','2025-01-07 17:00:00',2,'draft','public','2024-12-10 19:07:50','2024-12-10 19:23:13',2,NULL),(10,'singing song','at the multipurpose hall with r',NULL,'2024-12-19 10:20:00','2024-12-19 14:20:00',2,'draft','private','2024-12-11 08:20:34','2024-12-11 08:20:34',2,NULL),(11,'book fair','at bracu',NULL,'2024-12-26 23:01:00','2024-12-27 23:01:00',2,'draft','public','2024-12-11 17:01:13','2024-12-11 17:06:52',2,NULL),(12,'spain','journey to spain',NULL,'2024-12-19 14:43:00','2024-12-20 14:43:00',5,'draft','private','2024-12-16 08:44:55','2024-12-16 08:44:55',5,NULL),(13,'spain2','spain journey 2',NULL,'2024-12-26 14:54:00','2024-12-27 14:54:00',5,'draft','private','2024-12-16 08:57:00','2024-12-16 08:57:00',5,'images/event_13_spain-madrid.png'),(14,'madrid','tour de madrid',NULL,'2024-12-18 15:02:00','2024-12-19 15:02:00',5,'draft','public','2024-12-16 09:02:26','2024-12-16 09:09:50',5,'images/event_14_banner.png'),(16,'programming contest fall 24','to inspire future coders',NULL,'2024-12-20 09:25:00','2024-12-20 12:25:00',2,'draft','public','2024-12-17 03:26:49','2024-12-17 03:34:40',2,'images/event_15_Programming-in-Computer-Science.jpg'),(17,'hackathon','it is a hackathon that will presented by X',NULL,'3002-12-12 23:11:00','3002-12-19 00:50:00',6,'draft','private','2024-12-19 03:47:40','2024-12-19 03:47:40',6,NULL),(18,'badminton','badminton match at bracu',NULL,'2024-12-25 15:04:00','2024-12-26 15:04:00',5,'draft','public','2024-12-23 09:04:51','2024-12-23 09:08:06',5,'images/event_18_spain-madrid.png');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registrations`
--

LOCK TABLES `Registrations` WRITE;
/*!40000 ALTER TABLE `Registrations` DISABLE KEYS */;
INSERT INTO `Registrations` VALUES (13,2,1,5,'pending','2024-12-10 17:37:10'),(17,3,1,5,'pending','2024-12-10 17:43:48'),(18,3,1,3,'pending','2024-12-10 17:49:29'),(21,2,5,10,'pending','2024-12-10 19:23:26'),(22,2,1,4,'pending','2024-12-11 08:17:53'),(24,2,3,1,'pending','2024-12-11 16:59:26'),(25,2,1,3,'pending','2024-12-15 09:13:34'),(26,2,1,6,'pending','2024-12-15 09:41:22'),(30,5,14,13,'pending','2024-12-16 15:07:40'),(31,5,1,6,'pending','2024-12-16 15:21:30'),(32,2,1,12,'pending','2024-12-17 03:10:48'),(33,2,16,17,'pending','2024-12-17 06:39:31'),(34,6,16,16,'pending','2024-12-19 03:44:13'),(35,5,16,16,'pending','2024-12-19 04:52:55'),(36,5,18,19,'pending','2024-12-23 09:08:26');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sessions`
--

LOCK TABLES `Sessions` WRITE;
/*!40000 ALTER TABLE `Sessions` DISABLE KEYS */;
INSERT INTO `Sessions` VALUES (1,3,NULL,'opening ceremony','opening ceremony','2024-12-08 15:24:00','2024-12-08 17:26:00',5000,'2024-12-08 06:22:11','2024-12-08 06:22:11',0.00),(3,1,NULL,'opening','opening','2024-12-10 12:41:00','2024-12-11 12:41:00',2,'2024-12-08 06:42:03','2024-12-08 06:42:03',0.00),(4,1,NULL,'performing','performing','2024-12-11 14:44:00','2024-12-13 02:44:00',2,'2024-12-08 06:42:44','2024-12-08 06:42:44',0.00),(5,1,NULL,'movie screening','movie screening','2024-12-11 12:43:00','2024-12-12 12:43:00',2,'2024-12-08 06:43:29','2024-12-08 06:43:29',0.00),(6,1,NULL,'photo session','photo session at the rooftop','2024-12-17 14:43:00','2024-12-17 17:43:00',100,'2024-12-08 08:43:56','2024-12-08 08:43:56',0.00),(7,4,NULL,'inaguration','samople','2024-12-25 16:35:00','2024-12-25 19:35:00',100,'2024-12-08 10:35:16','2024-12-08 10:35:16',0.00),(8,3,NULL,'dancing','in the hall by a group','2024-12-11 22:23:00','2024-12-10 23:23:00',500,'2024-12-10 15:23:46','2024-12-10 15:23:46',0.00),(9,3,NULL,'honululu','movie showing in big screen','2024-12-13 21:24:00','2024-12-14 21:24:00',80,'2024-12-10 15:24:34','2024-12-10 15:24:34',0.00),(10,5,NULL,'inaguration','inaguration ceremony','2025-01-05 09:10:00','2025-01-05 09:45:00',5000,'2024-12-10 19:15:01','2024-12-10 19:15:01',0.00),(11,11,NULL,'opening ceremony','for 5 mins','2024-12-26 23:05:00','2024-12-26 23:10:00',10,'2024-12-11 17:06:22','2024-12-11 17:06:22',0.00),(12,1,NULL,'sample x','ddd','2024-12-14 16:19:00','2024-12-27 16:19:00',40,'2024-12-15 10:19:57','2024-12-15 10:19:57',0.00),(13,14,NULL,'inaguration','inaguration - 500 ','2024-12-19 15:09:00','2024-12-20 15:09:00',1000,'2024-12-16 09:09:45','2024-12-16 13:04:50',100.00),(15,14,NULL,'lulu','lulululu','2024-12-20 19:10:00','2024-12-21 19:10:00',400,'2024-12-16 13:10:33','2024-12-16 13:10:33',40.00),(16,16,NULL,'inaguration ceremony','it will include speeches from the guests','2024-12-20 09:30:00','2024-12-20 09:40:00',100,'2024-12-17 03:30:54','2024-12-17 03:30:54',0.00),(17,16,NULL,'the contest','2 hours long programming contest','2024-12-20 09:45:00','2024-12-20 11:45:00',100,'2024-12-17 03:31:58','2024-12-17 03:31:58',50.00),(18,16,NULL,'price giving ceremony','will be conducted by bracu officials','2024-12-20 12:00:00','2024-12-17 13:30:00',150,'2024-12-17 03:34:26','2024-12-17 03:34:26',0.00),(19,18,NULL,'initial ceremony','it will be conducted for 30 mins','2024-12-24 15:07:00','2024-12-25 15:07:00',20,'2024-12-23 09:07:13','2024-12-23 09:07:13',100.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
INSERT INTO `Transactions` VALUES (4,30,14,13,'bkash','djflkdjkllfksk',100.00,'pending','2024-12-16 15:07:41','2024-12-16 15:07:41'),(5,31,1,6,'bkash','lsjflksdfl',0.00,'pending','2024-12-16 15:21:30','2024-12-16 15:21:30'),(6,32,1,12,'bkash','sjflkjfjdskljf',0.00,'pending','2024-12-17 03:10:48','2024-12-17 03:10:48'),(7,33,16,17,'bkash','kfjlsdfkslfjsjklfjsdklfj',50.00,'pending','2024-12-17 06:39:31','2024-12-17 06:39:31'),(8,34,16,16,'bkash','123',0.00,'pending','2024-12-19 03:44:13','2024-12-19 03:44:13'),(9,35,16,16,'bkash','hjgjhggk',0.00,'pending','2024-12-19 04:52:55','2024-12-19 04:52:55'),(10,36,18,19,'bkash','dksfsdjfhjsf',100.00,'pending','2024-12-23 09:08:26','2024-12-23 09:08:26');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'juju','jubair@juju.com','scrypt:32768:8:1$qKsxj7dStAnSHyT0$2d404fcfbbfd1a99986cf708b60e292f8c425045f282000b22ef1260d474c053154b3cf9ed3d560ec7869bf95d1a84ce52d21d347db01165b6aff13306a8d6c0','customer',0,'2024-12-01 15:12:42'),(2,'sami','sami@gmail.com','scrypt:32768:8:1$zUF9fyCaGLT41giK$955662877bc6574009a3755b5e6fd71e4c62b9ecfc92d50146e9d0f2f05d2aa89a03dd71bf633d50ef8f8e856cb01c4d69e4b15b51e978f9b471b80a0d2d57af','both',0,'2024-12-01 15:36:02'),(3,'sami1','sami1@gmail.com','scrypt:32768:8:1$XLU6uoXWnzOtDusN$a23a810521c6cc0f0f0f585ce6f9e240ff03d4dad018b6aa0fc03812cabde0343bb4541c5a2a45bf27f1d9223eec8797e1715ff8fc5441099ba883c29d627241','both',0,'2024-12-03 13:51:10'),(4,'sami2','sami2@gmail.com','scrypt:32768:8:1$MrMZ4YCppzqhwAHa$b3285fbc93da93c87d4659d7c91f68760cc5932486218214305d681c7acaab0fe193163a072e6eb8fc08bbf2e38e7eacbbff6a20f8a1f8ff32b01be2eea48e84','both',0,'2024-12-03 18:06:43'),(5,'sami55','sami55@gmail.com','scrypt:32768:8:1$RCa4PsDlmAgrBkUt$a7d25fbe8cffe715db024e398be68fdb05b470b944be1b2703e2c62fd81d64d47d875cce0e5932c1a4280a2b0ec82984e71e559d913e5b8058bbb2066522f3d2','both',0,'2024-12-16 08:11:59'),(6,'rehan ','rehan@gmail.com','scrypt:32768:8:1$pwtqwkqQqzSMGaIR$19a039d525a3f4d35ecc47be65a966bdd1beae22b8ff87544c7bd22df070e1884de5934cbc3f748e05fd98f38c213b8ffa9b75082c0b5c6e125e5a8cfca346e3','both',0,'2024-12-19 03:43:27');
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

-- Dump completed on 2024-12-24  2:26:16
