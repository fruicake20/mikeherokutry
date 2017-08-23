-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: simple_cms_development
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hashed_password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'Maikeru','Agtual','fruitcake0020@gmail.com','21b19c7ba98639e275e131a67fe091a82acc24dc','2017-04-12 02:16:20','2017-04-17 09:34:41','mikemikeness','d590f1f0e0c78b7698182347dc6196fe40301293'),(3,'Rukia','Kuchiki','rukia.kuchiki@bleach.com','23a54cc9e75a8d6b2bbaecd36b1683ef68cc9932','2017-04-20 09:44:06','2017-04-20 09:44:06','rukiakuchiki','804fb6ce3c340481a469595327eb4da8767d924b');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users_pages`
--

DROP TABLE IF EXISTS `admin_users_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users_pages` (
  `admin_user_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  KEY `index_admin_users_pages_on_admin_user_id_and_page_id` (`admin_user_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users_pages`
--

LOCK TABLES `admin_users_pages` WRITE;
/*!40000 ALTER TABLE `admin_users_pages` DISABLE KEYS */;
INSERT INTO `admin_users_pages` VALUES (1,1);
/*!40000 ALTER TABLE `admin_users_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pages_on_subject_id` (`subject_id`),
  KEY `index_pages_on_permalink` (`permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,5,'Pangalawang pahina','first',2,1,'2017-04-12 01:55:39','2017-04-21 02:27:52'),(4,5,'wdaasd','asdasdas',3,1,'2017-04-21 01:58:17','2017-04-21 02:22:20'),(5,5,'Pinakaunang Pahina','asdasdasda',1,1,'2017-04-21 01:59:08','2017-04-21 02:27:38');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20170411065642'),('20170411065648'),('20170411065706'),('20170412010139'),('20170412010500'),('20170412013536'),('20170412020151'),('20170412022634'),('20170412024207'),('20170412025138'),('20170412030331'),('20170412044058');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_edits`
--

DROP TABLE IF EXISTS `section_edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_edits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_section_edits_on_admin_user_id_and_section_id` (`admin_user_id`,`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_edits`
--

LOCK TABLES `section_edits` WRITE;
/*!40000 ALTER TABLE `section_edits` DISABLE KEYS */;
INSERT INTO `section_edits` VALUES (1,1,1,'Test Edit','2017-04-12 04:59:39','2017-04-12 04:59:52'),(2,1,1,'wahahahahahaha','2017-04-12 05:00:51','2017-04-12 05:00:51'),(3,1,1,'nyahahahaha','2017-04-12 05:08:07','2017-04-12 05:08:07'),(4,1,1,'nyahahahahahehe','2017-04-12 05:08:45','2017-04-12 05:08:45'),(5,1,1,'^_^','2017-04-12 05:10:06','2017-04-12 05:10:06'),(6,1,1,'XD','2017-04-12 05:10:41','2017-04-12 05:10:41'),(7,1,1,'TECH OPS','2017-04-12 05:10:59','2017-04-12 05:10:59'),(8,1,1,'MAIKERUUUUUUUUUUUUUUUU','2017-04-12 05:11:16','2017-04-12 05:11:16'),(9,1,1,'HELLLLLLLLLLLLO','2017-04-12 05:11:40','2017-04-12 05:11:40'),(10,1,1,'ELLLOOOOOOOHHHHHHHHHH','2017-04-12 05:12:15','2017-04-12 05:12:15'),(11,1,1,'Room Shambles','2017-04-12 05:12:34','2017-04-12 05:12:34'),(12,1,1,'Radio Knife','2017-04-12 05:12:56','2017-04-12 05:12:56'),(13,1,1,'kyahhhhhhhhhhhhhhhhnessssssssssss','2017-04-12 05:14:47','2017-04-12 05:14:47'),(14,1,1,'YO YO HOHOHOHOHOHOHO','2017-04-12 05:15:14','2017-04-12 05:15:14'),(15,1,1,'gomu gomu nu gatling!!!!','2017-04-12 05:15:45','2017-04-12 05:15:45');
/*!40000 ALTER TABLE `section_edits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sections_on_page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,'Section One',1,1,'text','hello world!','2017-04-12 04:58:24','2017-04-21 01:41:51'),(2,5,'section 2',2,1,'text','about section 2','2017-04-21 02:24:17','2017-04-21 02:32:06'),(3,5,'section 1',1,1,'text','about section 1','2017-04-21 02:25:56','2017-04-21 02:32:06'),(4,5,'section 3',3,1,'HTML','<strong>About Section 3</strong>','2017-04-21 02:31:01','2017-04-21 02:32:06');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (5,'Halimbawa',1,1,'2017-04-17 01:32:00','2017-04-21 02:36:32'),(7,'qweqweq',2,1,'2017-04-21 02:22:00','2017-04-21 02:36:32');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpics`
--

DROP TABLE IF EXISTS `userpics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpics`
--

LOCK TABLES `userpics` WRITE;
/*!40000 ALTER TABLE `userpics` DISABLE KEYS */;
INSERT INTO `userpics` VALUES (1,1,NULL,'image/jpeg','ichigo.jpg',NULL,15478,267,200,'2017-04-20 03:06:19','2017-04-21 01:14:47'),(2,NULL,1,'image/jpeg','ichigo_thumbnail.jpg','thumbnail',3690,100,75,'2017-04-20 03:06:19','2017-04-21 01:14:47'),(9,3,NULL,'image/jpeg','index.jpeg',NULL,6313,153,200,'2017-04-20 09:44:06','2017-04-20 09:44:06'),(10,NULL,9,'image/jpeg','index_thumbnail.jpeg','thumbnail',2407,77,100,'2017-04-20 09:44:06','2017-04-20 09:44:06');
/*!40000 ALTER TABLE `userpics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-21 17:54:01
