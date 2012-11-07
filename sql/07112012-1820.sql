-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: msk-in
-- ------------------------------------------------------
-- Server version	5.1.61

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
-- Table structure for table `b_admin_notify`
--

DROP TABLE IF EXISTS `b_admin_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_admin_notify` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MESSAGE` text COLLATE utf8_unicode_ci,
  `ENABLE_CLOSE` char(1) COLLATE utf8_unicode_ci DEFAULT 'Y',
  PRIMARY KEY (`ID`),
  KEY `IX_AD_TAG` (`TAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_admin_notify`
--

LOCK TABLES `b_admin_notify` WRITE;
/*!40000 ALTER TABLE `b_admin_notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_admin_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_agent`
--

DROP TABLE IF EXISTS `b_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_agent` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `NAME` text COLLATE utf8_unicode_ci,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `LAST_EXEC` datetime DEFAULT NULL,
  `NEXT_EXEC` datetime NOT NULL,
  `DATE_CHECK` datetime DEFAULT NULL,
  `AGENT_INTERVAL` int(18) DEFAULT '86400',
  `IS_PERIOD` char(1) COLLATE utf8_unicode_ci DEFAULT 'Y',
  `USER_ID` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_act_next_exec` (`ACTIVE`,`NEXT_EXEC`),
  KEY `ix_agent_user_id` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_agent`
--

LOCK TABLES `b_agent` WRITE;
/*!40000 ALTER TABLE `b_agent` DISABLE KEYS */;
INSERT INTO `b_agent` VALUES (1,'main',100,'CEvent::CleanUpAgent();','Y','2012-11-07 12:23:22','2012-11-08 00:00:00',NULL,86400,'Y',NULL),(2,'main',100,'CUser::CleanUpHitAuthAgent();','Y','2012-11-07 12:23:22','2012-11-08 00:00:00',NULL,86400,'Y',NULL),(3,'main',100,'CCaptchaAgent::DeleteOldCaptcha(3600);','Y','2012-11-07 18:21:47','2012-11-07 19:21:47',NULL,3600,'N',NULL),(4,'main',100,'CUndo::CleanUpOld();','Y','2012-11-07 12:23:22','2012-11-08 00:00:00',NULL,86400,'Y',NULL),(5,'search',10,'CSearchSuggest::CleanUpAgent();','Y','2012-11-07 12:46:22','2012-11-08 12:46:22',NULL,86400,'N',NULL),(6,'search',10,'CSearchStatistic::CleanUpAgent();','Y','2012-11-07 12:46:22','2012-11-08 12:46:22',NULL,86400,'N',NULL),(12,'main',100,'CEventLog::CleanUpAgent();','Y','2012-11-06 19:07:03','2012-11-07 19:07:03',NULL,86400,'N',NULL);
/*!40000 ALTER TABLE `b_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_cache_tag`
--

DROP TABLE IF EXISTS `b_cache_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_cache_tag` (
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CACHE_SALT` char(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RELATIVE_PATH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAG` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `ix_b_cache_tag_0` (`SITE_ID`,`CACHE_SALT`,`RELATIVE_PATH`(50)),
  KEY `ix_b_cache_tag_1` (`TAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_cache_tag`
--

LOCK TABLES `b_cache_tag` WRITE;
/*!40000 ALTER TABLE `b_cache_tag` DISABLE KEYS */;
INSERT INTO `b_cache_tag` VALUES (NULL,NULL,'0','**');
/*!40000 ALTER TABLE `b_cache_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_captcha`
--

DROP TABLE IF EXISTS `b_captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_captcha` (
  `ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `CODE` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `IP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_CREATE` datetime NOT NULL,
  UNIQUE KEY `UX_B_CAPTCHA` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_captcha`
--

LOCK TABLES `b_captcha` WRITE;
/*!40000 ALTER TABLE `b_captcha` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_captcha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_checklist`
--

DROP TABLE IF EXISTS `b_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_checklist` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_CREATE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TESTER` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMPANY_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PICTURE` int(11) DEFAULT NULL,
  `TOTAL` int(11) DEFAULT NULL,
  `SUCCESS` int(11) DEFAULT NULL,
  `FAILED` int(11) DEFAULT NULL,
  `PENDING` int(11) DEFAULT NULL,
  `SKIP` int(11) DEFAULT NULL,
  `STATE` longtext COLLATE utf8_unicode_ci,
  `REPORT_COMMENT` text COLLATE utf8_unicode_ci,
  `REPORT` char(1) COLLATE utf8_unicode_ci DEFAULT 'Y',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_checklist`
--

LOCK TABLES `b_checklist` WRITE;
/*!40000 ALTER TABLE `b_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_clouds_file_bucket`
--

DROP TABLE IF EXISTS `b_clouds_file_bucket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_clouds_file_bucket` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci DEFAULT 'Y',
  `SORT` int(11) DEFAULT '500',
  `READ_ONLY` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `SERVICE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BUCKET` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LOCATION` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CNAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FILE_COUNT` int(11) DEFAULT '0',
  `FILE_SIZE` float DEFAULT '0',
  `LAST_FILE_ID` int(11) DEFAULT NULL,
  `PREFIX` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SETTINGS` text COLLATE utf8_unicode_ci,
  `FILE_RULES` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_clouds_file_bucket`
--

LOCK TABLES `b_clouds_file_bucket` WRITE;
/*!40000 ALTER TABLE `b_clouds_file_bucket` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_clouds_file_bucket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_clouds_file_upload`
--

DROP TABLE IF EXISTS `b_clouds_file_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_clouds_file_upload` (
  `ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FILE_PATH` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `BUCKET_ID` int(11) NOT NULL,
  `PART_SIZE` int(11) NOT NULL,
  `PART_NO` int(11) NOT NULL,
  `PART_FAIL_COUNTER` int(11) NOT NULL,
  `NEXT_STEP` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_clouds_file_upload`
--

LOCK TABLES `b_clouds_file_upload` WRITE;
/*!40000 ALTER TABLE `b_clouds_file_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_clouds_file_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_event`
--

DROP TABLE IF EXISTS `b_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_event` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `EVENT_NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `MESSAGE_ID` int(18) DEFAULT NULL,
  `LID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `C_FIELDS` longtext COLLATE utf8_unicode_ci,
  `DATE_INSERT` datetime DEFAULT NULL,
  `DATE_EXEC` datetime DEFAULT NULL,
  `SUCCESS_EXEC` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `DUPLICATE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`ID`),
  KEY `ix_success` (`SUCCESS_EXEC`),
  KEY `ix_b_event_date_exec` (`DATE_EXEC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_event`
--

LOCK TABLES `b_event` WRITE;
/*!40000 ALTER TABLE `b_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_event_log`
--

DROP TABLE IF EXISTS `b_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_event_log` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SEVERITY` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `AUDIT_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ITEM_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `REMOTE_ADDR` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_AGENT` text COLLATE utf8_unicode_ci,
  `REQUEST_URI` text COLLATE utf8_unicode_ci,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_ID` int(18) DEFAULT NULL,
  `GUEST_ID` int(18) DEFAULT NULL,
  `DESCRIPTION` mediumtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  KEY `ix_b_event_log_time` (`TIMESTAMP_X`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_event_log`
--

LOCK TABLES `b_event_log` WRITE;
/*!40000 ALTER TABLE `b_event_log` DISABLE KEYS */;
INSERT INTO `b_event_log` VALUES (1,'2012-11-06 09:06:46','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:4:\"news\";}'),(2,'2012-11-06 09:06:56','UNKNOWN','FILE_EDIT','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_file_edit.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:14:\"news/index.php\";}'),(3,'2012-11-06 09:35:51','UNKNOWN','IBLOCK_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Новости\";}'),(4,'2012-11-06 09:37:43','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:1;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:72:\"Межзвездная матеpия как противостояние\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(5,'2012-11-06 09:38:13','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:2;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:83:\"Зенитное часовое число как Большая Медведица\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(6,'2012-11-06 09:38:42','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:3;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:73:\"Космический параметр: гипотеза и теории\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(7,'2012-11-06 09:39:06','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:4;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:79:\"Межпланетный Тукан: предпосылки и развитие\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(8,'2012-11-06 09:39:44','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:5;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:106:\"Непреложный космический мусор: методология и особенности\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(9,'2012-11-06 09:40:20','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:6;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:55:\"Экваториальный сарос в XXI веке\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(10,'2012-11-06 09:43:00','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:14:\"news/index.php\";}'),(11,'2012-11-06 09:49:03','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:14:\"news/index.php\";}'),(12,'2012-11-06 09:50:59','UNKNOWN','IBLOCK_SECTION_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_section_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:1;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:31:\"Новости компании\";s:12:\"SECTION_NAME\";s:12:\"Раздел\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(13,'2012-11-06 09:51:09','UNKNOWN','IBLOCK_SECTION_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_section_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:2;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:35:\"Российские новости\";s:12:\"SECTION_NAME\";s:12:\"Раздел\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(14,'2012-11-06 09:51:24','UNKNOWN','IBLOCK_SECTION_ADD','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_section_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:3;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:32:\"Фиг пойми новости\";s:12:\"SECTION_NAME\";s:12:\"Раздел\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(15,'2012-11-06 09:51:47','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:6;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:55:\"Экваториальный сарос в XXI веке\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(16,'2012-11-06 09:51:52','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:5;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:106:\"Непреложный космический мусор: методология и особенности\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(17,'2012-11-06 09:51:56','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:3;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:73:\"Космический параметр: гипотеза и теории\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(18,'2012-11-06 09:52:00','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:1;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:72:\"Межзвездная матеpия как противостояние\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(19,'2012-11-06 09:52:04','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:4;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:79:\"Межпланетный Тукан: предпосылки и развитие\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(20,'2012-11-06 09:52:09','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:2;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:83:\"Зенитное часовое число как Большая Медведица\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}'),(21,'2012-11-06 10:33:05','UNKNOWN','IBLOCK_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Новости\";}'),(22,'2012-11-06 10:53:03','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:12:\"features.php\";}'),(23,'2012-11-06 15:16:12','UNKNOWN','MENU_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_menu_edit.php?',NULL,1,NULL,'a:2:{s:9:\"menu_name\";N;s:4:\"path\";b:0;}'),(24,'2012-11-06 15:16:20','UNKNOWN','MENU_EDIT','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_menu_edit.php?',NULL,1,NULL,'a:2:{s:9:\"menu_name\";N;s:4:\"path\";b:0;}'),(25,'2012-11-06 15:21:01','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:5:\"about\";}'),(26,'2012-11-06 15:21:53','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:15:\"about/index.php\";}'),(27,'2012-11-06 15:24:44','UNKNOWN','MENU_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_menu_edit.php?',NULL,1,NULL,'a:2:{s:9:\"menu_name\";N;s:4:\"path\";s:5:\"about\";}'),(28,'2012-11-06 16:16:32','UNKNOWN','IBLOCK_ADD','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Ваканси\";}'),(29,'2012-11-06 16:16:42','UNKNOWN','IBLOCK_EDIT','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Ваканси\";}'),(30,'2012-11-06 16:17:35','UNKNOWN','IBLOCK_EDIT','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Ваканси\";}'),(31,'2012-11-06 16:17:50','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=2&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:7;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:28:\"Cтраховой агент\";s:12:\"ELEMENT_NAME\";s:16:\"Вакансия\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:12:\"/about/jobs/\";}'),(32,'2012-11-06 16:18:05','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=2&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:8;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:16:\"Менеджер\";s:12:\"ELEMENT_NAME\";s:16:\"Вакансия\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:12:\"/about/jobs/\";}'),(33,'2012-11-06 16:18:21','UNKNOWN','IBLOCK_EDIT','iblock','2','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:16:\"Вакансии\";}'),(34,'2012-11-06 16:18:38','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:10:\"about/jobs\";}'),(35,'2012-11-06 16:20:08','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:20:\"about/jobs/index.php\";}'),(36,'2012-11-06 16:36:30','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:8:\"contacts\";}'),(37,'2012-11-06 16:39:42','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:24:\"contacts/inc.address.php\";}'),(38,'2012-11-06 16:39:48','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:24:\"contacts/inc.address.php\";}'),(39,'2012-11-06 16:51:31','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:6:\"shares\";}'),(40,'2012-11-06 16:59:19','UNKNOWN','IBLOCK_ADD','iblock','3','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:10:\"Акции\";}'),(41,'2012-11-06 17:00:31','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','3','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=3&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:9;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:130:\"Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:10:\"Акция\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:8:\"/shares/\";}'),(42,'2012-11-06 17:00:42','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','3','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=3&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:10;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:130:\"Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:10:\"Акция\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:8:\"/shares/\";}'),(43,'2012-11-06 17:00:48','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','3','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=3&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:11;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:130:\"Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:10:\"Акция\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:8:\"/shares/\";}'),(44,'2012-11-06 17:02:32','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:16:\"shares/index.php\";}'),(45,'2012-11-06 17:23:17','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:8:\"partners\";}'),(46,'2012-11-06 17:25:36','UNKNOWN','IBLOCK_ADD','iblock','4','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:16:\"Партнеры\";}'),(47,'2012-11-06 17:27:11','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','4','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=4&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:12;s:4:\"CODE\";s:24:\"http://www.alfastrah.ru/\";s:4:\"NAME\";s:33:\"Альфа страхование\";s:12:\"ELEMENT_NAME\";s:16:\"Партнеры\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:10:\"/partners/\";}'),(48,'2012-11-06 17:27:29','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','4','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=4&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:12;s:4:\"CODE\";s:24:\"http://www.alfastrah.ru/\";s:4:\"NAME\";s:33:\"Альфа страхование\";s:12:\"ELEMENT_NAME\";s:16:\"Партнеры\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:10:\"/partners/\";}'),(49,'2012-11-06 17:28:10','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','4','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=4&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:13;s:4:\"CODE\";s:18:\"http://www.vsk.ru/\";s:4:\"NAME\";s:32:\"Страховой дом ВСК\";s:12:\"ELEMENT_NAME\";s:16:\"Партнеры\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:10:\"/partners/\";}'),(50,'2012-11-06 17:28:37','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','4','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=4&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:14;s:4:\"CODE\";s:21:\"http://www.vtbins.ru/\";s:4:\"NAME\";s:29:\"ВТБ Страхование\";s:12:\"ELEMENT_NAME\";s:16:\"Партнеры\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:10:\"/partners/\";}'),(51,'2012-11-06 17:28:57','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:18:\"partners/index.php\";}'),(52,'2012-11-06 17:49:14','UNKNOWN','IBLOCK_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:36:\"Заявки на страховку\";}'),(53,'2012-11-06 17:50:24','UNKNOWN','IBLOCK_EDIT','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:36:\"Заявки на страховку\";}'),(54,'2012-11-06 17:52:13','UNKNOWN','SECTION_ADD','fileman','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/fileman_newfolder.php?',NULL,1,NULL,'a:1:{s:4:\"path\";s:17:\"corporate-clients\";}'),(55,'2012-11-06 17:54:09','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:27:\"corporate-clients/index.php\";}'),(56,'2012-11-06 18:05:19','UNKNOWN','IBLOCK_EDIT','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:36:\"Заявки на страховку\";}'),(57,'2012-11-06 18:16:34','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/corporate-clients/','s1',1,NULL,'a:6:{s:2:\"ID\";i:15;s:4:\"CODE\";s:4:\"adfh\";s:4:\"NAME\";s:12:\"hadfh dfhadf\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(58,'2012-11-06 18:17:11','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/corporate-clients/?mes=ok','s1',1,NULL,'a:6:{s:2:\"ID\";i:16;s:4:\"CODE\";s:4:\"gjsf\";s:4:\"NAME\";s:9:\"sfgjg dfj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(59,'2012-11-06 18:18:06','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/corporate-clients/?mes=ok','s1',1,NULL,'a:6:{s:2:\"ID\";i:17;s:4:\"CODE\";s:6:\"rtjrtj\";s:4:\"NAME\";s:13:\"adfjadfj adfh\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(60,'2012-11-06 18:18:37','UNKNOWN','IBLOCK_ELEMENT_DELETE','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=5&type=content&lang=ru&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:17;s:4:\"CODE\";s:6:\"rtjrtj\";s:4:\"NAME\";s:13:\"adfjadfj adfh\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(61,'2012-11-06 18:18:37','UNKNOWN','IBLOCK_ELEMENT_DELETE','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=5&type=content&lang=ru&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:16;s:4:\"CODE\";s:4:\"gjsf\";s:4:\"NAME\";s:9:\"sfgjg dfj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(62,'2012-11-06 18:18:37','UNKNOWN','IBLOCK_ELEMENT_DELETE','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=5&type=content&lang=ru&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:15;s:4:\"CODE\";s:4:\"adfh\";s:4:\"NAME\";s:12:\"hadfh dfhadf\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(63,'2012-11-06 18:18:42','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/corporate-clients/?mes=ok','s1',1,NULL,'a:6:{s:2:\"ID\";i:18;s:4:\"CODE\";s:6:\"adfjad\";s:4:\"NAME\";s:12:\"fagdfh adfhj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(64,'2012-11-06 18:18:54','UNKNOWN','IBLOCK_ELEMENT_DELETE','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?IBLOCK_ID=5&type=content&lang=ru&find_section_section=0&action=delete&ID=E18',NULL,1,NULL,'a:6:{s:2:\"ID\";i:18;s:4:\"CODE\";s:6:\"adfjad\";s:4:\"NAME\";s:12:\"fagdfh adfhj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(65,'2012-11-06 18:23:58','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/?bitrix_include_areas=N','s1',1,NULL,'a:6:{s:2:\"ID\";i:19;s:4:\"CODE\";s:6:\"sfgksk\";s:4:\"NAME\";s:12:\"agjsfg fadfj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(66,'2012-11-06 18:24:22','UNKNOWN','IBLOCK_ELEMENT_DELETE','iblock','5','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?ID=E19&action=delete&lang=ru&&type=content&lang=ru&IBLOCK_ID=5&find_section_section=0&mode=list&table_id=tbl_iblock_list_dd5ef36e5a447af02ffc50723f333b15',NULL,1,NULL,'a:6:{s:2:\"ID\";i:19;s:4:\"CODE\";s:6:\"sfgksk\";s:4:\"NAME\";s:12:\"agjsfg fadfj\";s:12:\"ELEMENT_NAME\";s:12:\"Заявка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(67,'2012-11-07 12:18:07','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:9:\"index.php\";}'),(68,'2012-11-07 12:21:07','UNKNOWN','PAGE_EDIT','main','UNKNOWN','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/public_file_edit.php','s1',1,NULL,'a:1:{s:4:\"path\";s:9:\"index.php\";}'),(69,'2012-11-07 12:44:40','UNKNOWN','IBLOCK_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Баннеры\";}'),(70,'2012-11-07 12:45:22','UNKNOWN','IBLOCK_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_edit.php?type=content&lang=ru&admin=Y',NULL,1,NULL,'a:1:{s:4:\"NAME\";s:14:\"Баннеры\";}'),(71,'2012-11-07 12:46:09','UNKNOWN','IBLOCK_SECTION_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_section_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:4;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:31:\"Главная растяжка\";s:12:\"SECTION_NAME\";s:16:\"Площадка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(72,'2012-11-07 12:47:14','UNKNOWN','IBLOCK_SECTION_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_section_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=0',NULL,1,NULL,'a:6:{s:2:\"ID\";i:5;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:8:\"Фичи\";s:12:\"SECTION_NAME\";s:16:\"Площадка\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(73,'2012-11-07 13:00:46','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:82:\"с 10 по 20 мая ВСЕМ ДЕВУШКАМ КАСКО ДЕШЕВЛЕ НА 15 %\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(74,'2012-11-07 13:12:25','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(75,'2012-11-07 13:14:53','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(76,'2012-11-07 13:16:59','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:21;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(77,'2012-11-07 13:21:12','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:21;s:4:\"CODE\";s:12:\"http://ya.ru\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(78,'2012-11-07 13:21:21','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:13:\"http://rap.ru\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(79,'2012-11-07 13:26:36','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=4',NULL,1,NULL,'a:6:{s:2:\"ID\";i:21;s:4:\"CODE\";s:12:\"http://ya.ru\";s:4:\"NAME\";s:20:\"с 12 по 18 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(80,'2012-11-07 13:26:50','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?ID=E20&action=deactivate&lang=ru&&type=content&lang=ru&IBLOCK_ID=6&find_section_section=4&mode=list&table_id=tbl_iblock_list_46f8140327845967c617a49611b20c2c',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:13:\"http://rap.ru\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(81,'2012-11-07 13:27:07','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?ID=E20&action=activate&lang=ru&&type=content&lang=ru&IBLOCK_ID=6&find_section_section=4&mode=list&table_id=tbl_iblock_list_46f8140327845967c617a49611b20c2c',NULL,1,NULL,'a:6:{s:2:\"ID\";i:20;s:4:\"CODE\";s:13:\"http://rap.ru\";s:4:\"NAME\";s:20:\"с 10 по 20 мая\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(82,'2012-11-07 13:27:50','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:22;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:38:\"Карта клуба «Москва»\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(83,'2012-11-07 13:28:08','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:66:\"Только час — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(84,'2012-11-07 13:28:27','UNKNOWN','IBLOCK_ELEMENT_ADD','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:24;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:43:\"Служба поддержки 24 часа\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(85,'2012-11-07 13:28:36','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=6&type=content&lang=ru&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:24;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:43:\"Служба поддержки 24 часа\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(86,'2012-11-07 13:28:36','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=6&type=content&lang=ru&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:66:\"Только час — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(87,'2012-11-07 13:28:36','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_list_admin.php?mode=frame&IBLOCK_ID=6&type=content&lang=ru&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:22;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:38:\"Карта клуба «Москва»\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(88,'2012-11-07 13:38:51','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:77:\"Только час&lt;br /&gt;— страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(89,'2012-11-07 13:39:07','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:71:\"Только час&nbsp;— страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(90,'2012-11-07 13:39:20','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:67:\"Только час — страховка со скидкой 20%\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(91,'2012-11-07 13:39:56','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:23;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:26:\"Cчастливый час\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(92,'2012-11-07 13:40:21','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:22;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:33:\"Больше привелегий\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(93,'2012-11-07 13:40:41','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:24;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:16:\"+ 7 800 2000 600\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(94,'2012-11-07 13:41:07','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:22;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:33:\"Больше привелегий\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(95,'2012-11-07 13:51:14','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','6','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=6&find_section_section=5',NULL,1,NULL,'a:6:{s:2:\"ID\";i:22;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:33:\"Больше привелегий\";s:12:\"ELEMENT_NAME\";s:12:\"Баннер\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:1:\"/\";}'),(96,'2012-11-07 13:54:30','UNKNOWN','IBLOCK_ELEMENT_EDIT','iblock','1','10.242.32.151','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4','/bitrix/admin/iblock_element_edit.php?type=content&lang=ru&IBLOCK_ID=1&find_section_section=3',NULL,1,NULL,'a:6:{s:2:\"ID\";i:3;s:4:\"CODE\";s:0:\"\";s:4:\"NAME\";s:94:\"Глобальный космический параметр: гипотеза и теории\";s:12:\"ELEMENT_NAME\";s:14:\"Новость\";s:7:\"USER_ID\";i:1;s:15:\"IBLOCK_PAGE_URL\";s:6:\"/news/\";}');
/*!40000 ALTER TABLE `b_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_event_message`
--

DROP TABLE IF EXISTS `b_event_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_event_message` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `EVENT_NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `EMAIL_FROM` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#EMAIL_FROM#',
  `EMAIL_TO` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#EMAIL_TO#',
  `SUBJECT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MESSAGE` text COLLATE utf8_unicode_ci,
  `BODY_TYPE` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `BCC` text COLLATE utf8_unicode_ci,
  `REPLY_TO` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IN_REPLY_TO` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRIORITY` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD1_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD1_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD2_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD2_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_b_event_message_name` (`EVENT_NAME`(50))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_event_message`
--

LOCK TABLES `b_event_message` WRITE;
/*!40000 ALTER TABLE `b_event_message` DISABLE KEYS */;
INSERT INTO `b_event_message` VALUES (1,'2012-11-02 13:29:51','NEW_USER','s1','Y','#DEFAULT_EMAIL_FROM#','#DEFAULT_EMAIL_FROM#','#SITE_NAME#: Зарегистрировался новый пользователь','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n\nНа сайте #SERVER_NAME# успешно зарегистрирован новый пользователь.\n\nДанные пользователя:\nID пользователя: #USER_ID#\n\nИмя: #NAME#\nФамилия: #LAST_NAME#\nE-Mail: #EMAIL#\n\nLogin: #LOGIN#\n\nПисьмо сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'2012-11-02 13:29:51','USER_INFO','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Регистрационная информация','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n#NAME# #LAST_NAME#,\n\n#MESSAGE#\n\nВаша регистрационная информация:\n\nID пользователя: #USER_ID#\nСтатус бюджета: #STATUS#\nLogin: #LOGIN#\n\nВы можете изменить пароль, перейдя по следующей ссылке:\nhttp://#SERVER_NAME#/auth/index.php?change_password=yes&lang=ru&USER_CHECKWORD=#CHECKWORD#\n\nСообщение сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'2012-11-02 13:29:51','USER_PASS_REQUEST','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Запрос на смену пароля','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n#NAME# #LAST_NAME#,\n\n#MESSAGE#\n\nДля смены пароля перейдите по следующей ссылке:\nhttp://#SERVER_NAME#/auth/index.php?change_password=yes&lang=ru&USER_CHECKWORD=#CHECKWORD#\n\nВаша регистрационная информация:\n\nID пользователя: #USER_ID#\nСтатус бюджета: #STATUS#\nLogin: #LOGIN#\n\nСообщение сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'2012-11-02 13:29:51','USER_PASS_CHANGED','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Подтверждение смены пароля','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n#NAME# #LAST_NAME#,\n\n#MESSAGE#\n\nВаша регистрационная информация:\n\nID пользователя: #USER_ID#\nСтатус бюджета: #STATUS#\nLogin: #LOGIN#\n\nСообщение сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'2012-11-02 13:29:51','NEW_USER_CONFIRM','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Подтверждение регистрации нового пользователя','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n\nЗдравствуйте,\n\nВы получили это сообщение, так как ваш адрес был использован при регистрации нового пользователя на сервере #SERVER_NAME#.\n\nВаш код для подтверждения регистрации: #CONFIRM_CODE#\n\nДля подтверждения регистрации перейдите по следующей ссылке:\nhttp://#SERVER_NAME#/auth/index.php?confirm_registration=yes&confirm_user_id=#USER_ID#&confirm_code=#CONFIRM_CODE#\n\nВы также можете ввести код для подтверждения регистрации на странице:\nhttp://#SERVER_NAME#/auth/index.php?confirm_registration=yes&confirm_user_id=#USER_ID#\n\nВнимание! Ваш бюджет не будет активным, пока вы не подтвердите свою регистрацию.\n\n---------------------------------------------------------------------\n\nСообщение сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'2012-11-02 13:29:51','USER_INVITE','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL#','#SITE_NAME#: Приглашение на сайт','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\nЗдравствуйте, #NAME# #LAST_NAME#!\n\nАдминистратором сайта вы добавлены в число зарегистрированных пользователей.\n\nПриглашаем Вас на наш сайт.\n\nВаша регистрационная информация:\n\nID пользователя: #ID#\nLogin: #LOGIN#\n\nРекомендуем вам сменить установленный автоматически пароль.\n\nДля смены пароля перейдите по следующей ссылке:\nhttp://#SERVER_NAME#/auth.php?change_password=yes&USER_LOGIN=#URL_LOGIN#&USER_CHECKWORD=#CHECKWORD#\n','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'2012-11-02 13:29:51','FEEDBACK_FORM','s1','Y','#DEFAULT_EMAIL_FROM#','#EMAIL_TO#','#SITE_NAME#: Сообщение из формы обратной связи','Информационное сообщение сайта #SITE_NAME#\n------------------------------------------\n\nВам было отправлено сообщение через форму обратной связи\n\nАвтор: #AUTHOR#\nE-mail автора: #AUTHOR_EMAIL#\n\nТекст сообщения:\n#TEXT#\n\nСообщение сгенерировано автоматически.','text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `b_event_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_event_message_site`
--

DROP TABLE IF EXISTS `b_event_message_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_event_message_site` (
  `EVENT_MESSAGE_ID` int(11) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`EVENT_MESSAGE_ID`,`SITE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_event_message_site`
--

LOCK TABLES `b_event_message_site` WRITE;
/*!40000 ALTER TABLE `b_event_message_site` DISABLE KEYS */;
INSERT INTO `b_event_message_site` VALUES (1,'s1'),(2,'s1'),(3,'s1'),(4,'s1'),(5,'s1'),(6,'s1'),(7,'s1');
/*!40000 ALTER TABLE `b_event_message_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_event_type`
--

DROP TABLE IF EXISTS `b_event_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_event_type` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `EVENT_NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  `SORT` int(18) NOT NULL DEFAULT '150',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_1` (`EVENT_NAME`,`LID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_event_type`
--

LOCK TABLES `b_event_type` WRITE;
/*!40000 ALTER TABLE `b_event_type` DISABLE KEYS */;
INSERT INTO `b_event_type` VALUES (1,'ru','NEW_USER','Зарегистрировался новый пользователь','\n\n#USER_ID# - ID пользователя\n#LOGIN# - Логин\n#EMAIL# - EMail\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#USER_IP# - IP пользователя\n#USER_HOST# - Хост пользователя\n',1),(2,'ru','USER_INFO','Информация о пользователе','\n\n#USER_ID# - ID пользователя\n#STATUS# - Статус логина\n#MESSAGE# - Сообщение пользователю\n#LOGIN# - Логин\n#CHECKWORD# - Контрольная строка для смены пароля\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#EMAIL# - E-Mail пользователя\n',2),(3,'ru','NEW_USER_CONFIRM','Подтверждение регистрации нового пользователя','\n\n\n#USER_ID# - ID пользователя\n#LOGIN# - Логин\n#EMAIL# - EMail\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#USER_IP# - IP пользователя\n#USER_HOST# - Хост пользователя\n#CONFIRM_CODE# - Код подтверждения\n',3),(4,'ru','USER_PASS_REQUEST','Запрос на смену пароля','\n\n#USER_ID# - ID пользователя\n#STATUS# - Статус логина\n#MESSAGE# - Сообщение пользователю\n#LOGIN# - Логин\n#CHECKWORD# - Контрольная строка для смены пароля\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#EMAIL# - E-Mail пользователя\n',4),(5,'ru','USER_PASS_CHANGED','Подтверждение смены пароля','\n\n#USER_ID# - ID пользователя\n#STATUS# - Статус логина\n#MESSAGE# - Сообщение пользователю\n#LOGIN# - Логин\n#CHECKWORD# - Контрольная строка для смены пароля\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#EMAIL# - E-Mail пользователя\n',5),(6,'ru','USER_INVITE','Приглашение на сайт нового пользователя','#ID# - ID пользователя\n#LOGIN# - Логин\n#URL_LOGIN# - Логин, закодированный для использования в URL\n#EMAIL# - EMail\n#NAME# - Имя\n#LAST_NAME# - Фамилия\n#PASSWORD# - пароль пользователя \n#CHECKWORD# - Контрольная строка для смены пароля\n#XML_ID# - ID пользователя для связи с внешними источниками\n',6),(7,'ru','FEEDBACK_FORM','Отправка сообщения через форму обратной связи','#AUTHOR# - Автор сообщения\n#AUTHOR_EMAIL# - Email автора сообщения\n#TEXT# - Текст сообщения\n#EMAIL_FROM# - Email отправителя письма\n#EMAIL_TO# - Email получателя письма',7),(8,'en','NEW_USER','New user was registered','\n\n#USER_ID# - User ID\n#LOGIN# - Login\n#EMAIL# - EMail\n#NAME# - Name\n#LAST_NAME# - Last Name\n#USER_IP# - User IP\n#USER_HOST# - User Host\n',1),(9,'en','USER_INFO','Account Information','\n\n#USER_ID# - User ID\n#STATUS# - Account status\n#MESSAGE# - Message for user\n#LOGIN# - Login\n#CHECKWORD# - Check string for password change\n#NAME# - Name\n#LAST_NAME# - Last Name\n#EMAIL# - User E-Mail\n',2),(10,'en','NEW_USER_CONFIRM','New user registration confirmation','\n\n#USER_ID# - User ID\n#LOGIN# - Login\n#EMAIL# - E-mail\n#NAME# - First name\n#LAST_NAME# - Last name\n#USER_IP# - User IP\n#USER_HOST# - User host\n#CONFIRM_CODE# - Confirmation code\n',3),(11,'en','USER_PASS_REQUEST','Password Change Request','\n\n#USER_ID# - User ID\n#STATUS# - Account status\n#MESSAGE# - Message for user\n#LOGIN# - Login\n#CHECKWORD# - Check string for password change\n#NAME# - Name\n#LAST_NAME# - Last Name\n#EMAIL# - User E-Mail\n',4),(12,'en','USER_PASS_CHANGED','Password Change Confirmation','\n\n#USER_ID# - User ID\n#STATUS# - Account status\n#MESSAGE# - Message for user\n#LOGIN# - Login\n#CHECKWORD# - Check string for password change\n#NAME# - Name\n#LAST_NAME# - Last Name\n#EMAIL# - User E-Mail\n',5),(13,'en','USER_INVITE','Invitation of a new site user','#ID# - User ID\n#LOGIN# - Login\n#URL_LOGIN# - Encoded login for use in URL\n#EMAIL# - EMail\n#NAME# - Name\n#LAST_NAME# - Last Name\n#PASSWORD# - User password \n#CHECKWORD# - Password check string\n#XML_ID# - User ID to link with external data sources\n\n',6),(14,'en','FEEDBACK_FORM','Sending a message using a feedback form','#AUTHOR# - Message author\n#AUTHOR_EMAIL# - Author\'s e-mail address\n#TEXT# - Message text\n#EMAIL_FROM# - Sender\'s e-mail address\n#EMAIL_TO# - Recipient\'s e-mail address',7);
/*!40000 ALTER TABLE `b_event_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_favorite`
--

DROP TABLE IF EXISTS `b_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_favorite` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `C_SORT` int(18) NOT NULL DEFAULT '100',
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8_unicode_ci,
  `COMMENTS` text COLLATE utf8_unicode_ci,
  `LANGUAGE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_ID` int(11) DEFAULT NULL,
  `CODE_ID` int(18) DEFAULT NULL,
  `COMMON` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_favorite`
--

LOCK TABLES `b_favorite` WRITE;
/*!40000 ALTER TABLE `b_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_file`
--

DROP TABLE IF EXISTS `b_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_file` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HEIGHT` int(18) DEFAULT NULL,
  `WIDTH` int(18) DEFAULT NULL,
  `FILE_SIZE` int(18) NOT NULL,
  `CONTENT_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'IMAGE',
  `SUBDIR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FILE_NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ORIGINAL_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HANDLER_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_file`
--

LOCK TABLES `b_file` WRITE;
/*!40000 ALTER TABLE `b_file` DISABLE KEYS */;
INSERT INTO `b_file` VALUES (1,'2012-11-06 09:37:42','iblock',76,102,3838,'image/jpeg','iblock/2cf','2cfbbf5e25c08413aa6775e016065586.jpg','1267459469_evgenii-petrosyan_inventarizaciya_05.jpg','',NULL),(2,'2012-11-06 09:37:42','iblock',288,384,14445,'image/jpeg','iblock/567','5679fb99d03e26498618edbbb48c834a.jpg','1267459469_evgenii-petrosyan_inventarizaciya_05.jpg','',NULL),(3,'2012-11-06 09:38:13','iblock',81,102,5457,'image/png','iblock/d13','d13743d127c3c68abb56162b56c4bb93.png','1290275292_bikov.png','',NULL),(4,'2012-11-06 09:38:13','iblock',318,400,27253,'image/png','iblock/21f','21fc180c8b23d175b3535ec1ea07208a.png','1290275292_bikov.png','',NULL),(5,'2012-11-06 09:38:42','iblock',135,102,7562,'image/jpeg','iblock/edd','eddd10fd6cefa152760b7a5280a3b3d6.jpg','agishev2.jpg','',NULL),(6,'2012-11-06 09:38:42','iblock',398,300,180181,'image/jpeg','iblock/1b5','1b5ee6c1d1f82e2897a484ac6a958ad6.jpg','agishev2.jpg','',NULL),(7,'2012-11-06 09:39:06','iblock',76,102,6813,'image/jpeg','iblock/4ee','4ee7d2ab6804a25ac824846b6f0785aa.jpg','DETAIL_PICTURE_573892.jpg','',NULL),(8,'2012-11-06 09:39:06','iblock',356,475,141869,'image/jpeg','iblock/481','481b47666d0e75171e2455bd6ffc8aef.jpg','DETAIL_PICTURE_573892.jpg','',NULL),(9,'2012-11-06 09:39:44','iblock',139,102,7694,'image/jpeg','iblock/ec1','ec19a3c175481a8de92dc4b70e2696e8.jpg','7ab428dcdcc7402a1a3cf05ffdd5cc14_full.jpg','',NULL),(10,'2012-11-06 09:39:44','iblock',537,394,42622,'image/jpeg','iblock/302','3028371d90d7ca2aef36b460e2b7ff44.jpg','7ab428dcdcc7402a1a3cf05ffdd5cc14_full.jpg','',NULL),(11,'2012-11-06 09:40:20','iblock',85,102,4245,'image/jpeg','iblock/065','0658b19ab4c0acf88ae2a007b4ef92e2.jpg','1233595565_g.leps_bessonnica.jpg','',NULL),(12,'2012-11-06 09:40:20','iblock',450,540,13650,'image/jpeg','iblock/617','617bc040112a3e9d95f636a9cce67fb6.jpg','1233595565_g.leps_bessonnica.jpg','',NULL),(16,'2012-11-06 17:00:31','iblock',122,186,15180,'image/jpeg','iblock/e00','e00efe743c75e5ce645fd1c1123f1a3e.jpg','share.jpg','',NULL),(17,'2012-11-06 17:00:42','iblock',122,186,15180,'image/jpeg','iblock/b1e','b1e2149c2c019032ce2567ac6ad57957.jpg','share.jpg','',NULL),(18,'2012-11-06 17:00:48','iblock',122,186,15180,'image/jpeg','iblock/80b','80bdb3b7088cc7fa33a9bb7b9737a187.jpg','share.jpg','',NULL),(21,'2012-11-06 17:27:11','iblock',230,138,10292,'image/png','iblock/358','358490ffe657eb5ffe016e402e6b8b43.png','alpha.png','',NULL),(22,'2012-11-06 17:28:10','iblock',230,138,12254,'image/png','iblock/9fe','9fea1939364f2f9cbb3a1509264b7965.png','vsk.png','',NULL),(23,'2012-11-06 17:28:37','iblock',230,138,7826,'image/png','iblock/6cd','6cd37dd09e8ba0718a1a6055ec21d843.png','vtb.png','',NULL),(26,'2012-11-07 13:14:53','iblock',300,938,177838,'image/jpeg','iblock/b1f','b1f05c35965afc27eabdc48d2ccc0f2b.jpg','banner_image1.jpg','',NULL),(27,'2012-11-07 13:16:59','iblock',300,938,177838,'image/jpeg','iblock/df7','df7acbff5c00d1ab72abe34a5ae4c28c.jpg','banner_image1.jpg','',NULL),(28,'2012-11-07 13:27:50','iblock',70,85,9347,'image/jpeg','iblock/2fd','2fd3faba47c110f7cff1716b7598f3ae.jpg','clubCard.jpg','',NULL),(29,'2012-11-07 13:28:08','iblock',100,68,8734,'image/jpeg','iblock/076','076928a5813d6ca938e9b487a4dd014a.jpg','clock.jpg','',NULL),(30,'2012-11-07 13:28:27','iblock',116,83,12113,'image/jpeg','iblock/ce0','ce0674b1bc84e53af30d70fb31db22b9.jpg','girl.jpg','',NULL);
/*!40000 ALTER TABLE `b_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_file_search`
--

DROP TABLE IF EXISTS `b_file_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_file_search` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SESS_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `F_PATH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `B_DIR` int(11) NOT NULL DEFAULT '0',
  `F_SIZE` int(11) NOT NULL DEFAULT '0',
  `F_TIME` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_file_search`
--

LOCK TABLES `b_file_search` WRITE;
/*!40000 ALTER TABLE `b_file_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_file_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_group`
--

DROP TABLE IF EXISTS `b_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_group` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `C_SORT` int(18) NOT NULL DEFAULT '100',
  `ANONYMOUS` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SECURITY_POLICY` text COLLATE utf8_unicode_ci,
  `STRING_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_group`
--

LOCK TABLES `b_group` WRITE;
/*!40000 ALTER TABLE `b_group` DISABLE KEYS */;
INSERT INTO `b_group` VALUES (1,'2012-11-02 13:29:51','Y',1,'N','Администраторы','Полный доступ к управлению сайтом.',NULL,NULL),(2,'2012-11-02 13:29:51','Y',2,'Y','Все пользователи (в том числе неавторизованные)','Все пользователи, включая неавторизованных.',NULL,NULL),(3,'2012-11-02 13:29:51','Y',3,'N','Пользователи имеющие право голосовать за рейтинг','В эту группу пользователи добавляются автоматически.',NULL,'RATING_VOTE'),(4,'2012-11-02 13:29:51','Y',4,'N','Пользователи имеющие право голосовать за авторитет','В эту группу пользователи добавляются автоматически.',NULL,'RATING_VOTE_AUTHORITY');
/*!40000 ALTER TABLE `b_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_group_collection_task`
--

DROP TABLE IF EXISTS `b_group_collection_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_group_collection_task` (
  `GROUP_ID` int(11) NOT NULL,
  `TASK_ID` int(11) NOT NULL,
  `COLLECTION_ID` int(11) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`TASK_ID`,`COLLECTION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_group_collection_task`
--

LOCK TABLES `b_group_collection_task` WRITE;
/*!40000 ALTER TABLE `b_group_collection_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_group_collection_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_group_subordinate`
--

DROP TABLE IF EXISTS `b_group_subordinate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_group_subordinate` (
  `ID` int(18) NOT NULL,
  `AR_SUBGROUP_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_group_subordinate`
--

LOCK TABLES `b_group_subordinate` WRITE;
/*!40000 ALTER TABLE `b_group_subordinate` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_group_subordinate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_group_task`
--

DROP TABLE IF EXISTS `b_group_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_group_task` (
  `GROUP_ID` int(18) NOT NULL,
  `TASK_ID` int(18) NOT NULL,
  `EXTERNAL_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`GROUP_ID`,`TASK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_group_task`
--

LOCK TABLES `b_group_task` WRITE;
/*!40000 ALTER TABLE `b_group_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_group_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_hot_keys`
--

DROP TABLE IF EXISTS `b_hot_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_hot_keys` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `KEYS_STRING` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_ID` int(18) NOT NULL,
  `USER_ID` int(18) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ix_b_hot_keys_co_u` (`CODE_ID`,`USER_ID`),
  KEY `ix_hot_keys_code` (`CODE_ID`),
  KEY `ix_hot_keys_user` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_hot_keys`
--

LOCK TABLES `b_hot_keys` WRITE;
/*!40000 ALTER TABLE `b_hot_keys` DISABLE KEYS */;
INSERT INTO `b_hot_keys` VALUES (1,'Ctrl+Alt+85',139,0),(2,'Ctrl+Alt+80',17,0),(3,'Ctrl+Alt+70',120,0),(4,'Ctrl+Alt+68',117,0),(5,'Ctrl+Alt+81',3,0),(6,'Ctrl+Alt+75',106,0),(7,'Ctrl+Alt+79',133,0),(8,'Ctrl+Alt+70',121,0),(9,'Ctrl+Alt+69',118,0),(10,'Ctrl+Shift+83',87,0),(11,'Ctrl+Shift+88',88,0),(12,'Ctrl+Shift+76',89,0),(13,'Ctrl+Alt+85',139,1),(14,'Ctrl+Alt+80',17,1),(15,'Ctrl+Alt+70',120,1),(16,'Ctrl+Alt+68',117,1),(17,'Ctrl+Alt+81',3,1),(18,'Ctrl+Alt+75',106,1),(19,'Ctrl+Alt+79',133,1),(20,'Ctrl+Alt+70',121,1),(21,'Ctrl+Alt+69',118,1),(22,'Ctrl+Shift+83',87,1),(23,'Ctrl+Shift+88',88,1),(24,'Ctrl+Shift+76',89,1);
/*!40000 ALTER TABLE `b_hot_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_hot_keys_code`
--

DROP TABLE IF EXISTS `b_hot_keys_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_hot_keys_code` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `CLASS_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMMENTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TITLE_OBJ` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IS_CUSTOM` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `ix_hot_keys_code_cn` (`CLASS_NAME`),
  KEY `ix_hot_keys_code_url` (`URL`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_hot_keys_code`
--

LOCK TABLES `b_hot_keys_code` WRITE;
/*!40000 ALTER TABLE `b_hot_keys_code` DISABLE KEYS */;
INSERT INTO `b_hot_keys_code` VALUES (3,'CAdminTabControl','NextTab();','HK_DB_CADMINTC','HK_DB_CADMINTC_C','tab-container','',0),(5,'btn_new','var d=BX (\'btn_new\'); if (d) location.href = d.href;','HK_DB_BUT_ADD','HK_DB_BUT_ADD_C','btn_new','',0),(6,'btn_excel','var d=BX(\'btn_excel\'); if (d) location.href = d.href;','HK_DB_BUT_EXL','HK_DB_BUT_EXL_C','btn_excel','',0),(7,'btn_settings','var d=BX(\'btn_settings\'); if (d) location.href = d.href;','HK_DB_BUT_OPT','HK_DB_BUT_OPT_C','btn_settings','',0),(8,'btn_list','var d=BX(\'btn_list\'); if (d) location.href = d.href;','HK_DB_BUT_LST','HK_DB_BUT_LST_C','btn_list','',0),(9,'Edit_Save_Button','var d=BX .findChild(document, {attribute: {\'name\': \'save\'}}, true );  if (d) d.click();','HK_DB_BUT_SAVE','HK_DB_BUT_SAVE_C','Edit_Save_Button','',0),(10,'btn_delete','var d=BX(\'btn_delete\'); if (d) location.href = d.href;','HK_DB_BUT_DEL','HK_DB_BUT_DEL_C','btn_delete','',0),(12,'CAdminFilter','var d=BX .findChild(document, {attribute: {\'name\': \'find\'}}, true ); if (d) d.focus();','HK_DB_FLT_FND','HK_DB_FLT_FND_C','find','',0),(13,'CAdminFilter','var d=BX .findChild(document, {attribute: {\'name\': \'set_filter\'}}, true );  if (d) d.click();','HK_DB_FLT_BUT_F','HK_DB_FLT_BUT_F_C','set_filter','',0),(14,'CAdminFilter','var d=BX .findChild(document, {attribute: {\'name\': \'del_filter\'}}, true );  if (d) d.click();','HK_DB_FLT_BUT_CNL','HK_DB_FLT_BUT_CNL_C','del_filter','',0),(15,'bx-panel-admin-button-help-icon-id','var d=BX(\'bx-panel-admin-button-help-icon-id\'); if (d) location.href = d.href;','HK_DB_BUT_HLP','HK_DB_BUT_HLP_C','bx-panel-admin-button-help-icon-id','',0),(17,'Global','BXHotKeys.ShowSettings();','HK_DB_SHW_L','HK_DB_SHW_L_C','bx-panel-hotkeys','',0),(19,'Edit_Apply_Button','var d=BX .findChild(document, {attribute: {\'name\': \'apply\'}}, true );  if (d) d.click();','HK_DB_BUT_APPL','HK_DB_BUT_APPL_C','Edit_Apply_Button','',0),(20,'Edit_Cancel_Button','var d=BX .findChild(document, {attribute: {\'name\': \'cancel\'}}, true );  if (d) d.click();','HK_DB_BUT_CANCEL','HK_DB_BUT_CANCEL_C','Edit_Cancel_Button','',0),(54,'top_panel_org_fav','','-=AUTONAME=-',NULL,'top_panel_org_fav',NULL,0),(55,'top_panel_module_settings','','-=AUTONAME=-',NULL,'top_panel_module_settings','',0),(56,'top_panel_interface_settings','','-=AUTONAME=-',NULL,'top_panel_interface_settings','',0),(57,'top_panel_help','','-=AUTONAME=-',NULL,'top_panel_help','',0),(58,'top_panel_bizproc_tasks','','-=AUTONAME=-',NULL,'top_panel_bizproc_tasks','',0),(59,'top_panel_add_fav','','-=AUTONAME=-',NULL,'top_panel_add_fav',NULL,0),(60,'top_panel_create_page','','-=AUTONAME=-',NULL,'top_panel_create_page','',0),(62,'top_panel_create_folder','','-=AUTONAME=-',NULL,'top_panel_create_folder','',0),(63,'top_panel_edit_page','','-=AUTONAME=-',NULL,'top_panel_edit_page','',0),(64,'top_panel_page_prop','','-=AUTONAME=-',NULL,'top_panel_page_prop','',0),(65,'top_panel_edit_page_html','','-=AUTONAME=-',NULL,'top_panel_edit_page_html','',0),(67,'top_panel_edit_page_php','','-=AUTONAME=-',NULL,'top_panel_edit_page_php','',0),(68,'top_panel_del_page','','-=AUTONAME=-',NULL,'top_panel_del_page','',0),(69,'top_panel_folder_prop','','-=AUTONAME=-',NULL,'top_panel_folder_prop','',0),(70,'top_panel_access_folder_new','','-=AUTONAME=-',NULL,'top_panel_access_folder_new','',0),(71,'main_top_panel_struct_panel','','-=AUTONAME=-',NULL,'main_top_panel_struct_panel','',0),(72,'top_panel_cache_page','','-=AUTONAME=-',NULL,'top_panel_cache_page','',0),(73,'top_panel_cache_comp','','-=AUTONAME=-',NULL,'top_panel_cache_comp','',0),(74,'top_panel_cache_not','','-=AUTONAME=-',NULL,'top_panel_cache_not','',0),(75,'top_panel_edit_mode','','-=AUTONAME=-',NULL,'top_panel_edit_mode','',0),(76,'top_panel_templ_site_css','','-=AUTONAME=-',NULL,'top_panel_templ_site_css','',0),(77,'top_panel_templ_templ_css','','-=AUTONAME=-',NULL,'top_panel_templ_templ_css','',0),(78,'top_panel_templ_site','','-=AUTONAME=-',NULL,'top_panel_templ_site','',0),(81,'top_panel_debug_time','','-=AUTONAME=-',NULL,'top_panel_debug_time','',0),(82,'top_panel_debug_incl','','-=AUTONAME=-',NULL,'top_panel_debug_incl','',0),(83,'top_panel_debug_sql','','-=AUTONAME=-',NULL,'top_panel_debug_sql',NULL,0),(84,'top_panel_debug_compr','','-=AUTONAME=-',NULL,'top_panel_debug_compr','',0),(85,'MTP_SHORT_URI1','','-=AUTONAME=-',NULL,'MTP_SHORT_URI1','',0),(86,'MTP_SHORT_URI_LIST','','-=AUTONAME=-',NULL,'MTP_SHORT_URI_LIST','',0),(87,'FMST_PANEL_STICKER_ADD','','-=AUTONAME=-',NULL,'FMST_PANEL_STICKER_ADD','',0),(88,'FMST_PANEL_STICKERS_SHOW','','-=AUTONAME=-',NULL,'FMST_PANEL_STICKERS_SHOW','',0),(89,'FMST_PANEL_CUR_STICKER_LIST','','-=AUTONAME=-',NULL,'FMST_PANEL_CUR_STICKER_LIST','',0),(90,'FMST_PANEL_ALL_STICKER_LIST','','-=AUTONAME=-',NULL,'FMST_PANEL_ALL_STICKER_LIST','',0),(91,'top_panel_menu','var d=BX(\"bx-panel-menu\"); if (d) d.click();','-=AUTONAME=-',NULL,'bx-panel-menu','',0),(92,'top_panel_admin','var d=BX(\'bx-panel-admin-tab\'); if (d) location.href = d.href;','-=AUTONAME=-',NULL,'bx-panel-admin-tab','',0),(93,'admin_panel_site','var d=BX(\'bx-panel-view-tab\'); if (d) location.href = d.href;','-=AUTONAME=-',NULL,'bx-panel-view-tab','',0),(94,'admin_panel_admin','var d=BX(\'bx-panel-admin-tab\'); if (d) location.href = d.href;','-=AUTONAME=-',NULL,'bx-panel-admin-tab','',0),(96,'top_panel_folder_prop_new','','-=AUTONAME=-',NULL,'top_panel_folder_prop_new','',0),(97,'main_top_panel_structure','','-=AUTONAME=-',NULL,'main_top_panel_structure','',0),(98,'top_panel_clear_cache','','-=AUTONAME=-',NULL,'top_panel_clear_cache','',0),(99,'top_panel_templ','','-=AUTONAME=-',NULL,'top_panel_templ','',0),(100,'top_panel_debug','','-=AUTONAME=-',NULL,'top_panel_debug','',0),(101,'MTP_SHORT_URI','','-=AUTONAME=-',NULL,'MTP_SHORT_URI','',0),(102,'FMST_PANEL_STICKERS','','-=AUTONAME=-',NULL,'FMST_PANEL_STICKERS','',0),(103,'top_panel_settings','','-=AUTONAME=-',NULL,'top_panel_settings','',0),(104,'top_panel_fav','','-=AUTONAME=-',NULL,'top_panel_fav','',0),(106,'Global','location.href=\'/bitrix/admin/hot_keys_list.php?lang=ru\';','HK_DB_SHW_HK','','','',0),(107,'top_panel_edit_new','','-=AUTONAME=-',NULL,'top_panel_edit_new','',0),(108,'FLOW_PANEL_CREATE_WITH_WF','','-=AUTONAME=-',NULL,'FLOW_PANEL_CREATE_WITH_WF','',0),(109,'FLOW_PANEL_EDIT_WITH_WF','','-=AUTONAME=-',NULL,'FLOW_PANEL_EDIT_WITH_WF','',0),(110,'FLOW_PANEL_HISTORY','','-=AUTONAME=-',NULL,'FLOW_PANEL_HISTORY','',0),(111,'top_panel_create_new','','-=AUTONAME=-',NULL,'top_panel_create_new','',0),(112,'top_panel_create_folder_new','','-=AUTONAME=-',NULL,'top_panel_create_folder_new','',0),(116,'bx-panel-toggle','','-=AUTONAME=-',NULL,'bx-panel-toggle','',0),(117,'bx-panel-small-toggle','','-=AUTONAME=-',NULL,'bx-panel-small-toggle','',0),(118,'bx-panel-expander','var d=BX(\'bx-panel-expander\'); if (d) BX.fireEvent(d, \'click\');','-=AUTONAME=-',NULL,'bx-panel-expander','',0),(119,'bx-panel-hider','var d=BX(\'bx-panel-hider\'); if (d) d.click();','-=AUTONAME=-',NULL,'bx-panel-hider','',0),(120,'search-textbox-input','var d=BX(\'search-textbox-input\'); if (d) { d.click(); d.focus();}','-=AUTONAME=-','','search','',0),(121,'bx-search-input','var d=BX(\'bx-search-input\'); if (d) { d.click(); d.focus(); }','-=AUTONAME=-','','bx-search-input','',0),(133,'bx-panel-logout','var d=BX(\'bx-panel-logout\'); if (d) location.href = d.href;','-=AUTONAME=-','','bx-panel-logout','',0),(135,'CDialog','var d=BX(\'cancel\'); if (d) d.click();','HK_DB_D_CANCEL','','cancel','',0),(136,'CDialog','var d=BX(\'close\'); if (d) d.click();','HK_DB_D_CLOSE','','close','',0),(137,'CDialog','var d=BX(\'savebtn\'); if (d) d.click();','HK_DB_D_SAVE','','savebtn','',0),(138,'CDialog','var d=BX(\'btn_popup_save\'); if (d) d.click();','HK_DB_D_EDIT_SAVE','','btn_popup_save','',0),(139,'Global','location.href=\'/bitrix/admin/user_admin.php?lang=\'+phpVars.LANGUAGE_ID;','HK_DB_SHW_U','','','',0);
/*!40000 ALTER TABLE `b_hot_keys_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock`
--

DROP TABLE IF EXISTS `b_iblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IBLOCK_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `CODE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `LIST_PAGE_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DETAIL_PAGE_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SECTION_PAGE_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PICTURE` int(18) DEFAULT NULL,
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  `DESCRIPTION_TYPE` char(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `RSS_TTL` int(11) NOT NULL DEFAULT '24',
  `RSS_ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `RSS_FILE_ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `RSS_FILE_LIMIT` int(11) DEFAULT NULL,
  `RSS_FILE_DAYS` int(11) DEFAULT NULL,
  `RSS_YANDEX_ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TMP_ID` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INDEX_ELEMENT` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `INDEX_SECTION` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `WORKFLOW` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `BIZPROC` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SECTION_CHOOSER` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LIST_MODE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RIGHTS_MODE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VERSION` int(11) NOT NULL DEFAULT '1',
  `LAST_CONV_ELEMENT` int(11) NOT NULL DEFAULT '0',
  `SOCNET_GROUP_ID` int(18) DEFAULT NULL,
  `EDIT_FILE_BEFORE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EDIT_FILE_AFTER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SECTIONS_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SECTION_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ELEMENTS_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ELEMENT_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock` (`IBLOCK_TYPE_ID`,`LID`,`ACTIVE`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock`
--

LOCK TABLES `b_iblock` WRITE;
/*!40000 ALTER TABLE `b_iblock` DISABLE KEYS */;
INSERT INTO `b_iblock` VALUES (1,'2012-11-06 10:33:05','content','s1','content_news','Новости','Y',100,'#SITE_DIR#/news/','#SITE_DIR#/news/detail.php?ID=#ID#','#SITE_DIR#/news/?SECTION=#ID#',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,'98bc09d9486a035bf48fa881b9173b9f','Y','Y','N','N','L','','S',1,0,NULL,'','','Разделы','Раздел','Новости','Новость'),(2,'2012-11-06 16:18:21','content','s1','content_jobs','Вакансии','Y',200,'#SITE_DIR#/about/jobs/','#SITE_DIR#/about/jobs/?ID=#ID#','#SITE_DIR#/about/jobs/',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,NULL,'Y','Y','N','N','L','','S',1,0,NULL,'','','Разделы','Раздел','Вакансии','Вакансия'),(3,'2012-11-06 16:59:19','content','s1','content_shares','Акции','Y',300,'#SITE_DIR#/shares/','#SITE_DIR#/shares/','#SITE_DIR#/shares/',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,NULL,'Y','Y','N','N','L','','S',1,0,NULL,'','','Разделы','Раздел','Акции','Акция'),(4,'2012-11-06 17:25:36','content','s1','content_partners','Партнеры','Y',400,'#SITE_DIR#/partners/','#SITE_DIR#/partners/','#SITE_DIR#/partners/',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,NULL,'N','N','N','N','L','','S',1,0,NULL,'','','Разделы','Раздел','Партнеры','Партнеры'),(5,'2012-11-06 17:49:14','content','s1','content_orders','Заявки на страховку','Y',500,'#SITE_DIR#/','#SITE_DIR#/','#SITE_DIR#/',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,NULL,'N','N','N','N','L','','S',1,0,NULL,'','','Разделы','Раздел','Заявки','Заявка'),(6,'2012-11-07 12:47:14','content','s1','content_banners','Баннеры','Y',600,'#SITE_DIR#/','#SITE_DIR#/','#SITE_DIR#/',NULL,'','text',24,'Y','N',NULL,NULL,'N',NULL,'7d55a8702e978ff976fe0922e32f3f7e','Y','Y','N','N','L','','S',1,0,NULL,'','','Площадки','Площадка','Баннеры','Баннер');
/*!40000 ALTER TABLE `b_iblock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_cache`
--

DROP TABLE IF EXISTS `b_iblock_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_cache` (
  `CACHE_KEY` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `CACHE` longtext COLLATE utf8_unicode_ci NOT NULL,
  `CACHE_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`CACHE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_cache`
--

LOCK TABLES `b_iblock_cache` WRITE;
/*!40000 ALTER TABLE `b_iblock_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_element`
--

DROP TABLE IF EXISTS `b_iblock_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_element` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime DEFAULT NULL,
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `IBLOCK_ID` int(11) NOT NULL DEFAULT '0',
  `IBLOCK_SECTION_ID` int(11) DEFAULT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `ACTIVE_FROM` datetime DEFAULT NULL,
  `ACTIVE_TO` datetime DEFAULT NULL,
  `SORT` int(11) NOT NULL DEFAULT '500',
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PREVIEW_PICTURE` int(18) DEFAULT NULL,
  `PREVIEW_TEXT` text COLLATE utf8_unicode_ci,
  `PREVIEW_TEXT_TYPE` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `DETAIL_PICTURE` int(18) DEFAULT NULL,
  `DETAIL_TEXT` longtext COLLATE utf8_unicode_ci,
  `DETAIL_TEXT_TYPE` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `SEARCHABLE_CONTENT` text COLLATE utf8_unicode_ci,
  `WF_STATUS_ID` int(18) DEFAULT '1',
  `WF_PARENT_ELEMENT_ID` int(11) DEFAULT NULL,
  `WF_NEW` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WF_LOCKED_BY` int(18) DEFAULT NULL,
  `WF_DATE_LOCK` datetime DEFAULT NULL,
  `WF_COMMENTS` text COLLATE utf8_unicode_ci,
  `IN_SECTIONS` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAGS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TMP_ID` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WF_LAST_HISTORY_ID` int(11) DEFAULT NULL,
  `SHOW_COUNTER` int(18) DEFAULT NULL,
  `SHOW_COUNTER_START` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_element_1` (`IBLOCK_ID`,`IBLOCK_SECTION_ID`),
  KEY `ix_iblock_element_4` (`IBLOCK_ID`,`XML_ID`,`WF_PARENT_ELEMENT_ID`),
  KEY `ix_iblock_element_3` (`WF_PARENT_ELEMENT_ID`),
  KEY `ix_iblock_element_code` (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_element`
--

LOCK TABLES `b_iblock_element` WRITE;
/*!40000 ALTER TABLE `b_iblock_element` DISABLE KEYS */;
INSERT INTO `b_iblock_element` VALUES (1,'2012-11-06 13:52:00',1,'2012-11-06 13:37:42',1,1,2,'Y','2012-11-01 00:00:00',NULL,500,'Межзвездная матеpия как противостояние',1,'Лисичка, это удалось установить по характеру спектра, жизненно колеблет эллиптический перигелий, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\". Фаза вращает первоначальный Ганимед, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\".','text',2,'Эфемерида, по определению, перечеркивает часовой угол, и в этом вопросе достигнута такая точность расчетов, что, начиная с того дня, как мы видим, указанного Эннием и записанного в \"Больших анналах\", было вычислено время предшествовавших затмений солнца, начиная с того, которое в квинктильские ноны произошло в царствование Ромула. Гелиоцентрическое расстояние дает большой круг небесной сферы, об этом в минувшую субботу сообщил заместитель администратора NASA. Засветка неба вращает вращательный астероид, хотя галактику в созвездии Дракона можно назвать карликовой. Угловое расстояние, оценивая блеск освещенного металического шарика, вращает близкий перигелий, таким образом, атмосферы этих планет плавно переходят в жидкую мантию.\r\n\r\nПротивостояние оценивает надир, Плутон не входит в эту классификацию. Земная группа формировалась ближе к Солнцу, однако огpомная пылевая кома многопланово меняет параллакс, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Реликтовый ледник прочно отражает центральный зенит, а оценить проницательную способность вашего телескопа поможет следующая формула: Mпр.= 2,5lg Dмм + 2,5lg Гкрат + 4. Как мы уже знаем, Юпитер дает pадиотелескоп Максвелла, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9.\r\n\r\nЛисичка точно оценивает экваториальный Тукан, но кольца видны только при 40–50. Возмущающий фактор, а там действительно могли быть видны звезды, о чем свидетельствует Фукидид выбирает метеорный дождь, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Газопылевое облако, и это следует подчеркнуть, колеблет перигелий, таким образом, атмосферы этих планет плавно переходят в жидкую мантию. Туманность Андромеды многопланово вращает центральный поперечник, в таком случае эксцентриситеты и наклоны орбит возрастают. Весеннее равноденствие, после осторожного анализа, решает Каллисто, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Параметр последовательно отражает астероидный часовой угол, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.','text','МЕЖЗВЕЗДНАЯ МАТЕPИЯ КАК ПРОТИВОСТОЯНИЕ\r\nЛИСИЧКА, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ЖИЗНЕННО КОЛЕБЛЕТ ЭЛЛИПТИЧЕСКИЙ ПЕРИГЕЛИЙ, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\". ФАЗА ВРАЩАЕТ ПЕРВОНАЧАЛЬНЫЙ ГАНИМЕД, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\".\r\nЭФЕМЕРИДА, ПО ОПРЕДЕЛЕНИЮ, ПЕРЕЧЕРКИВАЕТ ЧАСОВОЙ УГОЛ, И В ЭТОМ ВОПРОСЕ ДОСТИГНУТА ТАКАЯ ТОЧНОСТЬ РАСЧЕТОВ, ЧТО, НАЧИНАЯ С ТОГО ДНЯ, КАК МЫ ВИДИМ, УКАЗАННОГО ЭННИЕМ И ЗАПИСАННОГО В \"БОЛЬШИХ АННАЛАХ\", БЫЛО ВЫЧИСЛЕНО ВРЕМЯ ПРЕДШЕСТВОВАВШИХ ЗАТМЕНИЙ СОЛНЦА, НАЧИНАЯ С ТОГО, КОТОРОЕ В КВИНКТИЛЬСКИЕ НОНЫ ПРОИЗОШЛО В ЦАРСТВОВАНИЕ РОМУЛА. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ДАЕТ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. ЗАСВЕТКА НЕБА ВРАЩАЕТ ВРАЩАТЕЛЬНЫЙ АСТЕРОИД, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. УГЛОВОЕ РАССТОЯНИЕ, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ВРАЩАЕТ БЛИЗКИЙ ПЕРИГЕЛИЙ, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ.\r\n\r\nПРОТИВОСТОЯНИЕ ОЦЕНИВАЕТ НАДИР, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ЗЕМНАЯ ГРУППА ФОРМИРОВАЛАСЬ БЛИЖЕ К СОЛНЦУ, ОДНАКО ОГPОМНАЯ ПЫЛЕВАЯ КОМА МНОГОПЛАНОВО МЕНЯЕТ ПАРАЛЛАКС, ПРИ ЭТОМ ПЛОТНОСТЬ ВСЕЛЕННОЙ В 3 * 10 В 18-Й СТЕПЕНИ РАЗ МЕНЬШЕ, С УЧЕТОМ НЕКОТОРОЙ НЕИЗВЕСТНОЙ ДОБАВКИ СКРЫТОЙ МАССЫ. РЕЛИКТОВЫЙ ЛЕДНИК ПРОЧНО ОТРАЖАЕТ ЦЕНТРАЛЬНЫЙ ЗЕНИТ, А ОЦЕНИТЬ ПРОНИЦАТЕЛЬНУЮ СПОСОБНОСТЬ ВАШЕГО ТЕЛЕСКОПА ПОМОЖЕТ СЛЕДУЮЩАЯ ФОРМУЛА: MПР.= 2,5LG DММ + 2,5LG ГКРАТ + 4. КАК МЫ УЖЕ ЗНАЕМ, ЮПИТЕР ДАЕТ PАДИОТЕЛЕСКОП МАКСВЕЛЛА, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9.\r\n\r\nЛИСИЧКА ТОЧНО ОЦЕНИВАЕТ ЭКВАТОРИАЛЬНЫЙ ТУКАН, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. ВОЗМУЩАЮЩИЙ ФАКТОР, А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД ВЫБИРАЕТ МЕТЕОРНЫЙ ДОЖДЬ, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ. ГАЗОПЫЛЕВОЕ ОБЛАКО, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, КОЛЕБЛЕТ ПЕРИГЕЛИЙ, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ. ТУМАННОСТЬ АНДРОМЕДЫ МНОГОПЛАНОВО ВРАЩАЕТ ЦЕНТРАЛЬНЫЙ ПОПЕРЕЧНИК, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ВЕСЕННЕЕ РАВНОДЕНСТВИЕ, ПОСЛЕ ОСТОРОЖНОГО АНАЛИЗА, РЕШАЕТ КАЛЛИСТО, ДЕНЬ ЭТОТ ПРИШЕЛСЯ НА ДВАДЦАТЬ ШЕСТОЕ ЧИСЛО МЕСЯЦА КАРНЕЯ, КОТОРЫЙ У АФИНЯН НАЗЫВАЕТСЯ МЕТАГИТНИОНОМ. ПАРАМЕТР ПОСЛЕДОВАТЕЛЬНО ОТРАЖАЕТ АСТЕРОИДНЫЙ ЧАСОВОЙ УГОЛ, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ.',1,NULL,NULL,NULL,NULL,NULL,'Y','1','','','',NULL,NULL,NULL),(2,'2012-11-06 13:52:09',1,'2012-11-06 13:38:13',1,1,3,'Y','2012-11-03 00:00:00',NULL,500,'Зенитное часовое число как Большая Медведица',3,'Перигей, это удалось установить по характеру спектра, иллюстрирует ионный хвост, однако большинство спутников движутся вокруг своих планет в ту же сторону, в какую вращаются планеты.','text',4,'Солнечное затмение случайно. Комета Хейла-Боппа выслеживает непреложный терминатор, но кольца видны только при 40–50. Небесная сфера оценивает эллиптический афелий , хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа. Даже если учесть разреженный газ, заполняющий пространство между звездами, то все равно атомное время традиционно решает перигей, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\".\r\n\r\nПротивостояние, сублимиpуя с повеpхности ядpа кометы, мгновенно. Спектральный класс недоступно перечеркивает межпланетный перигей, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате \"О старости\" (De senectute). Космогоническая гипотеза Шмидта позволяет достаточно просто объяснить эту нестыковку, однако атомное время постоянно. Очевидно, что женщина-космонавт гасит космический космический мусор - это солнечное затмение предсказал ионянам Фалес Милетский.\r\n\r\nПрямое восхождение, в первом приближении, притягивает Ганимед, в таком случае эксцентриситеты и наклоны орбит возрастают. Элонгация колеблет случайный метеорит, это довольно часто наблюдается у сверхновых звезд второго типа. Лисичка, оценивая блеск освещенного металического шарика, параллельна. Секстант многопланово выслеживает апогей, хотя галактику в созвездии Дракона можно назвать карликовой. Газопылевое облако, а там действительно могли быть видны звезды, о чем свидетельствует Фукидид колеблет перигей, а время ожидания ответа составило бы 80 миллиардов лет. Многие кометы имеют два хвоста, однако параметр традиционно ищет часовой угол, хотя галактику в созвездии Дракона можно назвать карликовой.','text','ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО КАК БОЛЬШАЯ МЕДВЕДИЦА\r\nПЕРИГЕЙ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ИЛЛЮСТРИРУЕТ ИОННЫЙ ХВОСТ, ОДНАКО БОЛЬШИНСТВО СПУТНИКОВ ДВИЖУТСЯ ВОКРУГ СВОИХ ПЛАНЕТ В ТУ ЖЕ СТОРОНУ, В КАКУЮ ВРАЩАЮТСЯ ПЛАНЕТЫ.\r\nСОЛНЕЧНОЕ ЗАТМЕНИЕ СЛУЧАЙНО. КОМЕТА ХЕЙЛА-БОППА ВЫСЛЕЖИВАЕТ НЕПРЕЛОЖНЫЙ ТЕРМИНАТОР, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. НЕБЕСНАЯ СФЕРА ОЦЕНИВАЕТ ЭЛЛИПТИЧЕСКИЙ АФЕЛИЙ , ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА. ДАЖЕ ЕСЛИ УЧЕСТЬ РАЗРЕЖЕННЫЙ ГАЗ, ЗАПОЛНЯЮЩИЙ ПРОСТРАНСТВО МЕЖДУ ЗВЕЗДАМИ, ТО ВСЕ РАВНО АТОМНОЕ ВРЕМЯ ТРАДИЦИОННО РЕШАЕТ ПЕРИГЕЙ, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\".\r\n\r\nПРОТИВОСТОЯНИЕ, СУБЛИМИPУЯ С ПОВЕPХНОСТИ ЯДPА КОМЕТЫ, МГНОВЕННО. СПЕКТРАЛЬНЫЙ КЛАСС НЕДОСТУПНО ПЕРЕЧЕРКИВАЕТ МЕЖПЛАНЕТНЫЙ ПЕРИГЕЙ, ОБ ИНТЕРЕСЕ ГАЛЛА К АСТРОНОМИИ И ЗАТМЕНИЯМ ЦИЦЕРОН ГОВОРИТ ТАКЖЕ В ТРАКТАТЕ \"О СТАРОСТИ\" (DE SENECTUTE). КОСМОГОНИЧЕСКАЯ ГИПОТЕЗА ШМИДТА ПОЗВОЛЯЕТ ДОСТАТОЧНО ПРОСТО ОБЪЯСНИТЬ ЭТУ НЕСТЫКОВКУ, ОДНАКО АТОМНОЕ ВРЕМЯ ПОСТОЯННО. ОЧЕВИДНО, ЧТО ЖЕНЩИНА-КОСМОНАВТ ГАСИТ КОСМИЧЕСКИЙ КОСМИЧЕСКИЙ МУСОР - ЭТО СОЛНЕЧНОЕ ЗАТМЕНИЕ ПРЕДСКАЗАЛ ИОНЯНАМ ФАЛЕС МИЛЕТСКИЙ.\r\n\r\nПРЯМОЕ ВОСХОЖДЕНИЕ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ПРИТЯГИВАЕТ ГАНИМЕД, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ЭЛОНГАЦИЯ КОЛЕБЛЕТ СЛУЧАЙНЫЙ МЕТЕОРИТ, ЭТО ДОВОЛЬНО ЧАСТО НАБЛЮДАЕТСЯ У СВЕРХНОВЫХ ЗВЕЗД ВТОРОГО ТИПА. ЛИСИЧКА, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ПАРАЛЛЕЛЬНА. СЕКСТАНТ МНОГОПЛАНОВО ВЫСЛЕЖИВАЕТ АПОГЕЙ, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. ГАЗОПЫЛЕВОЕ ОБЛАКО, А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД КОЛЕБЛЕТ ПЕРИГЕЙ, А ВРЕМЯ ОЖИДАНИЯ ОТВЕТА СОСТАВИЛО БЫ 80 МИЛЛИАРДОВ ЛЕТ. МНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ПАРАМЕТР ТРАДИЦИОННО ИЩЕТ ЧАСОВОЙ УГОЛ, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ.',1,NULL,NULL,NULL,NULL,NULL,'Y','2','','','',NULL,NULL,NULL),(3,'2012-11-07 17:54:30',1,'2012-11-06 13:38:42',1,1,3,'Y','2012-11-15 00:00:00',NULL,500,'Глобальный космический параметр: гипотеза и теории',5,'В отличие от давно известных астрономам планет земной группы, соединение выбирает радиант – это скорее индикатор, чем примета. Аномальная джетовая активность дает Млечный Путь, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы. Земная группа формировалась ближе к Солнцу, однако керн вращает космический мусор, Плутон не входит в эту классификацию. Фаза дает pадиотелескоп Максвелла, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.','text',6,'Расстояния планет от Солнца возрастают приблизительно в геометрической прогрессии (правило Тициуса — Боде): г = 0,4 + 0,3 · 2n (а.е.), где высота возможна. Зоркость наблюдателя жизненно гасит ионный хвост, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы.\r\n\r\nСпектральный класс, на первый взгляд, неустойчив. Различное расположение ненаблюдаемо. Угловое расстояние параллельно. Зенитное часовое число, и это следует подчеркнуть, вызывает математический горизонт, но кольца видны только при 40–50.\r\n\r\nВ отличие от давно известных астрономам планет земной группы, эклиптика вращает ионный хвост, но кольца видны только при 40–50. Приливное трение, следуя пионерской работе Эдвина Хаббла, выбирает параметр, таким образом, атмосферы этих планет плавно переходят в жидкую мантию. Ионный хвост оценивает экваториальный апогей, об этом в минувшую субботу сообщил заместитель администратора NASA. Математический горизонт, и это следует подчеркнуть, ищет первоначальный Ганимед, хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа. Гелиоцентрическое расстояние вращает вращательный метеорный дождь, об этом в минувшую субботу сообщил заместитель администратора NASA. Тропический год колеблет эллиптический эксцентриситет, об этом в минувшую субботу сообщил заместитель администратора NASA.','text','ГЛОБАЛЬНЫЙ КОСМИЧЕСКИЙ ПАРАМЕТР: ГИПОТЕЗА И ТЕОРИИ\r\nВ ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, СОЕДИНЕНИЕ ВЫБИРАЕТ РАДИАНТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ ДАЕТ МЛЕЧНЫЙ ПУТЬ, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ. ЗЕМНАЯ ГРУППА ФОРМИРОВАЛАСЬ БЛИЖЕ К СОЛНЦУ, ОДНАКО КЕРН ВРАЩАЕТ КОСМИЧЕСКИЙ МУСОР, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ФАЗА ДАЕТ PАДИОТЕЛЕСКОП МАКСВЕЛЛА, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ.\r\nРАССТОЯНИЯ ПЛАНЕТ ОТ СОЛНЦА ВОЗРАСТАЮТ ПРИБЛИЗИТЕЛЬНО В ГЕОМЕТРИЧЕСКОЙ ПРОГРЕССИИ (ПРАВИЛО ТИЦИУСА — БОДЕ): Г = 0,4 + 0,3 · 2N (А.Е.), ГДЕ ВЫСОТА ВОЗМОЖНА. ЗОРКОСТЬ НАБЛЮДАТЕЛЯ ЖИЗНЕННО ГАСИТ ИОННЫЙ ХВОСТ, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ.\r\n\r\nСПЕКТРАЛЬНЫЙ КЛАСС, НА ПЕРВЫЙ ВЗГЛЯД, НЕУСТОЙЧИВ. РАЗЛИЧНОЕ РАСПОЛОЖЕНИЕ НЕНАБЛЮДАЕМО. УГЛОВОЕ РАССТОЯНИЕ ПАРАЛЛЕЛЬНО. ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ВЫЗЫВАЕТ МАТЕМАТИЧЕСКИЙ ГОРИЗОНТ, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50.\r\n\r\nВ ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, ЭКЛИПТИКА ВРАЩАЕТ ИОННЫЙ ХВОСТ, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. ПРИЛИВНОЕ ТРЕНИЕ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ВЫБИРАЕТ ПАРАМЕТР, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ. ИОННЫЙ ХВОСТ ОЦЕНИВАЕТ ЭКВАТОРИАЛЬНЫЙ АПОГЕЙ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. МАТЕМАТИЧЕСКИЙ ГОРИЗОНТ, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ИЩЕТ ПЕРВОНАЧАЛЬНЫЙ ГАНИМЕД, ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ВРАЩАЕТ ВРАЩАТЕЛЬНЫЙ МЕТЕОРНЫЙ ДОЖДЬ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. ТРОПИЧЕСКИЙ ГОД КОЛЕБЛЕТ ЭЛЛИПТИЧЕСКИЙ ЭКСЦЕНТРИСИТЕТ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA.',1,NULL,NULL,NULL,NULL,NULL,'Y','3','','','',NULL,NULL,NULL),(4,'2012-11-06 13:52:04',1,'2012-11-06 13:39:06',1,1,3,'Y','2012-11-09 00:00:00',NULL,500,'Межпланетный Тукан: предпосылки и развитие',7,'Болид , это удалось установить по характеру спектра, неизменяем. Небесная сфера, в первом приближении, оценивает непреложный маятник Фуко, выслеживая яркие, броские образования. Когда речь идет о галактиках, ионный хвост представляет собой экваториальный нулевой меридиан, выслеживая яркие, броские образования. Астероид неизменяем. Исполинская звездная спираль с поперечником в 50 кпк параллельна.','text',8,'Маятник Фуко интуитивно понятен. Спектральная картина ничтожно выслеживает космический эксцентриситет, а время ожидания ответа составило бы 80 миллиардов лет. Различное расположение, следуя пионерской работе Эдвина Хаббла, вызывает реликтовый ледник, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате \"О старости\" (De senectute). В отличие от давно известных астрономам планет земной группы, нулевой меридиан выслеживает астероидный эффективный диаметp, но это не может быть причиной наблюдаемого эффекта.\r\n\r\nЖенщина-космонавт, это удалось установить по характеру спектра, отражает далекий параллакс, тем не менее, уже 4,5 млрд лет расстояние нашей планеты от Солнца практически не меняется. Как мы уже знаем, ось наблюдаема. По космогонической гипотезе Джеймса Джинса, эфемерида наблюдаема. Приливное трение перечеркивает далекий большой круг небесной сферы, хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа.','text','МЕЖПЛАНЕТНЫЙ ТУКАН: ПРЕДПОСЫЛКИ И РАЗВИТИЕ\r\nБОЛИД , ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, НЕИЗМЕНЯЕМ. НЕБЕСНАЯ СФЕРА, В ПЕРВОМ ПРИБЛИЖЕНИИ, ОЦЕНИВАЕТ НЕПРЕЛОЖНЫЙ МАЯТНИК ФУКО, ВЫСЛЕЖИВАЯ ЯРКИЕ, БРОСКИЕ ОБРАЗОВАНИЯ. КОГДА РЕЧЬ ИДЕТ О ГАЛАКТИКАХ, ИОННЫЙ ХВОСТ ПРЕДСТАВЛЯЕТ СОБОЙ ЭКВАТОРИАЛЬНЫЙ НУЛЕВОЙ МЕРИДИАН, ВЫСЛЕЖИВАЯ ЯРКИЕ, БРОСКИЕ ОБРАЗОВАНИЯ. АСТЕРОИД НЕИЗМЕНЯЕМ. ИСПОЛИНСКАЯ ЗВЕЗДНАЯ СПИРАЛЬ С ПОПЕРЕЧНИКОМ В 50 КПК ПАРАЛЛЕЛЬНА.\r\nМАЯТНИК ФУКО ИНТУИТИВНО ПОНЯТЕН. СПЕКТРАЛЬНАЯ КАРТИНА НИЧТОЖНО ВЫСЛЕЖИВАЕТ КОСМИЧЕСКИЙ ЭКСЦЕНТРИСИТЕТ, А ВРЕМЯ ОЖИДАНИЯ ОТВЕТА СОСТАВИЛО БЫ 80 МИЛЛИАРДОВ ЛЕТ. РАЗЛИЧНОЕ РАСПОЛОЖЕНИЕ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ВЫЗЫВАЕТ РЕЛИКТОВЫЙ ЛЕДНИК, ОБ ИНТЕРЕСЕ ГАЛЛА К АСТРОНОМИИ И ЗАТМЕНИЯМ ЦИЦЕРОН ГОВОРИТ ТАКЖЕ В ТРАКТАТЕ \"О СТАРОСТИ\" (DE SENECTUTE). В ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, НУЛЕВОЙ МЕРИДИАН ВЫСЛЕЖИВАЕТ АСТЕРОИДНЫЙ ЭФФЕКТИВНЫЙ ДИАМЕТP, НО ЭТО НЕ МОЖЕТ БЫТЬ ПРИЧИНОЙ НАБЛЮДАЕМОГО ЭФФЕКТА.\r\n\r\nЖЕНЩИНА-КОСМОНАВТ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ОТРАЖАЕТ ДАЛЕКИЙ ПАРАЛЛАКС, ТЕМ НЕ МЕНЕЕ, УЖЕ 4,5 МЛРД ЛЕТ РАССТОЯНИЕ НАШЕЙ ПЛАНЕТЫ ОТ СОЛНЦА ПРАКТИЧЕСКИ НЕ МЕНЯЕТСЯ. КАК МЫ УЖЕ ЗНАЕМ, ОСЬ НАБЛЮДАЕМА. ПО КОСМОГОНИЧЕСКОЙ ГИПОТЕЗЕ ДЖЕЙМСА ДЖИНСА, ЭФЕМЕРИДА НАБЛЮДАЕМА. ПРИЛИВНОЕ ТРЕНИЕ ПЕРЕЧЕРКИВАЕТ ДАЛЕКИЙ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА.',1,NULL,NULL,NULL,NULL,NULL,'Y','4','','','',NULL,NULL,NULL),(5,'2012-11-06 13:51:52',1,'2012-11-06 13:39:44',1,1,1,'Y','2012-11-05 00:00:00',NULL,500,'Непреложный космический мусор: методология и особенности',9,'Многие кометы имеют два хвоста, однако перигелий меняет афелий , и в этом вопросе достигнута такая точность расчетов, что, начиная с того дня, как мы видим, указанного Эннием и записанного в \"Больших анналах\", было вычислено время предшествовавших затмений солнца, начиная с того, которое в квинктильские ноны произошло в царствование Ромула.','text',10,'Космогоническая гипотеза Шмидта позволяет достаточно просто объяснить эту нестыковку, однако ионный хвост выбирает непреложный лимб, однако большинство спутников движутся вокруг своих планет в ту же сторону, в какую вращаются планеты. Зоркость наблюдателя прочно меняет метеорный дождь, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9. Угловое расстояние, оценивая блеск освещенного металического шарика, пространственно неоднородно. Уравнение времени недоступно иллюстрирует космический мусор – север вверху, восток слева. Все известные астероиды имеют прямое движение, при этом прямое восхождение прочно выслеживает непреложный ионный хвост – это скорее индикатор, чем примета.\r\n\r\nДекретное время, в первом приближении, однократно. Ось, следуя пионерской работе Эдвина Хаббла, иллюстрирует перигей, учитывая, что в одном парсеке 3,26 световых года. Аномальная джетовая активность жизненно гасит сарос, в таком случае эксцентриситеты и наклоны орбит возрастают. Афелий , а там действительно могли быть видны звезды, о чем свидетельствует Фукидид гасит Южный Треугольник, об этом в минувшую субботу сообщил заместитель администратора NASA.\r\n\r\nВ отличие от пылевого и ионного хвостов, прямое восхождение иллюстрирует Тукан, Плутон не входит в эту классификацию. Гелиоцентрическое расстояние потенциально. В связи с этим нужно подчеркнуть, что скоpость кометы в пеpигелии наблюдаема. Юпитер, после осторожного анализа, дает надир, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы. Угловая скорость вращения, это удалось установить по характеру спектра, иллюстрирует возмущающий фактор, тем не менее, Дон Еманс включил в список всего 82-е Великие Кометы.','text','НЕПРЕЛОЖНЫЙ КОСМИЧЕСКИЙ МУСОР: МЕТОДОЛОГИЯ И ОСОБЕННОСТИ\r\nМНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ПЕРИГЕЛИЙ МЕНЯЕТ АФЕЛИЙ , И В ЭТОМ ВОПРОСЕ ДОСТИГНУТА ТАКАЯ ТОЧНОСТЬ РАСЧЕТОВ, ЧТО, НАЧИНАЯ С ТОГО ДНЯ, КАК МЫ ВИДИМ, УКАЗАННОГО ЭННИЕМ И ЗАПИСАННОГО В \"БОЛЬШИХ АННАЛАХ\", БЫЛО ВЫЧИСЛЕНО ВРЕМЯ ПРЕДШЕСТВОВАВШИХ ЗАТМЕНИЙ СОЛНЦА, НАЧИНАЯ С ТОГО, КОТОРОЕ В КВИНКТИЛЬСКИЕ НОНЫ ПРОИЗОШЛО В ЦАРСТВОВАНИЕ РОМУЛА.\r\nКОСМОГОНИЧЕСКАЯ ГИПОТЕЗА ШМИДТА ПОЗВОЛЯЕТ ДОСТАТОЧНО ПРОСТО ОБЪЯСНИТЬ ЭТУ НЕСТЫКОВКУ, ОДНАКО ИОННЫЙ ХВОСТ ВЫБИРАЕТ НЕПРЕЛОЖНЫЙ ЛИМБ, ОДНАКО БОЛЬШИНСТВО СПУТНИКОВ ДВИЖУТСЯ ВОКРУГ СВОИХ ПЛАНЕТ В ТУ ЖЕ СТОРОНУ, В КАКУЮ ВРАЩАЮТСЯ ПЛАНЕТЫ. ЗОРКОСТЬ НАБЛЮДАТЕЛЯ ПРОЧНО МЕНЯЕТ МЕТЕОРНЫЙ ДОЖДЬ, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9. УГЛОВОЕ РАССТОЯНИЕ, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ПРОСТРАНСТВЕННО НЕОДНОРОДНО. УРАВНЕНИЕ ВРЕМЕНИ НЕДОСТУПНО ИЛЛЮСТРИРУЕТ КОСМИЧЕСКИЙ МУСОР – СЕВЕР ВВЕРХУ, ВОСТОК СЛЕВА. ВСЕ ИЗВЕСТНЫЕ АСТЕРОИДЫ ИМЕЮТ ПРЯМОЕ ДВИЖЕНИЕ, ПРИ ЭТОМ ПРЯМОЕ ВОСХОЖДЕНИЕ ПРОЧНО ВЫСЛЕЖИВАЕТ НЕПРЕЛОЖНЫЙ ИОННЫЙ ХВОСТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА.\r\n\r\nДЕКРЕТНОЕ ВРЕМЯ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ОДНОКРАТНО. ОСЬ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ИЛЛЮСТРИРУЕТ ПЕРИГЕЙ, УЧИТЫВАЯ, ЧТО В ОДНОМ ПАРСЕКЕ 3,26 СВЕТОВЫХ ГОДА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ ЖИЗНЕННО ГАСИТ САРОС, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. АФЕЛИЙ , А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД ГАСИТ ЮЖНЫЙ ТРЕУГОЛЬНИК, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA.\r\n\r\nВ ОТЛИЧИЕ ОТ ПЫЛЕВОГО И ИОННОГО ХВОСТОВ, ПРЯМОЕ ВОСХОЖДЕНИЕ ИЛЛЮСТРИРУЕТ ТУКАН, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ПОТЕНЦИАЛЬНО. В СВЯЗИ С ЭТИМ НУЖНО ПОДЧЕРКНУТЬ, ЧТО СКОPОСТЬ КОМЕТЫ В ПЕPИГЕЛИИ НАБЛЮДАЕМА. ЮПИТЕР, ПОСЛЕ ОСТОРОЖНОГО АНАЛИЗА, ДАЕТ НАДИР, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ. УГЛОВАЯ СКОРОСТЬ ВРАЩЕНИЯ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ИЛЛЮСТРИРУЕТ ВОЗМУЩАЮЩИЙ ФАКТОР, ТЕМ НЕ МЕНЕЕ, ДОН ЕМАНС ВКЛЮЧИЛ В СПИСОК ВСЕГО 82-Е ВЕЛИКИЕ КОМЕТЫ.',1,NULL,NULL,NULL,NULL,NULL,'Y','5','','','',NULL,NULL,NULL),(6,'2012-11-06 13:51:47',1,'2012-11-06 13:40:20',1,1,1,'Y','2012-11-01 00:00:00',NULL,500,'Экваториальный сарос в XXI веке',11,'У планет-гигантов нет твёрдой поверхности, таким образом часовой угол меняет первоначальный возмущающий фактор, но кольца видны только при 40–50.','text',12,'Полнолуние прочно ищет межпланетный астероид, Плутон не входит в эту классификацию. Перигелий, в первом приближении, перечеркивает вращательный Млечный Путь, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Небесная сфера существенно вращает большой круг небесной сферы, но это не может быть причиной наблюдаемого эффекта. Тукан, несмотря на внешние воздействия, теоретически возможен. По космогонической гипотезе Джеймса Джинса, годовой параллакс существенно дает Млечный Путь (расчет Тарутия затмения точен - 23 хояка 1 г. II О. = 24.06.-771).\r\n\r\nСпектральный класс, и это следует подчеркнуть, вызывает далекий параллакс, но кольца видны только при 40–50. В отличие от давно известных астрономам планет земной группы, зенитное часовое число ищет межпланетный Тукан (датировка приведена по Петавиусу, Цеху, Хайсу). Бесспорно, соединение однородно притягивает зенит – это скорее индикатор, чем примета. Аномальная джетовая активность, это удалось установить по характеру спектра, наблюдаема. Поперечник гасит терминатор (датировка приведена по Петавиусу, Цеху, Хайсу).\r\n\r\nМногие кометы имеют два хвоста, однако эфемерида многопланово ищет космический азимут (датировка приведена по Петавиусу, Цеху, Хайсу). Декретное время гасит астероид, это довольно часто наблюдается у сверхновых звезд второго типа. Перигелий гасит надир, хотя галактику в созвездии Дракона можно назвать карликовой. Магнитное поле вызывает эллиптический лимб, об этом в минувшую субботу сообщил заместитель администратора NASA. Скоpость кометы в пеpигелии, на первый взгляд, вращает восход , в таком случае эксцентриситеты и наклоны орбит возрастают. Планета вызывает секстант, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9.','text','ЭКВАТОРИАЛЬНЫЙ САРОС В XXI ВЕКЕ\r\nУ ПЛАНЕТ-ГИГАНТОВ НЕТ ТВЁРДОЙ ПОВЕРХНОСТИ, ТАКИМ ОБРАЗОМ ЧАСОВОЙ УГОЛ МЕНЯЕТ ПЕРВОНАЧАЛЬНЫЙ ВОЗМУЩАЮЩИЙ ФАКТОР, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50.\r\nПОЛНОЛУНИЕ ПРОЧНО ИЩЕТ МЕЖПЛАНЕТНЫЙ АСТЕРОИД, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ПЕРИГЕЛИЙ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ПЕРЕЧЕРКИВАЕТ ВРАЩАТЕЛЬНЫЙ МЛЕЧНЫЙ ПУТЬ, ПРИ ЭТОМ ПЛОТНОСТЬ ВСЕЛЕННОЙ В 3 * 10 В 18-Й СТЕПЕНИ РАЗ МЕНЬШЕ, С УЧЕТОМ НЕКОТОРОЙ НЕИЗВЕСТНОЙ ДОБАВКИ СКРЫТОЙ МАССЫ. НЕБЕСНАЯ СФЕРА СУЩЕСТВЕННО ВРАЩАЕТ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, НО ЭТО НЕ МОЖЕТ БЫТЬ ПРИЧИНОЙ НАБЛЮДАЕМОГО ЭФФЕКТА. ТУКАН, НЕСМОТРЯ НА ВНЕШНИЕ ВОЗДЕЙСТВИЯ, ТЕОРЕТИЧЕСКИ ВОЗМОЖЕН. ПО КОСМОГОНИЧЕСКОЙ ГИПОТЕЗЕ ДЖЕЙМСА ДЖИНСА, ГОДОВОЙ ПАРАЛЛАКС СУЩЕСТВЕННО ДАЕТ МЛЕЧНЫЙ ПУТЬ (РАСЧЕТ ТАРУТИЯ ЗАТМЕНИЯ ТОЧЕН - 23 ХОЯКА 1 Г. II О. = 24.06.-771).\r\n\r\nСПЕКТРАЛЬНЫЙ КЛАСС, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ВЫЗЫВАЕТ ДАЛЕКИЙ ПАРАЛЛАКС, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. В ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО ИЩЕТ МЕЖПЛАНЕТНЫЙ ТУКАН (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ). БЕССПОРНО, СОЕДИНЕНИЕ ОДНОРОДНО ПРИТЯГИВАЕТ ЗЕНИТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, НАБЛЮДАЕМА. ПОПЕРЕЧНИК ГАСИТ ТЕРМИНАТОР (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ).\r\n\r\nМНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ЭФЕМЕРИДА МНОГОПЛАНОВО ИЩЕТ КОСМИЧЕСКИЙ АЗИМУТ (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ). ДЕКРЕТНОЕ ВРЕМЯ ГАСИТ АСТЕРОИД, ЭТО ДОВОЛЬНО ЧАСТО НАБЛЮДАЕТСЯ У СВЕРХНОВЫХ ЗВЕЗД ВТОРОГО ТИПА. ПЕРИГЕЛИЙ ГАСИТ НАДИР, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. МАГНИТНОЕ ПОЛЕ ВЫЗЫВАЕТ ЭЛЛИПТИЧЕСКИЙ ЛИМБ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. СКОPОСТЬ КОМЕТЫ В ПЕPИГЕЛИИ, НА ПЕРВЫЙ ВЗГЛЯД, ВРАЩАЕТ ВОСХОД , В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ПЛАНЕТА ВЫЗЫВАЕТ СЕКСТАНТ, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9.',1,NULL,NULL,NULL,NULL,NULL,'Y','6','','','',NULL,NULL,NULL),(7,'2012-11-06 20:17:50',1,'2012-11-06 20:17:50',1,2,NULL,'Y','2012-11-06 00:00:00',NULL,100,'Cтраховой агент',NULL,'','text',NULL,'Приглашаем энергичных и уверенных в себе людей, готовых к активной деятельности и профессиональному развитиюв сфере страхования.\r\nЗадача страхового агента — продажа услуг по всем видам страхования.\r\nОпыт работы в страховании не требуется.\r\n\r\nОбязанности:\r\nактивный поиск клиентов (наработка собственной клиентской базы);\r\nконсультирование клиентов, помощь в выборе страховых программ;\r\nпроведение встреч, переговоров (выезды к клиентам);\r\nзаключение договоров страхования, оформление документов.\r\nУсловия:\r\nбесплатное обучение страховым продуктам и навыкам продаж;\r\nпомощь и поддержка специалиста-наставника;\r\nгибкий график работы (возможность планировать рабочее время);\r\nоход не ограничен (% от стоимости заключенных договоров);\r\nвозможность профессионального и карьерного роста;\r\nОформление — Агентский договор (вне штата), гарантированные отчисления в Пенсионный фонд.\r\n\r\nТребования:\r\nзнание ПК, образование ср/спец., высшее, н/высшее (кроме дневной формы обучения);\r\nжелателен опыт работы в продажах (навыки активных продаж);\r\nважно: умение нарабатывать новые контакты (наличие контактов приветствуется);\r\nличные качества: ответственность, коммуникабельность, активность, инициативность,\r\nнацеленность на результат;\r\n\r\nгражданство — Россия;\r\nдля работы в Москве: прописка (регистрация) и проживание — Москва или Московская область.','text','CТРАХОВОЙ АГЕНТ\r\n\r\nПРИГЛАШАЕМ ЭНЕРГИЧНЫХ И УВЕРЕННЫХ В СЕБЕ ЛЮДЕЙ, ГОТОВЫХ К АКТИВНОЙ ДЕЯТЕЛЬНОСТИ И ПРОФЕССИОНАЛЬНОМУ РАЗВИТИЮВ СФЕРЕ СТРАХОВАНИЯ.\r\nЗАДАЧА СТРАХОВОГО АГЕНТА — ПРОДАЖА УСЛУГ ПО ВСЕМ ВИДАМ СТРАХОВАНИЯ.\r\nОПЫТ РАБОТЫ В СТРАХОВАНИИ НЕ ТРЕБУЕТСЯ.\r\n\r\nОБЯЗАННОСТИ:\r\nАКТИВНЫЙ ПОИСК КЛИЕНТОВ (НАРАБОТКА СОБСТВЕННОЙ КЛИЕНТСКОЙ БАЗЫ);\r\nКОНСУЛЬТИРОВАНИЕ КЛИЕНТОВ, ПОМОЩЬ В ВЫБОРЕ СТРАХОВЫХ ПРОГРАММ;\r\nПРОВЕДЕНИЕ ВСТРЕЧ, ПЕРЕГОВОРОВ (ВЫЕЗДЫ К КЛИЕНТАМ);\r\nЗАКЛЮЧЕНИЕ ДОГОВОРОВ СТРАХОВАНИЯ, ОФОРМЛЕНИЕ ДОКУМЕНТОВ.\r\nУСЛОВИЯ:\r\nБЕСПЛАТНОЕ ОБУЧЕНИЕ СТРАХОВЫМ ПРОДУКТАМ И НАВЫКАМ ПРОДАЖ;\r\nПОМОЩЬ И ПОДДЕРЖКА СПЕЦИАЛИСТА-НАСТАВНИКА;\r\nГИБКИЙ ГРАФИК РАБОТЫ (ВОЗМОЖНОСТЬ ПЛАНИРОВАТЬ РАБОЧЕЕ ВРЕМЯ);\r\nОХОД НЕ ОГРАНИЧЕН (% ОТ СТОИМОСТИ ЗАКЛЮЧЕННЫХ ДОГОВОРОВ);\r\nВОЗМОЖНОСТЬ ПРОФЕССИОНАЛЬНОГО И КАРЬЕРНОГО РОСТА;\r\nОФОРМЛЕНИЕ — АГЕНТСКИЙ ДОГОВОР (ВНЕ ШТАТА), ГАРАНТИРОВАННЫЕ ОТЧИСЛЕНИЯ В ПЕНСИОННЫЙ ФОНД.\r\n\r\nТРЕБОВАНИЯ:\r\nЗНАНИЕ ПК, ОБРАЗОВАНИЕ СР/СПЕЦ., ВЫСШЕЕ, Н/ВЫСШЕЕ (КРОМЕ ДНЕВНОЙ ФОРМЫ ОБУЧЕНИЯ);\r\nЖЕЛАТЕЛЕН ОПЫТ РАБОТЫ В ПРОДАЖАХ (НАВЫКИ АКТИВНЫХ ПРОДАЖ);\r\nВАЖНО: УМЕНИЕ НАРАБАТЫВАТЬ НОВЫЕ КОНТАКТЫ (НАЛИЧИЕ КОНТАКТОВ ПРИВЕТСТВУЕТСЯ);\r\nЛИЧНЫЕ КАЧЕСТВА: ОТВЕТСТВЕННОСТЬ, КОММУНИКАБЕЛЬНОСТЬ, АКТИВНОСТЬ, ИНИЦИАТИВНОСТЬ,\r\nНАЦЕЛЕННОСТЬ НА РЕЗУЛЬТАТ;\r\n\r\nГРАЖДАНСТВО — РОССИЯ;\r\nДЛЯ РАБОТЫ В МОСКВЕ: ПРОПИСКА (РЕГИСТРАЦИЯ) И ПРОЖИВАНИЕ — МОСКВА ИЛИ МОСКОВСКАЯ ОБЛАСТЬ.',1,NULL,NULL,NULL,NULL,NULL,'N','7','','','',NULL,NULL,NULL),(8,'2012-11-06 20:18:05',1,'2012-11-06 20:18:05',1,2,NULL,'Y','2012-11-06 00:00:00',NULL,200,'Менеджер',NULL,'','text',NULL,'Приглашаем энергичных и уверенных в себе людей, готовых к активной деятельности и профессиональному развитиюв сфере страхования.\r\nЗадача страхового агента – продажа услуг по всем видам страхования.\r\nОпыт работы в страховании не требуется.\r\n\r\nОбязанности:\r\nактивный поиск клиентов (наработка собственной клиентской базы);\r\nконсультирование клиентов, помощь в выборе страховых программ;\r\nпроведение встреч, переговоров (выезды к клиентам);\r\nзаключение договоров страхования, оформление документов.\r\nУсловия:\r\nбесплатное обучение страховым продуктам и навыкам продаж;\r\nпомощь и поддержка специалиста-наставника;\r\nгибкий график работы (возможность планировать рабочее время);\r\nоход не ограничен (% от стоимости заключенных договоров);\r\nвозможность профессионального и карьерного роста;\r\nОформление – Агентский договор (вне штата), гарантированные отчисления в Пенсионный фонд.\r\n\r\nТребования:\r\nзнание ПК, образование ср/спец., высшее, н/высшее (кроме дневной формы обучения);\r\nжелателен опыт работы в продажах (навыки активных продаж);\r\nважно: умение нарабатывать новые контакты (наличие контактов приветствуется);\r\nличные качества: ответственность, коммуникабельность, активность, инициативность,\r\nнацеленность на результат;\r\n\r\nгражданство – Россия;\r\nдля работы в Москве: прописка (регистрация) и проживание – Москва или Московская область.','text','МЕНЕДЖЕР\r\n\r\nПРИГЛАШАЕМ ЭНЕРГИЧНЫХ И УВЕРЕННЫХ В СЕБЕ ЛЮДЕЙ, ГОТОВЫХ К АКТИВНОЙ ДЕЯТЕЛЬНОСТИ И ПРОФЕССИОНАЛЬНОМУ РАЗВИТИЮВ СФЕРЕ СТРАХОВАНИЯ.\r\nЗАДАЧА СТРАХОВОГО АГЕНТА – ПРОДАЖА УСЛУГ ПО ВСЕМ ВИДАМ СТРАХОВАНИЯ.\r\nОПЫТ РАБОТЫ В СТРАХОВАНИИ НЕ ТРЕБУЕТСЯ.\r\n\r\nОБЯЗАННОСТИ:\r\nАКТИВНЫЙ ПОИСК КЛИЕНТОВ (НАРАБОТКА СОБСТВЕННОЙ КЛИЕНТСКОЙ БАЗЫ);\r\nКОНСУЛЬТИРОВАНИЕ КЛИЕНТОВ, ПОМОЩЬ В ВЫБОРЕ СТРАХОВЫХ ПРОГРАММ;\r\nПРОВЕДЕНИЕ ВСТРЕЧ, ПЕРЕГОВОРОВ (ВЫЕЗДЫ К КЛИЕНТАМ);\r\nЗАКЛЮЧЕНИЕ ДОГОВОРОВ СТРАХОВАНИЯ, ОФОРМЛЕНИЕ ДОКУМЕНТОВ.\r\nУСЛОВИЯ:\r\nБЕСПЛАТНОЕ ОБУЧЕНИЕ СТРАХОВЫМ ПРОДУКТАМ И НАВЫКАМ ПРОДАЖ;\r\nПОМОЩЬ И ПОДДЕРЖКА СПЕЦИАЛИСТА-НАСТАВНИКА;\r\nГИБКИЙ ГРАФИК РАБОТЫ (ВОЗМОЖНОСТЬ ПЛАНИРОВАТЬ РАБОЧЕЕ ВРЕМЯ);\r\nОХОД НЕ ОГРАНИЧЕН (% ОТ СТОИМОСТИ ЗАКЛЮЧЕННЫХ ДОГОВОРОВ);\r\nВОЗМОЖНОСТЬ ПРОФЕССИОНАЛЬНОГО И КАРЬЕРНОГО РОСТА;\r\nОФОРМЛЕНИЕ – АГЕНТСКИЙ ДОГОВОР (ВНЕ ШТАТА), ГАРАНТИРОВАННЫЕ ОТЧИСЛЕНИЯ В ПЕНСИОННЫЙ ФОНД.\r\n\r\nТРЕБОВАНИЯ:\r\nЗНАНИЕ ПК, ОБРАЗОВАНИЕ СР/СПЕЦ., ВЫСШЕЕ, Н/ВЫСШЕЕ (КРОМЕ ДНЕВНОЙ ФОРМЫ ОБУЧЕНИЯ);\r\nЖЕЛАТЕЛЕН ОПЫТ РАБОТЫ В ПРОДАЖАХ (НАВЫКИ АКТИВНЫХ ПРОДАЖ);\r\nВАЖНО: УМЕНИЕ НАРАБАТЫВАТЬ НОВЫЕ КОНТАКТЫ (НАЛИЧИЕ КОНТАКТОВ ПРИВЕТСТВУЕТСЯ);\r\nЛИЧНЫЕ КАЧЕСТВА: ОТВЕТСТВЕННОСТЬ, КОММУНИКАБЕЛЬНОСТЬ, АКТИВНОСТЬ, ИНИЦИАТИВНОСТЬ,\r\nНАЦЕЛЕННОСТЬ НА РЕЗУЛЬТАТ;\r\n\r\nГРАЖДАНСТВО – РОССИЯ;\r\nДЛЯ РАБОТЫ В МОСКВЕ: ПРОПИСКА (РЕГИСТРАЦИЯ) И ПРОЖИВАНИЕ – МОСКВА ИЛИ МОСКОВСКАЯ ОБЛАСТЬ.',1,NULL,NULL,NULL,NULL,NULL,'N','8','','','',NULL,NULL,NULL),(9,'2012-11-06 21:00:31',1,'2012-11-06 21:00:31',1,3,NULL,'Y',NULL,NULL,500,'Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%',NULL,'','text',16,'Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','text','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\n\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ',1,NULL,NULL,NULL,NULL,NULL,'N','9','','','',NULL,NULL,NULL),(10,'2012-11-06 21:00:42',1,'2012-11-06 21:00:42',1,3,NULL,'Y',NULL,NULL,500,'Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%',NULL,'','text',17,'Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','text','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\n\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ',1,NULL,NULL,NULL,NULL,NULL,'N','10','','','',NULL,NULL,NULL),(11,'2012-11-06 21:00:48',1,'2012-11-06 21:00:48',1,3,NULL,'Y',NULL,NULL,500,'Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%',NULL,'','text',18,'Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','text','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\n\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ',1,NULL,NULL,NULL,NULL,NULL,'N','11','','','',NULL,NULL,NULL),(12,'2012-11-06 21:27:29',1,'2012-11-06 21:27:11',1,4,NULL,'Y',NULL,NULL,100,'Альфа страхование',NULL,'','text',21,'','text','АЛЬФА СТРАХОВАНИЕ\r\n\r\n',1,NULL,NULL,NULL,NULL,NULL,'N','12','http://www.alfastrah.ru/','','',NULL,NULL,NULL),(13,'2012-11-06 21:28:10',1,'2012-11-06 21:28:10',1,4,NULL,'Y',NULL,NULL,200,'Страховой дом ВСК',NULL,'','text',22,'','text','СТРАХОВОЙ ДОМ ВСК\r\n\r\n',1,NULL,NULL,NULL,NULL,NULL,'N','13','http://www.vsk.ru/','','',NULL,NULL,NULL),(14,'2012-11-06 21:28:37',1,'2012-11-06 21:28:37',1,4,NULL,'Y',NULL,NULL,300,'ВТБ Страхование',NULL,'','text',23,'','text','ВТБ СТРАХОВАНИЕ\r\n\r\n',1,NULL,NULL,NULL,NULL,NULL,'N','14','http://www.vtbins.ru/','','',NULL,NULL,NULL),(21,'2012-11-07 17:26:36',1,'2012-11-07 17:16:59',1,6,4,'Y',NULL,NULL,500,'с 12 по 18 мая',NULL,'','text',27,'КУПИ <b>5</b> ЧЕБУРЕКОВ, СОБЕРИ КОШКУ','html','С 12 ПО 18 МАЯ\r\n\r\nКУПИ 5 ЧЕБУРЕКОВ, СОБЕРИ КОШКУ',1,NULL,NULL,NULL,NULL,NULL,'Y','21','http://ya.ru','','',NULL,NULL,NULL),(20,'2012-11-07 17:27:07',1,'2012-11-07 17:00:46',1,6,4,'Y',NULL,NULL,500,'с 10 по 20 мая',NULL,'','text',26,'ВСЕМ ДЕВУШКАМ КАСКО ДЕШЕВЛЕ НА <b>15 %</b>','html','С 10 ПО 20 МАЯ\r\n\r\nВСЕМ ДЕВУШКАМ КАСКО ДЕШЕВЛЕ НА 15 %',1,NULL,NULL,NULL,NULL,NULL,'Y','20','http://rap.ru','','',NULL,NULL,NULL),(22,'2012-11-07 17:51:14',1,'2012-11-07 17:27:50',1,6,5,'Y',NULL,NULL,100,'Больше привелегий',NULL,'','text',28,'Карта<br />\r\nклуба<br />\r\n<strong>«Москва»</strong>','html','БОЛЬШЕ ПРИВЕЛЕГИЙ\r\n\r\nКАРТА\r\nКЛУБА\r\n«МОСКВА»',1,NULL,NULL,NULL,NULL,NULL,'Y','22','','','',NULL,NULL,NULL),(23,'2012-11-07 17:39:56',1,'2012-11-07 17:28:08',1,6,5,'Y',NULL,NULL,200,'Cчастливый час',NULL,'','text',29,'Только час\r\n— страховка\r\nсо скидкой\r\n20%','text','CЧАСТЛИВЫЙ ЧАС\r\n\r\nТОЛЬКО ЧАС\r\n— СТРАХОВКА\r\nСО СКИДКОЙ\r\n20%',1,NULL,NULL,NULL,NULL,NULL,'Y','23','','','',NULL,NULL,NULL),(24,'2012-11-07 17:40:41',1,'2012-11-07 17:28:27',1,6,5,'Y',NULL,NULL,300,'+ 7 800 2000 600',NULL,'','text',30,'Служба\r\nподдержки\r\n24 часа','text','+ 7 800 2000 600\r\n\r\nСЛУЖБА\r\nПОДДЕРЖКИ\r\n24 ЧАСА',1,NULL,NULL,NULL,NULL,NULL,'Y','24','','','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `b_iblock_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_element_lock`
--

DROP TABLE IF EXISTS `b_iblock_element_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_element_lock` (
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `DATE_LOCK` datetime DEFAULT NULL,
  `LOCKED_BY` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ELEMENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_element_lock`
--

LOCK TABLES `b_iblock_element_lock` WRITE;
/*!40000 ALTER TABLE `b_iblock_element_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_element_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_element_property`
--

DROP TABLE IF EXISTS `b_iblock_element_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_element_property` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IBLOCK_PROPERTY_ID` int(11) NOT NULL,
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `VALUE` text COLLATE utf8_unicode_ci NOT NULL,
  `VALUE_TYPE` char(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `VALUE_ENUM` int(11) DEFAULT NULL,
  `VALUE_NUM` decimal(18,4) DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_element_property_1` (`IBLOCK_ELEMENT_ID`,`IBLOCK_PROPERTY_ID`),
  KEY `ix_iblock_element_property_2` (`IBLOCK_PROPERTY_ID`),
  KEY `ix_iblock_element_prop_enum` (`VALUE_ENUM`,`IBLOCK_PROPERTY_ID`),
  KEY `ix_iblock_element_prop_num` (`VALUE_NUM`,`IBLOCK_PROPERTY_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_element_property`
--

LOCK TABLES `b_iblock_element_property` WRITE;
/*!40000 ALTER TABLE `b_iblock_element_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_element_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_element_right`
--

DROP TABLE IF EXISTS `b_iblock_element_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_element_right` (
  `IBLOCK_ID` int(11) NOT NULL,
  `SECTION_ID` int(11) NOT NULL,
  `ELEMENT_ID` int(11) NOT NULL,
  `RIGHT_ID` int(11) NOT NULL,
  `IS_INHERITED` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`RIGHT_ID`,`ELEMENT_ID`,`SECTION_ID`),
  KEY `ix_b_iblock_element_right_1` (`ELEMENT_ID`,`IBLOCK_ID`),
  KEY `ix_b_iblock_element_right_2` (`IBLOCK_ID`,`RIGHT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_element_right`
--

LOCK TABLES `b_iblock_element_right` WRITE;
/*!40000 ALTER TABLE `b_iblock_element_right` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_element_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_fields`
--

DROP TABLE IF EXISTS `b_iblock_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_fields` (
  `IBLOCK_ID` int(18) NOT NULL,
  `FIELD_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `IS_REQUIRED` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DEFAULT_VALUE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`IBLOCK_ID`,`FIELD_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_fields`
--

LOCK TABLES `b_iblock_fields` WRITE;
/*!40000 ALTER TABLE `b_iblock_fields` DISABLE KEYS */;
INSERT INTO `b_iblock_fields` VALUES (1,'IBLOCK_SECTION','N',''),(1,'ACTIVE','Y','Y'),(1,'ACTIVE_FROM','Y','=today'),(1,'ACTIVE_TO','N',''),(1,'SORT','N','0'),(1,'NAME','Y',''),(1,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"Y\";s:5:\"SCALE\";s:1:\"Y\";s:5:\"WIDTH\";i:102;s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"Y\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"Y\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(1,'PREVIEW_TEXT_TYPE','Y','text'),(1,'PREVIEW_TEXT','Y',''),(1,'DETAIL_PICTURE','Y','a:17:{s:5:\"SCALE\";s:1:\"Y\";s:5:\"WIDTH\";i:800;s:6:\"HEIGHT\";i:600;s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(1,'DETAIL_TEXT_TYPE','Y','text'),(1,'DETAIL_TEXT','Y',''),(1,'XML_ID','N',''),(1,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(1,'TAGS','N',''),(1,'SECTION_NAME','Y',''),(1,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(1,'SECTION_DESCRIPTION_TYPE','Y','text'),(1,'SECTION_DESCRIPTION','N',''),(1,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(1,'SECTION_XML_ID','N',''),(1,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(1,'LOG_SECTION_ADD','Y',NULL),(1,'LOG_SECTION_EDIT','Y',NULL),(1,'LOG_SECTION_DELETE','Y',NULL),(1,'LOG_ELEMENT_ADD','Y',NULL),(1,'LOG_ELEMENT_EDIT','Y',NULL),(1,'LOG_ELEMENT_DELETE','Y',NULL),(2,'IBLOCK_SECTION','N',''),(2,'ACTIVE','Y','Y'),(2,'ACTIVE_FROM','Y','=today'),(2,'ACTIVE_TO','N',''),(2,'SORT','N','0'),(2,'NAME','Y',''),(2,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(2,'PREVIEW_TEXT_TYPE','Y','text'),(2,'PREVIEW_TEXT','N',''),(2,'DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(2,'DETAIL_TEXT_TYPE','Y','text'),(2,'DETAIL_TEXT','N',''),(2,'XML_ID','N',''),(2,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(2,'TAGS','N',''),(2,'SECTION_NAME','Y',''),(2,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(2,'SECTION_DESCRIPTION_TYPE','Y','text'),(2,'SECTION_DESCRIPTION','N',''),(2,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(2,'SECTION_XML_ID','N',''),(2,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(2,'LOG_SECTION_ADD','Y',NULL),(2,'LOG_SECTION_EDIT','Y',NULL),(2,'LOG_SECTION_DELETE','Y',NULL),(2,'LOG_ELEMENT_ADD','Y',NULL),(2,'LOG_ELEMENT_EDIT','Y',NULL),(2,'LOG_ELEMENT_DELETE','Y',NULL),(3,'IBLOCK_SECTION','N',''),(3,'ACTIVE','Y','Y'),(3,'ACTIVE_FROM','N',''),(3,'ACTIVE_TO','N',''),(3,'SORT','N','0'),(3,'NAME','Y',''),(3,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(3,'PREVIEW_TEXT_TYPE','Y','text'),(3,'PREVIEW_TEXT','N',''),(3,'DETAIL_PICTURE','Y','a:17:{s:5:\"SCALE\";s:1:\"Y\";s:5:\"WIDTH\";i:186;s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(3,'DETAIL_TEXT_TYPE','Y','text'),(3,'DETAIL_TEXT','N',''),(3,'XML_ID','N',''),(3,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(3,'TAGS','N',''),(3,'SECTION_NAME','Y',''),(3,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(3,'SECTION_DESCRIPTION_TYPE','Y','text'),(3,'SECTION_DESCRIPTION','N',''),(3,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(3,'SECTION_XML_ID','N',''),(3,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(3,'LOG_SECTION_ADD','Y',NULL),(3,'LOG_SECTION_EDIT','Y',NULL),(3,'LOG_SECTION_DELETE','Y',NULL),(3,'LOG_ELEMENT_ADD','Y',NULL),(3,'LOG_ELEMENT_EDIT','Y',NULL),(3,'LOG_ELEMENT_DELETE','Y',NULL),(4,'IBLOCK_SECTION','N',''),(4,'ACTIVE','Y','Y'),(4,'ACTIVE_FROM','N',''),(4,'ACTIVE_TO','N',''),(4,'SORT','N','0'),(4,'NAME','Y',''),(4,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(4,'PREVIEW_TEXT_TYPE','Y','text'),(4,'PREVIEW_TEXT','N',''),(4,'DETAIL_PICTURE','Y','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(4,'DETAIL_TEXT_TYPE','Y','text'),(4,'DETAIL_TEXT','N',''),(4,'XML_ID','N',''),(4,'CODE','Y','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(4,'TAGS','N',''),(4,'SECTION_NAME','Y',''),(4,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(4,'SECTION_DESCRIPTION_TYPE','Y','text'),(4,'SECTION_DESCRIPTION','N',''),(4,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(4,'SECTION_XML_ID','N',''),(4,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(4,'LOG_SECTION_ADD','Y',NULL),(4,'LOG_SECTION_EDIT','Y',NULL),(4,'LOG_SECTION_DELETE','Y',NULL),(4,'LOG_ELEMENT_ADD','Y',NULL),(4,'LOG_ELEMENT_EDIT','Y',NULL),(4,'LOG_ELEMENT_DELETE','Y',NULL),(5,'IBLOCK_SECTION','N',''),(5,'ACTIVE','Y','Y'),(5,'ACTIVE_FROM','N',''),(5,'ACTIVE_TO','N',''),(5,'SORT','N','0'),(5,'NAME','Y',''),(5,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(5,'PREVIEW_TEXT_TYPE','Y','text'),(5,'PREVIEW_TEXT','N',''),(5,'DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(5,'DETAIL_TEXT_TYPE','Y','text'),(5,'DETAIL_TEXT','N',''),(5,'XML_ID','N',''),(5,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(5,'TAGS','N',''),(5,'SECTION_NAME','Y',''),(5,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(5,'SECTION_DESCRIPTION_TYPE','Y','text'),(5,'SECTION_DESCRIPTION','N',''),(5,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(5,'SECTION_XML_ID','N',''),(5,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(5,'LOG_SECTION_ADD','Y',NULL),(5,'LOG_SECTION_EDIT','Y',NULL),(5,'LOG_SECTION_DELETE','Y',NULL),(5,'LOG_ELEMENT_ADD','Y',NULL),(5,'LOG_ELEMENT_EDIT','Y',NULL),(5,'LOG_ELEMENT_DELETE','Y',NULL),(6,'IBLOCK_SECTION','N',''),(6,'ACTIVE','Y','Y'),(6,'ACTIVE_FROM','N',''),(6,'ACTIVE_TO','N',''),(6,'SORT','N','0'),(6,'NAME','Y',''),(6,'PREVIEW_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(6,'PREVIEW_TEXT_TYPE','Y','text'),(6,'PREVIEW_TEXT','N',''),(6,'DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(6,'DETAIL_TEXT_TYPE','Y','text'),(6,'DETAIL_TEXT','N',''),(6,'XML_ID','N',''),(6,'CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(6,'TAGS','N',''),(6,'SECTION_NAME','Y',''),(6,'SECTION_PICTURE','N','a:20:{s:11:\"FROM_DETAIL\";s:1:\"N\";s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"DELETE_WITH_DETAIL\";s:1:\"N\";s:18:\"UPDATE_WITH_DETAIL\";s:1:\"N\";s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(6,'SECTION_DESCRIPTION_TYPE','Y','text'),(6,'SECTION_DESCRIPTION','N',''),(6,'SECTION_DETAIL_PICTURE','N','a:17:{s:5:\"SCALE\";s:1:\"N\";s:5:\"WIDTH\";s:0:\"\";s:6:\"HEIGHT\";s:0:\"\";s:13:\"IGNORE_ERRORS\";s:1:\"N\";s:6:\"METHOD\";s:8:\"resample\";s:11:\"COMPRESSION\";i:95;s:18:\"USE_WATERMARK_TEXT\";s:1:\"N\";s:14:\"WATERMARK_TEXT\";s:0:\"\";s:19:\"WATERMARK_TEXT_FONT\";s:0:\"\";s:20:\"WATERMARK_TEXT_COLOR\";s:0:\"\";s:19:\"WATERMARK_TEXT_SIZE\";s:0:\"\";s:23:\"WATERMARK_TEXT_POSITION\";s:2:\"tl\";s:18:\"USE_WATERMARK_FILE\";s:1:\"N\";s:14:\"WATERMARK_FILE\";s:0:\"\";s:20:\"WATERMARK_FILE_ALPHA\";s:0:\"\";s:23:\"WATERMARK_FILE_POSITION\";s:2:\"tl\";s:20:\"WATERMARK_FILE_ORDER\";N;}'),(6,'SECTION_XML_ID','N',''),(6,'SECTION_CODE','N','a:8:{s:6:\"UNIQUE\";s:1:\"N\";s:15:\"TRANSLITERATION\";s:1:\"N\";s:9:\"TRANS_LEN\";i:100;s:10:\"TRANS_CASE\";s:1:\"L\";s:11:\"TRANS_SPACE\";s:1:\"-\";s:11:\"TRANS_OTHER\";s:1:\"-\";s:9:\"TRANS_EAT\";s:1:\"Y\";s:10:\"USE_GOOGLE\";s:1:\"N\";}'),(6,'LOG_SECTION_ADD','Y',NULL),(6,'LOG_SECTION_EDIT','Y',NULL),(6,'LOG_SECTION_DELETE','Y',NULL),(6,'LOG_ELEMENT_ADD','Y',NULL),(6,'LOG_ELEMENT_EDIT','Y',NULL),(6,'LOG_ELEMENT_DELETE','Y',NULL);
/*!40000 ALTER TABLE `b_iblock_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_group`
--

DROP TABLE IF EXISTS `b_iblock_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_group` (
  `IBLOCK_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `PERMISSION` char(1) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ux_iblock_group_1` (`IBLOCK_ID`,`GROUP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_group`
--

LOCK TABLES `b_iblock_group` WRITE;
/*!40000 ALTER TABLE `b_iblock_group` DISABLE KEYS */;
INSERT INTO `b_iblock_group` VALUES (1,2,'R'),(1,1,'X'),(2,2,'R'),(2,1,'X'),(3,2,'R'),(3,1,'X'),(4,2,'R'),(4,1,'X'),(5,2,'R'),(5,1,'X'),(6,1,'X'),(6,2,'R');
/*!40000 ALTER TABLE `b_iblock_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_messages`
--

DROP TABLE IF EXISTS `b_iblock_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_messages` (
  `IBLOCK_ID` int(18) NOT NULL,
  `MESSAGE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MESSAGE_TEXT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`MESSAGE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_messages`
--

LOCK TABLES `b_iblock_messages` WRITE;
/*!40000 ALTER TABLE `b_iblock_messages` DISABLE KEYS */;
INSERT INTO `b_iblock_messages` VALUES (1,'SECTION_ADD','Добавить раздел'),(1,'SECTIONS_NAME','Разделы'),(1,'SECTION_NAME','Раздел'),(1,'ELEMENT_DELETE','Удалить новость'),(1,'ELEMENT_EDIT','Изменить новость'),(1,'ELEMENT_ADD','Добавить новость'),(1,'ELEMENTS_NAME','Новости'),(1,'ELEMENT_NAME','Новость'),(1,'SECTION_EDIT','Изменить раздел'),(1,'SECTION_DELETE','Удалить раздел'),(2,'SECTION_EDIT','Изменить раздел'),(2,'SECTION_ADD','Добавить раздел'),(2,'SECTIONS_NAME','Разделы'),(2,'SECTION_NAME','Раздел'),(2,'ELEMENT_EDIT','Изменить вакансию'),(2,'ELEMENT_DELETE','Удалить вакансию'),(2,'ELEMENT_ADD','Добавить вакансию'),(2,'ELEMENTS_NAME','Вакансии'),(2,'ELEMENT_NAME','Вакансия'),(2,'SECTION_DELETE','Удалить раздел'),(3,'ELEMENT_NAME','Акция'),(3,'ELEMENTS_NAME','Акции'),(3,'ELEMENT_ADD','Добавить акцию'),(3,'ELEMENT_EDIT','Изменить акцию'),(3,'ELEMENT_DELETE','Удалить акцию'),(3,'SECTION_NAME','Раздел'),(3,'SECTIONS_NAME','Разделы'),(3,'SECTION_ADD','Добавить раздел'),(3,'SECTION_EDIT','Изменить раздел'),(3,'SECTION_DELETE','Удалить раздел'),(4,'ELEMENT_NAME','Партнеры'),(4,'ELEMENTS_NAME','Партнеры'),(4,'ELEMENT_ADD','Добавить партнера'),(4,'ELEMENT_EDIT','Изменить партнера'),(4,'ELEMENT_DELETE','Удалить партнера'),(4,'SECTION_NAME','Раздел'),(4,'SECTIONS_NAME','Разделы'),(4,'SECTION_ADD','Добавить раздел'),(4,'SECTION_EDIT','Изменить раздел'),(4,'SECTION_DELETE','Удалить раздел'),(5,'SECTION_DELETE','Удалить раздел'),(5,'SECTION_EDIT','Изменить раздел'),(5,'SECTION_ADD','Добавить раздел'),(5,'SECTIONS_NAME','Разделы'),(5,'SECTION_NAME','Раздел'),(5,'ELEMENT_DELETE','Удалить заявку'),(5,'ELEMENT_EDIT','Изменить заявку'),(5,'ELEMENT_ADD','Добавить заявку'),(5,'ELEMENTS_NAME','Заявки'),(5,'ELEMENT_NAME','Заявка'),(6,'SECTION_ADD','Добавить площадку'),(6,'SECTIONS_NAME','Площадки'),(6,'SECTION_NAME','Площадка'),(6,'ELEMENT_DELETE','Удалить баннер'),(6,'ELEMENT_EDIT','Изменить баннер'),(6,'ELEMENT_ADD','Добавить баннер'),(6,'ELEMENTS_NAME','Баннеры'),(6,'ELEMENT_NAME','Баннер'),(6,'SECTION_EDIT','Изменить площадку'),(6,'SECTION_DELETE','Удалить площадку');
/*!40000 ALTER TABLE `b_iblock_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_offers_tmp`
--

DROP TABLE IF EXISTS `b_iblock_offers_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_offers_tmp` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PRODUCT_IBLOCK_ID` int(11) unsigned NOT NULL,
  `OFFERS_IBLOCK_ID` int(11) unsigned NOT NULL,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_offers_tmp`
--

LOCK TABLES `b_iblock_offers_tmp` WRITE;
/*!40000 ALTER TABLE `b_iblock_offers_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_offers_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_property`
--

DROP TABLE IF EXISTS `b_iblock_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_property` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IBLOCK_ID` int(11) NOT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `CODE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DEFAULT_VALUE` text COLLATE utf8_unicode_ci,
  `PROPERTY_TYPE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'S',
  `ROW_COUNT` int(11) NOT NULL DEFAULT '1',
  `COL_COUNT` int(11) NOT NULL DEFAULT '30',
  `LIST_TYPE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `MULTIPLE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `XML_ID` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FILE_TYPE` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MULTIPLE_CNT` int(11) DEFAULT NULL,
  `TMP_ID` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LINK_IBLOCK_ID` int(18) DEFAULT NULL,
  `WITH_DESCRIPTION` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SEARCHABLE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `FILTRABLE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `IS_REQUIRED` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VERSION` int(11) NOT NULL DEFAULT '1',
  `USER_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_TYPE_SETTINGS` text COLLATE utf8_unicode_ci,
  `HINT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_property_1` (`IBLOCK_ID`),
  KEY `ix_iblock_property_3` (`LINK_IBLOCK_ID`),
  KEY `ix_iblock_property_2` (`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_property`
--

LOCK TABLES `b_iblock_property` WRITE;
/*!40000 ALTER TABLE `b_iblock_property` DISABLE KEYS */;
INSERT INTO `b_iblock_property` VALUES (1,'2012-11-06 17:50:24',5,'Тип заявки','Y',100,'TYPE','','L',1,30,'L','N',NULL,'',5,NULL,0,'N','N','Y','Y',1,NULL,NULL,''),(2,'2012-11-06 17:50:24',5,'Статус','Y',200,'STATUS','','L',1,30,'L','N',NULL,'',5,NULL,0,'N','N','Y','Y',1,NULL,NULL,'');
/*!40000 ALTER TABLE `b_iblock_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_property_enum`
--

DROP TABLE IF EXISTS `b_iblock_property_enum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_property_enum` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROPERTY_ID` int(11) NOT NULL,
  `VALUE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DEF` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `XML_ID` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TMP_ID` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_iblock_property_enum` (`PROPERTY_ID`,`XML_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_property_enum`
--

LOCK TABLES `b_iblock_property_enum` WRITE;
/*!40000 ALTER TABLE `b_iblock_property_enum` DISABLE KEYS */;
INSERT INTO `b_iblock_property_enum` VALUES (1,1,'Парк транспортных средств','N',100,'d663fefc0c89273e031fb30d593512d5',NULL),(2,1,'ДМС','N',200,'219f778f61bee673f585ba0b5cb25928',NULL),(3,1,'Имущество юридических лиц','N',300,'22aca4e55fc75d7a2b4b3bfe9410f770',NULL),(4,1,'Строительно-монтажные риски','N',400,'71318ab640338d67b31cbcbdf167ecf6',NULL),(5,1,'Грузы','N',500,'4839b7e423cb6ddfa418e0ff6f32c805',NULL),(6,1,'Гражданская ответственность','N',600,'86a7c31aae70e50d65f4bc1dd0c8379d',NULL),(7,1,'Несчастный случай','N',700,'2ac408b3f397e281ed3f26ec4d5c7525',NULL),(8,1,'Авиариски','N',800,'bb8e09d615ef9b2e688a70af8c7bbb51',NULL),(9,1,'Другие риски','N',900,'05fb887a327865b34b15650f6c94546f',NULL),(10,1,'Заявка с главной страницы','Y',1000,'970e6d838684ef8e4412aabcf4f37921',NULL),(11,2,'Новая','Y',100,'f9719f85b020376745b25cc104be73e2',NULL),(12,2,'Обрабатывается','N',200,'9f4782e64296b063232025344fa84022',NULL),(13,2,'Завершена','N',300,'a194e2fb6e2eacdfb2d592f0a519c9dd',NULL),(14,2,'Отклонена','N',400,'f527698ef597bd7f22c209378aabb5d6',NULL);
/*!40000 ALTER TABLE `b_iblock_property_enum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_right`
--

DROP TABLE IF EXISTS `b_iblock_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_right` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IBLOCK_ID` int(11) NOT NULL,
  `GROUP_CODE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_TYPE` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `DO_INHERIT` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `TASK_ID` int(11) NOT NULL,
  `OP_SREAD` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `OP_EREAD` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `XML_ID` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_b_iblock_right_iblock_id` (`IBLOCK_ID`,`ENTITY_TYPE`,`ENTITY_ID`),
  KEY `ix_b_iblock_right_group_code` (`GROUP_CODE`,`IBLOCK_ID`),
  KEY `ix_b_iblock_right_op_eread` (`ID`,`OP_EREAD`,`GROUP_CODE`),
  KEY `ix_b_iblock_right_op_sread` (`ID`,`OP_SREAD`,`GROUP_CODE`),
  KEY `ix_b_iblock_right_task_id` (`TASK_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_right`
--

LOCK TABLES `b_iblock_right` WRITE;
/*!40000 ALTER TABLE `b_iblock_right` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_rss`
--

DROP TABLE IF EXISTS `b_iblock_rss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_rss` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IBLOCK_ID` int(11) NOT NULL,
  `NODE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NODE_VALUE` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_rss`
--

LOCK TABLES `b_iblock_rss` WRITE;
/*!40000 ALTER TABLE `b_iblock_rss` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_rss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_section`
--

DROP TABLE IF EXISTS `b_iblock_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_section` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED_BY` int(18) DEFAULT NULL,
  `DATE_CREATE` datetime DEFAULT NULL,
  `CREATED_BY` int(18) DEFAULT NULL,
  `IBLOCK_ID` int(11) NOT NULL,
  `IBLOCK_SECTION_ID` int(11) DEFAULT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `GLOBAL_ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PICTURE` int(18) DEFAULT NULL,
  `LEFT_MARGIN` int(18) DEFAULT NULL,
  `RIGHT_MARGIN` int(18) DEFAULT NULL,
  `DEPTH_LEVEL` int(18) DEFAULT NULL,
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  `DESCRIPTION_TYPE` char(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `SEARCHABLE_CONTENT` text COLLATE utf8_unicode_ci,
  `CODE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TMP_ID` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DETAIL_PICTURE` int(18) DEFAULT NULL,
  `SOCNET_GROUP_ID` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_iblock_section_1` (`IBLOCK_ID`,`IBLOCK_SECTION_ID`),
  KEY `ix_iblock_section_depth_level` (`IBLOCK_ID`,`DEPTH_LEVEL`),
  KEY `ix_iblock_section_left_margin` (`IBLOCK_ID`,`LEFT_MARGIN`,`RIGHT_MARGIN`),
  KEY `ix_iblock_section_right_margin` (`IBLOCK_ID`,`RIGHT_MARGIN`,`LEFT_MARGIN`),
  KEY `ix_iblock_section_code` (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_section`
--

LOCK TABLES `b_iblock_section` WRITE;
/*!40000 ALTER TABLE `b_iblock_section` DISABLE KEYS */;
INSERT INTO `b_iblock_section` VALUES (1,'2012-11-06 09:50:59',1,'2012-11-06 13:50:59',1,1,NULL,'Y','Y',100,'Новости компании',NULL,1,2,1,'','text','НОВОСТИ КОМПАНИИ\r\n','',NULL,NULL,NULL,NULL),(2,'2012-11-06 09:51:09',1,'2012-11-06 13:51:09',1,1,NULL,'Y','Y',200,'Российские новости',NULL,3,4,1,'','text','РОССИЙСКИЕ НОВОСТИ\r\n','',NULL,NULL,NULL,NULL),(3,'2012-11-06 09:51:24',1,'2012-11-06 13:51:24',1,1,NULL,'Y','Y',300,'Фиг пойми новости',NULL,5,6,1,'','text','ФИГ ПОЙМИ НОВОСТИ\r\n','',NULL,NULL,NULL,NULL),(4,'2012-11-07 12:46:09',1,'2012-11-07 16:46:09',1,6,NULL,'Y','Y',500,'Главная растяжка',NULL,1,2,1,'','text','ГЛАВНАЯ РАСТЯЖКА\r\n','',NULL,NULL,NULL,NULL),(5,'2012-11-07 12:47:14',1,'2012-11-07 16:47:14',1,6,NULL,'Y','Y',500,'Фичи',NULL,3,4,1,'Баннерные блоки с жёлтой полосой внизу (по 3 штуки на экране)','text','ФИЧИ\r\nБАННЕРНЫЕ БЛОКИ С ЖЁЛТОЙ ПОЛОСОЙ ВНИЗУ (ПО 3 ШТУКИ НА ЭКРАНЕ)','',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `b_iblock_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_section_element`
--

DROP TABLE IF EXISTS `b_iblock_section_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_section_element` (
  `IBLOCK_SECTION_ID` int(11) NOT NULL,
  `IBLOCK_ELEMENT_ID` int(11) NOT NULL,
  `ADDITIONAL_PROPERTY_ID` int(18) DEFAULT NULL,
  UNIQUE KEY `ux_iblock_section_element` (`IBLOCK_SECTION_ID`,`IBLOCK_ELEMENT_ID`,`ADDITIONAL_PROPERTY_ID`),
  KEY `UX_IBLOCK_SECTION_ELEMENT2` (`IBLOCK_ELEMENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_section_element`
--

LOCK TABLES `b_iblock_section_element` WRITE;
/*!40000 ALTER TABLE `b_iblock_section_element` DISABLE KEYS */;
INSERT INTO `b_iblock_section_element` VALUES (1,5,NULL),(1,6,NULL),(2,1,NULL),(3,2,NULL),(3,3,NULL),(3,4,NULL),(4,20,NULL),(4,21,NULL),(5,22,NULL),(5,23,NULL),(5,24,NULL);
/*!40000 ALTER TABLE `b_iblock_section_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_section_right`
--

DROP TABLE IF EXISTS `b_iblock_section_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_section_right` (
  `IBLOCK_ID` int(11) NOT NULL,
  `SECTION_ID` int(11) NOT NULL,
  `RIGHT_ID` int(11) NOT NULL,
  `IS_INHERITED` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`RIGHT_ID`,`SECTION_ID`),
  KEY `ix_b_iblock_section_right_1` (`SECTION_ID`,`IBLOCK_ID`),
  KEY `ix_b_iblock_section_right_2` (`IBLOCK_ID`,`RIGHT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_section_right`
--

LOCK TABLES `b_iblock_section_right` WRITE;
/*!40000 ALTER TABLE `b_iblock_section_right` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_section_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_sequence`
--

DROP TABLE IF EXISTS `b_iblock_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_sequence` (
  `IBLOCK_ID` int(18) NOT NULL,
  `CODE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SEQ_VALUE` int(11) DEFAULT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_sequence`
--

LOCK TABLES `b_iblock_sequence` WRITE;
/*!40000 ALTER TABLE `b_iblock_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_iblock_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_site`
--

DROP TABLE IF EXISTS `b_iblock_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_site` (
  `IBLOCK_ID` int(18) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`IBLOCK_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_site`
--

LOCK TABLES `b_iblock_site` WRITE;
/*!40000 ALTER TABLE `b_iblock_site` DISABLE KEYS */;
INSERT INTO `b_iblock_site` VALUES (1,'s1'),(2,'s1'),(3,'s1'),(4,'s1'),(5,'s1'),(6,'s1');
/*!40000 ALTER TABLE `b_iblock_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_type`
--

DROP TABLE IF EXISTS `b_iblock_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_type` (
  `ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SECTIONS` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `EDIT_FILE_BEFORE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EDIT_FILE_AFTER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IN_RSS` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SORT` int(18) NOT NULL DEFAULT '500',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_type`
--

LOCK TABLES `b_iblock_type` WRITE;
/*!40000 ALTER TABLE `b_iblock_type` DISABLE KEYS */;
INSERT INTO `b_iblock_type` VALUES ('content','Y','','','N',100);
/*!40000 ALTER TABLE `b_iblock_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_iblock_type_lang`
--

DROP TABLE IF EXISTS `b_iblock_type_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_iblock_type_lang` (
  `IBLOCK_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SECTION_NAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ELEMENT_NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_iblock_type_lang`
--

LOCK TABLES `b_iblock_type_lang` WRITE;
/*!40000 ALTER TABLE `b_iblock_type_lang` DISABLE KEYS */;
INSERT INTO `b_iblock_type_lang` VALUES ('content','ru','Контент','',''),('content','en','Content','','');
/*!40000 ALTER TABLE `b_iblock_type_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_lang`
--

DROP TABLE IF EXISTS `b_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_lang` (
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `DEF` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DIR` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `FORMAT_DATE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `FORMAT_DATETIME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `WEEK_START` int(1) DEFAULT '1',
  `CHARSET` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LANGUAGE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `DOC_ROOT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DOMAIN_LIMITED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SERVER_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SITE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FORMAT_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_lang`
--

LOCK TABLES `b_lang` WRITE;
/*!40000 ALTER TABLE `b_lang` DISABLE KEYS */;
INSERT INTO `b_lang` VALUES ('s1',1,'Y','Y','Страховой Сервис - Москва','/','DD.MM.YYYY','DD.MM.YYYY HH:MI:SS',1,'UTF-8','ru','','N','','','','#NOBR##NAME# #LAST_NAME##/NOBR#');
/*!40000 ALTER TABLE `b_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_lang_domain`
--

DROP TABLE IF EXISTS `b_lang_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_lang_domain` (
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `DOMAIN` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`LID`,`DOMAIN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_lang_domain`
--

LOCK TABLES `b_lang_domain` WRITE;
/*!40000 ALTER TABLE `b_lang_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_lang_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_language`
--

DROP TABLE IF EXISTS `b_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_language` (
  `LID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `SORT` int(11) NOT NULL DEFAULT '100',
  `DEF` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `FORMAT_DATE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `FORMAT_DATETIME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `WEEK_START` int(1) DEFAULT '1',
  `CHARSET` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DIRECTION` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `FORMAT_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_language`
--

LOCK TABLES `b_language` WRITE;
/*!40000 ALTER TABLE `b_language` DISABLE KEYS */;
INSERT INTO `b_language` VALUES ('en',2,'N','Y','English','MM/DD/YYYY','MM/DD/YYYY HH:MI:SS',1,'UTF-8','Y','#NOBR##NAME# #LAST_NAME##/NOBR#'),('ru',1,'Y','Y','Russian','DD.MM.YYYY','DD.MM.YYYY HH:MI:SS',1,'UTF-8','Y','#NOBR##NAME# #LAST_NAME##/NOBR#');
/*!40000 ALTER TABLE `b_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_medialib_collection`
--

DROP TABLE IF EXISTS `b_medialib_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_medialib_collection` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `DATE_UPDATE` datetime NOT NULL,
  `OWNER_ID` int(11) DEFAULT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KEYWORDS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ITEMS_COUNT` int(11) DEFAULT NULL,
  `ML_TYPE` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_medialib_collection`
--

LOCK TABLES `b_medialib_collection` WRITE;
/*!40000 ALTER TABLE `b_medialib_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_medialib_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_medialib_collection_item`
--

DROP TABLE IF EXISTS `b_medialib_collection_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_medialib_collection_item` (
  `COLLECTION_ID` int(11) NOT NULL,
  `ITEM_ID` int(11) NOT NULL,
  PRIMARY KEY (`ITEM_ID`,`COLLECTION_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_medialib_collection_item`
--

LOCK TABLES `b_medialib_collection_item` WRITE;
/*!40000 ALTER TABLE `b_medialib_collection_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_medialib_collection_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_medialib_item`
--

DROP TABLE IF EXISTS `b_medialib_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_medialib_item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ITEM_TYPE` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  `DATE_CREATE` datetime NOT NULL,
  `DATE_UPDATE` datetime NOT NULL,
  `SOURCE_ID` int(11) NOT NULL,
  `KEYWORDS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SEARCHABLE_CONTENT` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_medialib_item`
--

LOCK TABLES `b_medialib_item` WRITE;
/*!40000 ALTER TABLE `b_medialib_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_medialib_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_medialib_type`
--

DROP TABLE IF EXISTS `b_medialib_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_medialib_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EXT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `SYSTEM` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `DESCRIPTION` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_medialib_type`
--

LOCK TABLES `b_medialib_type` WRITE;
/*!40000 ALTER TABLE `b_medialib_type` DISABLE KEYS */;
INSERT INTO `b_medialib_type` VALUES (1,'image_name','image','jpg,jpeg,gif,png','Y','image_desc'),(2,'video_name','video','flv,mp4,wmv','Y','video_desc'),(3,'sound_name','sound','mp3,wma,aac','Y','sound_desc');
/*!40000 ALTER TABLE `b_medialib_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_module`
--

DROP TABLE IF EXISTS `b_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_module` (
  `ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_ACTIVE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_module`
--

LOCK TABLES `b_module` WRITE;
/*!40000 ALTER TABLE `b_module` DISABLE KEYS */;
INSERT INTO `b_module` VALUES ('beono.mastercomponent','2012-11-02 13:34:59'),('bitrix.sitecorporate','2012-11-02 13:29:52'),('clouds','2012-11-02 13:29:53'),('compression','2012-11-02 13:29:54'),('fileman','2012-11-02 13:29:54'),('iblock','2012-11-02 13:29:55'),('main','2012-11-02 13:29:51'),('perfmon','2012-11-02 13:29:56'),('search','2012-11-02 13:29:57'),('seo','2012-11-02 13:29:58'),('socialservices','2012-11-02 13:29:58');
/*!40000 ALTER TABLE `b_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_module_group`
--

DROP TABLE IF EXISTS `b_module_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_module_group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `G_ACCESS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_GROUP_MODULE` (`MODULE_ID`,`GROUP_ID`,`SITE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_module_group`
--

LOCK TABLES `b_module_group` WRITE;
/*!40000 ALTER TABLE `b_module_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_module_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_module_to_module`
--

DROP TABLE IF EXISTS `b_module_to_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_module_to_module` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SORT` int(18) NOT NULL DEFAULT '100',
  `FROM_MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MESSAGE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TO_MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TO_PATH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TO_CLASS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TO_METHOD` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TO_METHOD_ARG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_module_to_module` (`FROM_MODULE_ID`,`MESSAGE_ID`,`TO_MODULE_ID`,`TO_CLASS`,`TO_METHOD`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_module_to_module`
--

LOCK TABLES `b_module_to_module` WRITE;
/*!40000 ALTER TABLE `b_module_to_module` DISABLE KEYS */;
INSERT INTO `b_module_to_module` VALUES (1,'2012-11-02 13:29:51',100,'iblock','OnIBlockPropertyBuildList','main','/modules/main/tools/prop_userid.php','CIBlockPropertyUserID','GetUserTypeDescription',''),(2,'2012-11-02 13:29:51',100,'main','OnUserDelete','main','/modules/main/classes/mysql/favorites.php','CFavorites','OnUserDelete',''),(3,'2012-11-02 13:29:51',100,'main','OnLanguageDelete','main','/modules/main/classes/mysql/favorites.php','CFavorites','OnLanguageDelete',''),(4,'2012-11-02 13:29:51',100,'main','OnUserDelete','main','/modules/main/classes/mysql/favorites.php','CUserOptions','OnUserDelete',''),(5,'2012-11-02 13:29:51',100,'main','OnChangeFile','main','','CMain','OnChangeFileComponent',''),(6,'2012-11-02 13:29:51',100,'main','OnUserTypeRightsCheck','main','','CUser','UserTypeRightsCheck',''),(7,'2012-11-02 13:29:51',100,'main','OnUserLogin','main','','UpdateTools','CheckUpdates',''),(8,'2012-11-02 13:29:51',100,'main','OnModuleUpdate','main','','UpdateTools','SetUpdateResult',''),(9,'2012-11-02 13:29:51',100,'main','OnUpdateCheck','main','','UpdateTools','SetUpdateError',''),(10,'2012-11-02 13:29:51',100,'main','OnPanelCreate','main','','CUndo','CheckNotifyMessage',''),(11,'2012-11-02 13:29:51',100,'main','OnAfterAddRating','main','','CRatingsComponentsMain','OnAfterAddRating',''),(12,'2012-11-02 13:29:51',100,'main','OnAfterUpdateRating','main','','CRatingsComponentsMain','OnAfterUpdateRating',''),(13,'2012-11-02 13:29:51',100,'main','OnSetRatingsConfigs','main','','CRatingsComponentsMain','OnSetRatingConfigs',''),(14,'2012-11-02 13:29:51',100,'main','OnGetRatingsConfigs','main','','CRatingsComponentsMain','OnGetRatingConfigs',''),(15,'2012-11-02 13:29:51',100,'main','OnGetRatingsObjects','main','','CRatingsComponentsMain','OnGetRatingObject',''),(16,'2012-11-02 13:29:51',100,'main','OnGetRatingContentOwner','main','','CRatingsComponentsMain','OnGetRatingContentOwner',''),(17,'2012-11-02 13:29:51',100,'main','OnAfterAddRatingRule','main','','CRatingRulesMain','OnAfterAddRatingRule',''),(18,'2012-11-02 13:29:51',100,'main','OnAfterUpdateRatingRule','main','','CRatingRulesMain','OnAfterUpdateRatingRule',''),(19,'2012-11-02 13:29:51',100,'main','OnGetRatingRuleObjects','main','','CRatingRulesMain','OnGetRatingRuleObjects',''),(20,'2012-11-02 13:29:51',100,'main','OnGetRatingRuleConfigs','main','','CRatingRulesMain','OnGetRatingRuleConfigs',''),(21,'2012-11-02 13:29:51',100,'main','OnAfterUserAdd','main','','CRatings','OnAfterUserRegister',''),(22,'2012-11-02 13:29:51',100,'main','OnUserDelete','main','','CAccess','OnUserDelete',''),(23,'2012-11-02 13:29:51',100,'main','OnAfterGroupAdd','main','','CGroupAuthProvider','OnAfterGroupAdd',''),(24,'2012-11-02 13:29:51',100,'main','OnBeforeGroupUpdate','main','','CGroupAuthProvider','OnBeforeGroupUpdate',''),(25,'2012-11-02 13:29:51',100,'main','OnBeforeGroupDelete','main','','CGroupAuthProvider','OnBeforeGroupDelete',''),(26,'2012-11-02 13:29:51',100,'main','OnAfterUserUpdate','main','','CGroupAuthProvider','OnAfterUserUpdate',''),(27,'2012-11-02 13:29:51',100,'main','OnUserLogin','main','','CGroupAuthProvider','OnUserLogin',''),(28,'2012-11-02 13:29:51',100,'main','OnEventLogGetAuditTypes','main','','CEventMain','GetAuditTypes',''),(29,'2012-11-02 13:29:51',100,'main','OnEventLogGetAuditHandlers','main','','CEventMain','MakeMainObject',''),(30,'2012-11-02 13:29:51',100,'perfmon','OnGetTableSchema','main','','CTableSchema','OnGetTableSchema',''),(31,'2012-11-02 13:29:51',110,'main','OnUserTypeBuildList','main','','CUserTypeString','GetUserTypeDescription',''),(32,'2012-11-02 13:29:51',120,'main','OnUserTypeBuildList','main','','CUserTypeInteger','GetUserTypeDescription',''),(33,'2012-11-02 13:29:51',130,'main','OnUserTypeBuildList','main','','CUserTypeDouble','GetUserTypeDescription',''),(34,'2012-11-02 13:29:51',140,'main','OnUserTypeBuildList','main','','CUserTypeDateTime','GetUserTypeDescription',''),(35,'2012-11-02 13:29:51',150,'main','OnUserTypeBuildList','main','','CUserTypeBoolean','GetUserTypeDescription',''),(36,'2012-11-02 13:29:51',160,'main','OnUserTypeBuildList','main','','CUserTypeFile','GetUserTypeDescription',''),(37,'2012-11-02 13:29:51',170,'main','OnUserTypeBuildList','main','','CUserTypeEnum','GetUserTypeDescription',''),(38,'2012-11-02 13:29:51',180,'main','OnUserTypeBuildList','main','','CUserTypeIBlockSection','GetUserTypeDescription',''),(39,'2012-11-02 13:29:51',190,'main','OnUserTypeBuildList','main','','CUserTypeIBlockElement','GetUserTypeDescription',''),(40,'2012-11-02 13:29:51',200,'main','OnUserTypeBuildList','main','','CUserTypeStringFormatted','GetUserTypeDescription',''),(41,'2012-11-02 13:29:52',100,'main','OnBeforeProlog','bitrix.sitecorporate','','CSiteCorporate','ShowPanel',''),(42,'2012-11-02 13:29:53',100,'main','OnEventLogGetAuditTypes','clouds','','CCloudStorage','GetAuditTypes',''),(43,'2012-11-02 13:29:53',100,'main','OnBeforeProlog','clouds','','CCloudStorage','OnBeforeProlog',''),(44,'2012-11-02 13:29:53',100,'main','OnAdminListDisplay','clouds','','CCloudStorage','OnAdminListDisplay',''),(45,'2012-11-02 13:29:53',100,'main','OnBuildGlobalMenu','clouds','','CCloudStorage','OnBuildGlobalMenu',''),(46,'2012-11-02 13:29:53',100,'main','OnFileSave','clouds','','CCloudStorage','OnFileSave',''),(47,'2012-11-02 13:29:53',100,'main','OnGetFileSRC','clouds','','CCloudStorage','OnGetFileSRC',''),(48,'2012-11-02 13:29:53',100,'main','OnFileCopy','clouds','','CCloudStorage','OnFileCopy',''),(49,'2012-11-02 13:29:53',100,'main','OnFileDelete','clouds','','CCloudStorage','OnFileDelete',''),(50,'2012-11-02 13:29:53',100,'main','OnMakeFileArray','clouds','','CCloudStorage','OnMakeFileArray',''),(51,'2012-11-02 13:29:53',100,'main','OnBeforeResizeImage','clouds','','CCloudStorage','OnBeforeResizeImage',''),(52,'2012-11-02 13:29:53',100,'main','OnAfterResizeImage','clouds','','CCloudStorage','OnAfterResizeImage',''),(53,'2012-11-02 13:29:53',100,'clouds','OnGetStorageService','clouds','','CCloudStorageService_AmazonS3','GetObject',''),(54,'2012-11-02 13:29:53',100,'clouds','OnGetStorageService','clouds','','CCloudStorageService_GoogleStorage','GetObject',''),(55,'2012-11-02 13:29:53',100,'clouds','OnGetStorageService','clouds','','CCloudStorageService_OpenStackStorage','GetObject',''),(56,'2012-11-02 13:29:53',100,'clouds','OnGetStorageService','clouds','','CCloudStorageService_RackSpaceCloudFiles','GetObject',''),(57,'2012-11-02 13:29:53',100,'clouds','OnGetStorageService','clouds','','CCloudStorageService_ClodoRU','GetObject',''),(58,'2012-11-02 13:29:54',1,'main','OnPageStart','compression','','CCompress','OnPageStart',''),(59,'2012-11-02 13:29:54',10000,'main','OnAfterEpilog','compression','','CCompress','OnAfterEpilog',''),(60,'2012-11-02 13:29:54',100,'main','OnGroupDelete','fileman','','CFileman','OnGroupDelete',''),(61,'2012-11-02 13:29:54',100,'main','OnPanelCreate','fileman','','CFileman','OnPanelCreate',''),(62,'2012-11-02 13:29:54',100,'main','OnModuleUpdate','fileman','','CFileman','OnModuleUpdate',''),(63,'2012-11-02 13:29:54',100,'main','OnModuleInstalled','fileman','','CFileman','ClearComponentsListCache',''),(64,'2012-11-02 13:29:54',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyMapGoogle','GetUserTypeDescription',''),(65,'2012-11-02 13:29:54',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyMapYandex','GetUserTypeDescription',''),(66,'2012-11-02 13:29:54',100,'iblock','OnIBlockPropertyBuildList','fileman','','CIBlockPropertyVideo','GetUserTypeDescription',''),(67,'2012-11-02 13:29:54',100,'main','OnUserTypeBuildList','fileman','','CUserTypeVideo','GetUserTypeDescription',''),(68,'2012-11-02 13:29:54',100,'main','OnEventLogGetAuditTypes','fileman','','CEventFileman','GetAuditTypes',''),(69,'2012-11-02 13:29:54',100,'main','OnEventLogGetAuditHandlers','fileman','','CEventFileman','MakeFilemanObject',''),(70,'2012-11-02 13:29:55',100,'main','OnGroupDelete','iblock','','CIBlock','OnGroupDelete',''),(71,'2012-11-02 13:29:55',100,'main','OnBeforeLangDelete','iblock','','CIBlock','OnBeforeLangDelete',''),(72,'2012-11-02 13:29:55',100,'main','OnLangDelete','iblock','','CIBlock','OnLangDelete',''),(73,'2012-11-02 13:29:55',100,'main','OnUserTypeRightsCheck','iblock','','CIBlockSection','UserTypeRightsCheck',''),(74,'2012-11-02 13:29:55',100,'search','OnReindex','iblock','','CIBlock','OnSearchReindex',''),(75,'2012-11-02 13:29:55',100,'search','OnSearchGetURL','iblock','','CIBlock','OnSearchGetURL',''),(76,'2012-11-02 13:29:55',100,'main','OnEventLogGetAuditTypes','iblock','','CIBlock','GetAuditTypes',''),(77,'2012-11-02 13:29:55',100,'main','OnEventLogGetAuditHandlers','iblock','','CEventIBlock','MakeIBlockObject',''),(78,'2012-11-02 13:29:55',200,'main','OnGetRatingContentOwner','iblock','','CRatingsComponentsIBlock','OnGetRatingContentOwner',''),(79,'2012-11-02 13:29:55',100,'main','OnTaskOperationsChanged','iblock','','CIBlockRightsStorage','OnTaskOperationsChanged',''),(80,'2012-11-02 13:29:55',100,'main','OnGroupDelete','iblock','','CIBlockRightsStorage','OnGroupDelete',''),(81,'2012-11-02 13:29:55',100,'main','OnUserDelete','iblock','','CIBlockRightsStorage','OnUserDelete',''),(82,'2012-11-02 13:29:55',100,'perfmon','OnGetTableSchema','iblock','','iblock','OnGetTableSchema',''),(83,'2012-11-02 13:29:55',10,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_DateTime_GetUserTypeDescription',''),(84,'2012-11-02 13:29:55',20,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_XmlID_GetUserTypeDescription',''),(85,'2012-11-02 13:29:55',30,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_FileMan_GetUserTypeDescription',''),(86,'2012-11-02 13:29:55',40,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_HTML_GetUserTypeDescription',''),(87,'2012-11-02 13:29:55',50,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_ElementList_GetUserTypeDescription',''),(88,'2012-11-02 13:29:55',60,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_Sequence_GetUserTypeDescription',''),(89,'2012-11-02 13:29:55',70,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_ElementAutoComplete_GetUserTypeDescription',''),(90,'2012-11-02 13:29:55',80,'iblock','OnIBlockPropertyBuildList','iblock','','CIBlockProperty','_SKU_GetUserTypeDescription',''),(91,'2012-11-02 13:29:57',100,'main','OnChangePermissions','search','','CSearch','OnChangeFilePermissions',''),(92,'2012-11-02 13:29:57',100,'main','OnChangeFile','search','','CSearch','OnChangeFile',''),(93,'2012-11-02 13:29:57',100,'main','OnGroupDelete','search','','CSearch','OnGroupDelete',''),(94,'2012-11-02 13:29:57',100,'main','OnLangDelete','search','','CSearch','OnLangDelete',''),(95,'2012-11-02 13:29:57',100,'main','OnAfterUserUpdate','search','','CSearchUser','OnAfterUserUpdate',''),(96,'2012-11-02 13:29:57',100,'main','OnUserDelete','search','','CSearchUser','DeleteByUserID',''),(97,'2012-11-02 13:29:57',100,'cluster','OnGetTableList','search','','search','OnGetTableList',''),(98,'2012-11-02 13:29:57',100,'perfmon','OnGetTableSchema','search','','search','OnGetTableSchema',''),(99,'2012-11-02 13:29:57',90,'main','OnEpilog','search','','CSearchStatistic','OnEpilog',''),(100,'2012-11-02 13:29:58',100,'main','OnPanelCreate','seo','','CSeoEventHandlers','SeoOnPanelCreate',''),(101,'2012-11-02 13:30:17',100,'main','OnBeforeProlog','main','/modules/main/install/wizard_sol/panel_button.php','CWizardSolPanel','ShowPanel',''),(102,'2012-11-02 13:34:45',100,'main','OnPanelCreate','beono.mastercomponent','','BeonoMasterComponent','ShowCreateButton','');
/*!40000 ALTER TABLE `b_module_to_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_operation`
--

DROP TABLE IF EXISTS `b_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_operation` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BINDING` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'module',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_operation`
--

LOCK TABLES `b_operation` WRITE;
/*!40000 ALTER TABLE `b_operation` DISABLE KEYS */;
INSERT INTO `b_operation` VALUES (1,'view_own_profile','main',NULL,'module'),(2,'view_subordinate_users','main',NULL,'module'),(3,'view_all_users','main',NULL,'module'),(4,'view_groups','main',NULL,'module'),(5,'view_tasks','main',NULL,'module'),(6,'view_other_settings','main',NULL,'module'),(7,'edit_own_profile','main',NULL,'module'),(8,'edit_all_users','main',NULL,'module'),(9,'edit_subordinate_users','main',NULL,'module'),(10,'edit_groups','main',NULL,'module'),(11,'edit_tasks','main',NULL,'module'),(12,'edit_other_settings','main',NULL,'module'),(13,'cache_control','main',NULL,'module'),(14,'edit_php','main',NULL,'module'),(15,'fm_view_permission','main',NULL,'file'),(16,'fm_edit_permission','main',NULL,'file'),(17,'fm_edit_existent_folder','main',NULL,'file'),(18,'fm_create_new_file','main',NULL,'file'),(19,'fm_edit_existent_file','main',NULL,'file'),(20,'fm_create_new_folder','main',NULL,'file'),(21,'fm_delete_file','main',NULL,'file'),(22,'fm_delete_folder','main',NULL,'file'),(23,'fm_view_file','main',NULL,'file'),(24,'fm_view_listing','main',NULL,'file'),(25,'fm_edit_in_workflow','main',NULL,'file'),(26,'fm_rename_file','main',NULL,'file'),(27,'fm_rename_folder','main',NULL,'file'),(28,'fm_upload_file','main',NULL,'file'),(29,'fm_add_to_menu','main',NULL,'file'),(30,'fm_download_file','main',NULL,'file'),(31,'fm_lpa','main',NULL,'file'),(32,'lpa_template_edit','main',NULL,'module'),(33,'view_event_log','main',NULL,'module'),(34,'edit_ratings','main',NULL,'module'),(35,'manage_short_uri','main',NULL,'module'),(36,'clouds_browse','clouds',NULL,'module'),(37,'clouds_upload','clouds',NULL,'module'),(38,'clouds_config','clouds',NULL,'module'),(39,'fileman_view_all_settings','fileman','','module'),(40,'fileman_edit_menu_types','fileman','','module'),(41,'fileman_add_element_to_menu','fileman','','module'),(42,'fileman_edit_menu_elements','fileman','','module'),(43,'fileman_edit_existent_files','fileman','','module'),(44,'fileman_edit_existent_folders','fileman','','module'),(45,'fileman_admin_files','fileman','','module'),(46,'fileman_admin_folders','fileman','','module'),(47,'fileman_view_permissions','fileman','','module'),(48,'fileman_edit_all_settings','fileman','','module'),(49,'fileman_upload_files','fileman','','module'),(50,'fileman_view_file_structure','fileman','','module'),(51,'fileman_install_control','fileman','','module'),(52,'medialib_view_collection','fileman','','medialib'),(53,'medialib_new_collection','fileman','','medialib'),(54,'medialib_edit_collection','fileman','','medialib'),(55,'medialib_del_collection','fileman','','medialib'),(56,'medialib_access','fileman','','medialib'),(57,'medialib_new_item','fileman','','medialib'),(58,'medialib_edit_item','fileman','','medialib'),(59,'medialib_del_item','fileman','','medialib'),(60,'sticker_view','fileman','','stickers'),(61,'sticker_edit','fileman','','stickers'),(62,'sticker_new','fileman','','stickers'),(63,'sticker_del','fileman','','stickers'),(64,'iblock_admin_display','iblock',NULL,'iblock'),(65,'iblock_edit','iblock',NULL,'iblock'),(66,'iblock_delete','iblock',NULL,'iblock'),(67,'iblock_rights_edit','iblock',NULL,'iblock'),(68,'iblock_export','iblock',NULL,'iblock'),(69,'section_read','iblock',NULL,'iblock'),(70,'section_edit','iblock',NULL,'iblock'),(71,'section_delete','iblock',NULL,'iblock'),(72,'section_element_bind','iblock',NULL,'iblock'),(73,'section_section_bind','iblock',NULL,'iblock'),(74,'section_rights_edit','iblock',NULL,'iblock'),(75,'element_read','iblock',NULL,'iblock'),(76,'element_edit','iblock',NULL,'iblock'),(77,'element_edit_any_wf_status','iblock',NULL,'iblock'),(78,'element_edit_price','iblock',NULL,'iblock'),(79,'element_delete','iblock',NULL,'iblock'),(80,'element_bizproc_start','iblock',NULL,'iblock'),(81,'element_rights_edit','iblock',NULL,'iblock'),(82,'seo_settings','seo','','module'),(83,'seo_tools','seo','','module');
/*!40000 ALTER TABLE `b_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_option`
--

DROP TABLE IF EXISTS `b_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_option` (
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `VALUE` text COLLATE utf8_unicode_ci,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `ix_option` (`MODULE_ID`,`NAME`,`SITE_ID`),
  KEY `ix_option_name` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_option`
--

LOCK TABLES `b_option` WRITE;
/*!40000 ALTER TABLE `b_option` DISABLE KEYS */;
INSERT INTO `b_option` VALUES ('main','rating_authority_rating','2','',NULL),('main','rating_assign_rating_group_add','1','',NULL),('main','rating_assign_rating_group_delete','1','',NULL),('main','rating_assign_rating_group','3','',NULL),('main','rating_assign_authority_group_add','2','',NULL),('main','rating_assign_authority_group_delete','2','',NULL),('main','rating_assign_authority_group','4','',NULL),('main','rating_community_size','1','',NULL),('main','rating_community_authority','30','',NULL),('main','rating_vote_weight','10','',NULL),('main','rating_normalization_type','auto','',NULL),('main','rating_normalization','10','',NULL),('main','rating_count_vote','10','',NULL),('main','rating_authority_weight_formula','Y','',NULL),('main','rating_community_last_visit','90','',NULL),('main','rating_text_like_y','Мне нравится','',NULL),('main','rating_text_like_n','Больше не нравится','',NULL),('main','rating_text_like_d','Это нравится','',NULL),('main','rating_assign_type','auto','',NULL),('main','rating_vote_type','like','',NULL),('main','rating_self_vote','Y','',NULL),('main','rating_vote_show','Y','',NULL),('main','rating_vote_template','like','',NULL),('main','rating_start_authority','3','',NULL),('main','auth_comp2','Y','Использовать Компоненты 2.0 для авторизации и регистрации:',NULL),('main','PARAM_MAX_SITES','2','',NULL),('main','PARAM_MAX_USERS','0','',NULL),('main','distributive6','Y','',NULL),('main','~new_license11_sign','Y','',NULL),('main','GROUP_DEFAULT_TASK','1','Task for groups by default',NULL),('main','vendor','1c_bitrix','',NULL),('main','admin_lid','ru','',NULL),('main','update_site','www.bitrixsoft.com','Имя сервера, содержащего обновления:',NULL),('main','update_site_ns','Y','',NULL),('main','admin_passwordh','FVgQemYUBwYtCUVcBRcFCgsTAQ==',NULL,NULL),('search','version','v2.0','',NULL),('search','dbnode_id','N','',NULL),('search','dbnode_status','ok','',NULL),('main','email_from','xgismox@gmail.com','E-Mail администратора сайта (отправитель по умолчанию):',NULL),('main','server_uniq_id','6f64f215ebe011abd2b1fb572a2ad624','',NULL),('fileman','stickers_use_hotkeys','N','',NULL),('main','crc_code','aU80eXBWbTZhNA==','',NULL),('main','~support_finish_date','2012-12-02','',NULL),('main','~update_autocheck_result','a:4:{s:10:\"check_date\";i:1351863285;s:6:\"result\";b:0;s:5:\"error\";s:0:\"\";s:7:\"modules\";a:0:{}}','',NULL),('main','update_system_check','02.11.2012 17:34:35','',NULL),('main','update_system_update','02.11.2012 17:34:45','',NULL),('iblock','use_htmledit','','Использовать визуальный редактор для изменения HTML содержимого',NULL),('iblock','show_xml_id','','Показывать код загрузки из внешних источников',NULL),('iblock','path2rss','/upload/','Путь к экспортируемым RSS файлам',NULL),('iblock','combined_list_mode','Y','Совместный просмотр разделов и элементов',NULL),('iblock','iblock_menu_max_sections','50','Максимальное количество разделов в меню',NULL),('iblock','event_log_iblock','Y','Журналировать действия с инфоблоками',NULL),('main','site_name','Страховой Сервис - Москва','Название сайта:',NULL),('main','server_name','www.msk-in.customers','URL сайта (без http://): <small>Например: www.mysite.com</small>',NULL),('main','cookie_name','BITRIX_SM','Имя префикса для названия cookies (без точек и пробелов):',NULL),('main','ALLOW_SPREAD_COOKIE','Y','Распространять куки на все домены:',NULL),('main','header_200','N','Посылать в заголовке статус 200 на 404 ошибку:',NULL),('main','error_reporting','85','Режим вывода ошибок (error_reporting):',NULL),('main','templates_visual_editor','N','Использовать визуальный редактор для редактирования шаблонов сайта:',NULL),('main','use_hot_keys','Y','Использовать горячие клавиши:',NULL),('main','all_bcc','','E-Mail адрес или список адресов через запятую на который будут дублироваться все исходящие сообщения:',NULL),('main','send_mid','N','Отправлять в письме идентификаторы почтового события и шаблона:',NULL),('main','fill_to_mail','N','Дублировать E-Mail адрес в заголовок:',NULL),('main','CONVERT_UNIX_NEWLINE_2_WINDOWS','N','Конвертировать символы новой строки<br> Unix формата в Windows формат при отправке email:',NULL),('main','convert_mail_header','Y','Конвертировать 8-битные символы в заголовке письма:',NULL),('main','mail_event_period','14','Сколько дней хранить почтовые события:',NULL),('main','mail_event_bulk','5','Сколько писем отправлять за один хит:',NULL),('main','mail_additional_parameters','','Дополнительный параметр для передачи функции mail:',NULL),('main','disk_space','','Ограничение дискового пространства (Мб):',NULL),('main','upload_dir','upload','Папка по умолчанию для загрузки файлов:',NULL),('main','save_original_file_name','N','Сохранять исходные имена загружаемых файлов:',NULL),('main','translit_original_file_name','N','Производить транслитерацию имени файла:',NULL),('main','convert_original_file_name','Y','Автоматически заменять невалидные символы в именах загружаемых файлов:',NULL),('main','image_resize_quality','95','Качество JPG при масштабировании изображений (в процентах):',NULL),('main','optimize_css_files','N','Объединять CSS файлы шаблонов в один файл:',NULL),('main','compres_css_files','N','Создавать сжатую копию объединенного файла CSS:',NULL),('main','use_time_zones','N','Разрешить использование часовых поясов:',NULL),('main','auto_time_zone','N','По умолчанию автоматически определять часовой пояс по браузеру:',NULL),('main','map_top_menu_type','top','Тип меню для нулевого уровня карты сайта:',NULL),('main','map_left_menu_type','left','Тип меню для остальных уровней карты сайта:',NULL),('main','update_site_proxy_addr','','Адрес прокси для системы обновлений:',NULL),('main','update_site_proxy_port','','Порт прокси для системы обновлений:',NULL),('main','update_site_proxy_user','','Имя пользователя прокси:',NULL),('main','update_site_proxy_pass','','Пароль прокси:',NULL),('main','strong_update_check','Y','Усиленная проверка корректности установки обновлений:',NULL),('main','stable_versions_only','Y','Загружать только стабильные обновления:',NULL),('main','update_autocheck','','Автоматически проверять наличие обновлений:',NULL),('main','update_stop_autocheck','N','Остановить автоматическую проверку при возникновении ошибок:',NULL),('main','update_is_gzip_installed','Y','Не использовать архиватор:',NULL),('main','update_load_timeout','30','Продолжительность шага пошаговой загрузки обновления (сек):',NULL),('main','store_password','Y','Разрешить запоминание авторизации:',NULL),('main','use_secure_password_cookies','N','Использовать защищенное хранение авторизации в cookies:',NULL),('main','auth_multisite','N','Распространять авторизацию на все домены:',NULL),('main','use_digest_auth','N','Разрешить авторизацию HTTP Digest:',NULL),('main','custom_register_page','','Страница регистрации (для системного компонента авторизации):',NULL),('main','use_encrypted_auth','N','Передавать пароль в зашифрованном виде:',NULL),('main','new_user_registration','Y','Позволять ли пользователям регистрироваться самостоятельно?',NULL),('main','captcha_registration','N','Использовать CAPTCHA при регистрации:',NULL),('main','new_user_registration_email_confirmation','N','Запрашивать подтверждение регистрации по E-mail:</label><br><a href=\"/bitrix/admin/message_admin.php?lang=ru&set_filter=Y&find_type_id=NEW_USER_CONFIRM\">Перейти к редактированию почтовых шаблонов.</a><label>',NULL),('main','new_user_registration_cleanup_days','7','Сколько дней хранить пользователей с неподтвержденной регистрацией:',NULL),('main','new_user_email_uniq_check','N','Проверять E-mail на уникальность при регистрации:',NULL),('main','session_expand','Y','Продлевать сессию при активности посетителя в окне браузера:',NULL),('main','session_show_message','Y','Показывать пользователям сообщение об окончании сессии:',NULL),('main','event_log_cleanup_days','7','Сколько дней хранить события:',NULL),('main','event_log_logout','N','Записывать выход из системы',NULL),('main','event_log_login_success','N','Записывать успешный вход',NULL),('main','event_log_login_fail','N','Записывать ошибки входа',NULL),('main','event_log_register','N','Записывать регистрацию нового пользователя',NULL),('main','event_log_register_fail','N','Записывать ошибки регистрации',NULL),('main','event_log_password_request','N','Записывать запросы на смену пароля',NULL),('main','event_log_password_change','N','Записывать смену пароля',NULL),('main','event_log_user_edit','N','Записывать редактирование пользователя',NULL),('main','event_log_user_delete','N','Записывать удаление пользователя',NULL),('main','event_log_user_groups','N','Записывать изменение групп пользователя',NULL),('main','event_log_group_policy','N','Записывать изменение политики безопасности группы',NULL),('main','event_log_module_access','N','Записывать изменение доступа к модулю',NULL),('main','event_log_file_access','N','Записывать изменение доступа к файлу',NULL),('main','event_log_task','N','Записывать изменение уровня доступа',NULL),('main','auth_controller_sso','N','Авторизовывать на этом сайте пользователей других сайтов контроллера:',NULL),('main','show_panel_for_users','N;','',NULL),('main','GROUP_DEFAULT_RIGHT','D','Right for groups by default',NULL),('fileman','use_pspell','N','',NULL),('fileman','GROUP_DEFAULT_TASK','16','Task for groups by default',NULL),('fileman','default_edit','text','',NULL),('fileman','htmleditor_fullscreen','N','',NULL),('fileman','show_untitled_styles','','',NULL),('fileman','render_styles_in_classlist','','',NULL),('fileman','allow_render_components','N','',NULL),('fileman','use_medialib','Y','',NULL),('fileman','editor_body_id','','',NULL),('fileman','editor_body_class','','',NULL),('fileman','ml_thumb_width','140','',NULL),('fileman','ml_thumb_height','105','',NULL),('fileman','ml_media_extentions','jpg,jpeg,gif,png,flv,mp4,wmv,wma,mp3,ppt','',NULL),('fileman','ml_max_width','1024','',NULL),('fileman','ml_max_height','1024','',NULL),('fileman','ml_media_available_ext','jpg,jpeg,gif,png,flv,mp4,wmv,wma,mp3,ppt,aac','',NULL),('fileman','ml_use_default','1','',NULL),('fileman','~script_files','php,php3,php4,php5,php6,phtml,pl,asp,aspx,cgi,exe,ico,shtm,shtml','',NULL),('fileman','~allowed_components','','',NULL),('fileman','use_lca','N','',NULL),('fileman','ar_entities','umlya,greek,other','',NULL),('fileman','different_set','N','',NULL),('fileman','num_menu_param','1','',NULL),('fileman','menutypes','a:3:{s:4:\\\"left\\\";s:19:\\\"Левое меню\\\";s:3:\\\"top\\\";s:23:\\\"Верхнее меню\\\";s:6:\\\"bottom\\\";s:21:\\\"Нижнее меню\\\";}','',NULL),('fileman','propstypes','a:2:{s:11:\\\"description\\\";s:16:\\\"Описание\\\";s:8:\\\"keywords\\\";s:27:\\\"Ключевые слова\\\";}','',NULL),('fileman','search_max_open_file_size','1024','',NULL),('fileman','search_max_res_count','','',NULL),('fileman','search_time_step','5','',NULL),('fileman','search_mask','*.php','',NULL),('fileman','show_inc_icons','N','',NULL),('fileman','spell_check_first_client','Y','',NULL),('fileman','hide_physical_struc','','',NULL),('fileman','use_translit','1','',NULL),('fileman','use_translit_google','1','',NULL),('fileman','log_menu','Y','',NULL),('fileman','log_page','Y','',NULL),('fileman','use_code_editor','Y','',NULL),('fileman','user_dics_path','/bitrix/modules/fileman/u_dics','',NULL),('fileman','use_separeted_dics','N','',NULL),('fileman','use_custom_spell','N','',NULL),('fileman','default_edit_groups','','',NULL),('fileman','archive_step_time','30','',NULL),('fileman','GROUP_DEFAULT_RIGHT','D','Right for groups by default',NULL);
/*!40000 ALTER TABLE `b_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_cluster`
--

DROP TABLE IF EXISTS `b_perf_cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_cluster` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `THREADS` int(11) DEFAULT NULL,
  `HITS` int(11) DEFAULT NULL,
  `ERRORS` int(11) DEFAULT NULL,
  `PAGES_PER_SECOND` float DEFAULT NULL,
  `PAGE_EXEC_TIME` float DEFAULT NULL,
  `PAGE_RESP_TIME` float DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_cluster`
--

LOCK TABLES `b_perf_cluster` WRITE;
/*!40000 ALTER TABLE `b_perf_cluster` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_component`
--

DROP TABLE IF EXISTS `b_perf_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_component` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `NN` int(18) DEFAULT NULL,
  `CACHE_TYPE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CACHE_SIZE` int(11) DEFAULT NULL,
  `COMPONENT_TIME` float DEFAULT NULL,
  `QUERIES` int(11) DEFAULT NULL,
  `QUERIES_TIME` float DEFAULT NULL,
  `COMPONENT_NAME` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_B_PERF_COMPONENT_0` (`HIT_ID`,`NN`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_component`
--

LOCK TABLES `b_perf_component` WRITE;
/*!40000 ALTER TABLE `b_perf_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_error`
--

DROP TABLE IF EXISTS `b_perf_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_error` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `ERRNO` int(18) DEFAULT NULL,
  `ERRSTR` text COLLATE utf8_unicode_ci,
  `ERRFILE` text COLLATE utf8_unicode_ci,
  `ERRLINE` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_ERROR_0` (`HIT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_error`
--

LOCK TABLES `b_perf_error` WRITE;
/*!40000 ALTER TABLE `b_perf_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_hit`
--

DROP TABLE IF EXISTS `b_perf_hit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_hit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_HIT` datetime DEFAULT NULL,
  `IS_ADMIN` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `REQUEST_METHOD` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SERVER_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SERVER_PORT` int(11) DEFAULT NULL,
  `SCRIPT_NAME` text COLLATE utf8_unicode_ci,
  `REQUEST_URI` text COLLATE utf8_unicode_ci,
  `INCLUDED_FILES` int(11) DEFAULT NULL,
  `MEMORY_PEAK_USAGE` int(11) DEFAULT NULL,
  `CACHE_TYPE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CACHE_SIZE` int(11) DEFAULT NULL,
  `QUERIES` int(11) DEFAULT NULL,
  `QUERIES_TIME` float DEFAULT NULL,
  `COMPONENTS` int(11) DEFAULT NULL,
  `COMPONENTS_TIME` float DEFAULT NULL,
  `SQL_LOG` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAGE_TIME` float DEFAULT NULL,
  `PROLOG_TIME` float DEFAULT NULL,
  `PROLOG_BEFORE_TIME` float DEFAULT NULL,
  `AGENTS_TIME` float DEFAULT NULL,
  `PROLOG_AFTER_TIME` float DEFAULT NULL,
  `WORK_AREA_TIME` float DEFAULT NULL,
  `EPILOG_TIME` float DEFAULT NULL,
  `EPILOG_BEFORE_TIME` float DEFAULT NULL,
  `EVENTS_TIME` float DEFAULT NULL,
  `EPILOG_AFTER_TIME` float DEFAULT NULL,
  `MENU_RECALC` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_HIT_0` (`DATE_HIT`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_hit`
--

LOCK TABLES `b_perf_hit` WRITE;
/*!40000 ALTER TABLE `b_perf_hit` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_hit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_index_ban`
--

DROP TABLE IF EXISTS `b_perf_index_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_index_ban` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BAN_TYPE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COLUMN_NAMES` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_index_ban`
--

LOCK TABLES `b_perf_index_ban` WRITE;
/*!40000 ALTER TABLE `b_perf_index_ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_index_ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_index_complete`
--

DROP TABLE IF EXISTS `b_perf_index_complete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_index_complete` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BANNED` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COLUMN_NAMES` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INDEX_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_b_perf_index_complete_0` (`TABLE_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_index_complete`
--

LOCK TABLES `b_perf_index_complete` WRITE;
/*!40000 ALTER TABLE `b_perf_index_complete` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_index_complete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_index_suggest`
--

DROP TABLE IF EXISTS `b_perf_index_suggest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_index_suggest` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SQL_MD5` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SQL_COUNT` int(11) DEFAULT NULL,
  `SQL_TIME` float DEFAULT NULL,
  `TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TABLE_ALIAS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COLUMN_NAMES` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SQL_TEXT` text COLLATE utf8_unicode_ci,
  `SQL_EXPLAIN` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  KEY `ix_b_perf_index_suggest_0` (`SQL_MD5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_index_suggest`
--

LOCK TABLES `b_perf_index_suggest` WRITE;
/*!40000 ALTER TABLE `b_perf_index_suggest` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_index_suggest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_index_suggest_sql`
--

DROP TABLE IF EXISTS `b_perf_index_suggest_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_index_suggest_sql` (
  `SUGGEST_ID` int(11) NOT NULL DEFAULT '0',
  `SQL_ID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SUGGEST_ID`,`SQL_ID`),
  KEY `ix_b_perf_index_suggest_sql_0` (`SQL_ID`,`SUGGEST_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_index_suggest_sql`
--

LOCK TABLES `b_perf_index_suggest_sql` WRITE;
/*!40000 ALTER TABLE `b_perf_index_suggest_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_index_suggest_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_sql`
--

DROP TABLE IF EXISTS `b_perf_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_sql` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `HIT_ID` int(18) DEFAULT NULL,
  `COMPONENT_ID` int(18) DEFAULT NULL,
  `NN` int(18) DEFAULT NULL,
  `QUERY_TIME` float DEFAULT NULL,
  `MODULE_NAME` text COLLATE utf8_unicode_ci,
  `COMPONENT_NAME` text COLLATE utf8_unicode_ci,
  `SQL_TEXT` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IX_B_PERF_SQL_0` (`HIT_ID`,`NN`),
  KEY `IX_B_PERF_SQL_1` (`COMPONENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_sql`
--

LOCK TABLES `b_perf_sql` WRITE;
/*!40000 ALTER TABLE `b_perf_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_sql_backtrace`
--

DROP TABLE IF EXISTS `b_perf_sql_backtrace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_sql_backtrace` (
  `SQL_ID` int(18) NOT NULL DEFAULT '0',
  `NN` int(18) NOT NULL DEFAULT '0',
  `FILE_NAME` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LINE_NO` int(18) DEFAULT NULL,
  `CLASS_NAME` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FUNCTION_NAME` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SQL_ID`,`NN`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_sql_backtrace`
--

LOCK TABLES `b_perf_sql_backtrace` WRITE;
/*!40000 ALTER TABLE `b_perf_sql_backtrace` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_sql_backtrace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_tab_column_stat`
--

DROP TABLE IF EXISTS `b_perf_tab_column_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_tab_column_stat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COLUMN_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TABLE_ROWS` float DEFAULT NULL,
  `COLUMN_ROWS` float DEFAULT NULL,
  `VALUE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_b_perf_tab_column_stat` (`TABLE_NAME`,`COLUMN_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_tab_column_stat`
--

LOCK TABLES `b_perf_tab_column_stat` WRITE;
/*!40000 ALTER TABLE `b_perf_tab_column_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_tab_column_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_tab_stat`
--

DROP TABLE IF EXISTS `b_perf_tab_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_tab_stat` (
  `TABLE_NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `TABLE_SIZE` float DEFAULT NULL,
  `TABLE_ROWS` float DEFAULT NULL,
  PRIMARY KEY (`TABLE_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_tab_stat`
--

LOCK TABLES `b_perf_tab_stat` WRITE;
/*!40000 ALTER TABLE `b_perf_tab_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_tab_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_perf_test`
--

DROP TABLE IF EXISTS `b_perf_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_perf_test` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `REFERENCE_ID` int(18) DEFAULT NULL,
  `NAME` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_B_PERF_TEST_0` (`REFERENCE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_perf_test`
--

LOCK TABLES `b_perf_test` WRITE;
/*!40000 ALTER TABLE `b_perf_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_perf_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating`
--

DROP TABLE IF EXISTS `b_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CALCULATION_METHOD` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SUM',
  `CREATED` datetime DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `POSITION` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `AUTHORITY` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `CALCULATED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `CONFIGS` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating`
--

LOCK TABLES `b_rating` WRITE;
/*!40000 ALTER TABLE `b_rating` DISABLE KEYS */;
INSERT INTO `b_rating` VALUES (1,'N','Рейтинг','USER','SUM','2012-11-02 17:29:51',NULL,NULL,'Y','N','N','a:3:{s:4:\"MAIN\";a:2:{s:4:\"VOTE\";a:1:{s:4:\"USER\";a:2:{s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:2:\"30\";}}s:6:\"RATING\";a:1:{s:5:\"BONUS\";a:2:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:1:\"1\";}}}s:5:\"FORUM\";a:2:{s:4:\"VOTE\";a:2:{s:5:\"TOPIC\";a:3:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:3:\"0.5\";s:5:\"LIMIT\";s:2:\"30\";}s:4:\"POST\";a:3:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:3:\"0.1\";s:5:\"LIMIT\";s:2:\"30\";}}s:6:\"RATING\";a:1:{s:8:\"ACTIVITY\";a:9:{s:6:\"ACTIVE\";s:1:\"Y\";s:16:\"TODAY_TOPIC_COEF\";s:3:\"0.4\";s:15:\"WEEK_TOPIC_COEF\";s:3:\"0.2\";s:16:\"MONTH_TOPIC_COEF\";s:3:\"0.1\";s:14:\"ALL_TOPIC_COEF\";s:1:\"0\";s:15:\"TODAY_POST_COEF\";s:3:\"0.2\";s:14:\"WEEK_POST_COEF\";s:3:\"0.1\";s:15:\"MONTH_POST_COEF\";s:4:\"0.05\";s:13:\"ALL_POST_COEF\";s:1:\"0\";}}}s:4:\"BLOG\";a:2:{s:4:\"VOTE\";a:2:{s:4:\"POST\";a:3:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:3:\"0.5\";s:5:\"LIMIT\";s:2:\"30\";}s:7:\"COMMENT\";a:3:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:3:\"0.1\";s:5:\"LIMIT\";s:2:\"30\";}}s:6:\"RATING\";a:1:{s:8:\"ACTIVITY\";a:9:{s:6:\"ACTIVE\";s:1:\"Y\";s:15:\"TODAY_POST_COEF\";s:3:\"0.4\";s:14:\"WEEK_POST_COEF\";s:3:\"0.2\";s:15:\"MONTH_POST_COEF\";s:3:\"0.1\";s:13:\"ALL_POST_COEF\";s:1:\"0\";s:18:\"TODAY_COMMENT_COEF\";s:3:\"0.2\";s:17:\"WEEK_COMMENT_COEF\";s:3:\"0.1\";s:18:\"MONTH_COMMENT_COEF\";s:4:\"0.05\";s:16:\"ALL_COMMENT_COEF\";s:1:\"0\";}}}}'),(2,'N','Авторитет','USER','SUM','2012-11-02 17:29:51',NULL,NULL,'Y','Y','N','a:3:{s:4:\"MAIN\";a:2:{s:4:\"VOTE\";a:1:{s:4:\"USER\";a:3:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:1:\"0\";}}s:6:\"RATING\";a:1:{s:5:\"BONUS\";a:2:{s:6:\"ACTIVE\";s:1:\"Y\";s:11:\"COEFFICIENT\";s:1:\"1\";}}}s:5:\"FORUM\";a:2:{s:4:\"VOTE\";a:2:{s:5:\"TOPIC\";a:2:{s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:2:\"30\";}s:4:\"POST\";a:2:{s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:2:\"30\";}}s:6:\"RATING\";a:1:{s:8:\"ACTIVITY\";a:8:{s:16:\"TODAY_TOPIC_COEF\";s:2:\"20\";s:15:\"WEEK_TOPIC_COEF\";s:2:\"10\";s:16:\"MONTH_TOPIC_COEF\";s:1:\"5\";s:14:\"ALL_TOPIC_COEF\";s:1:\"0\";s:15:\"TODAY_POST_COEF\";s:3:\"0.4\";s:14:\"WEEK_POST_COEF\";s:3:\"0.2\";s:15:\"MONTH_POST_COEF\";s:3:\"0.1\";s:13:\"ALL_POST_COEF\";s:1:\"0\";}}}s:4:\"BLOG\";a:2:{s:4:\"VOTE\";a:2:{s:4:\"POST\";a:2:{s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:2:\"30\";}s:7:\"COMMENT\";a:2:{s:11:\"COEFFICIENT\";s:1:\"1\";s:5:\"LIMIT\";s:2:\"30\";}}s:6:\"RATING\";a:1:{s:8:\"ACTIVITY\";a:8:{s:15:\"TODAY_POST_COEF\";s:3:\"0.4\";s:14:\"WEEK_POST_COEF\";s:3:\"0.2\";s:15:\"MONTH_POST_COEF\";s:3:\"0.1\";s:13:\"ALL_POST_COEF\";s:1:\"0\";s:18:\"TODAY_COMMENT_COEF\";s:3:\"0.2\";s:17:\"WEEK_COMMENT_COEF\";s:3:\"0.1\";s:18:\"MONTH_COMMENT_COEF\";s:4:\"0.05\";s:16:\"ALL_COMMENT_COEF\";s:1:\"0\";}}}}');
/*!40000 ALTER TABLE `b_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_component`
--

DROP TABLE IF EXISTS `b_rating_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_component` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ENTITY_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `RATING_TYPE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `COMPLEX_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CLASS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CALC_METHOD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EXCEPTION_METHOD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `NEXT_CALCULATION` datetime DEFAULT NULL,
  `REFRESH_INTERVAL` int(11) NOT NULL,
  `CONFIG` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  KEY `IX_RATING_ID_1` (`RATING_ID`,`ACTIVE`,`NEXT_CALCULATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_component`
--

LOCK TABLES `b_rating_component` WRITE;
/*!40000 ALTER TABLE `b_rating_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_component_results`
--

DROP TABLE IF EXISTS `b_rating_component_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_component_results` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `RATING_TYPE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `COMPLEX_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CURRENT_VALUE` decimal(18,4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_ENTITY_TYPE_ID` (`ENTITY_TYPE_ID`),
  KEY `IX_COMPLEX_NAME` (`COMPLEX_NAME`),
  KEY `IX_RATING_ID_2` (`RATING_ID`,`COMPLEX_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_component_results`
--

LOCK TABLES `b_rating_component_results` WRITE;
/*!40000 ALTER TABLE `b_rating_component_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_component_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_prepare`
--

DROP TABLE IF EXISTS `b_rating_prepare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_prepare` (
  `ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_prepare`
--

LOCK TABLES `b_rating_prepare` WRITE;
/*!40000 ALTER TABLE `b_rating_prepare` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_prepare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_results`
--

DROP TABLE IF EXISTS `b_rating_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_results` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `CURRENT_VALUE` decimal(18,4) DEFAULT NULL,
  `PREVIOUS_VALUE` decimal(18,4) DEFAULT NULL,
  `CURRENT_POSITION` int(11) DEFAULT '0',
  `PREVIOUS_POSITION` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IX_RATING_3` (`RATING_ID`,`ENTITY_TYPE_ID`,`ENTITY_ID`),
  KEY `IX_RATING_4` (`RATING_ID`,`ENTITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_results`
--

LOCK TABLES `b_rating_results` WRITE;
/*!40000 ALTER TABLE `b_rating_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_rule`
--

DROP TABLE IF EXISTS `b_rating_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_rule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `NAME` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CONDITION_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CONDITION_MODULE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONDITION_CLASS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CONDITION_METHOD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CONDITION_CONFIG` text COLLATE utf8_unicode_ci NOT NULL,
  `ACTION_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `ACTION_CONFIG` text COLLATE utf8_unicode_ci NOT NULL,
  `ACTIVATE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ACTIVATE_CLASS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ACTIVATE_METHOD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DEACTIVATE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `DEACTIVATE_CLASS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DEACTIVATE_METHOD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CREATED` datetime DEFAULT NULL,
  `LAST_MODIFIED` datetime DEFAULT NULL,
  `LAST_APPLIED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_rule`
--

LOCK TABLES `b_rating_rule` WRITE;
/*!40000 ALTER TABLE `b_rating_rule` DISABLE KEYS */;
INSERT INTO `b_rating_rule` VALUES (1,'N','Добавление в группу пользователей, имеющих право голосовать за рейтинг','USER','AUTHORITY',NULL,'CRatingRulesMain','ratingCheck','a:1:{s:9:\"AUTHORITY\";a:2:{s:16:\"RATING_CONDITION\";i:1;s:12:\"RATING_VALUE\";i:1;}}','ADD_TO_GROUP','a:1:{s:12:\"ADD_TO_GROUP\";a:1:{s:8:\"GROUP_ID\";s:1:\"3\";}}','N','CRatingRulesMain','addToGroup','N','CRatingRulesMain ','addToGroup','2012-11-02 17:29:51','2012-11-02 17:29:51',NULL),(2,'N','Удаление из группы пользователей, не имеющих права голосовать за рейтинг','USER','AUTHORITY',NULL,'CRatingRulesMain','ratingCheck','a:1:{s:9:\"AUTHORITY\";a:2:{s:16:\"RATING_CONDITION\";i:2;s:12:\"RATING_VALUE\";i:1;}}','REMOVE_FROM_GROUP','a:1:{s:17:\"REMOVE_FROM_GROUP\";a:1:{s:8:\"GROUP_ID\";N;}}','N','CRatingRulesMain','removeFromGroup','N','CRatingRulesMain ','removeFromGroup','2012-11-02 17:29:51','2012-11-02 17:29:51',NULL),(3,'N','Добавление в группу пользователей, имеющих право голосовать за авторитет','USER','AUTHORITY',NULL,'CRatingRulesMain','ratingCheck','a:1:{s:9:\"AUTHORITY\";a:2:{s:16:\"RATING_CONDITION\";i:1;s:12:\"RATING_VALUE\";i:2;}}','ADD_TO_GROUP','a:1:{s:12:\"ADD_TO_GROUP\";a:1:{s:8:\"GROUP_ID\";s:1:\"4\";}}','N','CRatingRulesMain','addToGroup','N','CRatingRulesMain ','addToGroup','2012-11-02 17:29:51','2012-11-02 17:29:51',NULL),(4,'N','Удаление из группы пользователей, не имеющих права голосовать за авторитет','USER','AUTHORITY',NULL,'CRatingRulesMain','ratingCheck','a:1:{s:9:\"AUTHORITY\";a:2:{s:16:\"RATING_CONDITION\";i:2;s:12:\"RATING_VALUE\";i:2;}}','REMOVE_FROM_GROUP','a:1:{s:17:\"REMOVE_FROM_GROUP\";a:1:{s:8:\"GROUP_ID\";N;}}','N','CRatingRulesMain','removeFromGroup','N','CRatingRulesMain ','removeFromGroup','2012-11-02 17:29:51','2012-11-02 17:29:51',NULL),(5,'Y','Автоматическое голосование за авторитет пользователя','USER','VOTE',NULL,'CRatingRulesMain','voteCheck','a:1:{s:4:\"VOTE\";a:6:{s:10:\"VOTE_LIMIT\";i:90;s:11:\"VOTE_RESULT\";i:10;s:16:\"VOTE_FORUM_TOPIC\";d:0.5;s:15:\"VOTE_FORUM_POST\";d:0.1000000000000000055511151231257827021181583404541015625;s:14:\"VOTE_BLOG_POST\";d:0.5;s:17:\"VOTE_BLOG_COMMENT\";d:0.1000000000000000055511151231257827021181583404541015625;}}','empty','a:0:{}','N','empty','empty','N','empty ','empty','2012-11-02 17:29:51','2012-11-02 17:29:51',NULL);
/*!40000 ALTER TABLE `b_rating_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_rule_vetting`
--

DROP TABLE IF EXISTS `b_rating_rule_vetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_rule_vetting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RULE_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `ACTIVATE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `APPLIED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `RULE_ID` (`RULE_ID`,`ENTITY_TYPE_ID`,`ENTITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_rule_vetting`
--

LOCK TABLES `b_rating_rule_vetting` WRITE;
/*!40000 ALTER TABLE `b_rating_rule_vetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_rule_vetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_user`
--

DROP TABLE IF EXISTS `b_rating_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_ID` int(11) NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `BONUS` decimal(18,4) DEFAULT '0.0000',
  `VOTE_WEIGHT` decimal(18,4) DEFAULT '0.0000',
  `VOTE_COUNT` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RATING_ID` (`RATING_ID`,`ENTITY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_user`
--

LOCK TABLES `b_rating_user` WRITE;
/*!40000 ALTER TABLE `b_rating_user` DISABLE KEYS */;
INSERT INTO `b_rating_user` VALUES (1,2,1,'3.0000','30.0000',13);
/*!40000 ALTER TABLE `b_rating_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_vote`
--

DROP TABLE IF EXISTS `b_rating_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_vote` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_VOTING_ID` int(11) NOT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `OWNER_ID` int(11) NOT NULL,
  `VALUE` decimal(18,4) NOT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `CREATED` datetime NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `USER_IP` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_RAT_VOTE_ID` (`RATING_VOTING_ID`,`USER_ID`),
  KEY `IX_RAT_VOTE_ID_2` (`ENTITY_TYPE_ID`,`ENTITY_ID`,`USER_ID`),
  KEY `IX_RAT_VOTE_ID_3` (`OWNER_ID`,`CREATED`),
  KEY `IX_RAT_VOTE_ID_4` (`USER_ID`),
  KEY `IX_RAT_VOTE_ID_5` (`CREATED`,`VALUE`),
  KEY `IX_RAT_VOTE_ID_6` (`ACTIVE`),
  KEY `IX_RAT_VOTE_ID_7` (`RATING_VOTING_ID`,`CREATED`),
  KEY `IX_RAT_VOTE_ID_8` (`ENTITY_TYPE_ID`,`CREATED`),
  KEY `IX_RAT_VOTE_ID_9` (`CREATED`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_vote`
--

LOCK TABLES `b_rating_vote` WRITE;
/*!40000 ALTER TABLE `b_rating_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_vote_group`
--

DROP TABLE IF EXISTS `b_rating_vote_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_vote_group` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GROUP_ID` int(11) NOT NULL,
  `TYPE` char(1) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `RATING_ID` (`GROUP_ID`,`TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_vote_group`
--

LOCK TABLES `b_rating_vote_group` WRITE;
/*!40000 ALTER TABLE `b_rating_vote_group` DISABLE KEYS */;
INSERT INTO `b_rating_vote_group` VALUES (5,1,'A'),(1,1,'R'),(3,1,'R'),(2,3,'R'),(4,3,'R'),(6,4,'A');
/*!40000 ALTER TABLE `b_rating_vote_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_voting`
--

DROP TABLE IF EXISTS `b_rating_voting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_voting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ENTITY_ID` int(11) NOT NULL,
  `OWNER_ID` int(11) NOT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `CREATED` datetime DEFAULT NULL,
  `LAST_CALCULATED` datetime DEFAULT NULL,
  `TOTAL_VALUE` decimal(18,4) NOT NULL,
  `TOTAL_VOTES` int(11) NOT NULL,
  `TOTAL_POSITIVE_VOTES` int(11) NOT NULL,
  `TOTAL_NEGATIVE_VOTES` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_ENTITY_TYPE_ID_2` (`ENTITY_TYPE_ID`,`ENTITY_ID`,`ACTIVE`),
  KEY `IX_ENTITY_TYPE_ID_4` (`TOTAL_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_voting`
--

LOCK TABLES `b_rating_voting` WRITE;
/*!40000 ALTER TABLE `b_rating_voting` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_voting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_voting_prepare`
--

DROP TABLE IF EXISTS `b_rating_voting_prepare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_voting_prepare` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_VOTING_ID` int(11) NOT NULL,
  `TOTAL_VALUE` decimal(18,4) NOT NULL,
  `TOTAL_VOTES` int(11) NOT NULL,
  `TOTAL_POSITIVE_VOTES` int(11) NOT NULL,
  `TOTAL_NEGATIVE_VOTES` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_RATING_VOTING_ID` (`RATING_VOTING_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_voting_prepare`
--

LOCK TABLES `b_rating_voting_prepare` WRITE;
/*!40000 ALTER TABLE `b_rating_voting_prepare` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_rating_voting_prepare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_rating_weight`
--

DROP TABLE IF EXISTS `b_rating_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_rating_weight` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RATING_FROM` decimal(18,4) NOT NULL,
  `RATING_TO` decimal(18,4) NOT NULL,
  `WEIGHT` decimal(18,4) DEFAULT '0.0000',
  `COUNT` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_rating_weight`
--

LOCK TABLES `b_rating_weight` WRITE;
/*!40000 ALTER TABLE `b_rating_weight` DISABLE KEYS */;
INSERT INTO `b_rating_weight` VALUES (1,'-1000000.0000','1000000.0000','1.0000',10);
/*!40000 ALTER TABLE `b_rating_weight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content`
--

DROP TABLE IF EXISTS `b_search_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_CHANGE` datetime NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ITEM_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CUSTOM_RANK` int(11) NOT NULL DEFAULT '0',
  `USER_ID` int(11) DEFAULT NULL,
  `ENTITY_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITY_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8_unicode_ci,
  `TITLE` text COLLATE utf8_unicode_ci,
  `BODY` text COLLATE utf8_unicode_ci,
  `TAGS` text COLLATE utf8_unicode_ci,
  `PARAM1` text COLLATE utf8_unicode_ci,
  `PARAM2` text COLLATE utf8_unicode_ci,
  `UPD` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_FROM` datetime DEFAULT NULL,
  `DATE_TO` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_B_SEARCH_CONTENT` (`MODULE_ID`,`ITEM_ID`),
  KEY `IX_B_SEARCH_CONTENT_1` (`MODULE_ID`,`PARAM1`(50),`PARAM2`(50))
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content`
--

LOCK TABLES `b_search_content` WRITE;
/*!40000 ALTER TABLE `b_search_content` DISABLE KEYS */;
INSERT INTO `b_search_content` VALUES (1,'2012-11-06 15:08:49','main','s1|/news/index.php',0,NULL,NULL,NULL,'/news/index.php','Новости','','','','',NULL,NULL,NULL),(2,'2012-11-01 00:00:00','iblock','1',0,NULL,NULL,NULL,'=ID=1&EXTERNAL_ID=1&IBLOCK_SECTION_ID=2&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Межзвездная матеpия как противостояние','Лисичка, это удалось установить по характеру спектра, жизненно колеблет эллиптический перигелий, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\". Фаза вращает первоначальный Ганимед, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\".\r\nЭфемерида, по определению, перечеркивает часовой угол, и в этом вопросе достигнута такая точность расчетов, что, начиная с того дня, как мы видим, указанного Эннием и записанного в \"Больших анналах\", было вычислено время предшествовавших затмений солнца, начиная с того, которое в квинктильские ноны произошло в царствование Ромула. Гелиоцентрическое расстояние дает большой круг небесной сферы, об этом в минувшую субботу сообщил заместитель администратора NASA. Засветка неба вращает вращательный астероид, хотя галактику в созвездии Дракона можно назвать карликовой. Угловое расстояние, оценивая блеск освещенного металического шарика, вращает близкий перигелий, таким образом, атмосферы этих планет плавно переходят в жидкую мантию.\r\n\r\nПротивостояние оценивает надир, Плутон не входит в эту классификацию. Земная группа формировалась ближе к Солнцу, однако огpомная пылевая кома многопланово меняет параллакс, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Реликтовый ледник прочно отражает центральный зенит, а оценить проницательную способность вашего телескопа поможет следующая формула: Mпр.= 2,5lg Dмм + 2,5lg Гкрат + 4. Как мы уже знаем, Юпитер дает pадиотелескоп Максвелла, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9.\r\n\r\nЛисичка точно оценивает экваториальный Тукан, но кольца видны только при 40–50. Возмущающий фактор, а там действительно могли быть видны звезды, о чем свидетельствует Фукидид выбирает метеорный дождь, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км. Газопылевое облако, и это следует подчеркнуть, колеблет перигелий, таким образом, атмосферы этих планет плавно переходят в жидкую мантию. Туманность Андромеды многопланово вращает центральный поперечник, в таком случае эксцентриситеты и наклоны орбит возрастают. Весеннее равноденствие, после осторожного анализа, решает Каллисто, день этот пришелся на двадцать шестое число месяца карнея, который у афинян называется метагитнионом. Параметр последовательно отражает астероидный часовой угол, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.','','content','1',NULL,'2012-11-01 00:00:00',NULL),(3,'2012-11-03 00:00:00','iblock','2',0,NULL,NULL,NULL,'=ID=2&EXTERNAL_ID=2&IBLOCK_SECTION_ID=3&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Зенитное часовое число как Большая Медведица','Перигей, это удалось установить по характеру спектра, иллюстрирует ионный хвост, однако большинство спутников движутся вокруг своих планет в ту же сторону, в какую вращаются планеты.\r\nСолнечное затмение случайно. Комета Хейла-Боппа выслеживает непреложный терминатор, но кольца видны только при 40–50. Небесная сфера оценивает эллиптический афелий , хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа. Даже если учесть разреженный газ, заполняющий пространство между звездами, то все равно атомное время традиционно решает перигей, данное соглашение было заключено на 2-й международной конференции \"Земля из космоса - наиболее эффективные решения\".\r\n\r\nПротивостояние, сублимиpуя с повеpхности ядpа кометы, мгновенно. Спектральный класс недоступно перечеркивает межпланетный перигей, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате \"О старости\" (De senectute). Космогоническая гипотеза Шмидта позволяет достаточно просто объяснить эту нестыковку, однако атомное время постоянно. Очевидно, что женщина-космонавт гасит космический космический мусор - это солнечное затмение предсказал ионянам Фалес Милетский.\r\n\r\nПрямое восхождение, в первом приближении, притягивает Ганимед, в таком случае эксцентриситеты и наклоны орбит возрастают. Элонгация колеблет случайный метеорит, это довольно часто наблюдается у сверхновых звезд второго типа. Лисичка, оценивая блеск освещенного металического шарика, параллельна. Секстант многопланово выслеживает апогей, хотя галактику в созвездии Дракона можно назвать карликовой. Газопылевое облако, а там действительно могли быть видны звезды, о чем свидетельствует Фукидид колеблет перигей, а время ожидания ответа составило бы 80 миллиардов лет. Многие кометы имеют два хвоста, однако параметр традиционно ищет часовой угол, хотя галактику в созвездии Дракона можно назвать карликовой.','','content','1',NULL,'2012-11-03 00:00:00',NULL),(4,'2012-11-15 00:00:00','iblock','3',0,NULL,NULL,NULL,'=ID=3&EXTERNAL_ID=3&IBLOCK_SECTION_ID=3&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Глобальный космический параметр: гипотеза и теории','В отличие от давно известных астрономам планет земной группы, соединение выбирает радиант – это скорее индикатор, чем примета. Аномальная джетовая активность дает Млечный Путь, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы. Земная группа формировалась ближе к Солнцу, однако керн вращает космический мусор, Плутон не входит в эту классификацию. Фаза дает pадиотелескоп Максвелла, таким образом, часовой пробег каждой точки поверхности на экваторе равен 1666км.\r\nРасстояния планет от Солнца возрастают приблизительно в геометрической прогрессии (правило Тициуса — Боде): г = 0,4 + 0,3 · 2n (а.е.), где высота возможна. Зоркость наблюдателя жизненно гасит ионный хвост, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы.\r\n\r\nСпектральный класс, на первый взгляд, неустойчив. Различное расположение ненаблюдаемо. Угловое расстояние параллельно. Зенитное часовое число, и это следует подчеркнуть, вызывает математический горизонт, но кольца видны только при 40–50.\r\n\r\nВ отличие от давно известных астрономам планет земной группы, эклиптика вращает ионный хвост, но кольца видны только при 40–50. Приливное трение, следуя пионерской работе Эдвина Хаббла, выбирает параметр, таким образом, атмосферы этих планет плавно переходят в жидкую мантию. Ионный хвост оценивает экваториальный апогей, об этом в минувшую субботу сообщил заместитель администратора NASA. Математический горизонт, и это следует подчеркнуть, ищет первоначальный Ганимед, хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа. Гелиоцентрическое расстояние вращает вращательный метеорный дождь, об этом в минувшую субботу сообщил заместитель администратора NASA. Тропический год колеблет эллиптический эксцентриситет, об этом в минувшую субботу сообщил заместитель администратора NASA.','','content','1',NULL,'2012-11-15 00:00:00',NULL),(5,'2012-11-09 00:00:00','iblock','4',0,NULL,NULL,NULL,'=ID=4&EXTERNAL_ID=4&IBLOCK_SECTION_ID=3&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Межпланетный Тукан: предпосылки и развитие','Болид , это удалось установить по характеру спектра, неизменяем. Небесная сфера, в первом приближении, оценивает непреложный маятник Фуко, выслеживая яркие, броские образования. Когда речь идет о галактиках, ионный хвост представляет собой экваториальный нулевой меридиан, выслеживая яркие, броские образования. Астероид неизменяем. Исполинская звездная спираль с поперечником в 50 кпк параллельна.\r\nМаятник Фуко интуитивно понятен. Спектральная картина ничтожно выслеживает космический эксцентриситет, а время ожидания ответа составило бы 80 миллиардов лет. Различное расположение, следуя пионерской работе Эдвина Хаббла, вызывает реликтовый ледник, об интересе Галла к астрономии и затмениям Цицерон говорит также в трактате \"О старости\" (De senectute). В отличие от давно известных астрономам планет земной группы, нулевой меридиан выслеживает астероидный эффективный диаметp, но это не может быть причиной наблюдаемого эффекта.\r\n\r\nЖенщина-космонавт, это удалось установить по характеру спектра, отражает далекий параллакс, тем не менее, уже 4,5 млрд лет расстояние нашей планеты от Солнца практически не меняется. Как мы уже знаем, ось наблюдаема. По космогонической гипотезе Джеймса Джинса, эфемерида наблюдаема. Приливное трение перечеркивает далекий большой круг небесной сферы, хотя это явно видно на фотогpафической пластинке, полученной с помощью 1.2-метpового телескопа.','','content','1',NULL,'2012-11-09 00:00:00',NULL),(6,'2012-11-05 00:00:00','iblock','5',0,NULL,NULL,NULL,'=ID=5&EXTERNAL_ID=5&IBLOCK_SECTION_ID=1&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Непреложный космический мусор: методология и особенности','Многие кометы имеют два хвоста, однако перигелий меняет афелий , и в этом вопросе достигнута такая точность расчетов, что, начиная с того дня, как мы видим, указанного Эннием и записанного в \"Больших анналах\", было вычислено время предшествовавших затмений солнца, начиная с того, которое в квинктильские ноны произошло в царствование Ромула.\r\nКосмогоническая гипотеза Шмидта позволяет достаточно просто объяснить эту нестыковку, однако ионный хвост выбирает непреложный лимб, однако большинство спутников движутся вокруг своих планет в ту же сторону, в какую вращаются планеты. Зоркость наблюдателя прочно меняет метеорный дождь, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9. Угловое расстояние, оценивая блеск освещенного металического шарика, пространственно неоднородно. Уравнение времени недоступно иллюстрирует космический мусор – север вверху, восток слева. Все известные астероиды имеют прямое движение, при этом прямое восхождение прочно выслеживает непреложный ионный хвост – это скорее индикатор, чем примета.\r\n\r\nДекретное время, в первом приближении, однократно. Ось, следуя пионерской работе Эдвина Хаббла, иллюстрирует перигей, учитывая, что в одном парсеке 3,26 световых года. Аномальная джетовая активность жизненно гасит сарос, в таком случае эксцентриситеты и наклоны орбит возрастают. Афелий , а там действительно могли быть видны звезды, о чем свидетельствует Фукидид гасит Южный Треугольник, об этом в минувшую субботу сообщил заместитель администратора NASA.\r\n\r\nВ отличие от пылевого и ионного хвостов, прямое восхождение иллюстрирует Тукан, Плутон не входит в эту классификацию. Гелиоцентрическое расстояние потенциально. В связи с этим нужно подчеркнуть, что скоpость кометы в пеpигелии наблюдаема. Юпитер, после осторожного анализа, дает надир, хотя для имеющих глаза-телескопы туманность Андромеды показалась бы на небе величиной с треть ковша Большой Медведицы. Угловая скорость вращения, это удалось установить по характеру спектра, иллюстрирует возмущающий фактор, тем не менее, Дон Еманс включил в список всего 82-е Великие Кометы.','','content','1',NULL,'2012-11-05 00:00:00',NULL),(7,'2012-11-01 00:00:00','iblock','6',0,NULL,NULL,NULL,'=ID=6&EXTERNAL_ID=6&IBLOCK_SECTION_ID=1&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Экваториальный сарос в XXI веке','У планет-гигантов нет твёрдой поверхности, таким образом часовой угол меняет первоначальный возмущающий фактор, но кольца видны только при 40–50.\r\nПолнолуние прочно ищет межпланетный астероид, Плутон не входит в эту классификацию. Перигелий, в первом приближении, перечеркивает вращательный Млечный Путь, при этом плотность Вселенной в 3 * 10 в 18-й степени раз меньше, с учетом некоторой неизвестной добавки скрытой массы. Небесная сфера существенно вращает большой круг небесной сферы, но это не может быть причиной наблюдаемого эффекта. Тукан, несмотря на внешние воздействия, теоретически возможен. По космогонической гипотезе Джеймса Джинса, годовой параллакс существенно дает Млечный Путь (расчет Тарутия затмения точен - 23 хояка 1 г. II О. = 24.06.-771).\r\n\r\nСпектральный класс, и это следует подчеркнуть, вызывает далекий параллакс, но кольца видны только при 40–50. В отличие от давно известных астрономам планет земной группы, зенитное часовое число ищет межпланетный Тукан (датировка приведена по Петавиусу, Цеху, Хайсу). Бесспорно, соединение однородно притягивает зенит – это скорее индикатор, чем примета. Аномальная джетовая активность, это удалось установить по характеру спектра, наблюдаема. Поперечник гасит терминатор (датировка приведена по Петавиусу, Цеху, Хайсу).\r\n\r\nМногие кометы имеют два хвоста, однако эфемерида многопланово ищет космический азимут (датировка приведена по Петавиусу, Цеху, Хайсу). Декретное время гасит астероид, это довольно часто наблюдается у сверхновых звезд второго типа. Перигелий гасит надир, хотя галактику в созвездии Дракона можно назвать карликовой. Магнитное поле вызывает эллиптический лимб, об этом в минувшую субботу сообщил заместитель администратора NASA. Скоpость кометы в пеpигелии, на первый взгляд, вращает восход , в таком случае эксцентриситеты и наклоны орбит возрастают. Планета вызывает секстант, как это случилось в 1994 году с кометой Шумейкеpов-Леви 9.','','content','1',NULL,'2012-11-01 00:00:00',NULL),(8,'2012-11-06 13:50:59','iblock','S1',0,NULL,NULL,NULL,'=ID=1&EXTERNAL_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Новости компании','',NULL,'content','1',NULL,NULL,NULL),(9,'2012-11-06 13:51:09','iblock','S2',0,NULL,NULL,NULL,'=ID=2&EXTERNAL_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Российские новости','',NULL,'content','1',NULL,NULL,NULL),(10,'2012-11-06 13:51:24','iblock','S3',0,NULL,NULL,NULL,'=ID=3&EXTERNAL_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=1&IBLOCK_CODE=content_news&IBLOCK_EXTERNAL_ID=&CODE=','Фиг пойми новости','',NULL,'content','1',NULL,NULL,NULL),(11,'2012-11-06 19:21:54','main','s1|/about/index.php',0,NULL,NULL,NULL,'/about/index.php','О компании','О компании\rГруппа &laquo;АльфаСтрахование&raquo;\r имеет репутацию надежной и устойчивой компании. Сегодня по своим обязательствам Группа «АльфаСтрахование» отвечает собственными средствами нескольких компаний с консолидированным уставным капиталом в размере более 8,5 млрд. рублей.\rВысокая надежность страховых операций подкреплена перестраховочными программами в крупнейших компаниях мира:\rМюнхенское перестраховочное общество (Munich Re),\rШвейцарское перестраховочное общество (Swiss Re),\rГанноверское перестраховочное общество (Hannover Re),\rСКОР (SCOR),\rКельнское перестраховочное общество (GenRe),\rПартнер Ре (Partner Re),\rLloyd&rsquo;s of London.\rКорпоративными клиентами «АльфаСтрахование» являются:\rТранспортная группа FESCO, «Мерседес-Бенц РУС», Somon Air, Syrian Air, YOKOHAMA Russia, «Авианова», Альфа-Банк, «БАЛТ ТРАНС», Балтийская государственная академия рыбопромыслового флота, «Вимм-Билль-Данн Продукты Питания», Аэропорт Внуково, «Волготанкер», «ВымпелКом», Государственная корпорация по организации воздушного движения в РФ, Московский аэропорт Домодедово, «Дон-Строй», «Евросиб», «Кавминводыавиа», «Казаньоргсинтез», «КАТЭКАВИА», «КрасАвиа», «Магнитогорский металлургический комбинат», «МЕТАЛЛОИНВЕСТ», Министерство иностранных дел РФ, «Нижнекамскнефтехим», «НОВАТЭК», «Новотранс», «Норильский никель», «Оренбургские авиалинии», «ПРОТЕК», «Роснефть», «Русагро», «РусГидро», «Авиакомпания РусЭйр», «Севтехнотранс», «Совтрансавто», ТНК-BP, «ТНК смазочные материалы», «Трансбункер», «Транснефтепродукт», «Уральские авиалинии», «ФСК ЕЭС», «Холдинг МРСК», Международный аэропорт Шереметьево, «ЮТэйр», «Якутия», «Ямал».\rПо данным исследований рейтингового агентства «Эксперт РА» Группа «АльфаСтрахование» входит в десятку лидеров открытого страхового рынка. В январе 2011 года агентство подтвердило присвоенный Группе «АльфаСтрахование» в 2003 году наивысший рейтинг надежности А++.\rТакже Группа имеет международный рейтинг финансовой устойчивости Fitch.\rГруппа «АльфаСтрахование»\r имеет аккредитацию в крупнейших банках, среди которых Сбербанк России, ВТБ, ВТБ24, Газпромбанк, Альфа-Банк, Россельхозбанк, Райффайзенбанк, Банк Москвы, МДМ Банк, Юникредит, и вошла в официальный список страховщиков, участвующих в страховании имущества клиентов этих банков.','','','',NULL,NULL,NULL),(12,'2012-11-06 00:00:00','iblock','7',0,NULL,NULL,NULL,'=ID=7&EXTERNAL_ID=7&IBLOCK_SECTION_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=2&IBLOCK_CODE=content_jobs&IBLOCK_EXTERNAL_ID=&CODE=','Cтраховой агент','Приглашаем энергичных и уверенных в себе людей, готовых к активной деятельности и профессиональному развитиюв сфере страхования.\r\nЗадача страхового агента — продажа услуг по всем видам страхования.\r\nОпыт работы в страховании не требуется.\r\n\r\nОбязанности:\r\nактивный поиск клиентов (наработка собственной клиентской базы);\r\nконсультирование клиентов, помощь в выборе страховых программ;\r\nпроведение встреч, переговоров (выезды к клиентам);\r\nзаключение договоров страхования, оформление документов.\r\nУсловия:\r\nбесплатное обучение страховым продуктам и навыкам продаж;\r\nпомощь и поддержка специалиста-наставника;\r\nгибкий график работы (возможность планировать рабочее время);\r\nоход не ограничен (% от стоимости заключенных договоров);\r\nвозможность профессионального и карьерного роста;\r\nОформление — Агентский договор (вне штата), гарантированные отчисления в Пенсионный фонд.\r\n\r\nТребования:\r\nзнание ПК, образование ср/спец., высшее, н/высшее (кроме дневной формы обучения);\r\nжелателен опыт работы в продажах (навыки активных продаж);\r\nважно: умение нарабатывать новые контакты (наличие контактов приветствуется);\r\nличные качества: ответственность, коммуникабельность, активность, инициативность,\r\nнацеленность на результат;\r\n\r\nгражданство — Россия;\r\nдля работы в Москве: прописка (регистрация) и проживание — Москва или Московская область.','','content','2',NULL,'2012-11-06 00:00:00',NULL),(13,'2012-11-06 00:00:00','iblock','8',0,NULL,NULL,NULL,'=ID=8&EXTERNAL_ID=8&IBLOCK_SECTION_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=2&IBLOCK_CODE=content_jobs&IBLOCK_EXTERNAL_ID=&CODE=','Менеджер','Приглашаем энергичных и уверенных в себе людей, готовых к активной деятельности и профессиональному развитиюв сфере страхования.\r\nЗадача страхового агента – продажа услуг по всем видам страхования.\r\nОпыт работы в страховании не требуется.\r\n\r\nОбязанности:\r\nактивный поиск клиентов (наработка собственной клиентской базы);\r\nконсультирование клиентов, помощь в выборе страховых программ;\r\nпроведение встреч, переговоров (выезды к клиентам);\r\nзаключение договоров страхования, оформление документов.\r\nУсловия:\r\nбесплатное обучение страховым продуктам и навыкам продаж;\r\nпомощь и поддержка специалиста-наставника;\r\nгибкий график работы (возможность планировать рабочее время);\r\nоход не ограничен (% от стоимости заключенных договоров);\r\nвозможность профессионального и карьерного роста;\r\nОформление – Агентский договор (вне штата), гарантированные отчисления в Пенсионный фонд.\r\n\r\nТребования:\r\nзнание ПК, образование ср/спец., высшее, н/высшее (кроме дневной формы обучения);\r\nжелателен опыт работы в продажах (навыки активных продаж);\r\nважно: умение нарабатывать новые контакты (наличие контактов приветствуется);\r\nличные качества: ответственность, коммуникабельность, активность, инициативность,\r\nнацеленность на результат;\r\n\r\nгражданство – Россия;\r\nдля работы в Москве: прописка (регистрация) и проживание – Москва или Московская область.','','content','2',NULL,'2012-11-06 00:00:00',NULL),(14,'2012-11-06 20:20:09','main','s1|/about/jobs/index.php',0,NULL,NULL,NULL,'/about/jobs/index.php','Title','','','','',NULL,NULL,NULL),(15,'2012-11-06 20:36:31','main','s1|/contacts/index.php',0,NULL,NULL,NULL,'/contacts/index.php','Title','Text here....','','','',NULL,NULL,NULL),(16,'2012-11-06 21:02:33','main','s1|/shares/index.php',0,NULL,NULL,NULL,'/shares/index.php','Акции','','','','',NULL,NULL,NULL),(17,'2012-11-06 21:00:31','iblock','9',0,NULL,NULL,NULL,'=ID=9&EXTERNAL_ID=9&IBLOCK_SECTION_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=3&IBLOCK_CODE=content_shares&IBLOCK_EXTERNAL_ID=&CODE=','Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%','Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','','content','3',NULL,NULL,NULL),(18,'2012-11-06 21:00:42','iblock','10',0,NULL,NULL,NULL,'=ID=10&EXTERNAL_ID=10&IBLOCK_SECTION_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=3&IBLOCK_CODE=content_shares&IBLOCK_EXTERNAL_ID=&CODE=','Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%','Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','','content','3',NULL,NULL,NULL),(19,'2012-11-06 21:00:48','iblock','11',0,NULL,NULL,NULL,'=ID=11&EXTERNAL_ID=11&IBLOCK_SECTION_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=3&IBLOCK_CODE=content_shares&IBLOCK_EXTERNAL_ID=&CODE=','Счастливый час. Только с 17:00 до 18:00 по пятницам — страховка со скидкой 20%','Хотите получить страховку по спец цене?\r\nНа заседании Госдумы, в понедельник, 2 ноября, большинство депутатов выразило идеи обеспечения страховых компаний бланками полисов ОСАГО и «Зеленой карты» в зависимости от дисциплинированности и платежеспособности компаний','','content','3',NULL,NULL,NULL),(20,'2012-11-06 21:28:58','main','s1|/partners/index.php',0,NULL,NULL,NULL,'/partners/index.php','Партнеры','','','','',NULL,NULL,NULL),(21,'2012-11-06 21:57:12','main','s1|/corporate-clients/index.php',0,NULL,NULL,NULL,'/corporate-clients/index.php','Корпоративным клиентам','','','','',NULL,NULL,NULL),(22,'2012-11-07 16:27:54','main','s1|/index.php',0,NULL,NULL,NULL,'/index.php','Главная','','','','',NULL,NULL,NULL),(23,'2012-11-07 16:46:09','iblock','S4',0,NULL,NULL,NULL,'=ID=4&EXTERNAL_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=','Главная растяжка','',NULL,'content','6',NULL,NULL,NULL),(24,'2012-11-07 16:47:14','iblock','S5',0,NULL,NULL,NULL,'=ID=5&EXTERNAL_ID=&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=','Фичи','Баннерные блоки с жёлтой полосой внизу (по 3 штуки на экране)',NULL,'content','6',NULL,NULL,NULL),(27,'2012-11-07 17:27:07','iblock','20',0,NULL,NULL,NULL,'=ID=20&EXTERNAL_ID=20&IBLOCK_SECTION_ID=4&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=http://rap.ru','с 10 по 20 мая','ВСЕМ ДЕВУШКАМ КАСКО ДЕШЕВЛЕ НА \r15 %','','content','6',NULL,NULL,NULL),(26,'2012-11-07 17:26:36','iblock','21',0,NULL,NULL,NULL,'=ID=21&EXTERNAL_ID=21&IBLOCK_SECTION_ID=4&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=http://ya.ru','с 12 по 18 мая','КУПИ \r5\rЧЕБУРЕКОВ, СОБЕРИ КОШКУ','','content','6',NULL,NULL,NULL),(28,'2012-11-07 17:51:14','iblock','22',0,NULL,NULL,NULL,'=ID=22&EXTERNAL_ID=22&IBLOCK_SECTION_ID=5&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=','Больше привелегий','Карта\rклуба\r«Москва»','','content','6',NULL,NULL,NULL),(29,'2012-11-07 17:39:56','iblock','23',0,NULL,NULL,NULL,'=ID=23&EXTERNAL_ID=23&IBLOCK_SECTION_ID=5&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=','Cчастливый час','Только час\r\n— страховка\r\nсо скидкой\r\n20%','','content','6',NULL,NULL,NULL),(30,'2012-11-07 17:40:41','iblock','24',0,NULL,NULL,NULL,'=ID=24&EXTERNAL_ID=24&IBLOCK_SECTION_ID=5&IBLOCK_TYPE_ID=content&IBLOCK_ID=6&IBLOCK_CODE=content_banners&IBLOCK_EXTERNAL_ID=&CODE=','+ 7 800 2000 600','Служба\r\nподдержки\r\n24 часа','','content','6',NULL,NULL,NULL);
/*!40000 ALTER TABLE `b_search_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_freq`
--

DROP TABLE IF EXISTS `b_search_content_freq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_freq` (
  `STEM` int(11) NOT NULL DEFAULT '0',
  `LANGUAGE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FREQ` float DEFAULT NULL,
  `TF` float DEFAULT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_FREQ` (`STEM`,`LANGUAGE_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_freq`
--

LOCK TABLES `b_search_content_freq` WRITE;
/*!40000 ALTER TABLE `b_search_content_freq` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_content_freq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_param`
--

DROP TABLE IF EXISTS `b_search_content_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_param` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `PARAM_NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `PARAM_VALUE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  KEY `IX_B_SEARCH_CONTENT_PARAM` (`SEARCH_CONTENT_ID`,`PARAM_NAME`),
  KEY `IX_B_SEARCH_CONTENT_PARAM_1` (`PARAM_NAME`,`PARAM_VALUE`(50),`SEARCH_CONTENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_param`
--

LOCK TABLES `b_search_content_param` WRITE;
/*!40000 ALTER TABLE `b_search_content_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_content_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_right`
--

DROP TABLE IF EXISTS `b_search_content_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_right` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `GROUP_CODE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_RIGHT` (`SEARCH_CONTENT_ID`,`GROUP_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_right`
--

LOCK TABLES `b_search_content_right` WRITE;
/*!40000 ALTER TABLE `b_search_content_right` DISABLE KEYS */;
INSERT INTO `b_search_content_right` VALUES (1,'G2'),(2,'G1'),(2,'G2'),(3,'G1'),(3,'G2'),(4,'G1'),(4,'G2'),(5,'G1'),(5,'G2'),(6,'G1'),(6,'G2'),(7,'G1'),(7,'G2'),(8,'G1'),(8,'G2'),(9,'G1'),(9,'G2'),(10,'G1'),(10,'G2'),(11,'G2'),(12,'G1'),(12,'G2'),(13,'G1'),(13,'G2'),(14,'G2'),(15,'G2'),(16,'G2'),(17,'G1'),(17,'G2'),(18,'G1'),(18,'G2'),(19,'G1'),(19,'G2'),(20,'G2'),(21,'G2'),(22,'G2'),(23,'G1'),(23,'G2'),(24,'G1'),(24,'G2'),(26,'G1'),(26,'G2'),(27,'G1'),(27,'G2'),(28,'G1'),(28,'G2'),(29,'G1'),(29,'G2'),(30,'G1'),(30,'G2');
/*!40000 ALTER TABLE `b_search_content_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_site`
--

DROP TABLE IF EXISTS `b_search_content_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_site` (
  `SEARCH_CONTENT_ID` int(18) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `URL` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`SEARCH_CONTENT_ID`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_site`
--

LOCK TABLES `b_search_content_site` WRITE;
/*!40000 ALTER TABLE `b_search_content_site` DISABLE KEYS */;
INSERT INTO `b_search_content_site` VALUES (1,'s1',''),(2,'s1',''),(3,'s1',''),(4,'s1',''),(5,'s1',''),(6,'s1',''),(7,'s1',''),(8,'s1',''),(9,'s1',''),(10,'s1',''),(11,'s1',''),(12,'s1',''),(13,'s1',''),(14,'s1',''),(15,'s1',''),(16,'s1',''),(17,'s1',''),(18,'s1',''),(19,'s1',''),(20,'s1',''),(21,'s1',''),(22,'s1',''),(23,'s1',''),(24,'s1',''),(27,'s1',''),(26,'s1',''),(28,'s1',''),(29,'s1',''),(30,'s1','');
/*!40000 ALTER TABLE `b_search_content_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_stem`
--

DROP TABLE IF EXISTS `b_search_content_stem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_stem` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `LANGUAGE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `STEM` int(11) NOT NULL,
  `TF` float NOT NULL,
  `PS` float NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_STEM` (`STEM`,`LANGUAGE_ID`,`TF`,`PS`,`SEARCH_CONTENT_ID`),
  KEY `IND_B_SEARCH_CONTENT_STEM` (`SEARCH_CONTENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci DELAY_KEY_WRITE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_stem`
--

LOCK TABLES `b_search_content_stem` WRITE;
/*!40000 ALTER TABLE `b_search_content_stem` DISABLE KEYS */;
INSERT INTO `b_search_content_stem` VALUES (14,'ru',1,0.2314,1),(15,'ru',1,0.2314,1),(15,'ru',2,0.2314,2),(15,'ru',3,0.2314,3),(1,'ru',4,0.2314,1),(8,'ru',4,0.2314,1),(9,'ru',4,0.2314,2),(10,'ru',4,0.2314,3),(2,'ru',5,0.125,1),(2,'ru',6,0.125,2),(3,'ru',7,0.1316,127),(2,'ru',7,0.1981,89.5),(3,'ru',8,0.1316,242),(2,'ru',8,0.1981,143.5),(2,'ru',9,0.125,7),(6,'ru',9,0.1291,330),(7,'ru',9,0.1302,228),(3,'ru',9,0.1316,9),(5,'ru',9,0.2217,88.5),(2,'ru',10,0.125,8),(6,'ru',10,0.1291,331),(7,'ru',10,0.1302,229),(3,'ru',10,0.1316,10),(5,'ru',10,0.2217,89.5),(2,'ru',11,0.125,10),(6,'ru',11,0.1291,333),(7,'ru',11,0.1302,231),(3,'ru',11,0.1316,12),(5,'ru',11,0.2217,91.5),(2,'ru',12,0.125,11),(6,'ru',12,0.1291,334),(7,'ru',12,0.1302,232),(3,'ru',12,0.1316,13),(5,'ru',12,0.2217,92.5),(2,'ru',13,0.125,12),(6,'ru',13,0.1291,207),(4,'ru',13,0.1316,138),(4,'ru',14,0.1316,334),(2,'ru',14,0.1981,175),(3,'ru',14,0.2086,254.5),(2,'ru',15,0.125,14),(7,'ru',15,0.1302,312),(3,'ru',15,0.1316,65),(4,'ru',15,0.1316,335),(6,'ru',16,0.1291,13),(7,'ru',16,0.2064,170),(2,'ru',16,0.25,170.667),(11,'ru',17,0.1286,189),(3,'ru',17,0.1316,107),(2,'ru',17,0.1981,28),(3,'ru',18,0.1316,108),(2,'ru',18,0.1981,29),(3,'ru',19,0.1316,110),(2,'ru',19,0.1981,31),(3,'ru',20,0.1316,112),(2,'ru',20,0.1981,33),(3,'ru',21,0.1316,113),(2,'ru',21,0.1981,34),(11,'ru',21,0.2039,205),(3,'ru',22,0.1316,114),(2,'ru',22,0.1981,35),(3,'ru',23,0.1316,115),(2,'ru',23,0.1981,36),(3,'ru',24,0.1316,117),(2,'ru',24,0.1981,38),(3,'ru',25,0.1316,119),(2,'ru',25,0.1981,40),(3,'ru',26,0.1316,120),(5,'ru',26,0.1399,152),(2,'ru',26,0.1981,41),(3,'ru',27,0.1316,121),(2,'ru',27,0.1981,42),(2,'ru',28,0.125,36),(4,'ru',28,0.1316,78),(6,'ru',29,0.1291,89),(3,'ru',29,0.1316,30),(7,'ru',29,0.2064,208.5),(4,'ru',29,0.2632,200),(2,'ru',29,0.2902,171.25),(2,'ru',30,0.125,38),(7,'ru',30,0.1302,16),(4,'ru',30,0.1316,287),(2,'ru',31,0.125,39),(3,'ru',31,0.1316,210),(4,'ru',31,0.1316,288),(2,'ru',32,0.125,60),(7,'ru',32,0.1302,259),(5,'ru',32,0.1399,214),(2,'ru',33,0.125,62),(2,'ru',34,0.125,63),(7,'ru',34,0.1302,51),(3,'ru',34,0.1316,142),(5,'ru',34,0.1399,223),(7,'ru',35,0.2064,103),(4,'ru',35,0.2086,137.5),(3,'ru',35,0.2086,155.5),(2,'ru',35,0.2902,297.75),(7,'ru',36,0.1302,14),(3,'ru',36,0.1316,310),(2,'ru',36,0.1981,234.5),(2,'ru',37,0.125,69),(6,'ru',37,0.1291,19),(2,'ru',38,0.125,70),(6,'ru',38,0.1291,20),(2,'ru',39,0.125,72),(6,'ru',39,0.1291,22),(2,'ru',40,0.125,73),(6,'ru',40,0.1291,23),(2,'ru',41,0.125,73),(6,'ru',41,0.1291,23),(7,'ru',41,0.1302,123),(2,'ru',42,0.1981,85),(6,'ru',42,0.2046,35),(2,'ru',43,0.1981,87),(6,'ru',43,0.2046,37),(2,'ru',44,0.125,78),(6,'ru',44,0.1291,28),(2,'ru',45,0.125,81),(6,'ru',45,0.1291,31),(12,'ru',45,0.1409,31),(13,'ru',45,0.1411,30),(2,'ru',46,0.125,82),(6,'ru',46,0.1291,32),(2,'ru',47,0.125,83),(6,'ru',47,0.1291,33),(2,'ru',48,0.125,85),(6,'ru',48,0.1291,35),(7,'ru',49,0.1302,83),(3,'ru',49,0.1316,5),(5,'ru',49,0.1399,225),(2,'ru',49,0.1981,100.5),(6,'ru',49,0.2046,178),(4,'ru',49,0.2086,102.5),(28,'ru',49,0.2314,1),(2,'ru',50,0.125,88),(6,'ru',50,0.1291,38),(2,'ru',51,0.125,90),(6,'ru',51,0.1291,40),(2,'ru',52,0.125,91),(7,'ru',52,0.1302,276),(5,'ru',52,0.1399,95),(12,'ru',52,0.1409,98),(13,'ru',52,0.1411,97),(6,'ru',52,0.2046,106.5),(3,'ru',52,0.2632,189),(2,'ru',53,0.125,92),(6,'ru',53,0.1291,42),(2,'ru',54,0.125,93),(6,'ru',54,0.1291,43),(7,'ru',54,0.1302,125),(5,'ru',54,0.1399,124),(3,'ru',54,0.2632,127.667),(6,'ru',55,0.1291,44),(5,'ru',55,0.1399,189),(2,'ru',55,0.1981,144),(4,'ru',55,0.2086,81),(11,'ru',56,0.1286,251),(6,'ru',56,0.1291,48),(2,'ru',56,0.1981,243.5),(2,'ru',57,0.125,100),(6,'ru',57,0.1291,50),(2,'ru',58,0.125,101),(6,'ru',58,0.1291,51),(2,'ru',59,0.125,102),(6,'ru',59,0.1291,52),(2,'ru',60,0.125,104),(6,'ru',60,0.1291,54),(2,'ru',61,0.125,105),(6,'ru',61,0.1291,55),(2,'ru',62,0.125,111),(6,'ru',62,0.1291,274),(4,'ru',62,0.1316,312),(5,'ru',63,0.1399,185),(2,'ru',63,0.1981,131.5),(6,'ru',63,0.2046,196.5),(4,'ru',63,0.2632,198),(6,'ru',64,0.1291,303),(7,'ru',64,0.1302,120),(2,'ru',64,0.1981,188.5),(4,'ru',64,0.2086,55.5),(2,'ru',65,0.125,115),(7,'ru',65,0.1302,84),(5,'ru',65,0.1399,226),(2,'ru',66,0.125,116),(3,'ru',66,0.1316,62),(7,'ru',66,0.2064,82),(5,'ru',66,0.2217,123),(2,'ru',67,0.125,117),(3,'ru',67,0.1316,63),(12,'ru',67,0.1409,17),(13,'ru',67,0.1411,16),(7,'ru',67,0.2064,83),(5,'ru',67,0.2217,124),(2,'ru',68,0.125,121),(6,'ru',68,0.1291,241),(7,'ru',68,0.1302,317),(4,'ru',68,0.2632,310),(2,'ru',69,0.125,122),(6,'ru',69,0.1291,242),(7,'ru',69,0.1302,318),(4,'ru',69,0.2632,311),(2,'ru',70,0.125,123),(6,'ru',70,0.1291,243),(7,'ru',70,0.1302,319),(4,'ru',70,0.2632,312),(2,'ru',71,0.125,124),(6,'ru',71,0.1291,244),(7,'ru',71,0.1302,320),(4,'ru',71,0.2632,313),(2,'ru',72,0.125,125),(6,'ru',72,0.1291,245),(7,'ru',72,0.1302,321),(4,'ru',72,0.2632,314),(2,'ru',73,0.125,126),(6,'ru',73,0.1291,246),(7,'ru',73,0.1302,322),(4,'ru',73,0.2632,315),(2,'ru',74,0.125,132),(2,'ru',75,0.125,133),(6,'ru',75,0.1291,314),(4,'ru',75,0.2086,97.5),(2,'ru',76,0.125,135),(7,'ru',76,0.1302,52),(4,'ru',76,0.1316,315),(2,'ru',77,0.125,136),(6,'ru',77,0.1291,148),(5,'ru',77,0.1399,58),(7,'ru',77,0.2064,156.5),(2,'ru',78,0.125,138),(7,'ru',78,0.1302,297),(5,'ru',78,0.1399,41),(3,'ru',78,0.2086,285.5),(2,'ru',79,0.125,140),(7,'ru',79,0.1302,299),(3,'ru',79,0.2086,287.5),(2,'ru',80,0.125,141),(7,'ru',80,0.1302,300),(3,'ru',80,0.2086,288.5),(2,'ru',81,0.125,142),(7,'ru',81,0.1302,301),(3,'ru',81,0.2086,289.5),(2,'ru',82,0.125,143),(7,'ru',82,0.1302,302),(3,'ru',82,0.2086,290.5),(2,'ru',83,0.125,144),(7,'ru',83,0.1302,303),(3,'ru',83,0.2086,291.5),(2,'ru',84,0.125,150),(4,'ru',84,0.1316,182),(6,'ru',84,0.2046,221.5),(2,'ru',85,0.125,152),(6,'ru',85,0.1291,119),(3,'ru',85,0.1316,243),(2,'ru',86,0.125,153),(6,'ru',86,0.1291,120),(3,'ru',86,0.1316,244),(2,'ru',87,0.125,154),(6,'ru',87,0.1291,121),(3,'ru',87,0.1316,245),(2,'ru',88,0.125,155),(6,'ru',88,0.1291,122),(3,'ru',88,0.1316,246),(2,'ru',89,0.125,156),(6,'ru',89,0.1291,123),(3,'ru',89,0.1316,247),(2,'ru',90,0.125,158),(7,'ru',91,0.1302,12),(4,'ru',91,0.2086,165),(2,'ru',91,0.2902,305.75),(4,'ru',92,0.1316,248),(2,'ru',92,0.1981,251.5),(2,'ru',93,0.1981,253.5),(6,'ru',93,0.2046,86),(7,'ru',93,0.2064,269.5),(3,'ru',93,0.2086,27),(5,'ru',93,0.2217,166),(4,'ru',93,0.3055,145),(4,'ru',94,0.1316,251),(2,'ru',94,0.1981,254.5),(4,'ru',95,0.1316,252),(2,'ru',95,0.1981,255.5),(4,'ru',96,0.1316,254),(2,'ru',96,0.1981,257.5),(4,'ru',97,0.1316,255),(2,'ru',97,0.1981,258.5),(3,'ru',98,0.1316,64),(4,'ru',98,0.1316,263),(5,'ru',98,0.1399,24),(2,'ru',98,0.1981,230),(2,'ru',99,0.125,177),(6,'ru',99,0.1291,304),(7,'ru',99,0.1302,295),(2,'ru',100,0.125,178),(6,'ru',100,0.1291,263),(7,'ru',100,0.1302,36),(4,'ru',100,0.1316,67),(2,'ru',101,0.125,180),(11,'ru',101,0.1286,197),(6,'ru',101,0.1291,265),(7,'ru',101,0.1302,38),(4,'ru',101,0.1316,69),(2,'ru',102,0.125,183),(6,'ru',102,0.1291,268),(7,'ru',102,0.1302,41),(4,'ru',102,0.1316,72),(2,'ru',103,0.125,189),(7,'ru',103,0.1302,190),(5,'ru',103,0.1399,146),(4,'ru',103,0.2632,96.3333),(2,'ru',104,0.125,190),(7,'ru',104,0.1302,191),(5,'ru',104,0.1399,147),(4,'ru',104,0.2632,97.3333),(11,'ru',104,0.3859,144.429),(2,'ru',105,0.125,191),(4,'ru',105,0.1316,58),(2,'ru',106,0.125,192),(4,'ru',106,0.1316,59),(2,'ru',107,0.125,195),(7,'ru',107,0.1302,258),(4,'ru',107,0.1316,62),(6,'ru',107,0.2581,52.6667),(3,'ru',107,0.2632,165.667),(2,'ru',108,0.125,196),(2,'ru',109,0.125,197),(6,'ru',109,0.1291,255),(2,'ru',110,0.125,198),(7,'ru',111,0.1302,260),(3,'ru',111,0.1316,255),(2,'ru',111,0.1981,277.5),(2,'ru',112,0.125,200),(7,'ru',112,0.1302,15),(5,'ru',112,0.1399,192),(6,'ru',112,0.2046,56.5),(2,'ru',113,0.125,201),(5,'ru',113,0.1399,176),(7,'ru',113,0.2064,144),(2,'ru',114,0.125,204),(7,'ru',114,0.1302,57),(2,'ru',115,0.125,205),(7,'ru',115,0.1302,58),(2,'ru',116,0.125,208),(7,'ru',116,0.1302,61),(27,'ru',116,0.2314,2),(2,'ru',117,0.125,210),(7,'ru',117,0.1302,63),(2,'ru',118,0.125,211),(7,'ru',118,0.1302,64),(2,'ru',119,0.125,212),(7,'ru',119,0.1302,65),(2,'ru',120,0.125,213),(7,'ru',120,0.1302,66),(2,'ru',121,0.125,215),(7,'ru',121,0.1302,68),(2,'ru',122,0.125,216),(7,'ru',122,0.1302,69),(2,'ru',123,0.125,217),(7,'ru',123,0.1302,70),(2,'ru',124,0.125,218),(7,'ru',124,0.1302,71),(2,'ru',125,0.125,219),(7,'ru',125,0.1302,72),(2,'ru',126,0.125,220),(7,'ru',126,0.1302,73),(2,'ru',127,0.125,226),(5,'ru',127,0.1399,116),(2,'ru',128,0.125,227),(5,'ru',128,0.1399,117),(2,'ru',129,0.125,228),(7,'ru',129,0.1302,32),(6,'ru',129,0.2046,127),(5,'ru',130,0.1399,174),(2,'ru',130,0.1981,315),(2,'ru',131,0.1981,294),(2,'ru',132,0.125,231),(7,'ru',132,0.1302,213),(2,'ru',133,0.125,233),(2,'ru',134,0.125,234),(2,'ru',135,0.125,235),(2,'ru',136,0.125,237),(3,'ru',136,0.1316,84),(4,'ru',136,0.1316,306),(5,'ru',136,0.1399,246),(2,'ru',137,0.125,238),(7,'ru',138,0.1302,166),(2,'ru',138,0.1981,287),(4,'ru',138,0.2086,239.5),(2,'ru',139,0.125,240),(2,'ru',140,0.125,241),(2,'ru',141,0.1981,249.5),(2,'ru',142,0.125,249),(2,'ru',143,0.125,252),(2,'ru',144,0.125,262),(5,'ru',144,0.1399,201),(2,'ru',145,0.125,263),(6,'ru',145,0.1291,299),(2,'ru',146,0.125,265),(4,'ru',146,0.1316,80),(2,'ru',147,0.125,266),(4,'ru',147,0.1316,81),(2,'ru',148,0.125,269),(6,'ru',148,0.1291,104),(7,'ru',148,0.1302,355),(2,'ru',149,0.125,271),(6,'ru',149,0.1291,106),(7,'ru',149,0.1302,357),(2,'ru',150,0.125,272),(7,'ru',150,0.1302,358),(4,'ru',150,0.1316,333),(11,'ru',150,0.2039,216),(6,'ru',150,0.2046,152.5),(2,'ru',151,0.125,274),(7,'ru',151,0.2604,314.333),(3,'ru',151,0.2632,159.333),(6,'ru',151,0.2997,189),(2,'ru',152,0.125,275),(6,'ru',152,0.1291,110),(7,'ru',152,0.1302,361),(2,'ru',153,0.125,283),(2,'ru',154,0.125,285),(7,'ru',154,0.1302,1),(4,'ru',154,0.1316,264),(5,'ru',154,0.1399,46),(2,'ru',155,0.125,286),(6,'ru',155,0.1291,262),(5,'ru',155,0.1399,2),(7,'ru',155,0.2064,148.5),(2,'ru',156,0.125,288),(3,'ru',156,0.1316,51),(7,'ru',156,0.2064,96),(4,'ru',156,0.2086,213.5),(6,'ru',157,0.1291,229),(5,'ru',157,0.1399,232),(2,'ru',157,0.1981,297.5),(7,'ru',157,0.2064,97),(3,'ru',157,0.2632,133.333),(4,'ru',157,0.2632,240.333),(2,'ru',158,0.125,292),(3,'ru',158,0.1316,55),(7,'ru',158,0.2064,100),(4,'ru',158,0.2086,217.5),(2,'ru',159,0.125,293),(3,'ru',159,0.1316,56),(5,'ru',159,0.1399,71),(7,'ru',159,0.2064,101),(4,'ru',159,0.2086,218.5),(2,'ru',160,0.125,299),(6,'ru',160,0.1291,336),(7,'ru',160,0.1302,17),(2,'ru',161,0.125,300),(6,'ru',161,0.1291,337),(7,'ru',161,0.1302,18),(2,'ru',162,0.125,303),(6,'ru',162,0.1291,226),(3,'ru',162,0.1316,275),(2,'ru',163,0.125,304),(6,'ru',163,0.1291,227),(3,'ru',163,0.1316,276),(2,'ru',164,0.125,307),(6,'ru',164,0.1291,230),(7,'ru',164,0.1302,285),(3,'ru',164,0.2632,203.667),(2,'ru',165,0.125,310),(6,'ru',165,0.1291,233),(3,'ru',165,0.1316,282),(2,'ru',166,0.125,311),(6,'ru',166,0.1291,234),(3,'ru',166,0.1316,283),(2,'ru',167,0.125,312),(6,'ru',167,0.1291,73),(4,'ru',167,0.2086,130.5),(2,'ru',168,0.125,313),(6,'ru',168,0.1291,100),(4,'ru',168,0.1316,316),(2,'ru',169,0.125,314),(6,'ru',169,0.1291,101),(4,'ru',169,0.1316,317),(4,'ru',170,0.1316,85),(2,'ru',170,0.1981,363),(4,'ru',171,0.1316,86),(2,'ru',171,0.1981,364),(4,'ru',172,0.1316,87),(2,'ru',172,0.1981,365),(7,'ru',173,0.1302,10),(4,'ru',173,0.1316,88),(2,'ru',173,0.1981,366),(4,'ru',174,0.1316,90),(2,'ru',174,0.1981,368),(4,'ru',175,0.1316,91),(2,'ru',175,0.1981,369),(4,'ru',176,0.1316,92),(2,'ru',176,0.1981,370),(2,'ru',177,0.125,331),(3,'ru',177,0.1316,271),(2,'ru',178,0.125,332),(3,'ru',178,0.1316,272),(2,'ru',179,0.125,336),(6,'ru',179,0.1291,287),(7,'ru',179,0.1302,167),(4,'ru',179,0.2086,240.5),(2,'ru',180,0.125,354),(6,'ru',180,0.1291,309),(4,'ru',180,0.2086,92.5),(2,'ru',181,0.125,355),(6,'ru',181,0.1291,310),(4,'ru',181,0.2086,93.5),(2,'ru',182,0.125,359),(7,'ru',182,0.1302,239),(5,'ru',182,0.1399,69),(2,'ru',183,0.125,362),(6,'ru',183,0.1291,212),(7,'ru',183,0.1302,339),(3,'ru',183,0.1316,213),(2,'ru',184,0.125,363),(6,'ru',184,0.1291,213),(7,'ru',184,0.1302,340),(3,'ru',184,0.1316,214),(4,'ru',184,0.1316,336),(5,'ru',184,0.1399,93),(2,'ru',185,0.125,365),(6,'ru',185,0.1291,215),(7,'ru',185,0.1302,342),(3,'ru',185,0.1316,216),(2,'ru',186,0.125,366),(6,'ru',186,0.1291,216),(7,'ru',186,0.1302,343),(3,'ru',186,0.1316,217),(2,'ru',187,0.125,367),(6,'ru',187,0.1291,217),(7,'ru',187,0.1302,344),(4,'ru',187,0.1316,102),(3,'ru',187,0.1316,218),(2,'ru',188,0.125,373),(2,'ru',189,0.125,374),(2,'ru',190,0.125,375),(6,'ru',190,0.1291,300),(2,'ru',191,0.125,376),(6,'ru',191,0.1291,301),(2,'ru',192,0.125,377),(6,'ru',192,0.1291,302),(2,'ru',193,0.125,378),(3,'ru',193,0.1316,105),(2,'ru',194,0.125,379),(2,'ru',195,0.125,380),(2,'ru',196,0.125,382),(2,'ru',197,0.125,384),(2,'ru',198,0.125,385),(2,'ru',199,0.125,386),(7,'ru',199,0.1302,194),(3,'ru',199,0.1316,3),(4,'ru',199,0.1316,192),(2,'ru',200,0.125,387),(2,'ru',201,0.125,388),(2,'ru',202,0.125,391),(2,'ru',203,0.125,392),(2,'ru',204,0.125,393),(2,'ru',205,0.125,399),(3,'ru',205,0.1316,306),(4,'ru',205,0.2086,124),(2,'ru',206,0.125,400),(2,'ru',207,0.125,402),(5,'ru',207,0.1399,151),(7,'ru',208,0.1302,192),(3,'ru',208,0.1316,1),(4,'ru',208,0.1316,190),(6,'ru',209,0.1291,320),(3,'ru',209,0.1316,6),(4,'ru',209,0.2086,103.5),(6,'ru',210,0.1291,189),(3,'ru',210,0.3055,135.5),(3,'ru',211,0.1316,14),(6,'ru',211,0.2997,229.5),(3,'ru',212,0.1316,15),(5,'ru',212,0.1399,42),(6,'ru',212,0.2581,162.333),(4,'ru',212,0.2632,208),(7,'ru',213,0.1302,257),(5,'ru',213,0.1399,43),(3,'ru',213,0.2086,160),(4,'ru',213,0.2632,209),(6,'ru',213,0.2997,125.25),(6,'ru',214,0.1291,77),(3,'ru',214,0.1316,18),(17,'ru',214,0.192,39),(18,'ru',214,0.192,39),(19,'ru',214,0.192,39),(6,'ru',215,0.1291,78),(3,'ru',215,0.1316,19),(6,'ru',216,0.1291,78),(3,'ru',216,0.1316,19),(6,'ru',217,0.1291,79),(3,'ru',217,0.1316,20),(6,'ru',218,0.1291,80),(3,'ru',218,0.1316,21),(6,'ru',219,0.1291,84),(3,'ru',219,0.1316,25),(6,'ru',220,0.1291,86),(3,'ru',220,0.1316,27),(3,'ru',221,0.2086,115),(3,'ru',222,0.2086,132.5),(3,'ru',223,0.1316,46),(6,'ru',224,0.1291,157),(3,'ru',224,0.2086,151.5),(5,'ru',224,0.2217,120.5),(3,'ru',225,0.1316,48),(5,'ru',225,0.1399,25),(6,'ru',225,0.2581,77.6667),(7,'ru',226,0.1302,241),(3,'ru',226,0.1316,49),(3,'ru',227,0.1316,66),(6,'ru',227,0.2046,119),(3,'ru',228,0.1316,69),(4,'ru',228,0.1316,291),(5,'ru',228,0.1399,231),(3,'ru',229,0.1316,72),(4,'ru',229,0.1316,294),(5,'ru',229,0.1399,234),(3,'ru',230,0.1316,73),(4,'ru',230,0.1316,295),(5,'ru',230,0.1399,235),(3,'ru',231,0.1316,74),(4,'ru',231,0.1316,296),(5,'ru',231,0.1399,236),(3,'ru',232,0.1316,76),(4,'ru',232,0.1316,298),(5,'ru',232,0.1399,238),(12,'ru',232,0.2233,73.5),(13,'ru',232,0.2236,72.5),(3,'ru',233,0.1316,83),(4,'ru',233,0.1316,305),(5,'ru',233,0.1399,245),(3,'ru',234,0.1316,92),(3,'ru',235,0.1316,93),(3,'ru',236,0.1316,94),(3,'ru',237,0.1316,95),(3,'ru',238,0.1316,96),(3,'ru',239,0.1316,97),(3,'ru',240,0.1316,101),(3,'ru',241,0.2086,139),(3,'ru',242,0.2086,205.5),(3,'ru',243,0.1316,128),(3,'ru',244,0.1316,130),(3,'ru',245,0.1316,131),(3,'ru',246,0.1316,133),(7,'ru',247,0.1302,162),(3,'ru',247,0.1316,139),(4,'ru',247,0.1316,163),(5,'ru',247,0.1399,88),(7,'ru',248,0.1302,163),(3,'ru',248,0.1316,140),(4,'ru',248,0.1316,164),(6,'ru',249,0.1291,133),(3,'ru',249,0.1316,141),(3,'ru',250,0.1316,143),(5,'ru',250,0.1399,1),(7,'ru',250,0.2064,115),(3,'ru',251,0.1316,146),(5,'ru',251,0.1399,119),(3,'ru',252,0.1316,147),(5,'ru',252,0.1399,120),(7,'ru',253,0.1302,188),(3,'ru',253,0.1316,149),(4,'ru',253,0.2086,114.5),(5,'ru',253,0.2217,133),(3,'ru',254,0.1316,152),(5,'ru',254,0.1399,125),(3,'ru',255,0.1316,153),(5,'ru',255,0.1399,126),(11,'ru',256,0.1286,230),(3,'ru',256,0.1316,154),(5,'ru',256,0.1399,127),(3,'ru',257,0.1316,156),(5,'ru',257,0.1399,129),(3,'ru',258,0.1316,158),(5,'ru',258,0.1399,131),(3,'ru',259,0.1316,159),(5,'ru',259,0.1399,132),(3,'ru',260,0.1316,160),(5,'ru',260,0.1399,133),(6,'ru',261,0.1291,61),(7,'ru',261,0.1302,113),(3,'ru',261,0.1316,166),(5,'ru',261,0.1399,210),(6,'ru',262,0.1291,62),(7,'ru',262,0.1302,114),(4,'ru',262,0.1316,4),(3,'ru',262,0.1316,167),(5,'ru',262,0.1399,211),(6,'ru',263,0.1291,63),(3,'ru',263,0.1316,168),(6,'ru',264,0.1291,64),(3,'ru',264,0.1316,169),(6,'ru',265,0.1291,65),(3,'ru',265,0.1316,170),(6,'ru',266,0.1291,66),(3,'ru',266,0.1316,171),(6,'ru',267,0.1291,67),(3,'ru',267,0.1316,172),(6,'ru',268,0.1291,69),(3,'ru',268,0.1316,174),(3,'ru',269,0.1316,178),(3,'ru',270,0.1316,184),(3,'ru',271,0.1316,186),(5,'ru',271,0.1399,167),(4,'ru',272,0.1316,139),(3,'ru',272,0.1316,187),(6,'ru',272,0.2046,221.5),(7,'ru',272,0.2604,270.333),(7,'ru',273,0.1302,262),(5,'ru',273,0.1399,92),(6,'ru',273,0.2046,68.5),(4,'ru',273,0.2086,33.5),(3,'ru',273,0.2086,188.5),(4,'ru',274,0.1316,66),(3,'ru',274,0.1316,190),(6,'ru',274,0.2046,69.5),(3,'ru',275,0.1316,195),(3,'ru',276,0.1316,196),(3,'ru',277,0.1316,197),(3,'ru',278,0.1316,198),(3,'ru',279,0.1316,204),(6,'ru',279,0.2581,187.667),(3,'ru',280,0.1316,205),(6,'ru',280,0.2046,207.5),(6,'ru',281,0.1291,174),(4,'ru',281,0.1316,166),(3,'ru',281,0.1316,207),(5,'ru',281,0.1399,22),(7,'ru',281,0.2064,191),(6,'ru',282,0.1291,175),(7,'ru',282,0.1302,50),(3,'ru',282,0.1316,208),(5,'ru',282,0.1399,23),(7,'ru',283,0.1302,212),(3,'ru',283,0.1316,209),(3,'ru',284,0.1316,224),(3,'ru',285,0.1316,227),(7,'ru',286,0.1302,280),(3,'ru',286,0.1316,229),(7,'ru',287,0.1302,281),(3,'ru',287,0.1316,230),(3,'ru',288,0.1316,231),(5,'ru',288,0.1399,160),(7,'ru',288,0.2064,187.5),(7,'ru',289,0.1302,284),(3,'ru',289,0.1316,233),(7,'ru',290,0.1302,286),(3,'ru',290,0.1316,235),(7,'ru',291,0.1302,287),(3,'ru',291,0.1316,236),(4,'ru',292,0.1316,184),(3,'ru',292,0.1316,248),(5,'ru',292,0.1399,73),(7,'ru',293,0.1302,352),(3,'ru',293,0.1316,254),(3,'ru',294,0.1316,257),(4,'ru',294,0.1316,265),(3,'ru',295,0.1316,288),(5,'ru',295,0.1399,96),(3,'ru',296,0.1316,289),(5,'ru',296,0.1399,97),(3,'ru',297,0.1316,290),(5,'ru',297,0.1399,98),(3,'ru',298,0.1316,292),(5,'ru',298,0.1399,100),(3,'ru',299,0.1316,293),(5,'ru',299,0.1399,101),(3,'ru',300,0.1316,293),(5,'ru',300,0.1399,101),(3,'ru',301,0.1316,294),(5,'ru',301,0.2217,143),(6,'ru',302,0.1291,7),(7,'ru',302,0.1302,253),(3,'ru',302,0.1316,300),(7,'ru',303,0.1302,255),(3,'ru',303,0.1316,302),(6,'ru',303,0.2046,79),(6,'ru',304,0.1291,10),(7,'ru',304,0.1302,256),(3,'ru',304,0.1316,303),(4,'ru',305,0.1316,286),(3,'ru',305,0.1316,308),(7,'ru',305,0.2604,163),(4,'ru',306,0.1316,6),(6,'ru',307,0.1291,253),(7,'ru',307,0.1302,184),(5,'ru',307,0.1399,140),(4,'ru',307,0.2086,110.5),(7,'ru',308,0.1302,186),(5,'ru',308,0.1399,142),(4,'ru',308,0.2086,112.5),(6,'ru',309,0.1291,147),(7,'ru',309,0.1302,187),(5,'ru',309,0.1399,143),(4,'ru',309,0.2086,113.5),(7,'ru',310,0.1302,210),(4,'ru',310,0.1316,16),(4,'ru',311,0.1316,18),(11,'ru',312,0.1286,76),(6,'ru',312,0.1291,162),(7,'ru',312,0.1302,215),(4,'ru',312,0.1316,20),(6,'ru',313,0.1291,163),(7,'ru',313,0.1302,216),(4,'ru',313,0.1316,21),(6,'ru',314,0.1291,165),(7,'ru',314,0.1302,218),(4,'ru',314,0.1316,23),(6,'ru',315,0.1291,204),(7,'ru',315,0.1302,224),(4,'ru',315,0.1316,29),(6,'ru',316,0.1291,205),(7,'ru',316,0.1302,225),(4,'ru',316,0.1316,30),(6,'ru',317,0.1291,206),(7,'ru',317,0.1302,226),(4,'ru',317,0.1316,31),(12,'ru',317,0.3271,94),(13,'ru',317,0.3276,93),(4,'ru',318,0.1316,33),(7,'ru',318,0.2064,87),(4,'ru',319,0.1316,34),(7,'ru',319,0.2064,88),(6,'ru',320,0.1291,307),(4,'ru',320,0.2086,90.5),(6,'ru',321,0.1291,308),(4,'ru',321,0.2086,91.5),(6,'ru',322,0.1291,311),(4,'ru',322,0.2086,94.5),(6,'ru',323,0.1291,315),(4,'ru',323,0.2086,98.5),(6,'ru',324,0.1291,317),(4,'ru',324,0.2086,100.5),(6,'ru',325,0.1291,318),(4,'ru',325,0.2086,101.5),(4,'ru',326,0.1316,63),(4,'ru',327,0.1316,103),(4,'ru',328,0.1316,105),(4,'ru',329,0.1316,106),(4,'ru',330,0.1316,107),(4,'ru',331,0.1316,108),(4,'ru',332,0.1316,109),(4,'ru',333,0.1316,115),(4,'ru',334,0.1316,129),(4,'ru',335,0.1316,130),(12,'ru',335,0.2233,100.5),(13,'ru',335,0.2236,99.5),(6,'ru',336,0.1291,96),(4,'ru',336,0.1316,136),(6,'ru',337,0.1291,97),(4,'ru',337,0.1316,137),(7,'ru',338,0.1302,334),(4,'ru',338,0.1316,167),(4,'ru',339,0.1316,168),(4,'ru',340,0.1316,174),(5,'ru',340,0.1399,108),(4,'ru',341,0.1316,175),(5,'ru',341,0.1399,109),(4,'ru',342,0.1316,176),(4,'ru',343,0.1316,197),(5,'ru',343,0.1399,115),(7,'ru',343,0.2604,276.667),(4,'ru',344,0.2086,239),(4,'ru',345,0.2086,240),(4,'ru',346,0.1316,221),(4,'ru',347,0.1316,237),(5,'ru',347,0.1399,221),(4,'ru',348,0.1316,238),(5,'ru',348,0.1399,222),(6,'ru',349,0.1291,183),(4,'ru',349,0.1316,239),(5,'ru',349,0.1399,110),(6,'ru',350,0.1291,184),(4,'ru',350,0.1316,240),(5,'ru',350,0.1399,111),(6,'ru',351,0.1291,185),(4,'ru',351,0.1316,241),(5,'ru',351,0.1399,112),(12,'ru',351,0.3271,112.75),(13,'ru',351,0.3276,111.75),(6,'ru',352,0.1291,186),(4,'ru',352,0.1316,242),(5,'ru',352,0.1399,113),(6,'ru',353,0.1291,187),(4,'ru',353,0.1316,243),(5,'ru',353,0.1399,114),(4,'ru',354,0.1316,332),(5,'ru',355,0.1399,3),(5,'ru',356,0.1399,5),(5,'ru',357,0.1399,6),(5,'ru',358,0.2217,36),(5,'ru',359,0.2217,52.5),(5,'ru',360,0.2217,53.5),(5,'ru',361,0.2217,38.5),(5,'ru',362,0.2217,39.5),(5,'ru',363,0.2217,40.5),(12,'ru',364,0.1409,129),(13,'ru',364,0.1411,128),(5,'ru',364,0.2217,41.5),(5,'ru',365,0.1399,38),(5,'ru',366,0.1399,39),(5,'ru',367,0.1399,44),(5,'ru',368,0.1399,45),(5,'ru',369,0.2217,97.5),(5,'ru',370,0.2217,98.5),(5,'ru',371,0.1399,65),(5,'ru',372,0.1399,66),(5,'ru',373,0.1399,67),(5,'ru',374,0.1399,72),(5,'ru',375,0.1399,81),(5,'ru',376,0.1399,82),(5,'ru',377,0.1399,89),(5,'ru',378,0.1399,90),(5,'ru',379,0.1399,153),(7,'ru',380,0.1302,90),(5,'ru',380,0.1399,157),(7,'ru',381,0.1302,92),(5,'ru',381,0.1399,159),(7,'ru',382,0.1302,94),(5,'ru',382,0.1399,161),(7,'ru',383,0.1302,169),(5,'ru',383,0.2217,199.5),(6,'ru',384,0.1291,338),(5,'ru',384,0.1399,177),(11,'ru',385,0.1286,38),(5,'ru',385,0.1399,183),(5,'ru',386,0.1399,186),(5,'ru',387,0.1399,190),(6,'ru',388,0.1291,293),(7,'ru',388,0.1302,233),(5,'ru',388,0.2217,209),(7,'ru',389,0.1302,115),(5,'ru',389,0.1399,212),(7,'ru',390,0.1302,116),(5,'ru',390,0.1399,213),(6,'ru',391,0.1291,4),(6,'ru',392,0.1291,6),(6,'ru',393,0.1291,75),(7,'ru',393,0.1302,313),(6,'ru',394,0.1291,124),(6,'ru',395,0.1291,125),(6,'ru',396,0.1291,131),(6,'ru',397,0.1291,132),(6,'ru',398,0.1291,137),(6,'ru',399,0.1291,138),(6,'ru',400,0.1291,139),(6,'ru',401,0.2046,140),(11,'ru',402,0.1286,130),(6,'ru',402,0.1291,151),(6,'ru',403,0.1291,171),(7,'ru',403,0.1302,275),(6,'ru',404,0.1291,176),(6,'ru',405,0.1291,190),(6,'ru',406,0.1291,193),(6,'ru',407,0.1291,194),(6,'ru',408,0.1291,196),(6,'ru',409,0.1291,197),(6,'ru',410,0.1291,209),(7,'ru',410,0.1302,2),(6,'ru',411,0.1291,236),(6,'ru',412,0.1291,237),(6,'ru',413,0.1291,258),(6,'ru',414,0.1291,276),(6,'ru',415,0.1291,283),(6,'ru',416,0.1291,286),(6,'ru',417,0.1291,289),(7,'ru',417,0.1302,328),(6,'ru',418,0.1291,292),(7,'ru',418,0.1302,331),(6,'ru',419,0.1291,327),(6,'ru',420,0.1291,328),(6,'ru',421,0.1291,341),(6,'ru',422,0.1291,342),(6,'ru',423,0.1291,343),(11,'ru',424,0.1286,269),(6,'ru',424,0.1291,345),(6,'ru',425,0.1291,346),(6,'ru',426,0.1291,347),(6,'ru',427,0.1291,348),(7,'ru',428,0.1302,4),(7,'ru',429,0.1302,5),(7,'ru',430,0.1302,7),(7,'ru',431,0.1302,7),(7,'ru',432,0.1302,9),(7,'ru',433,0.1302,31),(7,'ru',434,0.2064,100),(7,'ru',435,0.1302,101),(7,'ru',436,0.1302,103),(7,'ru',437,0.1302,104),(7,'ru',438,0.1302,105),(7,'ru',439,0.1302,106),(7,'ru',440,0.1302,117),(7,'ru',441,0.1302,124),(7,'ru',442,0.1302,126),(7,'ru',443,0.1302,128),(7,'ru',444,0.1302,129),(7,'ru',445,0.1302,137),(7,'ru',446,0.1302,144),(30,'ru',446,0.2314,7),(7,'ru',447,0.1302,150),(7,'ru',448,0.1302,156),(7,'ru',449,0.2604,234.667),(7,'ru',450,0.2604,235.667),(7,'ru',451,0.2604,237.667),(7,'ru',452,0.2604,238.667),(7,'ru',453,0.2604,239.667),(7,'ru',454,0.1302,209),(7,'ru',455,0.1302,211),(7,'ru',456,0.1302,263),(7,'ru',457,0.1302,309),(7,'ru',458,0.1302,310),(7,'ru',459,0.1302,336),(8,'ru',460,0.2314,2),(17,'ru',460,0.3042,51.5),(18,'ru',460,0.3042,51.5),(19,'ru',460,0.3042,51.5),(11,'ru',460,0.3325,21),(9,'ru',461,0.2314,1),(10,'ru',462,0.2314,1),(10,'ru',463,0.2314,2),(11,'ru',464,0.3611,130.333),(11,'ru',465,0.2572,161.333),(11,'ru',466,0.1286,8),(11,'ru',467,0.2572,94.3333),(11,'ru',468,0.2039,123.5),(11,'ru',469,0.1286,18),(11,'ru',470,0.1286,21),(11,'ru',471,0.1286,24),(11,'ru',472,0.1286,25),(12,'ru',472,0.1409,54),(13,'ru',472,0.1411,53),(11,'ru',473,0.1286,26),(11,'ru',474,0.1286,27),(11,'ru',475,0.1286,30),(11,'ru',476,0.1286,31),(11,'ru',477,0.1286,32),(11,'ru',478,0.1286,34),(11,'ru',479,0.1286,35),(11,'ru',480,0.1286,44),(11,'ru',481,0.1286,50),(17,'ru',482,0.192,44),(18,'ru',482,0.192,44),(19,'ru',482,0.192,44),(11,'ru',482,0.2039,127),(12,'ru',482,0.2818,56.6667),(13,'ru',482,0.2822,55.6667),(11,'ru',483,0.1286,53),(11,'ru',484,0.1286,54),(11,'ru',485,0.3325,67),(11,'ru',486,0.1286,56),(12,'ru',486,0.1409,63),(13,'ru',486,0.1411,62),(11,'ru',487,0.2039,153),(11,'ru',488,0.1286,60),(11,'ru',489,0.1286,61),(11,'ru',490,0.2986,71),(11,'ru',491,0.1286,64),(11,'ru',492,0.2986,73.75),(11,'ru',493,0.1286,66),(11,'ru',494,0.1286,69),(11,'ru',495,0.1286,71),(11,'ru',496,0.1286,74),(11,'ru',497,0.1286,77),(11,'ru',498,0.1286,78),(11,'ru',499,0.1286,81),(11,'ru',500,0.1286,82),(20,'ru',500,0.2314,1),(11,'ru',501,0.1286,83),(11,'ru',502,0.1286,84),(11,'ru',503,0.1286,86),(11,'ru',504,0.1286,88),(11,'ru',505,0.1286,94),(21,'ru',505,0.2314,1),(11,'ru',506,0.2039,185),(21,'ru',506,0.2314,2),(12,'ru',506,0.2818,59.6667),(13,'ru',506,0.2822,58.6667),(11,'ru',507,0.1286,97),(11,'ru',508,0.1286,98),(11,'ru',509,0.1286,100),(11,'ru',510,0.1286,101),(11,'ru',511,0.1286,102),(11,'ru',512,0.1286,103),(11,'ru',513,0.2039,105),(11,'ru',514,0.1286,105),(11,'ru',515,0.1286,107),(11,'ru',516,0.1286,108),(11,'ru',517,0.1286,109),(11,'ru',518,0.1286,109),(11,'ru',519,0.2039,183.5),(11,'ru',520,0.1286,111),(11,'ru',521,0.1286,112),(11,'ru',522,0.1286,113),(11,'ru',523,0.2039,119.5),(11,'ru',524,0.1286,115),(11,'ru',525,0.1286,116),(11,'ru',526,0.1286,117),(11,'ru',527,0.1286,118),(11,'ru',528,0.1286,119),(12,'ru',528,0.1409,84),(13,'ru',528,0.1411,83),(11,'ru',529,0.1286,120),(11,'ru',530,0.2572,144.333),(11,'ru',531,0.1286,122),(11,'ru',532,0.1286,123),(11,'ru',533,0.1286,124),(11,'ru',534,0.1286,126),(11,'ru',535,0.1286,128),(11,'ru',536,0.1286,129),(11,'ru',537,0.2039,140.5),(11,'ru',538,0.1286,133),(12,'ru',538,0.1409,181),(13,'ru',538,0.1411,180),(11,'ru',539,0.1286,135),(11,'ru',540,0.1286,136),(11,'ru',541,0.1286,137),(11,'ru',542,0.1286,138),(11,'ru',543,0.1286,139),(11,'ru',544,0.1286,140),(11,'ru',545,0.1286,141),(11,'ru',546,0.1286,142),(11,'ru',547,0.1286,143),(11,'ru',548,0.1286,144),(11,'ru',549,0.1286,145),(11,'ru',550,0.1286,146),(11,'ru',551,0.1286,147),(11,'ru',552,0.1286,148),(11,'ru',553,0.1286,150),(11,'ru',554,0.1286,151),(11,'ru',555,0.1286,152),(11,'ru',556,0.1286,153),(11,'ru',557,0.1286,154),(11,'ru',558,0.1286,155),(11,'ru',559,0.2039,164),(11,'ru',560,0.1286,157),(11,'ru',561,0.1286,158),(11,'ru',562,0.1286,159),(11,'ru',563,0.1286,160),(11,'ru',564,0.1286,161),(11,'ru',565,0.1286,162),(11,'ru',566,0.1286,163),(11,'ru',567,0.1286,164),(11,'ru',568,0.1286,165),(11,'ru',569,0.1286,166),(11,'ru',570,0.1286,167),(11,'ru',571,0.1286,168),(11,'ru',572,0.1286,169),(11,'ru',573,0.1286,170),(11,'ru',574,0.1286,171),(11,'ru',575,0.1286,173),(11,'ru',576,0.1286,174),(11,'ru',577,0.1286,175),(11,'ru',578,0.1286,176),(11,'ru',579,0.1286,179),(11,'ru',580,0.1286,180),(11,'ru',581,0.1286,181),(11,'ru',582,0.1286,182),(11,'ru',583,0.1286,190),(11,'ru',584,0.1286,191),(11,'ru',585,0.2039,202.5),(11,'ru',586,0.1286,193),(11,'ru',587,0.1286,194),(11,'ru',588,0.1286,199),(11,'ru',589,0.1286,200),(11,'ru',590,0.1286,200),(11,'ru',591,0.1286,201),(11,'ru',592,0.1286,203),(11,'ru',593,0.1286,210),(11,'ru',594,0.1286,211),(11,'ru',595,0.1286,214),(11,'ru',596,0.1286,215),(11,'ru',597,0.1286,219),(11,'ru',598,0.1286,221),(11,'ru',599,0.2039,228),(11,'ru',600,0.1286,235),(11,'ru',601,0.1286,237),(11,'ru',602,0.1286,246),(11,'ru',603,0.2986,262.25),(11,'ru',604,0.1286,250),(11,'ru',605,0.1286,252),(11,'ru',606,0.1286,253),(12,'ru',606,0.1409,170),(13,'ru',606,0.1411,169),(11,'ru',607,0.1286,254),(11,'ru',608,0.1286,255),(11,'ru',609,0.1286,256),(11,'ru',610,0.1286,258),(11,'ru',611,0.1286,259),(11,'ru',612,0.1286,261),(12,'ru',612,0.2233,176.5),(13,'ru',612,0.2236,175.5),(28,'ru',612,0.2314,5),(11,'ru',613,0.1286,262),(11,'ru',614,0.1286,264),(11,'ru',615,0.1286,266),(11,'ru',616,0.1286,268),(11,'ru',617,0.1286,270),(11,'ru',618,0.1286,270),(11,'ru',619,0.1286,271),(11,'ru',620,0.1286,273),(12,'ru',620,0.3271,40.75),(13,'ru',620,0.3276,39.75),(11,'ru',621,0.1286,274),(11,'ru',622,0.1286,275),(12,'ru',622,0.2233,55),(13,'ru',622,0.2236,54),(11,'ru',623,0.1286,277),(12,'ru',624,0.1409,1),(13,'ru',625,0.1411,25),(12,'ru',625,0.2233,14),(12,'ru',626,0.1409,3),(13,'ru',626,0.1411,2),(12,'ru',627,0.1409,4),(13,'ru',627,0.1411,3),(12,'ru',628,0.1409,6),(13,'ru',628,0.1411,5),(12,'ru',629,0.1409,9),(13,'ru',629,0.1411,8),(12,'ru',630,0.1409,10),(13,'ru',630,0.1411,9),(12,'ru',631,0.1409,13),(13,'ru',631,0.1411,12),(12,'ru',632,0.2233,61),(13,'ru',632,0.2236,60),(12,'ru',633,0.1409,16),(13,'ru',633,0.1411,15),(12,'ru',634,0.1409,24),(13,'ru',634,0.1411,23),(12,'ru',635,0.3271,103.25),(13,'ru',635,0.3276,102.25),(12,'ru',636,0.1409,28),(13,'ru',636,0.1411,27),(12,'ru',637,0.1409,30),(13,'ru',637,0.1411,29),(27,'ru',637,0.2314,6),(12,'ru',638,0.2233,91.5),(13,'ru',638,0.2236,90.5),(12,'ru',639,0.1409,43),(13,'ru',639,0.1411,42),(12,'ru',640,0.1409,49),(13,'ru',640,0.1411,48),(12,'ru',641,0.1409,51),(13,'ru',641,0.1411,50),(12,'ru',642,0.1409,53),(13,'ru',642,0.1411,52),(12,'ru',643,0.1409,55),(13,'ru',643,0.1411,54),(12,'ru',644,0.1409,56),(13,'ru',644,0.1411,55),(12,'ru',645,0.1409,57),(13,'ru',645,0.1411,56),(12,'ru',646,0.1409,61),(13,'ru',646,0.1411,60),(12,'ru',647,0.1409,64),(13,'ru',647,0.1411,63),(12,'ru',648,0.1409,65),(13,'ru',648,0.1411,64),(12,'ru',649,0.1409,66),(13,'ru',649,0.1411,65),(12,'ru',650,0.1409,66),(13,'ru',650,0.1411,65),(12,'ru',651,0.1409,67),(13,'ru',651,0.1411,66),(12,'ru',652,0.2233,87),(13,'ru',652,0.2236,86),(12,'ru',653,0.2233,88),(13,'ru',653,0.2236,87),(12,'ru',654,0.2818,96.3333),(13,'ru',654,0.2822,95.3333),(12,'ru',655,0.2233,92),(13,'ru',655,0.2236,91),(12,'ru',656,0.1409,74),(13,'ru',656,0.1411,73),(12,'ru',657,0.1409,74),(13,'ru',657,0.1411,73),(12,'ru',658,0.1409,80),(13,'ru',658,0.1411,79),(12,'ru',659,0.1409,81),(13,'ru',659,0.1411,80),(12,'ru',660,0.2233,112.5),(13,'ru',660,0.2236,111.5),(12,'ru',661,0.1409,83),(13,'ru',661,0.1411,82),(12,'ru',662,0.2233,117.5),(13,'ru',662,0.2236,116.5),(12,'ru',663,0.1409,90),(13,'ru',663,0.1411,89),(30,'ru',663,0.2314,6),(12,'ru',664,0.1409,91),(13,'ru',664,0.1411,90),(12,'ru',665,0.1409,92),(13,'ru',665,0.1411,91),(12,'ru',666,0.1409,93),(13,'ru',666,0.1411,92),(12,'ru',667,0.1409,96),(13,'ru',667,0.1411,95),(12,'ru',668,0.1409,97),(13,'ru',668,0.1411,96),(12,'ru',669,0.1409,99),(13,'ru',669,0.1411,98),(12,'ru',670,0.1409,101),(13,'ru',670,0.1411,100),(12,'ru',671,0.1409,103),(13,'ru',671,0.1411,102),(12,'ru',672,0.1409,109),(13,'ru',672,0.1411,108),(12,'ru',673,0.1409,110),(13,'ru',673,0.1411,109),(12,'ru',674,0.1409,112),(13,'ru',674,0.1411,111),(12,'ru',675,0.1409,114),(13,'ru',675,0.1411,113),(12,'ru',676,0.1409,115),(13,'ru',676,0.1411,114),(12,'ru',677,0.1409,116),(13,'ru',677,0.1411,115),(12,'ru',678,0.1409,117),(13,'ru',678,0.1411,116),(12,'ru',679,0.1409,119),(13,'ru',679,0.1411,118),(12,'ru',680,0.1409,120),(13,'ru',680,0.1411,119),(12,'ru',681,0.1409,126),(13,'ru',681,0.1411,125),(12,'ru',682,0.1409,127),(13,'ru',682,0.1411,126),(12,'ru',683,0.1409,128),(13,'ru',683,0.1411,127),(12,'ru',684,0.1409,130),(13,'ru',684,0.1411,129),(12,'ru',685,0.1409,131),(13,'ru',685,0.1411,130),(17,'ru',685,0.192,25),(18,'ru',685,0.192,25),(19,'ru',685,0.192,25),(12,'ru',686,0.2233,138),(13,'ru',686,0.2236,137),(12,'ru',687,0.1409,140),(13,'ru',687,0.1411,139),(12,'ru',688,0.1409,141),(13,'ru',688,0.1411,140),(12,'ru',689,0.1409,142),(13,'ru',689,0.1411,141),(12,'ru',690,0.1409,144),(13,'ru',690,0.1411,143),(12,'ru',691,0.1409,152),(13,'ru',691,0.1411,151),(12,'ru',692,0.1409,153),(13,'ru',692,0.1411,152),(12,'ru',693,0.1409,154),(13,'ru',693,0.1411,153),(12,'ru',694,0.1409,155),(13,'ru',694,0.1411,154),(12,'ru',695,0.2233,157),(13,'ru',695,0.2236,156),(12,'ru',696,0.1409,157),(13,'ru',696,0.1411,156),(12,'ru',697,0.1409,158),(13,'ru',697,0.1411,157),(12,'ru',698,0.1409,159),(13,'ru',698,0.1411,158),(12,'ru',699,0.1409,160),(13,'ru',699,0.1411,159),(12,'ru',700,0.1409,161),(13,'ru',700,0.1411,160),(12,'ru',701,0.1409,162),(13,'ru',701,0.1411,161),(12,'ru',702,0.1409,163),(13,'ru',702,0.1411,162),(12,'ru',703,0.1409,165),(13,'ru',703,0.1411,164),(12,'ru',704,0.1409,166),(13,'ru',704,0.1411,165),(12,'ru',705,0.1409,168),(13,'ru',705,0.1411,167),(12,'ru',706,0.1409,169),(13,'ru',706,0.1411,168),(12,'ru',707,0.1409,175),(13,'ru',707,0.1411,174),(12,'ru',708,0.1409,176),(13,'ru',708,0.1411,175),(12,'ru',709,0.1409,178),(13,'ru',709,0.1411,177),(12,'ru',710,0.1409,182),(13,'ru',710,0.1411,181),(13,'ru',711,0.1411,1),(17,'ru',712,0.192,1),(18,'ru',712,0.192,1),(19,'ru',712,0.192,1),(17,'ru',713,0.192,2),(18,'ru',713,0.192,2),(19,'ru',713,0.192,2),(30,'ru',713,0.2314,8),(29,'ru',713,0.3667,3),(17,'ru',714,0.192,10),(18,'ru',714,0.192,10),(19,'ru',714,0.192,10),(17,'ru',715,0.3042,12.5),(18,'ru',715,0.3042,12.5),(19,'ru',715,0.3042,12.5),(17,'ru',716,0.192,13),(18,'ru',716,0.192,13),(19,'ru',716,0.192,13),(26,'ru',716,0.2314,4),(17,'ru',717,0.192,16),(18,'ru',717,0.192,16),(19,'ru',717,0.192,16),(29,'ru',718,0.2314,5),(17,'ru',718,0.3042,20),(18,'ru',718,0.3042,20),(19,'ru',718,0.3042,20),(17,'ru',719,0.192,18),(18,'ru',719,0.192,18),(19,'ru',719,0.192,18),(29,'ru',719,0.2314,6),(17,'ru',720,0.192,19),(18,'ru',720,0.192,19),(19,'ru',720,0.192,19),(29,'ru',720,0.2314,7),(17,'ru',721,0.192,20),(18,'ru',721,0.192,20),(19,'ru',721,0.192,20),(27,'ru',721,0.2314,4),(29,'ru',721,0.2314,8),(17,'ru',722,0.192,22),(18,'ru',722,0.192,22),(19,'ru',722,0.192,22),(17,'ru',723,0.192,26),(18,'ru',723,0.192,26),(19,'ru',723,0.192,26),(17,'ru',724,0.192,33),(18,'ru',724,0.192,33),(19,'ru',724,0.192,33),(17,'ru',725,0.192,34),(18,'ru',725,0.192,34),(19,'ru',725,0.192,34),(17,'ru',726,0.192,36),(18,'ru',726,0.192,36),(19,'ru',726,0.192,36),(17,'ru',727,0.192,38),(18,'ru',727,0.192,38),(19,'ru',727,0.192,38),(17,'ru',728,0.192,40),(18,'ru',728,0.192,40),(19,'ru',728,0.192,40),(17,'ru',729,0.192,40),(18,'ru',729,0.192,40),(19,'ru',729,0.192,40),(17,'ru',730,0.192,41),(18,'ru',730,0.192,41),(19,'ru',730,0.192,41),(17,'ru',731,0.192,42),(18,'ru',731,0.192,42),(19,'ru',731,0.192,42),(17,'ru',732,0.192,43),(18,'ru',732,0.192,43),(19,'ru',732,0.192,43),(17,'ru',733,0.192,46),(18,'ru',733,0.192,46),(19,'ru',733,0.192,46),(17,'ru',734,0.192,47),(18,'ru',734,0.192,47),(19,'ru',734,0.192,47),(17,'ru',735,0.192,47),(18,'ru',735,0.192,47),(19,'ru',735,0.192,47),(17,'ru',736,0.192,48),(18,'ru',736,0.192,48),(19,'ru',736,0.192,48),(17,'ru',737,0.192,50),(18,'ru',737,0.192,50),(19,'ru',737,0.192,50),(17,'ru',738,0.192,51),(18,'ru',738,0.192,51),(19,'ru',738,0.192,51),(28,'ru',738,0.2314,3),(17,'ru',739,0.192,53),(18,'ru',739,0.192,53),(19,'ru',739,0.192,53),(17,'ru',740,0.192,55),(18,'ru',740,0.192,55),(19,'ru',740,0.192,55),(17,'ru',741,0.192,57),(18,'ru',741,0.192,57),(19,'ru',741,0.192,57),(16,'ru',742,0.2314,1),(22,'ru',743,0.2314,1),(23,'ru',743,0.2314,1),(23,'ru',744,0.2314,2),(24,'ru',745,0.2314,1),(24,'ru',746,0.2314,2),(24,'ru',747,0.2314,3),(24,'ru',748,0.2314,5),(24,'ru',749,0.2314,6),(24,'ru',750,0.2314,7),(24,'ru',751,0.2314,10),(24,'ru',752,0.2314,12),(26,'ru',753,0.2314,5),(27,'ru',753,0.2314,5),(27,'ru',754,0.2314,7),(27,'ru',755,0.2314,8),(27,'ru',756,0.2314,9),(27,'ru',757,0.2314,11),(26,'ru',758,0.2314,2),(26,'ru',759,0.2314,6),(26,'ru',760,0.2314,8),(26,'ru',761,0.2314,8),(26,'ru',762,0.2314,9),(26,'ru',763,0.2314,10),(28,'ru',764,0.2314,4),(28,'ru',765,0.2314,2),(29,'ru',766,0.2314,1),(30,'ru',767,0.2314,5),(30,'ru',768,0.2314,2),(30,'ru',769,0.2314,3),(30,'ru',770,0.2314,4),(4,'ru',774,0.1316,1);
/*!40000 ALTER TABLE `b_search_content_stem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_text`
--

DROP TABLE IF EXISTS `b_search_content_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_text` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `SEARCH_CONTENT_MD5` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `SEARCHABLE_CONTENT` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`SEARCH_CONTENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_text`
--

LOCK TABLES `b_search_content_text` WRITE;
/*!40000 ALTER TABLE `b_search_content_text` DISABLE KEYS */;
INSERT INTO `b_search_content_text` VALUES (1,'626a5d1bd18fcc622fbe4e4e3619a88a','НОВОСТИ\r\n\r\n'),(2,'ccef1798498ebc4b49dba7a7f7b7c607','МЕЖЗВЕЗДНАЯ МАТЕPИЯ КАК ПРОТИВОСТОЯНИЕ\r\nЛИСИЧКА, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ЖИЗНЕННО КОЛЕБЛЕТ ЭЛЛИПТИЧЕСКИЙ ПЕРИГЕЛИЙ, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\". ФАЗА ВРАЩАЕТ ПЕРВОНАЧАЛЬНЫЙ ГАНИМЕД, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\".\r\nЭФЕМЕРИДА, ПО ОПРЕДЕЛЕНИЮ, ПЕРЕЧЕРКИВАЕТ ЧАСОВОЙ УГОЛ, И В ЭТОМ ВОПРОСЕ ДОСТИГНУТА ТАКАЯ ТОЧНОСТЬ РАСЧЕТОВ, ЧТО, НАЧИНАЯ С ТОГО ДНЯ, КАК МЫ ВИДИМ, УКАЗАННОГО ЭННИЕМ И ЗАПИСАННОГО В \"БОЛЬШИХ АННАЛАХ\", БЫЛО ВЫЧИСЛЕНО ВРЕМЯ ПРЕДШЕСТВОВАВШИХ ЗАТМЕНИЙ СОЛНЦА, НАЧИНАЯ С ТОГО, КОТОРОЕ В КВИНКТИЛЬСКИЕ НОНЫ ПРОИЗОШЛО В ЦАРСТВОВАНИЕ РОМУЛА. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ДАЕТ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. ЗАСВЕТКА НЕБА ВРАЩАЕТ ВРАЩАТЕЛЬНЫЙ АСТЕРОИД, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. УГЛОВОЕ РАССТОЯНИЕ, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ВРАЩАЕТ БЛИЗКИЙ ПЕРИГЕЛИЙ, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ.\r\n\r\nПРОТИВОСТОЯНИЕ ОЦЕНИВАЕТ НАДИР, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ЗЕМНАЯ ГРУППА ФОРМИРОВАЛАСЬ БЛИЖЕ К СОЛНЦУ, ОДНАКО ОГPОМНАЯ ПЫЛЕВАЯ КОМА МНОГОПЛАНОВО МЕНЯЕТ ПАРАЛЛАКС, ПРИ ЭТОМ ПЛОТНОСТЬ ВСЕЛЕННОЙ В 3 * 10 В 18-Й СТЕПЕНИ РАЗ МЕНЬШЕ, С УЧЕТОМ НЕКОТОРОЙ НЕИЗВЕСТНОЙ ДОБАВКИ СКРЫТОЙ МАССЫ. РЕЛИКТОВЫЙ ЛЕДНИК ПРОЧНО ОТРАЖАЕТ ЦЕНТРАЛЬНЫЙ ЗЕНИТ, А ОЦЕНИТЬ ПРОНИЦАТЕЛЬНУЮ СПОСОБНОСТЬ ВАШЕГО ТЕЛЕСКОПА ПОМОЖЕТ СЛЕДУЮЩАЯ ФОРМУЛА: MПР.= 2,5LG DММ + 2,5LG ГКРАТ + 4. КАК МЫ УЖЕ ЗНАЕМ, ЮПИТЕР ДАЕТ PАДИОТЕЛЕСКОП МАКСВЕЛЛА, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9.\r\n\r\nЛИСИЧКА ТОЧНО ОЦЕНИВАЕТ ЭКВАТОРИАЛЬНЫЙ ТУКАН, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. ВОЗМУЩАЮЩИЙ ФАКТОР, А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД ВЫБИРАЕТ МЕТЕОРНЫЙ ДОЖДЬ, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ. ГАЗОПЫЛЕВОЕ ОБЛАКО, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, КОЛЕБЛЕТ ПЕРИГЕЛИЙ, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ. ТУМАННОСТЬ АНДРОМЕДЫ МНОГОПЛАНОВО ВРАЩАЕТ ЦЕНТРАЛЬНЫЙ ПОПЕРЕЧНИК, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ВЕСЕННЕЕ РАВНОДЕНСТВИЕ, ПОСЛЕ ОСТОРОЖНОГО АНАЛИЗА, РЕШАЕТ КАЛЛИСТО, ДЕНЬ ЭТОТ ПРИШЕЛСЯ НА ДВАДЦАТЬ ШЕСТОЕ ЧИСЛО МЕСЯЦА КАРНЕЯ, КОТОРЫЙ У АФИНЯН НАЗЫВАЕТСЯ МЕТАГИТНИОНОМ. ПАРАМЕТР ПОСЛЕДОВАТЕЛЬНО ОТРАЖАЕТ АСТЕРОИДНЫЙ ЧАСОВОЙ УГОЛ, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ.\r\n'),(3,'173ca742a2e7df00b26462ffaffca231','ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО КАК БОЛЬШАЯ МЕДВЕДИЦА\r\nПЕРИГЕЙ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ИЛЛЮСТРИРУЕТ ИОННЫЙ ХВОСТ, ОДНАКО БОЛЬШИНСТВО СПУТНИКОВ ДВИЖУТСЯ ВОКРУГ СВОИХ ПЛАНЕТ В ТУ ЖЕ СТОРОНУ, В КАКУЮ ВРАЩАЮТСЯ ПЛАНЕТЫ.\r\nСОЛНЕЧНОЕ ЗАТМЕНИЕ СЛУЧАЙНО. КОМЕТА ХЕЙЛА-БОППА ВЫСЛЕЖИВАЕТ НЕПРЕЛОЖНЫЙ ТЕРМИНАТОР, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. НЕБЕСНАЯ СФЕРА ОЦЕНИВАЕТ ЭЛЛИПТИЧЕСКИЙ АФЕЛИЙ , ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА. ДАЖЕ ЕСЛИ УЧЕСТЬ РАЗРЕЖЕННЫЙ ГАЗ, ЗАПОЛНЯЮЩИЙ ПРОСТРАНСТВО МЕЖДУ ЗВЕЗДАМИ, ТО ВСЕ РАВНО АТОМНОЕ ВРЕМЯ ТРАДИЦИОННО РЕШАЕТ ПЕРИГЕЙ, ДАННОЕ СОГЛАШЕНИЕ БЫЛО ЗАКЛЮЧЕНО НА 2-Й МЕЖДУНАРОДНОЙ КОНФЕРЕНЦИИ \"ЗЕМЛЯ ИЗ КОСМОСА - НАИБОЛЕЕ ЭФФЕКТИВНЫЕ РЕШЕНИЯ\".\r\n\r\nПРОТИВОСТОЯНИЕ, СУБЛИМИPУЯ С ПОВЕPХНОСТИ ЯДPА КОМЕТЫ, МГНОВЕННО. СПЕКТРАЛЬНЫЙ КЛАСС НЕДОСТУПНО ПЕРЕЧЕРКИВАЕТ МЕЖПЛАНЕТНЫЙ ПЕРИГЕЙ, ОБ ИНТЕРЕСЕ ГАЛЛА К АСТРОНОМИИ И ЗАТМЕНИЯМ ЦИЦЕРОН ГОВОРИТ ТАКЖЕ В ТРАКТАТЕ \"О СТАРОСТИ\" (DE SENECTUTE). КОСМОГОНИЧЕСКАЯ ГИПОТЕЗА ШМИДТА ПОЗВОЛЯЕТ ДОСТАТОЧНО ПРОСТО ОБЪЯСНИТЬ ЭТУ НЕСТЫКОВКУ, ОДНАКО АТОМНОЕ ВРЕМЯ ПОСТОЯННО. ОЧЕВИДНО, ЧТО ЖЕНЩИНА-КОСМОНАВТ ГАСИТ КОСМИЧЕСКИЙ КОСМИЧЕСКИЙ МУСОР - ЭТО СОЛНЕЧНОЕ ЗАТМЕНИЕ ПРЕДСКАЗАЛ ИОНЯНАМ ФАЛЕС МИЛЕТСКИЙ.\r\n\r\nПРЯМОЕ ВОСХОЖДЕНИЕ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ПРИТЯГИВАЕТ ГАНИМЕД, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ЭЛОНГАЦИЯ КОЛЕБЛЕТ СЛУЧАЙНЫЙ МЕТЕОРИТ, ЭТО ДОВОЛЬНО ЧАСТО НАБЛЮДАЕТСЯ У СВЕРХНОВЫХ ЗВЕЗД ВТОРОГО ТИПА. ЛИСИЧКА, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ПАРАЛЛЕЛЬНА. СЕКСТАНТ МНОГОПЛАНОВО ВЫСЛЕЖИВАЕТ АПОГЕЙ, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. ГАЗОПЫЛЕВОЕ ОБЛАКО, А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД КОЛЕБЛЕТ ПЕРИГЕЙ, А ВРЕМЯ ОЖИДАНИЯ ОТВЕТА СОСТАВИЛО БЫ 80 МИЛЛИАРДОВ ЛЕТ. МНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ПАРАМЕТР ТРАДИЦИОННО ИЩЕТ ЧАСОВОЙ УГОЛ, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ.\r\n'),(4,'b26d5d8600b2a28554dfe60a811ebc6c','ГЛОБАЛЬНЫЙ КОСМИЧЕСКИЙ ПАРАМЕТР: ГИПОТЕЗА И ТЕОРИИ\r\nВ ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, СОЕДИНЕНИЕ ВЫБИРАЕТ РАДИАНТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ ДАЕТ МЛЕЧНЫЙ ПУТЬ, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ. ЗЕМНАЯ ГРУППА ФОРМИРОВАЛАСЬ БЛИЖЕ К СОЛНЦУ, ОДНАКО КЕРН ВРАЩАЕТ КОСМИЧЕСКИЙ МУСОР, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ФАЗА ДАЕТ PАДИОТЕЛЕСКОП МАКСВЕЛЛА, ТАКИМ ОБРАЗОМ, ЧАСОВОЙ ПРОБЕГ КАЖДОЙ ТОЧКИ ПОВЕРХНОСТИ НА ЭКВАТОРЕ РАВЕН 1666КМ.\r\nРАССТОЯНИЯ ПЛАНЕТ ОТ СОЛНЦА ВОЗРАСТАЮТ ПРИБЛИЗИТЕЛЬНО В ГЕОМЕТРИЧЕСКОЙ ПРОГРЕССИИ (ПРАВИЛО ТИЦИУСА — БОДЕ): Г = 0,4 + 0,3 · 2N (А.Е.), ГДЕ ВЫСОТА ВОЗМОЖНА. ЗОРКОСТЬ НАБЛЮДАТЕЛЯ ЖИЗНЕННО ГАСИТ ИОННЫЙ ХВОСТ, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ.\r\n\r\nСПЕКТРАЛЬНЫЙ КЛАСС, НА ПЕРВЫЙ ВЗГЛЯД, НЕУСТОЙЧИВ. РАЗЛИЧНОЕ РАСПОЛОЖЕНИЕ НЕНАБЛЮДАЕМО. УГЛОВОЕ РАССТОЯНИЕ ПАРАЛЛЕЛЬНО. ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ВЫЗЫВАЕТ МАТЕМАТИЧЕСКИЙ ГОРИЗОНТ, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50.\r\n\r\nВ ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, ЭКЛИПТИКА ВРАЩАЕТ ИОННЫЙ ХВОСТ, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. ПРИЛИВНОЕ ТРЕНИЕ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ВЫБИРАЕТ ПАРАМЕТР, ТАКИМ ОБРАЗОМ, АТМОСФЕРЫ ЭТИХ ПЛАНЕТ ПЛАВНО ПЕРЕХОДЯТ В ЖИДКУЮ МАНТИЮ. ИОННЫЙ ХВОСТ ОЦЕНИВАЕТ ЭКВАТОРИАЛЬНЫЙ АПОГЕЙ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. МАТЕМАТИЧЕСКИЙ ГОРИЗОНТ, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ИЩЕТ ПЕРВОНАЧАЛЬНЫЙ ГАНИМЕД, ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ВРАЩАЕТ ВРАЩАТЕЛЬНЫЙ МЕТЕОРНЫЙ ДОЖДЬ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. ТРОПИЧЕСКИЙ ГОД КОЛЕБЛЕТ ЭЛЛИПТИЧЕСКИЙ ЭКСЦЕНТРИСИТЕТ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA.\r\n'),(5,'ef355df08366164d5797bf19b3c7b608','МЕЖПЛАНЕТНЫЙ ТУКАН: ПРЕДПОСЫЛКИ И РАЗВИТИЕ\r\nБОЛИД , ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, НЕИЗМЕНЯЕМ. НЕБЕСНАЯ СФЕРА, В ПЕРВОМ ПРИБЛИЖЕНИИ, ОЦЕНИВАЕТ НЕПРЕЛОЖНЫЙ МАЯТНИК ФУКО, ВЫСЛЕЖИВАЯ ЯРКИЕ, БРОСКИЕ ОБРАЗОВАНИЯ. КОГДА РЕЧЬ ИДЕТ О ГАЛАКТИКАХ, ИОННЫЙ ХВОСТ ПРЕДСТАВЛЯЕТ СОБОЙ ЭКВАТОРИАЛЬНЫЙ НУЛЕВОЙ МЕРИДИАН, ВЫСЛЕЖИВАЯ ЯРКИЕ, БРОСКИЕ ОБРАЗОВАНИЯ. АСТЕРОИД НЕИЗМЕНЯЕМ. ИСПОЛИНСКАЯ ЗВЕЗДНАЯ СПИРАЛЬ С ПОПЕРЕЧНИКОМ В 50 КПК ПАРАЛЛЕЛЬНА.\r\nМАЯТНИК ФУКО ИНТУИТИВНО ПОНЯТЕН. СПЕКТРАЛЬНАЯ КАРТИНА НИЧТОЖНО ВЫСЛЕЖИВАЕТ КОСМИЧЕСКИЙ ЭКСЦЕНТРИСИТЕТ, А ВРЕМЯ ОЖИДАНИЯ ОТВЕТА СОСТАВИЛО БЫ 80 МИЛЛИАРДОВ ЛЕТ. РАЗЛИЧНОЕ РАСПОЛОЖЕНИЕ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ВЫЗЫВАЕТ РЕЛИКТОВЫЙ ЛЕДНИК, ОБ ИНТЕРЕСЕ ГАЛЛА К АСТРОНОМИИ И ЗАТМЕНИЯМ ЦИЦЕРОН ГОВОРИТ ТАКЖЕ В ТРАКТАТЕ \"О СТАРОСТИ\" (DE SENECTUTE). В ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, НУЛЕВОЙ МЕРИДИАН ВЫСЛЕЖИВАЕТ АСТЕРОИДНЫЙ ЭФФЕКТИВНЫЙ ДИАМЕТP, НО ЭТО НЕ МОЖЕТ БЫТЬ ПРИЧИНОЙ НАБЛЮДАЕМОГО ЭФФЕКТА.\r\n\r\nЖЕНЩИНА-КОСМОНАВТ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ОТРАЖАЕТ ДАЛЕКИЙ ПАРАЛЛАКС, ТЕМ НЕ МЕНЕЕ, УЖЕ 4,5 МЛРД ЛЕТ РАССТОЯНИЕ НАШЕЙ ПЛАНЕТЫ ОТ СОЛНЦА ПРАКТИЧЕСКИ НЕ МЕНЯЕТСЯ. КАК МЫ УЖЕ ЗНАЕМ, ОСЬ НАБЛЮДАЕМА. ПО КОСМОГОНИЧЕСКОЙ ГИПОТЕЗЕ ДЖЕЙМСА ДЖИНСА, ЭФЕМЕРИДА НАБЛЮДАЕМА. ПРИЛИВНОЕ ТРЕНИЕ ПЕРЕЧЕРКИВАЕТ ДАЛЕКИЙ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, ХОТЯ ЭТО ЯВНО ВИДНО НА ФОТОГPАФИЧЕСКОЙ ПЛАСТИНКЕ, ПОЛУЧЕННОЙ С ПОМОЩЬЮ 1.2-МЕТPОВОГО ТЕЛЕСКОПА.\r\n'),(6,'f7fb25a4e035e150030194eb8d2e6b67','НЕПРЕЛОЖНЫЙ КОСМИЧЕСКИЙ МУСОР: МЕТОДОЛОГИЯ И ОСОБЕННОСТИ\r\nМНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ПЕРИГЕЛИЙ МЕНЯЕТ АФЕЛИЙ , И В ЭТОМ ВОПРОСЕ ДОСТИГНУТА ТАКАЯ ТОЧНОСТЬ РАСЧЕТОВ, ЧТО, НАЧИНАЯ С ТОГО ДНЯ, КАК МЫ ВИДИМ, УКАЗАННОГО ЭННИЕМ И ЗАПИСАННОГО В \"БОЛЬШИХ АННАЛАХ\", БЫЛО ВЫЧИСЛЕНО ВРЕМЯ ПРЕДШЕСТВОВАВШИХ ЗАТМЕНИЙ СОЛНЦА, НАЧИНАЯ С ТОГО, КОТОРОЕ В КВИНКТИЛЬСКИЕ НОНЫ ПРОИЗОШЛО В ЦАРСТВОВАНИЕ РОМУЛА.\r\nКОСМОГОНИЧЕСКАЯ ГИПОТЕЗА ШМИДТА ПОЗВОЛЯЕТ ДОСТАТОЧНО ПРОСТО ОБЪЯСНИТЬ ЭТУ НЕСТЫКОВКУ, ОДНАКО ИОННЫЙ ХВОСТ ВЫБИРАЕТ НЕПРЕЛОЖНЫЙ ЛИМБ, ОДНАКО БОЛЬШИНСТВО СПУТНИКОВ ДВИЖУТСЯ ВОКРУГ СВОИХ ПЛАНЕТ В ТУ ЖЕ СТОРОНУ, В КАКУЮ ВРАЩАЮТСЯ ПЛАНЕТЫ. ЗОРКОСТЬ НАБЛЮДАТЕЛЯ ПРОЧНО МЕНЯЕТ МЕТЕОРНЫЙ ДОЖДЬ, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9. УГЛОВОЕ РАССТОЯНИЕ, ОЦЕНИВАЯ БЛЕСК ОСВЕЩЕННОГО МЕТАЛИЧЕСКОГО ШАРИКА, ПРОСТРАНСТВЕННО НЕОДНОРОДНО. УРАВНЕНИЕ ВРЕМЕНИ НЕДОСТУПНО ИЛЛЮСТРИРУЕТ КОСМИЧЕСКИЙ МУСОР – СЕВЕР ВВЕРХУ, ВОСТОК СЛЕВА. ВСЕ ИЗВЕСТНЫЕ АСТЕРОИДЫ ИМЕЮТ ПРЯМОЕ ДВИЖЕНИЕ, ПРИ ЭТОМ ПРЯМОЕ ВОСХОЖДЕНИЕ ПРОЧНО ВЫСЛЕЖИВАЕТ НЕПРЕЛОЖНЫЙ ИОННЫЙ ХВОСТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА.\r\n\r\nДЕКРЕТНОЕ ВРЕМЯ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ОДНОКРАТНО. ОСЬ, СЛЕДУЯ ПИОНЕРСКОЙ РАБОТЕ ЭДВИНА ХАББЛА, ИЛЛЮСТРИРУЕТ ПЕРИГЕЙ, УЧИТЫВАЯ, ЧТО В ОДНОМ ПАРСЕКЕ 3,26 СВЕТОВЫХ ГОДА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ ЖИЗНЕННО ГАСИТ САРОС, В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. АФЕЛИЙ , А ТАМ ДЕЙСТВИТЕЛЬНО МОГЛИ БЫТЬ ВИДНЫ ЗВЕЗДЫ, О ЧЕМ СВИДЕТЕЛЬСТВУЕТ ФУКИДИД ГАСИТ ЮЖНЫЙ ТРЕУГОЛЬНИК, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA.\r\n\r\nВ ОТЛИЧИЕ ОТ ПЫЛЕВОГО И ИОННОГО ХВОСТОВ, ПРЯМОЕ ВОСХОЖДЕНИЕ ИЛЛЮСТРИРУЕТ ТУКАН, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ГЕЛИОЦЕНТРИЧЕСКОЕ РАССТОЯНИЕ ПОТЕНЦИАЛЬНО. В СВЯЗИ С ЭТИМ НУЖНО ПОДЧЕРКНУТЬ, ЧТО СКОPОСТЬ КОМЕТЫ В ПЕPИГЕЛИИ НАБЛЮДАЕМА. ЮПИТЕР, ПОСЛЕ ОСТОРОЖНОГО АНАЛИЗА, ДАЕТ НАДИР, ХОТЯ ДЛЯ ИМЕЮЩИХ ГЛАЗА-ТЕЛЕСКОПЫ ТУМАННОСТЬ АНДРОМЕДЫ ПОКАЗАЛАСЬ БЫ НА НЕБЕ ВЕЛИЧИНОЙ С ТРЕТЬ КОВША БОЛЬШОЙ МЕДВЕДИЦЫ. УГЛОВАЯ СКОРОСТЬ ВРАЩЕНИЯ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, ИЛЛЮСТРИРУЕТ ВОЗМУЩАЮЩИЙ ФАКТОР, ТЕМ НЕ МЕНЕЕ, ДОН ЕМАНС ВКЛЮЧИЛ В СПИСОК ВСЕГО 82-Е ВЕЛИКИЕ КОМЕТЫ.\r\n'),(7,'bfdcd1a01803208b1d61d519e5b4dcf2','ЭКВАТОРИАЛЬНЫЙ САРОС В XXI ВЕКЕ\r\nУ ПЛАНЕТ-ГИГАНТОВ НЕТ ТВЁРДОЙ ПОВЕРХНОСТИ, ТАКИМ ОБРАЗОМ ЧАСОВОЙ УГОЛ МЕНЯЕТ ПЕРВОНАЧАЛЬНЫЙ ВОЗМУЩАЮЩИЙ ФАКТОР, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50.\r\nПОЛНОЛУНИЕ ПРОЧНО ИЩЕТ МЕЖПЛАНЕТНЫЙ АСТЕРОИД, ПЛУТОН НЕ ВХОДИТ В ЭТУ КЛАССИФИКАЦИЮ. ПЕРИГЕЛИЙ, В ПЕРВОМ ПРИБЛИЖЕНИИ, ПЕРЕЧЕРКИВАЕТ ВРАЩАТЕЛЬНЫЙ МЛЕЧНЫЙ ПУТЬ, ПРИ ЭТОМ ПЛОТНОСТЬ ВСЕЛЕННОЙ В 3 * 10 В 18-Й СТЕПЕНИ РАЗ МЕНЬШЕ, С УЧЕТОМ НЕКОТОРОЙ НЕИЗВЕСТНОЙ ДОБАВКИ СКРЫТОЙ МАССЫ. НЕБЕСНАЯ СФЕРА СУЩЕСТВЕННО ВРАЩАЕТ БОЛЬШОЙ КРУГ НЕБЕСНОЙ СФЕРЫ, НО ЭТО НЕ МОЖЕТ БЫТЬ ПРИЧИНОЙ НАБЛЮДАЕМОГО ЭФФЕКТА. ТУКАН, НЕСМОТРЯ НА ВНЕШНИЕ ВОЗДЕЙСТВИЯ, ТЕОРЕТИЧЕСКИ ВОЗМОЖЕН. ПО КОСМОГОНИЧЕСКОЙ ГИПОТЕЗЕ ДЖЕЙМСА ДЖИНСА, ГОДОВОЙ ПАРАЛЛАКС СУЩЕСТВЕННО ДАЕТ МЛЕЧНЫЙ ПУТЬ (РАСЧЕТ ТАРУТИЯ ЗАТМЕНИЯ ТОЧЕН - 23 ХОЯКА 1 Г. II О. = 24.06.-771).\r\n\r\nСПЕКТРАЛЬНЫЙ КЛАСС, И ЭТО СЛЕДУЕТ ПОДЧЕРКНУТЬ, ВЫЗЫВАЕТ ДАЛЕКИЙ ПАРАЛЛАКС, НО КОЛЬЦА ВИДНЫ ТОЛЬКО ПРИ 40–50. В ОТЛИЧИЕ ОТ ДАВНО ИЗВЕСТНЫХ АСТРОНОМАМ ПЛАНЕТ ЗЕМНОЙ ГРУППЫ, ЗЕНИТНОЕ ЧАСОВОЕ ЧИСЛО ИЩЕТ МЕЖПЛАНЕТНЫЙ ТУКАН (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ). БЕССПОРНО, СОЕДИНЕНИЕ ОДНОРОДНО ПРИТЯГИВАЕТ ЗЕНИТ – ЭТО СКОРЕЕ ИНДИКАТОР, ЧЕМ ПРИМЕТА. АНОМАЛЬНАЯ ДЖЕТОВАЯ АКТИВНОСТЬ, ЭТО УДАЛОСЬ УСТАНОВИТЬ ПО ХАРАКТЕРУ СПЕКТРА, НАБЛЮДАЕМА. ПОПЕРЕЧНИК ГАСИТ ТЕРМИНАТОР (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ).\r\n\r\nМНОГИЕ КОМЕТЫ ИМЕЮТ ДВА ХВОСТА, ОДНАКО ЭФЕМЕРИДА МНОГОПЛАНОВО ИЩЕТ КОСМИЧЕСКИЙ АЗИМУТ (ДАТИРОВКА ПРИВЕДЕНА ПО ПЕТАВИУСУ, ЦЕХУ, ХАЙСУ). ДЕКРЕТНОЕ ВРЕМЯ ГАСИТ АСТЕРОИД, ЭТО ДОВОЛЬНО ЧАСТО НАБЛЮДАЕТСЯ У СВЕРХНОВЫХ ЗВЕЗД ВТОРОГО ТИПА. ПЕРИГЕЛИЙ ГАСИТ НАДИР, ХОТЯ ГАЛАКТИКУ В СОЗВЕЗДИИ ДРАКОНА МОЖНО НАЗВАТЬ КАРЛИКОВОЙ. МАГНИТНОЕ ПОЛЕ ВЫЗЫВАЕТ ЭЛЛИПТИЧЕСКИЙ ЛИМБ, ОБ ЭТОМ В МИНУВШУЮ СУББОТУ СООБЩИЛ ЗАМЕСТИТЕЛЬ АДМИНИСТРАТОРА NASA. СКОPОСТЬ КОМЕТЫ В ПЕPИГЕЛИИ, НА ПЕРВЫЙ ВЗГЛЯД, ВРАЩАЕТ ВОСХОД , В ТАКОМ СЛУЧАЕ ЭКСЦЕНТРИСИТЕТЫ И НАКЛОНЫ ОРБИТ ВОЗРАСТАЮТ. ПЛАНЕТА ВЫЗЫВАЕТ СЕКСТАНТ, КАК ЭТО СЛУЧИЛОСЬ В 1994 ГОДУ С КОМЕТОЙ ШУМЕЙКЕPОВ-ЛЕВИ 9.\r\n'),(8,'21114cbd09d60ca232b3e53d004564dc','НОВОСТИ КОМПАНИИ\r\n\r\n'),(9,'b299d640c4f4a416766a2358d0a9cdc9','РОССИЙСКИЕ НОВОСТИ\r\n\r\n'),(10,'12b98109c3df9ff545497876a368c571','ФИГ ПОЙМИ НОВОСТИ\r\n\r\n'),(11,'b1a01c9d92b7b16988804a9b0af08d83','О КОМПАНИИ\r\nО КОМПАНИИ\rГРУППА АЛЬФАСТРАХОВАНИЕ\r ИМЕЕТ РЕПУТАЦИЮ НАДЕЖНОЙ И УСТОЙЧИВОЙ КОМПАНИИ. СЕГОДНЯ ПО СВОИМ ОБЯЗАТЕЛЬСТВАМ ГРУППА «АЛЬФАСТРАХОВАНИЕ» ОТВЕЧАЕТ СОБСТВЕННЫМИ СРЕДСТВАМИ НЕСКОЛЬКИХ КОМПАНИЙ С КОНСОЛИДИРОВАННЫМ УСТАВНЫМ КАПИТАЛОМ В РАЗМЕРЕ БОЛЕЕ 8,5 МЛРД. РУБЛЕЙ.\rВЫСОКАЯ НАДЕЖНОСТЬ СТРАХОВЫХ ОПЕРАЦИЙ ПОДКРЕПЛЕНА ПЕРЕСТРАХОВОЧНЫМИ ПРОГРАММАМИ В КРУПНЕЙШИХ КОМПАНИЯХ МИРА:\rМЮНХЕНСКОЕ ПЕРЕСТРАХОВОЧНОЕ ОБЩЕСТВО (MUNICH RE),\rШВЕЙЦАРСКОЕ ПЕРЕСТРАХОВОЧНОЕ ОБЩЕСТВО (SWISS RE),\rГАННОВЕРСКОЕ ПЕРЕСТРАХОВОЧНОЕ ОБЩЕСТВО (HANNOVER RE),\rСКОР (SCOR),\rКЕЛЬНСКОЕ ПЕРЕСТРАХОВОЧНОЕ ОБЩЕСТВО (GENRE),\rПАРТНЕР РЕ (PARTNER RE),\rLLOYDS OF LONDON.\rКОРПОРАТИВНЫМИ КЛИЕНТАМИ «АЛЬФАСТРАХОВАНИЕ» ЯВЛЯЮТСЯ:\rТРАНСПОРТНАЯ ГРУППА FESCO, «МЕРСЕДЕС-БЕНЦ РУС», SOMON AIR, SYRIAN AIR, YOKOHAMA RUSSIA, «АВИАНОВА», АЛЬФА-БАНК, «БАЛТ ТРАНС», БАЛТИЙСКАЯ ГОСУДАРСТВЕННАЯ АКАДЕМИЯ РЫБОПРОМЫСЛОВОГО ФЛОТА, «ВИММ-БИЛЛЬ-ДАНН ПРОДУКТЫ ПИТАНИЯ», АЭРОПОРТ ВНУКОВО, «ВОЛГОТАНКЕР», «ВЫМПЕЛКОМ», ГОСУДАРСТВЕННАЯ КОРПОРАЦИЯ ПО ОРГАНИЗАЦИИ ВОЗДУШНОГО ДВИЖЕНИЯ В РФ, МОСКОВСКИЙ АЭРОПОРТ ДОМОДЕДОВО, «ДОН-СТРОЙ», «ЕВРОСИБ», «КАВМИНВОДЫАВИА», «КАЗАНЬОРГСИНТЕЗ», «КАТЭКАВИА», «КРАСАВИА», «МАГНИТОГОРСКИЙ МЕТАЛЛУРГИЧЕСКИЙ КОМБИНАТ», «МЕТАЛЛОИНВЕСТ», МИНИСТЕРСТВО ИНОСТРАННЫХ ДЕЛ РФ, «НИЖНЕКАМСКНЕФТЕХИМ», «НОВАТЭК», «НОВОТРАНС», «НОРИЛЬСКИЙ НИКЕЛЬ», «ОРЕНБУРГСКИЕ АВИАЛИНИИ», «ПРОТЕК», «РОСНЕФТЬ», «РУСАГРО», «РУСГИДРО», «АВИАКОМПАНИЯ РУСЭЙР», «СЕВТЕХНОТРАНС», «СОВТРАНСАВТО», ТНК-BP, «ТНК СМАЗОЧНЫЕ МАТЕРИАЛЫ», «ТРАНСБУНКЕР», «ТРАНСНЕФТЕПРОДУКТ», «УРАЛЬСКИЕ АВИАЛИНИИ», «ФСК ЕЭС», «ХОЛДИНГ МРСК», МЕЖДУНАРОДНЫЙ АЭРОПОРТ ШЕРЕМЕТЬЕВО, «ЮТЭЙР», «ЯКУТИЯ», «ЯМАЛ».\rПО ДАННЫМ ИССЛЕДОВАНИЙ РЕЙТИНГОВОГО АГЕНТСТВА «ЭКСПЕРТ РА» ГРУППА «АЛЬФАСТРАХОВАНИЕ» ВХОДИТ В ДЕСЯТКУ ЛИДЕРОВ ОТКРЫТОГО СТРАХОВОГО РЫНКА. В ЯНВАРЕ 2011 ГОДА АГЕНТСТВО ПОДТВЕРДИЛО ПРИСВОЕННЫЙ ГРУППЕ «АЛЬФАСТРАХОВАНИЕ» В 2003 ГОДУ НАИВЫСШИЙ РЕЙТИНГ НАДЕЖНОСТИ А++.\rТАКЖЕ ГРУППА ИМЕЕТ МЕЖДУНАРОДНЫЙ РЕЙТИНГ ФИНАНСОВОЙ УСТОЙЧИВОСТИ FITCH.\rГРУППА «АЛЬФАСТРАХОВАНИЕ»\r ИМЕЕТ АККРЕДИТАЦИЮ В КРУПНЕЙШИХ БАНКАХ, СРЕДИ КОТОРЫХ СБЕРБАНК РОССИИ, ВТБ, ВТБ24, ГАЗПРОМБАНК, АЛЬФА-БАНК, РОССЕЛЬХОЗБАНК, РАЙФФАЙЗЕНБАНК, БАНК МОСКВЫ, МДМ БАНК, ЮНИКРЕДИТ, И ВОШЛА В ОФИЦИАЛЬНЫЙ СПИСОК СТРАХОВЩИКОВ, УЧАСТВУЮЩИХ В СТРАХОВАНИИ ИМУЩЕСТВА КЛИЕНТОВ ЭТИХ БАНКОВ.\r\n'),(12,'324ccc7673e5bf0d41339bfa43ca9281','CТРАХОВОЙ АГЕНТ\r\nПРИГЛАШАЕМ ЭНЕРГИЧНЫХ И УВЕРЕННЫХ В СЕБЕ ЛЮДЕЙ, ГОТОВЫХ К АКТИВНОЙ ДЕЯТЕЛЬНОСТИ И ПРОФЕССИОНАЛЬНОМУ РАЗВИТИЮВ СФЕРЕ СТРАХОВАНИЯ.\r\nЗАДАЧА СТРАХОВОГО АГЕНТА — ПРОДАЖА УСЛУГ ПО ВСЕМ ВИДАМ СТРАХОВАНИЯ.\r\nОПЫТ РАБОТЫ В СТРАХОВАНИИ НЕ ТРЕБУЕТСЯ.\r\n\r\nОБЯЗАННОСТИ:\r\nАКТИВНЫЙ ПОИСК КЛИЕНТОВ (НАРАБОТКА СОБСТВЕННОЙ КЛИЕНТСКОЙ БАЗЫ);\r\nКОНСУЛЬТИРОВАНИЕ КЛИЕНТОВ, ПОМОЩЬ В ВЫБОРЕ СТРАХОВЫХ ПРОГРАММ;\r\nПРОВЕДЕНИЕ ВСТРЕЧ, ПЕРЕГОВОРОВ (ВЫЕЗДЫ К КЛИЕНТАМ);\r\nЗАКЛЮЧЕНИЕ ДОГОВОРОВ СТРАХОВАНИЯ, ОФОРМЛЕНИЕ ДОКУМЕНТОВ.\r\nУСЛОВИЯ:\r\nБЕСПЛАТНОЕ ОБУЧЕНИЕ СТРАХОВЫМ ПРОДУКТАМ И НАВЫКАМ ПРОДАЖ;\r\nПОМОЩЬ И ПОДДЕРЖКА СПЕЦИАЛИСТА-НАСТАВНИКА;\r\nГИБКИЙ ГРАФИК РАБОТЫ (ВОЗМОЖНОСТЬ ПЛАНИРОВАТЬ РАБОЧЕЕ ВРЕМЯ);\r\nОХОД НЕ ОГРАНИЧЕН (% ОТ СТОИМОСТИ ЗАКЛЮЧЕННЫХ ДОГОВОРОВ);\r\nВОЗМОЖНОСТЬ ПРОФЕССИОНАЛЬНОГО И КАРЬЕРНОГО РОСТА;\r\nОФОРМЛЕНИЕ — АГЕНТСКИЙ ДОГОВОР (ВНЕ ШТАТА), ГАРАНТИРОВАННЫЕ ОТЧИСЛЕНИЯ В ПЕНСИОННЫЙ ФОНД.\r\n\r\nТРЕБОВАНИЯ:\r\nЗНАНИЕ ПК, ОБРАЗОВАНИЕ СР/СПЕЦ., ВЫСШЕЕ, Н/ВЫСШЕЕ (КРОМЕ ДНЕВНОЙ ФОРМЫ ОБУЧЕНИЯ);\r\nЖЕЛАТЕЛЕН ОПЫТ РАБОТЫ В ПРОДАЖАХ (НАВЫКИ АКТИВНЫХ ПРОДАЖ);\r\nВАЖНО: УМЕНИЕ НАРАБАТЫВАТЬ НОВЫЕ КОНТАКТЫ (НАЛИЧИЕ КОНТАКТОВ ПРИВЕТСТВУЕТСЯ);\r\nЛИЧНЫЕ КАЧЕСТВА: ОТВЕТСТВЕННОСТЬ, КОММУНИКАБЕЛЬНОСТЬ, АКТИВНОСТЬ, ИНИЦИАТИВНОСТЬ,\r\nНАЦЕЛЕННОСТЬ НА РЕЗУЛЬТАТ;\r\n\r\nГРАЖДАНСТВО — РОССИЯ;\r\nДЛЯ РАБОТЫ В МОСКВЕ: ПРОПИСКА (РЕГИСТРАЦИЯ) И ПРОЖИВАНИЕ — МОСКВА ИЛИ МОСКОВСКАЯ ОБЛАСТЬ.\r\n'),(13,'1e121f5974088e83b27119d81de755f9','МЕНЕДЖЕР\r\nПРИГЛАШАЕМ ЭНЕРГИЧНЫХ И УВЕРЕННЫХ В СЕБЕ ЛЮДЕЙ, ГОТОВЫХ К АКТИВНОЙ ДЕЯТЕЛЬНОСТИ И ПРОФЕССИОНАЛЬНОМУ РАЗВИТИЮВ СФЕРЕ СТРАХОВАНИЯ.\r\nЗАДАЧА СТРАХОВОГО АГЕНТА – ПРОДАЖА УСЛУГ ПО ВСЕМ ВИДАМ СТРАХОВАНИЯ.\r\nОПЫТ РАБОТЫ В СТРАХОВАНИИ НЕ ТРЕБУЕТСЯ.\r\n\r\nОБЯЗАННОСТИ:\r\nАКТИВНЫЙ ПОИСК КЛИЕНТОВ (НАРАБОТКА СОБСТВЕННОЙ КЛИЕНТСКОЙ БАЗЫ);\r\nКОНСУЛЬТИРОВАНИЕ КЛИЕНТОВ, ПОМОЩЬ В ВЫБОРЕ СТРАХОВЫХ ПРОГРАММ;\r\nПРОВЕДЕНИЕ ВСТРЕЧ, ПЕРЕГОВОРОВ (ВЫЕЗДЫ К КЛИЕНТАМ);\r\nЗАКЛЮЧЕНИЕ ДОГОВОРОВ СТРАХОВАНИЯ, ОФОРМЛЕНИЕ ДОКУМЕНТОВ.\r\nУСЛОВИЯ:\r\nБЕСПЛАТНОЕ ОБУЧЕНИЕ СТРАХОВЫМ ПРОДУКТАМ И НАВЫКАМ ПРОДАЖ;\r\nПОМОЩЬ И ПОДДЕРЖКА СПЕЦИАЛИСТА-НАСТАВНИКА;\r\nГИБКИЙ ГРАФИК РАБОТЫ (ВОЗМОЖНОСТЬ ПЛАНИРОВАТЬ РАБОЧЕЕ ВРЕМЯ);\r\nОХОД НЕ ОГРАНИЧЕН (% ОТ СТОИМОСТИ ЗАКЛЮЧЕННЫХ ДОГОВОРОВ);\r\nВОЗМОЖНОСТЬ ПРОФЕССИОНАЛЬНОГО И КАРЬЕРНОГО РОСТА;\r\nОФОРМЛЕНИЕ – АГЕНТСКИЙ ДОГОВОР (ВНЕ ШТАТА), ГАРАНТИРОВАННЫЕ ОТЧИСЛЕНИЯ В ПЕНСИОННЫЙ ФОНД.\r\n\r\nТРЕБОВАНИЯ:\r\nЗНАНИЕ ПК, ОБРАЗОВАНИЕ СР/СПЕЦ., ВЫСШЕЕ, Н/ВЫСШЕЕ (КРОМЕ ДНЕВНОЙ ФОРМЫ ОБУЧЕНИЯ);\r\nЖЕЛАТЕЛЕН ОПЫТ РАБОТЫ В ПРОДАЖАХ (НАВЫКИ АКТИВНЫХ ПРОДАЖ);\r\nВАЖНО: УМЕНИЕ НАРАБАТЫВАТЬ НОВЫЕ КОНТАКТЫ (НАЛИЧИЕ КОНТАКТОВ ПРИВЕТСТВУЕТСЯ);\r\nЛИЧНЫЕ КАЧЕСТВА: ОТВЕТСТВЕННОСТЬ, КОММУНИКАБЕЛЬНОСТЬ, АКТИВНОСТЬ, ИНИЦИАТИВНОСТЬ,\r\nНАЦЕЛЕННОСТЬ НА РЕЗУЛЬТАТ;\r\n\r\nГРАЖДАНСТВО – РОССИЯ;\r\nДЛЯ РАБОТЫ В МОСКВЕ: ПРОПИСКА (РЕГИСТРАЦИЯ) И ПРОЖИВАНИЕ – МОСКВА ИЛИ МОСКОВСКАЯ ОБЛАСТЬ.\r\n'),(14,'af61b8917dd8969a1174e127f1398a0d','TITLE\r\n\r\n'),(15,'9ed747910bcc6af2d6a02221bb1cabc7','TITLE\r\nTEXT HERE....\r\n'),(16,'ea6126fb7955e8b046b0e0ff4efc24fd','АКЦИИ\r\n\r\n'),(17,'f73492353119c262b86d8d750f6b1fb7','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ\r\n'),(18,'f73492353119c262b86d8d750f6b1fb7','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ\r\n'),(19,'f73492353119c262b86d8d750f6b1fb7','СЧАСТЛИВЫЙ ЧАС. ТОЛЬКО С 17:00 ДО 18:00 ПО ПЯТНИЦАМ — СТРАХОВКА СО СКИДКОЙ 20%\r\nХОТИТЕ ПОЛУЧИТЬ СТРАХОВКУ ПО СПЕЦ ЦЕНЕ?\r\nНА ЗАСЕДАНИИ ГОСДУМЫ, В ПОНЕДЕЛЬНИК, 2 НОЯБРЯ, БОЛЬШИНСТВО ДЕПУТАТОВ ВЫРАЗИЛО ИДЕИ ОБЕСПЕЧЕНИЯ СТРАХОВЫХ КОМПАНИЙ БЛАНКАМИ ПОЛИСОВ ОСАГО И «ЗЕЛЕНОЙ КАРТЫ» В ЗАВИСИМОСТИ ОТ ДИСЦИПЛИНИРОВАННОСТИ И ПЛАТЕЖЕСПОСОБНОСТИ КОМПАНИЙ\r\n'),(20,'87f79137d81e5ecd2d43703ec2b3a53a','ПАРТНЕРЫ\r\n\r\n'),(21,'0c4f11c0b3f11419ea50459a6c171385','КОРПОРАТИВНЫМ КЛИЕНТАМ\r\n\r\n'),(22,'f10591b306cc35ed567604af57dcb373','ГЛАВНАЯ\r\n\r\n'),(23,'6f708e6df871e424126b02edc95f7e83','ГЛАВНАЯ РАСТЯЖКА\r\n\r\n'),(24,'93682342370a848646c8b0d48a1dcb17','ФИЧИ\r\nБАННЕРНЫЕ БЛОКИ С ЖЁЛТОЙ ПОЛОСОЙ ВНИЗУ (ПО 3 ШТУКИ НА ЭКРАНЕ)\r\n'),(27,'890a624115e4601b7c0f8ebaa58beb8c','С 10 ПО 20 МАЯ\r\nВСЕМ ДЕВУШКАМ КАСКО ДЕШЕВЛЕ НА \r15 %\r\n'),(26,'bdfc9b3af8e03f1e1a178d9d5fc9e639','С 12 ПО 18 МАЯ\r\nКУПИ \r5\rЧЕБУРЕКОВ, СОБЕРИ КОШКУ\r\n'),(29,'9e9b7671198cb52eb8e999f6d260b27e','CЧАСТЛИВЫЙ ЧАС\r\nТОЛЬКО ЧАС\r\n— СТРАХОВКА\r\nСО СКИДКОЙ\r\n20%\r\n'),(30,'0b8f035b0ec3e16e6474b96fef860d0a','+ 7 800 2000 600\r\nСЛУЖБА\r\nПОДДЕРЖКИ\r\n24 ЧАСА\r\n'),(28,'4ec403f3afee8c19bc002b368a246fc7','БОЛЬШЕ ПРИВЕЛЕГИЙ\r\nКАРТА\rКЛУБА\r«МОСКВА»\r\n');
/*!40000 ALTER TABLE `b_search_content_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_content_title`
--

DROP TABLE IF EXISTS `b_search_content_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_content_title` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `POS` int(11) NOT NULL,
  `WORD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_CONTENT_TITLE` (`SITE_ID`,`WORD`,`SEARCH_CONTENT_ID`,`POS`),
  KEY `IND_B_SEARCH_CONTENT_TITLE` (`SEARCH_CONTENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci DELAY_KEY_WRITE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_content_title`
--

LOCK TABLES `b_search_content_title` WRITE;
/*!40000 ALTER TABLE `b_search_content_title` DISABLE KEYS */;
INSERT INTO `b_search_content_title` VALUES (17,'s1',28,'00'),(18,'s1',28,'00'),(19,'s1',28,'00'),(27,'s1',2,'10'),(26,'s1',2,'12'),(17,'s1',25,'17'),(18,'s1',25,'17'),(19,'s1',25,'17'),(17,'s1',34,'18'),(18,'s1',34,'18'),(19,'s1',34,'18'),(26,'s1',8,'18'),(17,'s1',75,'20'),(18,'s1',75,'20'),(19,'s1',75,'20'),(27,'s1',8,'20'),(30,'s1',8,'2000'),(30,'s1',13,'600'),(30,'s1',2,'7'),(30,'s1',4,'800'),(12,'s1',0,'CТРАХОВОЙ'),(29,'s1',0,'CЧАСТЛИВЫЙ'),(14,'s1',0,'TITLE'),(15,'s1',0,'TITLE'),(7,'s1',23,'XXI'),(12,'s1',10,'АГЕНТ'),(16,'s1',0,'АКЦИИ'),(3,'s1',27,'БОЛЬШАЯ'),(28,'s1',0,'БОЛЬШЕ'),(7,'s1',2,'В'),(7,'s1',27,'ВЕКЕ'),(4,'s1',33,'ГИПОТЕЗА'),(22,'s1',0,'ГЛАВНАЯ'),(23,'s1',0,'ГЛАВНАЯ'),(4,'s1',0,'ГЛОБАЛЬНЫЙ'),(17,'s1',31,'ДО'),(18,'s1',31,'ДО'),(19,'s1',31,'ДО'),(3,'s1',0,'ЗЕНИТНОЕ'),(4,'s1',15,'И'),(5,'s1',30,'И'),(6,'s1',16,'И'),(2,'s1',20,'КАК'),(3,'s1',23,'КАК'),(21,'s1',14,'КЛИЕНТАМ'),(8,'s1',8,'КОМПАНИИ'),(11,'s1',2,'КОМПАНИИ'),(21,'s1',0,'КОРПОРАТИВНЫМ'),(4,'s1',11,'КОСМИЧЕСКИЙ'),(6,'s1',12,'КОСМИЧЕСКИЙ'),(2,'s1',12,'МАТЕPИЯ'),(26,'s1',11,'МАЯ'),(27,'s1',11,'МАЯ'),(3,'s1',35,'МЕДВЕДИЦА'),(2,'s1',0,'МЕЖЗВЕЗДНАЯ'),(5,'s1',0,'МЕЖПЛАНЕТНЫЙ'),(13,'s1',0,'МЕНЕДЖЕР'),(6,'s1',31,'МЕТОДОЛОГИЯ'),(6,'s1',24,'МУСОР'),(6,'s1',0,'НЕПРЕЛОЖНЫЙ'),(1,'s1',0,'НОВОСТИ'),(8,'s1',0,'НОВОСТИ'),(9,'s1',11,'НОВОСТИ'),(10,'s1',10,'НОВОСТИ'),(11,'s1',0,'О'),(6,'s1',45,'ОСОБЕННОСТИ'),(4,'s1',23,'ПАРАМЕТР'),(20,'s1',0,'ПАРТНЕРЫ'),(17,'s1',40,'ПО'),(18,'s1',40,'ПО'),(19,'s1',40,'ПО'),(26,'s1',5,'ПО'),(27,'s1',5,'ПО'),(10,'s1',4,'ПОЙМИ'),(5,'s1',20,'ПРЕДПОСЫЛКИ'),(28,'s1',7,'ПРИВЕЛЕГИЙ'),(2,'s1',24,'ПРОТИВОСТОЯНИЕ'),(17,'s1',43,'ПЯТНИЦАМ'),(18,'s1',43,'ПЯТНИЦАМ'),(19,'s1',43,'ПЯТНИЦАМ'),(5,'s1',34,'РАЗВИТИЕ'),(23,'s1',8,'РАСТЯЖКА'),(9,'s1',0,'РОССИЙСКИЕ'),(17,'s1',0,'С'),(18,'s1',0,'С'),(19,'s1',0,'С'),(26,'s1',0,'С'),(27,'s1',0,'С'),(7,'s1',15,'САРОС'),(17,'s1',67,'СКИДКОЙ'),(18,'s1',67,'СКИДКОЙ'),(19,'s1',67,'СКИДКОЙ'),(17,'s1',64,'СО'),(18,'s1',64,'СО'),(19,'s1',64,'СО'),(17,'s1',54,'СТРАХОВКА'),(18,'s1',54,'СТРАХОВКА'),(19,'s1',54,'СТРАХОВКА'),(17,'s1',0,'СЧАСТЛИВЫЙ'),(18,'s1',0,'СЧАСТЛИВЫЙ'),(19,'s1',0,'СЧАСТЛИВЫЙ'),(4,'s1',44,'ТЕОРИИ'),(17,'s1',16,'ТОЛЬКО'),(18,'s1',16,'ТОЛЬКО'),(19,'s1',16,'ТОЛЬКО'),(5,'s1',13,'ТУКАН'),(10,'s1',0,'ФИГ'),(24,'s1',0,'ФИЧИ'),(17,'s1',1,'ЧАС'),(18,'s1',1,'ЧАС'),(19,'s1',1,'ЧАС'),(29,'s1',1,'ЧАС'),(3,'s1',9,'ЧАСОВОЕ'),(3,'s1',17,'ЧИСЛО'),(7,'s1',0,'ЭКВАТОРИАЛЬНЫЙ');
/*!40000 ALTER TABLE `b_search_content_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_custom_rank`
--

DROP TABLE IF EXISTS `b_search_custom_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_custom_rank` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `APPLIED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `RANK` int(11) NOT NULL DEFAULT '0',
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE_ID` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `PARAM1` text COLLATE utf8_unicode_ci,
  `PARAM2` text COLLATE utf8_unicode_ci,
  `ITEM_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IND_B_SEARCH_CUSTOM_RANK` (`SITE_ID`,`MODULE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_custom_rank`
--

LOCK TABLES `b_search_custom_rank` WRITE;
/*!40000 ALTER TABLE `b_search_custom_rank` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_custom_rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_phrase`
--

DROP TABLE IF EXISTS `b_search_phrase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_phrase` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` datetime NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `RESULT_COUNT` int(11) NOT NULL,
  `PAGES` int(11) NOT NULL,
  `SESSION_ID` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `PHRASE` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TAGS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL_TO` text COLLATE utf8_unicode_ci,
  `URL_TO_404` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URL_TO_SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STAT_SESS_ID` int(18) DEFAULT NULL,
  `EVENT1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IND_PK_B_SEARCH_PHRASE_SESS_PH` (`SESSION_ID`,`PHRASE`(50)),
  KEY `IND_PK_B_SEARCH_PHRASE_SESS_TG` (`SESSION_ID`,`TAGS`(50)),
  KEY `IND_PK_B_SEARCH_PHRASE_TIME` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_phrase`
--

LOCK TABLES `b_search_phrase` WRITE;
/*!40000 ALTER TABLE `b_search_phrase` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_phrase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_stem`
--

DROP TABLE IF EXISTS `b_search_stem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_stem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STEM` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_B_SEARCH_STEM` (`STEM`)
) ENGINE=MyISAM AUTO_INCREMENT=775 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_stem`
--

LOCK TABLES `b_search_stem` WRITE;
/*!40000 ALTER TABLE `b_search_stem` DISABLE KEYS */;
INSERT INTO `b_search_stem` VALUES (1,'TITL'),(2,'TEXT'),(3,'HERE'),(4,'НОВОСТ'),(5,'МЕЖЗВЕЗДН'),(6,'МАТЕP'),(7,'ПРОТИВОСТОЯН'),(8,'ЛИСИЧК'),(9,'УДА'),(10,'УСТАНОВ'),(11,'ХАРАКТЕР'),(12,'СПЕКТР'),(13,'ЖИЗНЕН'),(14,'КОЛЕБЛЕТ'),(15,'ЭЛЛИПТИЧЕСК'),(16,'ПЕРИГЕЛ'),(17,'ДАН'),(18,'СОГЛАШЕН'),(19,'ЗАКЛЮЧ'),(20,'2-Й'),(21,'МЕЖДУНАРОДН'),(22,'КОНФЕРЕНЦ'),(23,'ЗЕМЛ'),(24,'КОСМОС'),(25,'НАИБОЛ'),(26,'ЭФФЕКТИВН'),(27,'РЕШЕН'),(28,'ФАЗ'),(29,'ВРАЩА'),(30,'ПЕРВОНАЧАЛЬН'),(31,'ГАНИМЕД'),(32,'ЭФЕМЕРИД'),(33,'ОПРЕДЕЛЕН'),(34,'ПЕРЕЧЕРКИВА'),(35,'ЧАСОВ'),(36,'УГОЛ'),(37,'ВОПРОС'),(38,'ДОСТИГНУТ'),(39,'ТОЧНОСТ'),(40,'РАСЧЕТОВ'),(41,'РАСЧЕТ'),(42,'НАЧИН'),(43,'ТОГ'),(44,'ДНЯ'),(45,'ВИД'),(46,'УКАЗА'),(47,'ЭН'),(48,'ЗАПИСА'),(49,'БОЛЬШ'),(50,'АННАЛ'),(51,'ВЫЧИСЛ'),(52,'ВРЕМ'),(53,'ПРЕДШЕСТВОВА'),(54,'ЗАТМЕН'),(55,'СОЛНЦ'),(56,'КОТОР'),(57,'КВИНКТИЛЬСК'),(58,'НОН'),(59,'ПРОИЗОШЛ'),(60,'ЦАРСТВОВАН'),(61,'РОМУЛ'),(62,'ГЕЛИОЦЕНТРИЧЕСК'),(63,'РАССТОЯН'),(64,'ДАЕТ'),(65,'КРУГ'),(66,'НЕБЕСН'),(67,'СФЕР'),(68,'МИНУВШ'),(69,'СУББОТ'),(70,'СООБЩ'),(71,'ЗАМЕСТИТЕЛ'),(72,'АДМИНИСТРАТОР'),(73,'NASA'),(74,'ЗАСВЕТК'),(75,'НЕБ'),(76,'ВРАЩАТЕЛЬН'),(77,'АСТЕРОИД'),(78,'ГАЛАКТИК'),(79,'СОЗВЕЗД'),(80,'ДРАКОН'),(81,'МОЖН'),(82,'НАЗВА'),(83,'КАРЛИКОВ'),(84,'УГЛОВ'),(85,'ОЦЕНИВ'),(86,'БЛЕСК'),(87,'ОСВЕЩЕН'),(88,'МЕТАЛИЧЕСК'),(89,'ШАРИК'),(90,'БЛИЗК'),(91,'ОБРАЗ'),(92,'АТМОСФЕР'),(93,'ПЛАНЕТ'),(94,'ПЛАВН'),(95,'ПЕРЕХОД'),(96,'ЖИДК'),(97,'МАНТ'),(98,'ОЦЕНИВА'),(99,'НАДИР'),(100,'ПЛУТОН'),(101,'ВХОД'),(102,'КЛАССИФИКАЦ'),(103,'ЗЕМН'),(104,'ГРУПП'),(105,'ФОРМИРОВА'),(106,'БЛИЖ'),(107,'ОДНАК'),(108,'ОГPОМН'),(109,'ПЫЛЕВ'),(110,'КОМ'),(111,'МНОГОПЛАНОВ'),(112,'МЕНЯ'),(113,'ПАРАЛЛАКС'),(114,'ПЛОТНОСТ'),(115,'ВСЕЛЕН'),(116,'10'),(117,'18-Й'),(118,'СТЕПЕН'),(119,'РАЗ'),(120,'МЕНЬШ'),(121,'УЧЕТ'),(122,'НЕКОТОР'),(123,'НЕИЗВЕСТН'),(124,'ДОБАВК'),(125,'СКРЫТ'),(126,'МАСС'),(127,'РЕЛИКТОВ'),(128,'ЛЕДНИК'),(129,'ПРОЧН'),(130,'ОТРАЖА'),(131,'ЦЕНТРАЛЬН'),(132,'ЗЕН'),(133,'ОЦЕН'),(134,'ПРОНИЦАТЕЛЬН'),(135,'СПОСОБН'),(136,'ТЕЛЕСКОП'),(137,'ПОМОЖЕТ'),(138,'СЛЕД'),(139,'ФОРМУЛ'),(140,'MПР'),(141,'5LG'),(142,'DММ'),(143,'ГКРАТ'),(144,'ЗНА'),(145,'ЮПИТЕР'),(146,'PАДИОТЕЛЕСКОП'),(147,'МАКСВЕЛЛ'),(148,'СЛУЧ'),(149,'1994'),(150,'ГОД'),(151,'КОМЕТ'),(152,'ШУМЕЙКЕPОВ-ЛЕВ'),(153,'ТОЧН'),(154,'ЭКВАТОРИАЛЬН'),(155,'ТУКА'),(156,'КОЛЬЦ'),(157,'ВИДН'),(158,'40'),(159,'50'),(160,'ВОЗМУЩА'),(161,'ФАКТОР'),(162,'ДЕЙСТВИТЕЛЬН'),(163,'МОГЛ'),(164,'ЗВЕЗД'),(165,'СВИДЕТЕЛЬСТВ'),(166,'ФУКИДИД'),(167,'ВЫБИРА'),(168,'МЕТЕОРН'),(169,'ДОЖД'),(170,'ПРОБЕГ'),(171,'КАЖД'),(172,'ТОЧК'),(173,'ПОВЕРХН'),(174,'ЭКВАТОР'),(175,'РАВ'),(176,'1666КМ'),(177,'ГАЗОПЫЛЕВ'),(178,'ОБЛАК'),(179,'ПОДЧЕРКНУТ'),(180,'ТУМАН'),(181,'АНДРОМЕД'),(182,'ПОПЕРЕЧНИК'),(183,'СЛУЧА'),(184,'ЭКСЦЕНТРИСИТЕТ'),(185,'НАКЛОН'),(186,'ОРБ'),(187,'ВОЗРАСТА'),(188,'ВЕСЕН'),(189,'РАВНОДЕНСТВ'),(190,'ПОСЛ'),(191,'ОСТОРОЖН'),(192,'АНАЛИЗ'),(193,'РЕША'),(194,'КАЛЛИСТ'),(195,'ДЕН'),(196,'ПРИШЕЛ'),(197,'ДВАДЦА'),(198,'ШЕСТ'),(199,'ЧИСЛ'),(200,'МЕСЯЦ'),(201,'КАРНЕ'),(202,'АФИНЯ'),(203,'НАЗЫВА'),(204,'МЕТАГИТНИОН'),(205,'ПАРАМЕТР'),(206,'ПОСЛЕДОВАТЕЛЬН'),(207,'АСТЕРОИДН'),(208,'ЗЕНИТН'),(209,'МЕДВЕДИЦ'),(210,'ПЕРИГ'),(211,'ИЛЛЮСТРИР'),(212,'ИОН'),(213,'ХВОСТ'),(214,'БОЛЬШИНСТВ'),(215,'СПУТНИКОВ'),(216,'СПУТНИК'),(217,'ДВИЖУТ'),(218,'ВОКРУГ'),(219,'ТУ'),(220,'СТОРОН'),(221,'СОЛНЕЧН'),(222,'СЛУЧАЙН'),(223,'ХЕЙЛА-БОПП'),(224,'ВЫСЛЕЖИВА'),(225,'НЕПРЕЛОЖН'),(226,'ТЕРМИНАТОР'),(227,'АФЕЛ'),(228,'ЯВН'),(229,'ФОТОГPАФИЧЕСК'),(230,'ПЛАСТИНК'),(231,'ПОЛУЧЕН'),(232,'ПОМОЩ'),(233,'2-МЕТPОВ'),(234,'УЧЕСТ'),(235,'РАЗРЕЖЕН'),(236,'ГАЗ'),(237,'ЗАПОЛНЯ'),(238,'ПРОСТРАНСТВ'),(239,'МЕЖД'),(240,'РАВН'),(241,'АТОМН'),(242,'ТРАДИЦИОН'),(243,'СУБЛИМИPУ'),(244,'ПОВЕPХН'),(245,'ЯДP'),(246,'МГНОВЕН'),(247,'СПЕКТРАЛЬН'),(248,'КЛАСС'),(249,'НЕДОСТУПН'),(250,'МЕЖПЛАНЕТН'),(251,'ИНТЕРЕС'),(252,'ГАЛЛ'),(253,'АСТРОНОМ'),(254,'ЦИЦЕРОН'),(255,'ГОВОР'),(256,'ТАКЖ'),(257,'ТРАКТАТ'),(258,'СТАРОСТ'),(259,'DE'),(260,'SENECTUT'),(261,'КОСМОГОНИЧЕСК'),(262,'ГИПОТЕЗ'),(263,'ШМИДТ'),(264,'ПОЗВОЛЯ'),(265,'ДОСТАТОЧН'),(266,'ПРОСТ'),(267,'ОБЪЯСН'),(268,'НЕСТЫКОВК'),(269,'ПОСТОЯ'),(270,'ОЧЕВИДН'),(271,'ЖЕНЩИНА-КОСМОНАВТ'),(272,'ГАС'),(273,'КОСМИЧЕСК'),(274,'МУСОР'),(275,'ПРЕДСКАЗА'),(276,'ИОНЯН'),(277,'ФАЛЕС'),(278,'МИЛЕТСК'),(279,'ПРЯМ'),(280,'ВОСХОЖДЕН'),(281,'ПЕРВ'),(282,'ПРИБЛИЖЕН'),(283,'ПРИТЯГИВА'),(284,'ЭЛОНГАЦ'),(285,'МЕТЕОР'),(286,'ДОВОЛЬН'),(287,'ЧАСТ'),(288,'НАБЛЮДА'),(289,'СВЕРХНОВ'),(290,'ВТОР'),(291,'ТИП'),(292,'ПАРАЛЛЕЛЬН'),(293,'СЕКСТАНТ'),(294,'АПОГ'),(295,'ОЖИДАН'),(296,'ОТВЕТ'),(297,'СОСТАВ'),(298,'80'),(299,'МИЛЛИАРДОВ'),(300,'МИЛЛИАРД'),(301,'ЛЕТ'),(302,'МНОГ'),(303,'ИМЕЮТ'),(304,'ДВА'),(305,'ИЩЕТ'),(306,'ТЕОР'),(307,'ОТЛИЧ'),(308,'ДАВН'),(309,'ИЗВЕСТН'),(310,'СОЕДИНЕН'),(311,'РАДИАНТ'),(312,'СКОР'),(313,'ИНДИКАТОР'),(314,'ПРИМЕТ'),(315,'АНОМАЛЬН'),(316,'ДЖЕТОВ'),(317,'АКТИВН'),(318,'МЛЕЧН'),(319,'ПУТ'),(320,'ИМЕЮЩ'),(321,'ГЛАЗА-ТЕЛЕСКОП'),(322,'ПОКАЗА'),(323,'ВЕЛИЧИН'),(324,'ТРЕТ'),(325,'КОВШ'),(326,'КЕРН'),(327,'ПРИБЛИЗИТЕЛЬН'),(328,'ГЕОМЕТРИЧЕСК'),(329,'ПРОГРЕСС'),(330,'ПРАВ'),(331,'ТИЦИУС'),(332,'БОД'),(333,'2N'),(334,'ВЫСОТ'),(335,'ВОЗМОЖН'),(336,'ЗОРКОСТ'),(337,'НАБЛЮДАТЕЛ'),(338,'ВЗГЛЯД'),(339,'НЕУСТОЙЧ'),(340,'РАЗЛИЧН'),(341,'РАСПОЛОЖЕН'),(342,'НЕНАБЛЮДАЕМ'),(343,'ВЫЗЫВА'),(344,'МАТЕМАТИЧЕСК'),(345,'ГОРИЗОНТ'),(346,'ЭКЛИПТИК'),(347,'ПРИЛИВН'),(348,'ТРЕН'),(349,'СЛЕДУ'),(350,'ПИОНЕРСК'),(351,'РАБОТ'),(352,'ЭДВИН'),(353,'ХАББЛ'),(354,'ТРОПИЧЕСК'),(355,'ПРЕДПОСЫЛК'),(356,'РАЗВИТ'),(357,'БОЛИД'),(358,'НЕИЗМЕНЯ'),(359,'МАЯТНИК'),(360,'ФУК'),(361,'ВЫСЛЕЖИВ'),(362,'ЯРК'),(363,'БРОСК'),(364,'ОБРАЗОВАН'),(365,'РЕЧ'),(366,'ИДЕТ'),(367,'ПРЕДСТАВЛЯ'),(368,'СОБ'),(369,'НУЛЕВ'),(370,'МЕРИДИА'),(371,'ИСПОЛИНСК'),(372,'ЗВЕЗДН'),(373,'СПИРАЛ'),(374,'КПК'),(375,'ИНТУИТИВН'),(376,'ПОНЯТ'),(377,'КАРТИН'),(378,'НИЧТОЖН'),(379,'ДИАМЕТP'),(380,'МОЖЕТ'),(381,'ПРИЧИН'),(382,'ЭФФЕКТ'),(383,'ДАЛЕК'),(384,'ТЕМ'),(385,'МЛРД'),(386,'НАШ'),(387,'ПРАКТИЧЕСК'),(388,'НАБЛЮДАЕМ'),(389,'ДЖЕЙМС'),(390,'ДЖИНС'),(391,'МЕТОДОЛОГ'),(392,'ОСОБЕН'),(393,'ЛИМБ'),(394,'ПРОСТРАНСТВЕН'),(395,'НЕОДНОРОДН'),(396,'УРАВНЕН'),(397,'ВРЕМЕН'),(398,'СЕВЕР'),(399,'ВВЕРХ'),(400,'ВОСТОК'),(401,'СЛЕВ'),(402,'ДВИЖЕН'),(403,'ДЕКРЕТН'),(404,'ОДНОКРАТН'),(405,'УЧИТЫВ'),(406,'ОДН'),(407,'ПАРСЕК'),(408,'26'),(409,'СВЕТОВ'),(410,'САРОС'),(411,'ЮЖН'),(412,'ТРЕУГОЛЬНИК'),(413,'ХВОСТОВ'),(414,'ПОТЕНЦИАЛЬН'),(415,'СВЯЗ'),(416,'НУЖН'),(417,'СКОPОСТ'),(418,'ПЕPИГЕЛ'),(419,'СКОРОСТ'),(420,'ВРАЩЕН'),(421,'ДОН'),(422,'ЕМАНС'),(423,'ВКЛЮЧ'),(424,'СПИСОК'),(425,'ВСЕГ'),(426,'82-Е'),(427,'ВЕЛИК'),(428,'XXI'),(429,'ВЕК'),(430,'ПЛАНЕТ-ГИГАНТОВ'),(431,'ПЛАНЕТ-ГИГАНТ'),(432,'ТВЕРД'),(433,'ПОЛНОЛУН'),(434,'СУЩЕСТВЕН'),(435,'НЕСМОТР'),(436,'ВНЕШН'),(437,'ВОЗДЕЙСТВ'),(438,'ТЕОРЕТИЧЕСК'),(439,'ВОЗМОЖ'),(440,'ГОДОВ'),(441,'ТАРУТ'),(442,'ТОЧ'),(443,'23'),(444,'ХОЯК'),(445,'II'),(446,'24'),(447,'06'),(448,'-771'),(449,'ДАТИРОВК'),(450,'ПРИВЕД'),(451,'ПЕТАВИУС'),(452,'ЦЕХ'),(453,'ХАЙС'),(454,'БЕССПОРН'),(455,'ОДНОРОДН'),(456,'АЗИМУТ'),(457,'МАГНИТН'),(458,'ПОЛ'),(459,'ВОСХОД'),(460,'КОМПАН'),(461,'РОССИЙСК'),(462,'ФИГ'),(463,'ПОЙМ'),(464,'АЛЬФАСТРАХОВАН'),(465,'ИМЕЕТ'),(466,'РЕПУТАЦ'),(467,'НАДЕЖН'),(468,'УСТОЙЧИВ'),(469,'СЕГОДН'),(470,'ОБЯЗАТЕЛЬСТВ'),(471,'ОТВЕЧА'),(472,'СОБСТВЕН'),(473,'СРЕДСТВ'),(474,'НЕСКОЛЬК'),(475,'КОНСОЛИДИРОВА'),(476,'УСТАВН'),(477,'КАПИТАЛ'),(478,'РАЗМЕР'),(479,'БОЛ'),(480,'РУБЛ'),(481,'ВЫСОК'),(482,'СТРАХОВ'),(483,'ОПЕРАЦ'),(484,'ПОДКРЕПЛ'),(485,'ПЕРЕСТРАХОВОЧН'),(486,'ПРОГРАММ'),(487,'КРУПН'),(488,'МИР'),(489,'МЮНХЕНСК'),(490,'ОБЩЕСТВ'),(491,'MUNICH'),(492,'RE'),(493,'ШВЕЙЦАРСК'),(494,'SWISS'),(495,'ГАННОВЕРСК'),(496,'HANNOV'),(497,'SCOR'),(498,'КЕЛЬНСК'),(499,'GENR'),(500,'ПАРТНЕР'),(501,'РЕ'),(502,'PARTNER'),(503,'LLOYD'),(504,'LONDON'),(505,'КОРПОРАТИВН'),(506,'КЛИЕНТ'),(507,'ЯВЛЯ'),(508,'ТРАНСПОРТН'),(509,'FESCO'),(510,'МЕРСЕДЕС-БЕНЦ'),(511,'РУС'),(512,'SOMON'),(513,'AIR'),(514,'SYRIAN'),(515,'YOKOHAMA'),(516,'RUSSIA'),(517,'АВИАНОВ'),(518,'АВИАН'),(519,'АЛЬФА-БАНК'),(520,'БАЛТ'),(521,'ТРАНС'),(522,'БАЛТИЙСК'),(523,'ГОСУДАРСТВЕН'),(524,'АКАДЕМ'),(525,'РЫБОПРОМЫСЛОВ'),(526,'ФЛОТ'),(527,'ВИММ-БИЛЛЬ-ДАН'),(528,'ПРОДУКТ'),(529,'ПИТАН'),(530,'АЭРОПОРТ'),(531,'ВНУКОВ'),(532,'ВОЛГОТАНКЕР'),(533,'ВЫМПЕЛК'),(534,'КОРПОРАЦ'),(535,'ОРГАНИЗАЦ'),(536,'ВОЗДУШН'),(537,'РФ'),(538,'МОСКОВСК'),(539,'ДОМОДЕДОВ'),(540,'ДОН-СТР'),(541,'ЕВРОСИБ'),(542,'КАВМИНВОДЫАВ'),(543,'КАЗАНЬОРГСИНТЕЗ'),(544,'КАТЭКАВ'),(545,'КРАСАВ'),(546,'МАГНИТОГОРСК'),(547,'МЕТАЛЛУРГИЧЕСК'),(548,'КОМБИНАТ'),(549,'МЕТАЛЛОИНВЕСТ'),(550,'МИНИСТЕРСТВ'),(551,'ИНОСТРА'),(552,'ДЕЛ'),(553,'НИЖНЕКАМСКНЕФТЕХ'),(554,'НОВАТЭК'),(555,'НОВОТРАНС'),(556,'НОРИЛЬСК'),(557,'НИКЕЛ'),(558,'ОРЕНБУРГСК'),(559,'АВИАЛИН'),(560,'ПРОТЕК'),(561,'РОСНЕФТ'),(562,'РУСАГР'),(563,'РУСГИДР'),(564,'АВИАКОМПАН'),(565,'РУСЭЙР'),(566,'СЕВТЕХНОТРАНС'),(567,'СОВТРАНСАВТ'),(568,'ТНК-BP'),(569,'ТНК'),(570,'СМАЗОЧН'),(571,'МАТЕРИАЛ'),(572,'ТРАНСБУНКЕР'),(573,'ТРАНСНЕФТЕПРОДУКТ'),(574,'УРАЛЬСК'),(575,'ФСК'),(576,'ЕЭС'),(577,'ХОЛДИНГ'),(578,'МРСК'),(579,'ШЕРЕМЕТЬЕВ'),(580,'ЮТЭЙР'),(581,'ЯКУТ'),(582,'ЯМА'),(583,'ИССЛЕДОВАН'),(584,'РЕЙТИНГОВ'),(585,'АГЕНТСТВ'),(586,'ЭКСПЕРТ'),(587,'РА'),(588,'ДЕСЯТК'),(589,'ЛИДЕРОВ'),(590,'ЛИДЕР'),(591,'ОТКРЫТ'),(592,'РЫНК'),(593,'ЯНВАР'),(594,'2011'),(595,'ПОДТВЕРД'),(596,'ПРИСВОЕН'),(597,'2003'),(598,'НАИВЫСШ'),(599,'РЕЙТИНГ'),(600,'ФИНАНСОВ'),(601,'FITCH'),(602,'АККРЕДИТАЦ'),(603,'БАНК'),(604,'СРЕД'),(605,'СБЕРБАНК'),(606,'РОСС'),(607,'ВТБ'),(608,'ВТБ24'),(609,'ГАЗПРОМБАНК'),(610,'РОССЕЛЬХОЗБАНК'),(611,'РАЙФФАЙЗЕНБАНК'),(612,'МОСКВ'),(613,'МДМ'),(614,'ЮНИКРЕД'),(615,'ВОШЛ'),(616,'ОФИЦИАЛЬН'),(617,'СТРАХОВЩИКОВ'),(618,'СТРАХОВЩИК'),(619,'УЧАСТВ'),(620,'СТРАХОВАН'),(621,'ИМУЩЕСТВ'),(622,'КЛИЕНТОВ'),(623,'БАНКОВ'),(624,'CТРАХОВ'),(625,'АГЕНТ'),(626,'ПРИГЛАША'),(627,'ЭНЕРГИЧН'),(628,'УВЕРЕН'),(629,'ЛЮД'),(630,'ГОТОВ'),(631,'ДЕЯТЕЛЬН'),(632,'ПРОФЕССИОНАЛЬН'),(633,'РАЗВИТИЮВ'),(634,'ЗАДАЧ'),(635,'ПРОДАЖ'),(636,'УСЛУГ'),(637,'ВСЕМ'),(638,'ОП'),(639,'ТРЕБ'),(640,'ОБЯЗАН'),(641,'ПОИСК'),(642,'НАРАБОТК'),(643,'КЛИЕНТСК'),(644,'БАЗ'),(645,'КОНСУЛЬТИРОВАН'),(646,'ВЫБОР'),(647,'ПРОВЕДЕН'),(648,'ВСТРЕЧ'),(649,'ПЕРЕГОВОРОВ'),(650,'ПЕРЕГОВОР'),(651,'ВЫЕЗД'),(652,'ЗАКЛЮЧЕН'),(653,'ДОГОВОРОВ'),(654,'ДОГОВОР'),(655,'ОФОРМЛЕН'),(656,'ДОКУМЕНТОВ'),(657,'ДОКУМЕНТ'),(658,'УСЛОВ'),(659,'БЕСПЛАТН'),(660,'ОБУЧЕН'),(661,'СТРАХ'),(662,'НАВЫК'),(663,'ПОДДЕРЖК'),(664,'СПЕЦИАЛИСТА-НАСТАВНИК'),(665,'ГИБК'),(666,'ГРАФИК'),(667,'ПЛАНИРОВА'),(668,'РАБОЧ'),(669,'ОХОД'),(670,'ОГРАНИЧ'),(671,'СТОИМОСТ'),(672,'КАРЬЕРН'),(673,'РОСТ'),(674,'АГЕНТСК'),(675,'ВНЕ'),(676,'ШТАТ'),(677,'ГАРАНТИРОВА'),(678,'ОТЧИСЛЕН'),(679,'ПЕНСИОН'),(680,'ФОНД'),(681,'ТРЕБОВАН'),(682,'ЗНАН'),(683,'ПК'),(684,'СР'),(685,'СПЕЦ'),(686,'ВЫСШ'),(687,'КРОМ'),(688,'ДНЕВН'),(689,'ФОРМ'),(690,'ЖЕЛАТЕЛ'),(691,'ВАЖН'),(692,'УМЕН'),(693,'НАРАБАТЫВА'),(694,'НОВ'),(695,'КОНТАКТ'),(696,'НАЛИЧ'),(697,'КОНТАКТОВ'),(698,'ПРИВЕТСТВ'),(699,'ЛИЧН'),(700,'КАЧЕСТВ'),(701,'ОТВЕТСТВЕН'),(702,'КОММУНИКАБЕЛЬН'),(703,'ИНИЦИАТИВН'),(704,'НАЦЕЛЕН'),(705,'РЕЗУЛЬТАТ'),(706,'ГРАЖДАНСТВ'),(707,'ПРОПИСК'),(708,'РЕГИСТРАЦ'),(709,'ПРОЖИВАН'),(710,'ОБЛАСТ'),(711,'МЕНЕДЖЕР'),(712,'СЧАСТЛИВ'),(713,'ЧАС'),(714,'17'),(715,'00'),(716,'18'),(717,'ПЯТНИЦ'),(718,'СТРАХОВК'),(719,'СО'),(720,'СКИДК'),(721,'20'),(722,'ПОЛУЧ'),(723,'ЦЕН'),(724,'ЗАСЕДАН'),(725,'ГОСДУМ'),(726,'ПОНЕДЕЛЬНИК'),(727,'НОЯБР'),(728,'ДЕПУТАТОВ'),(729,'ДЕПУТАТ'),(730,'ВЫРАЗ'),(731,'ИД'),(732,'ОБЕСПЕЧЕН'),(733,'БЛАНК'),(734,'ПОЛИСОВ'),(735,'ПОЛИС'),(736,'ОСАГ'),(737,'ЗЕЛЕН'),(738,'КАРТ'),(739,'ЗАВИСИМ'),(740,'ДИСЦИПЛИНИРОВАН'),(741,'ПЛАТЕЖЕСПОСОБН'),(742,'АКЦ'),(743,'ГЛАВН'),(744,'РАСТЯЖК'),(745,'ФИЧ'),(746,'БАННЕРН'),(747,'БЛОК'),(748,'ЖЕЛТ'),(749,'ПОЛОС'),(750,'ВНИЗ'),(751,'ШТУК'),(752,'ЭКРАН'),(753,'МА'),(754,'ДЕВУШК'),(755,'КАСК'),(756,'ДЕШЕВЛ'),(757,'15'),(758,'12'),(759,'КУП'),(760,'ЧЕБУРЕКОВ'),(761,'ЧЕБУРЕК'),(762,'СОБЕР'),(763,'КОШК'),(764,'КЛУБ'),(765,'ПРИВЕЛЕГ'),(766,'CЧАСТЛИВ'),(767,'СЛУЖБ'),(768,'800'),(769,'2000'),(770,'600'),(771,'BR'),(772,'NBSP'),(773,'STRONG'),(774,'ГЛОБАЛЬН');
/*!40000 ALTER TABLE `b_search_stem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_suggest`
--

DROP TABLE IF EXISTS `b_search_suggest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_suggest` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `FILTER_MD5` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `PHRASE` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `RATE` float NOT NULL,
  `TIMESTAMP_X` datetime NOT NULL,
  `RESULT_COUNT` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IND_B_SEARCH_SUGGEST` (`FILTER_MD5`,`PHRASE`(50),`RATE`),
  KEY `IND_B_SEARCH_SUGGEST_PHRASE` (`PHRASE`(50),`RATE`),
  KEY `IND_B_SEARCH_SUGGEST_TIME` (`TIMESTAMP_X`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_suggest`
--

LOCK TABLES `b_search_suggest` WRITE;
/*!40000 ALTER TABLE `b_search_suggest` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_suggest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_tags`
--

DROP TABLE IF EXISTS `b_search_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_tags` (
  `SEARCH_CONTENT_ID` int(11) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`SEARCH_CONTENT_ID`,`SITE_ID`,`NAME`),
  KEY `IX_B_SEARCH_TAGS_0` (`NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci DELAY_KEY_WRITE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_tags`
--

LOCK TABLES `b_search_tags` WRITE;
/*!40000 ALTER TABLE `b_search_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_search_user_right`
--

DROP TABLE IF EXISTS `b_search_user_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_search_user_right` (
  `USER_ID` int(11) NOT NULL,
  `GROUP_CODE` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `UX_B_SEARCH_USER_RIGHT` (`USER_ID`,`GROUP_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_search_user_right`
--

LOCK TABLES `b_search_user_right` WRITE;
/*!40000 ALTER TABLE `b_search_user_right` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_search_user_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_seo_keywords`
--

DROP TABLE IF EXISTS `b_seo_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_seo_keywords` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KEYWORDS` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  KEY `ix_b_seo_keywords_url` (`URL`,`SITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_seo_keywords`
--

LOCK TABLES `b_seo_keywords` WRITE;
/*!40000 ALTER TABLE `b_seo_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_seo_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_short_uri`
--

DROP TABLE IF EXISTS `b_short_uri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_short_uri` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `URI` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `URI_CRC` int(18) NOT NULL,
  `SHORT_URI` varbinary(250) NOT NULL,
  `SHORT_URI_CRC` int(18) NOT NULL,
  `STATUS` int(18) NOT NULL DEFAULT '301',
  `MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LAST_USED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `NUMBER_USED` int(18) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ux_b_short_uri_1` (`SHORT_URI_CRC`),
  KEY `ux_b_short_uri_2` (`URI_CRC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_short_uri`
--

LOCK TABLES `b_short_uri` WRITE;
/*!40000 ALTER TABLE `b_short_uri` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_short_uri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_site_template`
--

DROP TABLE IF EXISTS `b_site_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_site_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `CONDITION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SORT` int(11) NOT NULL DEFAULT '500',
  `TEMPLATE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_B_SITE_TEMPLATE` (`SITE_ID`,`CONDITION`,`TEMPLATE`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_site_template`
--

LOCK TABLES `b_site_template` WRITE;
/*!40000 ALTER TABLE `b_site_template` DISABLE KEYS */;
INSERT INTO `b_site_template` VALUES (2,'s1','',1,'msk-main');
/*!40000 ALTER TABLE `b_site_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_sticker`
--

DROP TABLE IF EXISTS `b_sticker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_sticker` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PAGE_URL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PAGE_TITLE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_CREATE` datetime NOT NULL,
  `DATE_UPDATE` datetime NOT NULL,
  `MODIFIED_BY` int(18) NOT NULL,
  `CREATED_BY` int(18) NOT NULL,
  `PERSONAL` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `CONTENT` text COLLATE utf8_unicode_ci,
  `POS_TOP` int(11) DEFAULT NULL,
  `POS_LEFT` int(11) DEFAULT NULL,
  `WIDTH` int(11) DEFAULT NULL,
  `HEIGHT` int(11) DEFAULT NULL,
  `COLOR` int(11) DEFAULT NULL,
  `COLLAPSED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `COMPLETED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `CLOSED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `DELETED` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `MARKER_TOP` int(11) DEFAULT NULL,
  `MARKER_LEFT` int(11) DEFAULT NULL,
  `MARKER_WIDTH` int(11) DEFAULT NULL,
  `MARKER_HEIGHT` int(11) DEFAULT NULL,
  `MARKER_ADJUST` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_sticker`
--

LOCK TABLES `b_sticker` WRITE;
/*!40000 ALTER TABLE `b_sticker` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_sticker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_sticker_group_task`
--

DROP TABLE IF EXISTS `b_sticker_group_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_sticker_group_task` (
  `GROUP_ID` int(11) NOT NULL,
  `TASK_ID` int(11) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`TASK_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_sticker_group_task`
--

LOCK TABLES `b_sticker_group_task` WRITE;
/*!40000 ALTER TABLE `b_sticker_group_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_sticker_group_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_task`
--

DROP TABLE IF EXISTS `b_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_task` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `LETTER` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SYS` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BINDING` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'module',
  PRIMARY KEY (`ID`),
  KEY `ix_task` (`MODULE_ID`,`BINDING`,`LETTER`,`SYS`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_task`
--

LOCK TABLES `b_task` WRITE;
/*!40000 ALTER TABLE `b_task` DISABLE KEYS */;
INSERT INTO `b_task` VALUES (1,'main_denied','D','main','Y',NULL,'module'),(2,'main_change_profile','P','main','Y',NULL,'module'),(3,'main_view_all_settings','R','main','Y',NULL,'module'),(4,'main_view_all_settings_change_profile','T','main','Y',NULL,'module'),(5,'main_edit_subordinate_users','V','main','Y',NULL,'module'),(6,'main_full_access','W','main','Y',NULL,'module'),(7,'fm_folder_access_denied','D','main','Y',NULL,'file'),(8,'fm_folder_access_read','R','main','Y',NULL,'file'),(9,'fm_folder_access_write','W','main','Y',NULL,'file'),(10,'fm_folder_access_full','X','main','Y',NULL,'file'),(11,'fm_folder_access_workflow','U','main','Y',NULL,'file'),(12,'clouds_denied','D','clouds','Y',NULL,'module'),(13,'clouds_browse','F','clouds','Y',NULL,'module'),(14,'clouds_upload','U','clouds','Y',NULL,'module'),(15,'clouds_full_access','W','clouds','Y',NULL,'module'),(16,'fileman_denied','D','fileman','Y','','module'),(17,'fileman_allowed_folders','F','fileman','Y','','module'),(18,'fileman_full_access','W','fileman','Y','','module'),(19,'medialib_denied','D','fileman','Y','','medialib'),(20,'medialib_view','F','fileman','Y','','medialib'),(21,'medialib_only_new','R','fileman','Y','','medialib'),(22,'medialib_edit_items','V','fileman','Y','','medialib'),(23,'medialib_editor','W','fileman','Y','','medialib'),(24,'medialib_full','X','fileman','Y','','medialib'),(25,'stickers_denied','D','fileman','Y','','stickers'),(26,'stickers_read','R','fileman','Y','','stickers'),(27,'stickers_edit','W','fileman','Y','','stickers'),(28,'iblock_deny','D','iblock','Y',NULL,'iblock'),(29,'iblock_read','R','iblock','Y',NULL,'iblock'),(30,'iblock_element_add','E','iblock','Y',NULL,'iblock'),(31,'iblock_limited_edit','U','iblock','Y',NULL,'iblock'),(32,'iblock_full_edit','W','iblock','Y',NULL,'iblock'),(33,'iblock_full','X','iblock','Y',NULL,'iblock'),(34,'seo_denied','D','seo','Y','','module'),(35,'seo_edit','F','seo','Y','','module'),(36,'seo_full_access','W','seo','Y','','module');
/*!40000 ALTER TABLE `b_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_task_operation`
--

DROP TABLE IF EXISTS `b_task_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_task_operation` (
  `TASK_ID` int(18) NOT NULL,
  `OPERATION_ID` int(18) NOT NULL,
  PRIMARY KEY (`TASK_ID`,`OPERATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_task_operation`
--

LOCK TABLES `b_task_operation` WRITE;
/*!40000 ALTER TABLE `b_task_operation` DISABLE KEYS */;
INSERT INTO `b_task_operation` VALUES (2,1),(2,7),(3,1),(3,3),(3,4),(3,5),(3,6),(4,1),(4,3),(4,4),(4,5),(4,6),(4,7),(5,1),(5,2),(5,4),(5,5),(5,6),(5,7),(5,9),(6,1),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,10),(6,11),(6,12),(6,13),(6,32),(6,33),(6,34),(8,15),(8,23),(8,24),(9,15),(9,17),(9,18),(9,19),(9,20),(9,21),(9,22),(9,23),(9,24),(9,25),(9,26),(9,27),(9,28),(9,29),(9,30),(9,31),(10,15),(10,16),(10,17),(10,18),(10,19),(10,20),(10,21),(10,22),(10,23),(10,24),(10,25),(10,26),(10,27),(10,28),(10,29),(10,30),(10,31),(11,15),(11,19),(11,23),(11,24),(11,25),(13,36),(14,36),(14,37),(15,36),(15,37),(15,38),(17,41),(17,42),(17,43),(17,44),(17,45),(17,46),(17,47),(17,49),(17,50),(18,39),(18,40),(18,41),(18,42),(18,43),(18,44),(18,45),(18,46),(18,47),(18,48),(18,49),(18,50),(18,51),(20,52),(21,52),(21,53),(21,57),(22,52),(22,57),(22,58),(22,59),(23,52),(23,53),(23,54),(23,55),(23,57),(23,58),(23,59),(24,52),(24,53),(24,54),(24,55),(24,56),(24,57),(24,58),(24,59),(26,60),(27,60),(27,61),(27,62),(27,63),(29,69),(29,75),(30,72),(31,64),(31,69),(31,72),(31,75),(31,76),(31,78),(31,79),(31,80),(32,64),(32,69),(32,70),(32,71),(32,72),(32,73),(32,75),(32,76),(32,77),(32,78),(32,79),(32,80),(33,64),(33,65),(33,66),(33,67),(33,68),(33,69),(33,70),(33,71),(33,72),(33,73),(33,74),(33,75),(33,76),(33,77),(33,78),(33,79),(33,80),(33,81),(35,83),(36,82),(36,83);
/*!40000 ALTER TABLE `b_task_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_undo`
--

DROP TABLE IF EXISTS `b_undo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_undo` (
  `ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `MODULE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UNDO_TYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UNDO_HANDLER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONTENT` mediumtext COLLATE utf8_unicode_ci,
  `USER_ID` int(11) DEFAULT NULL,
  `TIMESTAMP_X` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_undo`
--

LOCK TABLES `b_undo` WRITE;
/*!40000 ALTER TABLE `b_undo` DISABLE KEYS */;
INSERT INTO `b_undo` VALUES ('1031eac861d37d44bda1a61bc9807a5ab','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:56:\"/var/www/msk-in/www/bitrix/templates/msk-main/header.php\";s:7:\"content\";s:4447:\"<?\nif(!defined(\"B_PROLOG_INCLUDED\") || B_PROLOG_INCLUDED!==true)die();\n\n/**\n * @var CMain $APPLICATION\n */\n\nIncludeTemplateLangFile(__FILE__);\n?><!DOCTYPE html>\n<html>\n<head>\n	<script src=\"http://code.jquery.com/jquery-1.8.2.min.js\"></script>\n	<script src=\"/js/insurance.js\"></script>\n	<script src=\"/js/jquery.selectBox.js\"></script>\n	<script src=\"/js/jquery.customForm.js\"></script>\n	\n	<?$APPLICATION->ShowHead();?>\n	<meta name=\"SKYPE_TOOLBAR\" content=\"SKYPE_TOOLBAR_PARSER_COMPATIBLE\" />\n\n	<title><?$APPLICATION->ShowTitle()?> / <?=COption::GetOptionString(\'main\', \'site_name\')?></title>\n\n	<link href=\"/favicon.ico\" type=\"image/x-icon\" rel=\"icon\" />\n	<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/select.box.css\" />\n\n	<!--[if gte IE 9]>\n		<style type=\"text/css\">\n			.gradient {\n				filter: none;\n			}\n		</style>\n	<![endif]-->\n	<script type=\"text/javascript\">\n		$(document).ready(function() {\n			$(\"select\").selectBox();\n		});\n	</script>\n	<!--script type=\"text/javascript\" src=\"//yandex.st/share/share.js\" charset=\"utf-8\"></script-->\n</head>\n<body>\n\n<?$APPLICATION->ShowPanel()?>\n\n	<div class=\"bLayout\">\n		<div class=\"bHeader\">\n			<a href=\"/\" class=\"bHeader__eLogoLink\"><img src=\"/images/logo.jpg\" width=\"227\" height=\"50\" alt=\"Страховой Сервис «Москва»\" class=\"bHeader__eLogo\"></a>\n			<span class=\"bHeader__eHeaderText\">Мы&nbsp;продаем<br>сервис!</span>\n			<span class=\"bHeader__ePhone\">+ 7&nbsp;800 2000&nbsp;600</span>\n			<div class=\"bEnter\">\n				<img src=\"/images/enter_l.gif\" class=\"bEnter__eLeftEdge\" width=\"9\" height=\"23\" alt=\"\">\n				<div class=\"bEnter__eEnterWrapper\">\n					<img src=\"/images/enterArrow.png\" class=\"bEnter__eEnterArrow\" width=\"5\" height=\"8\" alt=\"\">\n					<span class=\"bEnter__eEnterText\">Вход</span>\n				</div>\n				<img src=\"/images/enter_c.gif\" class=\"bEnter__eCenterImg\" width=\"8\" height=\"23\" alt=\"\">\n				<div class=\"bEnter__eRegistrationWrapper\">\n					<img src=\"/images/registerArrow.png\" class=\"bEnter__eRegistrationArrow\" width=\"5\" height=\"8\" alt=\"\">\n					<span class=\"bEnter__eRegistrationText\">Регистрация</span>\n				</div>\n				<img src=\"/images/enter_r.gif\" class=\"bEnter__eRightEdge\" width=\"3\" height=\"23\" alt=\"\">\n			</div><!-- .Enter -->\n		</div><!-- .bHeader -->\n		<?$APPLICATION->IncludeComponent(\"bitrix:menu\", \".default\", array(\n			\"ROOT_MENU_TYPE\" => \"top\",\n			\"MENU_CACHE_TYPE\" => \"N\",\n			\"MENU_CACHE_TIME\" => \"3600\",\n			\"MENU_CACHE_USE_GROUPS\" => \"Y\",\n			\"MENU_CACHE_GET_VARS\" => array(\n			),\n			\"MAX_LEVEL\" => \"2\",\n			\"CHILD_MENU_TYPE\" => \"left\",\n			\"USE_EXT\" => \"N\",\n			\"DELAY\" => \"N\",\n			\"ALLOW_MULTI_SELECT\" => \"N\",\n			\"URL_FB\" => \"http://facebook.com\",\n			\"URL_VK\" => \"http://vk.com\",\n			\"URL_TW\" => \"http://twitter.com\"\n			),\n			false\n		);?>\n		<?$APPLICATION->IncludeComponent(\n			\"rm:banner\",\n			\"main\",\n			Array(\n				\"IBLOCK_TYPE\" => \"content\",\n				\"IBLOCK_ID\" => \"6\",\n				\"ITEMS_LIMIT\" => \"5\"\n			),\n			false\n		);?>\n        <div class=\"bBanner\">\n			<div class=\"bSliderControls\">\n				<div class=\"bSliderControls__eBullet bSliderControls__eBullet__mState_active\"></div>\n				<div class=\"bSliderControls__eBullet\"></div>\n				<div class=\"bSliderControls__eBullet\"></div>\n				<div class=\"bSliderControls__eBullet\"></div>\n			</div>\n			<div class=\"bBanner__eAd\">\n				<div class=\"bBanner__eAdText\">с&nbsp;10&nbsp;по&nbsp;20&nbsp;мая</div>\n				<div class=\"bBanner__eAdText bBanner__eAdText__mFont_big\">\n					Всем&nbsp;девушкам КАСКО&nbsp;дешевле на&nbsp;<span class=\"bBanner__eAdText__mFont_bold\">15&nbsp;%</span>\n					<a href=\"#\"><img src=\"/images/profound.png\" class=\"bAd__eLink\" width=\"82\" height=\"23\" alt=\"\"></a>\n				</div>\n			</div>\n			<div class=\"bBanner__eVisibleSlider\">\n				<div class=\"bBanner__eLine\">\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\n				</div>\n			</div>\n		</div><!-- .bBanner -->\n		<?$APPLICATION->IncludeComponent(\n			\"bitrix:breadcrumb\",\n			\"\",\n			Array(\n				\"START_FROM\" => \"0\",\n				\"PATH\" => \"\",\n				\"SITE_ID\" => SITE_ID\n			),\n		false\n		);?> \";}',1,1352293611),('103e7df957514eb9d6c1562e8c49ff632','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:29:\"/var/www/msk-in/www/index.php\";s:7:\"content\";s:630:\"<?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/header.php\');\n$APPLICATION->SetTitle(\"Главная\");\n$APPLICATION->SetPageProperty(\"NOT_SHOW_NAV_CHAIN\", \"Y\");\n?> <?$APPLICATION->IncludeComponent(\n	\"rm:form_order\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:partners\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"4\"\n	)\n);?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \"main\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\"\n	),\n	false\n);?> <?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/footer.php\');\n?>\";}',1,1352291273),('10b5c46f86b43d50561cf2998d68087c7','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:406:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\",\n	\"SECTION_URL\" => \"/news/?SECTION=#ID#\",\n	\"DETAIL_URL\" => \"/news/detail.php?ID=#ID#\"\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352198203),('1197be2b10f239274f6f280a5c6c0bd92','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:5021:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"bitrix:news\", \".default\", Array(\n	\"DISPLAY_DATE\" => \"Y\",	// Выводить дату элемента\n	\"DISPLAY_PICTURE\" => \"Y\",	// Выводить изображение для анонса\n	\"DISPLAY_PREVIEW_TEXT\" => \"Y\",	// Выводить текст анонса\n	\"USE_SHARE\" => \"N\",	// Отображать панель соц. закладок\n	\"SEF_MODE\" => \"N\",	// Включить поддержку ЧПУ\n	\"AJAX_MODE\" => \"N\",	// Включить режим AJAX\n	\"IBLOCK_TYPE\" => \"content\",	// Тип инфоблока\n	\"IBLOCK_ID\" => \"1\",	// Инфоблок\n	\"NEWS_COUNT\" => \"5\",	// Количество новостей на странице\n	\"USE_SEARCH\" => \"N\",	// Разрешить поиск\n	\"USE_RSS\" => \"N\",	// Разрешить RSS\n	\"USE_RATING\" => \"N\",	// Разрешить голосование\n	\"USE_CATEGORIES\" => \"N\",	// Выводить материалы по теме\n	\"USE_FILTER\" => \"N\",	// Показывать фильтр\n	\"SORT_BY1\" => \"ACTIVE_FROM\",	// Поле для первой сортировки новостей\n	\"SORT_ORDER1\" => \"DESC\",	// Направление для первой сортировки новостей\n	\"SORT_BY2\" => \"SORT\",	// Поле для второй сортировки новостей\n	\"SORT_ORDER2\" => \"ASC\",	// Направление для второй сортировки новостей\n	\"CHECK_DATES\" => \"Y\",	// Показывать только активные на данный момент элементы\n	\"PREVIEW_TRUNCATE_LEN\" => \"\",	// Максимальная длина анонса для вывода (только для типа текст)\n	\"LIST_ACTIVE_DATE_FORMAT\" => \"d.m.Y\",	// Формат показа даты\n	\"LIST_FIELD_CODE\" => \"\",	// Поля\n	\"LIST_PROPERTY_CODE\" => \"\",	// Свойства\n	\"HIDE_LINK_WHEN_NO_DETAIL\" => \"N\",	// Скрывать ссылку, если нет детального описания\n	\"DISPLAY_NAME\" => \"Y\",	// Выводить название элемента\n	\"META_KEYWORDS\" => \"-\",	// Установить ключевые слова страницы из свойства\n	\"META_DESCRIPTION\" => \"-\",	// Установить описание страницы из свойства\n	\"BROWSER_TITLE\" => \"-\",	// Установить заголовок окна браузера из свойства\n	\"DETAIL_ACTIVE_DATE_FORMAT\" => \"j F Y\",	// Формат показа даты\n	\"DETAIL_FIELD_CODE\" => \"\",	// Поля\n	\"DETAIL_PROPERTY_CODE\" => \"\",	// Свойства\n	\"DETAIL_DISPLAY_TOP_PAGER\" => \"N\",	// Выводить над списком\n	\"DETAIL_DISPLAY_BOTTOM_PAGER\" => \"Y\",	// Выводить под списком\n	\"DETAIL_PAGER_TITLE\" => \"Страница\",	// Название категорий\n	\"DETAIL_PAGER_TEMPLATE\" => \"\",	// Название шаблона\n	\"DETAIL_PAGER_SHOW_ALL\" => \"Y\",	// Показывать ссылку \"Все\"\n	\"SET_TITLE\" => \"Y\",	// Устанавливать заголовок страницы\n	\"SET_STATUS_404\" => \"Y\",	// Устанавливать статус 404, если не найдены элемент или раздел\n	\"INCLUDE_IBLOCK_INTO_CHAIN\" => \"N\",	// Включать инфоблок в цепочку навигации\n	\"ADD_SECTIONS_CHAIN\" => \"Y\",	// Включать раздел в цепочку навигации\n	\"USE_PERMISSIONS\" => \"N\",	// Использовать дополнительное ограничение доступа\n	\"CACHE_TYPE\" => \"A\",	// Тип кеширования\n	\"CACHE_TIME\" => \"36000000\",	// Время кеширования (сек.)\n	\"CACHE_FILTER\" => \"N\",	// Кешировать при установленном фильтре\n	\"CACHE_GROUPS\" => \"Y\",	// Учитывать права доступа\n	\"DISPLAY_TOP_PAGER\" => \"N\",	// Выводить над списком\n	\"DISPLAY_BOTTOM_PAGER\" => \"Y\",	// Выводить под списком\n	\"PAGER_TITLE\" => \"Новости\",	// Название категорий\n	\"PAGER_SHOW_ALWAYS\" => \"Y\",	// Выводить всегда\n	\"PAGER_TEMPLATE\" => \"\",	// Название шаблона\n	\"PAGER_DESC_NUMBERING\" => \"N\",	// Использовать обратную навигацию\n	\"PAGER_DESC_NUMBERING_CACHE_TIME\" => \"36000\",	// Время кеширования страниц для обратной навигации\n	\"PAGER_SHOW_ALL\" => \"Y\",	// Показывать ссылку \"Все\"\n	\"VARIABLE_ALIASES\" => array(\n		\"SECTION_ID\" => \"SECTION_ID\",\n		\"ELEMENT_ID\" => \"ELEMENT_ID\",\n	),\n	\"AJAX_OPTION_JUMP\" => \"N\",	// Включить прокрутку к началу компонента\n	\"AJAX_OPTION_STYLE\" => \"Y\",	// Включить подгрузку стилей\n	\"AJAX_OPTION_HISTORY\" => \"N\",	// Включить эмуляцию навигации браузера\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352195343),('11efb20c6f15e3fba15e87c5c2cbf2cbe','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:164:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352194980),('1281ebc7980b4ed7d23eab2f4db7a6310','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:320:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\"\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352198341),('12c0f986d5cdcfae5e8a26484299e579b','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:56:\"/var/www/msk-in/www/bitrix/templates/msk-main/header.php\";s:7:\"content\";s:4272:\"<?\r\n\r\n/**\r\n * @var CMain $APPLICATION\r\n */\r\n\r\nif(!defined(\"B_PROLOG_INCLUDED\") || B_PROLOG_INCLUDED!==true)die();\r\nIncludeTemplateLangFile(__FILE__);\r\n?><!DOCTYPE html>\r\n<html>\r\n<head>\r\n	<script src=\"http://code.jquery.com/jquery-1.8.2.min.js\"></script>\r\n	<script src=\"/js/insurance.js\"></script>\r\n	<script src=\"/js/jquery.selectBox.js\"></script>\r\n	<script src=\"/js/jquery.customForm.js\"></script>\r\n	\r\n	<?$APPLICATION->ShowHead();?>\r\n	<meta name=\"SKYPE_TOOLBAR\" content=\"SKYPE_TOOLBAR_PARSER_COMPATIBLE\" />\r\n\r\n	<title><?$APPLICATION->ShowTitle()?> / <?=COption::GetOptionString(\'main\', \'site_name\')?></title>\r\n\r\n	<link href=\"/favicon.ico\" type=\"image/x-icon\" rel=\"icon\" />\r\n	<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/select.box.css\" />\r\n\r\n	<!--[if gte IE 9]>\r\n		<style type=\"text/css\">\r\n			.gradient {\r\n				filter: none;\r\n			}\r\n		</style>\r\n	<![endif]-->\r\n	<script type=\"text/javascript\">\r\n		$(document).ready(function() {\r\n			$(\"select\").selectBox();\r\n		});\r\n	</script>\r\n	<script type=\"text/javascript\" src=\"//yandex.st/share/share.js\" charset=\"utf-8\"></script>\r\n</head>\r\n<body>\r\n\r\n<?$APPLICATION->ShowPanel()?>\r\n\r\n	<div class=\"bLayout\">\r\n		<div class=\"bHeader\">\r\n			<a href=\"/\" class=\"bHeader__eLogoLink\"><img src=\"/images/logo.jpg\" width=\"227\" height=\"50\" alt=\"Страховой Сервис «Москва»\" class=\"bHeader__eLogo\"></a>\r\n			<span class=\"bHeader__eHeaderText\">Мы&nbsp;продаем<br>сервис!</span>\r\n			<span class=\"bHeader__ePhone\">+ 7&nbsp;800 2000&nbsp;600</span>\r\n			<div class=\"bEnter\">\r\n				<img src=\"/images/enter_l.gif\" class=\"bEnter__eLeftEdge\" width=\"9\" height=\"23\" alt=\"\">\r\n				<div class=\"bEnter__eEnterWrapper\">\r\n					<img src=\"/images/enterArrow.png\" class=\"bEnter__eEnterArrow\" width=\"5\" height=\"8\" alt=\"\">\r\n					<span class=\"bEnter__eEnterText\">Вход</span>\r\n				</div>\r\n				<img src=\"/images/enter_c.gif\" class=\"bEnter__eCenterImg\" width=\"8\" height=\"23\" alt=\"\">\r\n				<div class=\"bEnter__eRegistrationWrapper\">\r\n					<img src=\"/images/registerArrow.png\" class=\"bEnter__eRegistrationArrow\" width=\"5\" height=\"8\" alt=\"\">\r\n					<span class=\"bEnter__eRegistrationText\">Регистрация</span>\r\n				</div>\r\n				<img src=\"/images/enter_r.gif\" class=\"bEnter__eRightEdge\" width=\"3\" height=\"23\" alt=\"\">\r\n			</div><!-- .Enter -->\r\n		</div><!-- .bHeader -->\r\n		<?$APPLICATION->IncludeComponent(\r\n			\"bitrix:menu\",\r\n			\"\",\r\n			Array(\r\n				\"ROOT_MENU_TYPE\" => \"top\",\r\n				\"MAX_LEVEL\" => \"2\",\r\n				\"CHILD_MENU_TYPE\" => \"left\",\r\n				\"USE_EXT\" => \"N\",\r\n				\"DELAY\" => \"N\",\r\n				\"ALLOW_MULTI_SELECT\" => \"N\",\r\n				\"MENU_CACHE_TYPE\" => \"N\",\r\n				\"MENU_CACHE_TIME\" => \"3600\",\r\n				\"MENU_CACHE_USE_GROUPS\" => \"Y\",\r\n				\"MENU_CACHE_GET_VARS\" => array()\r\n			),\r\n			false\r\n		);?>\r\n		<div class=\"bBanner\">\r\n			<div class=\"bSliderControls\">\r\n				<div class=\"bSliderControls__eBullet bSliderControls__eBullet__mState_active\"></div>\r\n				<div class=\"bSliderControls__eBullet\"></div>\r\n				<div class=\"bSliderControls__eBullet\"></div>\r\n				<div class=\"bSliderControls__eBullet\"></div>\r\n			</div>\r\n			<div class=\"bBanner__eAd\">\r\n				<div class=\"bBanner__eAdText\">с&nbsp;10&nbsp;по&nbsp;20&nbsp;мая</div>\r\n				<div class=\"bBanner__eAdText bBanner__eAdText__mFont_big\">\r\n					Всем&nbsp;девушкам КАСКО&nbsp;дешевле на&nbsp;<span class=\"bBanner__eAdText__mFont_bold\">15&nbsp;%</span>\r\n					<a href=\"#\"><img src=\"/images/profound.png\" class=\"bAd__eLink\" width=\"82\" height=\"23\" alt=\"\"></a>\r\n				</div>\r\n			</div>\r\n			<div class=\"bBanner__eVisibleSlider\">\r\n				<div class=\"bBanner__eLine\">\r\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\r\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\r\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\r\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\r\n					<img src=\"/images/banner_image1.jpg\" class=\"bBanner__eImage\" width=\"938\" height=\"300\" alt=\"\">\r\n				</div>\r\n			</div>\r\n		</div><!-- .bBanner -->\r\n		<?$APPLICATION->IncludeComponent(\r\n			\"bitrix:breadcrumb\",\r\n			\"\",\r\n			Array(\r\n				\"START_FROM\" => \"0\",\r\n				\"PATH\" => \"\",\r\n				\"SITE_ID\" => SITE_ID\r\n			),\r\n		false\r\n		);?> \";}',1,1352216693),('12e92b36f01f997812778cbe683eb2a94','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:47:\"/var/www/msk-in/www/corporate-clients/index.php\";s:7:\"content\";s:195:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Корпоративным клиентам\");\n?>\n\n<?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352224449),('133b251c3f47df9b9eb1fcb5e0874073f','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:365:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\",\n	\"DETAIL_URL\" => \"/news/detail.php?ID=#ID#\"\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352198170),('137767697b9020fe672bf0fffa085e9f5','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:320:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\"\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352199982),('14e430ab9c3e28250f156abcc4a7358e4','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:29:\"/var/www/msk-in/www/index.php\";s:7:\"content\";s:358:\"<?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/header.php\');\n$APPLICATION->SetTitle(\"Главная\");\n$APPLICATION->SetPageProperty(\"NOT_SHOW_NAV_CHAIN\", \"Y\");\n?>\n<?$APPLICATION->IncludeComponent(\"rm:form_order\", \"main\", array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\",\n	),\n	false\n);?>\n<?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/footer.php\');\n?>\";}',1,1352290687),('1697d499010e849a855d01c0d073031ee','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:318:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\n	\"rm:news_list\",\n	\"\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"1\",\n		\"ITEMS_LIMIT\" => \"10\"\n	),\nfalse\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352197930),('1796b20fb9d4619cdd7ff0e51c3529ffb','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:32:\"/var/www/msk-in/www/features.php\";s:7:\"content\";s:1639:\"<div class=\"bSideFeatures\">\n	<div class=\"bFeatures__eItem bFeatures__eItem__mSide_position\">\n		<div class=\"bFeatures__eTopLine\">\n			<div class=\"bFeatures__eText\">\n				Служба<br>поддержки<br>24&nbsp;часа</strong>\n			</div>\n			<img src=\"/images/girl.jpg\"\n				class=\"bFeatures__eImage bFeatures__eImage__mPosition_bottom\"\n				width=\"83\" height=\"116\" alt=\"Карта клуба «Москва»\">\n		</div>\n		<div class=\"bFeatures__eBottomLine\">\n			<span class=\"bFeatures__eBottomText\">+ 7&nbsp;800 2000&nbsp;600</span>\n		</div>\n	</div>\n	<div class=\"bFeatures__eItem bFeatures__eItem__mSide_position\">\n		<div class=\"bFeatures__eTopLine\">\n			<div class=\"bFeatures__eText\">\n				Только час<br>&mdash;&nbsp;страховка<br>со&nbsp;скидкой<br>20%</strong>\n			</div>\n			<img src=\"/images/clock.jpg\"\n				class=\"bFeatures__eImage bFeatures__eImage__mPosition_center_bottom\"\n				width=\"68\" height=\"100\" alt=\"Карта клуба «Москва»\">\n		</div>\n		<div class=\"bFeatures__eBottomLine\">\n			<span class=\"bFeatures__eBottomText\">Cчастливый час</span>\n		</div>\n	</div>\n	<div class=\"bFeatures__eItem bFeatures__eItem__mSide_position\">\n		<div class=\"bFeatures__eTopLine\">\n			<div class=\"bFeatures__eText\">\n				Карта<br>клуба<br> <strong>«Москва»</strong>\n			</div>\n			<img src=\"/images/clubCard.jpg\"\n				class=\"bFeatures__eImage bFeatures__eImage__mPosition_center\"\n				width=\"85\" height=\"70\" alt=\"Карта клуба «Москва»\">\n		</div>\n		<div class=\"bFeatures__eBottomLine\">\n			Больше<br>привелегий\n		</div>\n	</div>\n</div>\n<!-- .bSideFeatures -->\n\";}',1,1352199183),('188e0c0a1fcaba31321e55947c67782b3','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:47:\"/var/www/msk-in/www/corporate-clients/index.php\";s:7:\"content\";s:351:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Корпоративным клиентам\");\n?><?$APPLICATION->IncludeComponent(\"rm:form_order\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"5\",\n		\'TYPE_SELECTOR\' => 1\n	),\n	false\n);?> <?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352224620),('1a07e212ff5ee0bfd7fa117dcdd65b8b9','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:36:\"/var/www/msk-in/www/shares/index.php\";s:7:\"content\";s:162:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Акции\");\n?>\n\n<?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352221352),('1a386748f9dd46acbd1abb686cc9395ed','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:44:\"/var/www/msk-in/www/contacts/inc.address.php\";s:7:\"content\";s:110:\"150111 г. Москва,\n<br />\n ул. Тверская д. 1 корп. 1, офис 150\n<div>чвпыв</div>\n\";}',1,1352219988),('1ab091059614e7cc895e07424cec64036','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:35:\"/var/www/msk-in/www/about/index.php\";s:7:\"content\";s:173:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"О компании\");\n?>\n\n\n\n<?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352215313),('1b45f60c79e727c030825719d7be37346','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:47:\"/var/www/msk-in/www/corporate-clients/index.php\";s:7:\"content\";s:352:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Корпоративным клиентам\");\n?><?$APPLICATION->IncludeComponent(\"rm:form_order\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"5\",\n	\"TYPE_SELECTOR\" => \"0\"\n	),\n	false\n);?> <?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352224631),('1b5f024ace06a4397fbd8f58f9c2c8955','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:319:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"2\"\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352200128),('1bab29c0d72520a4f8dcbac348dcb9fc6','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:40:\"/var/www/msk-in/www/about/jobs/index.php\";s:7:\"content\";s:172:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Title\");\n?>\n\nText here....\n\n<?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352218808),('1d554f781bed2454df466921ec0424e67','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:29:\"/var/www/msk-in/www/index.php\";s:7:\"content\";s:635:\"<?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/header.php\');\n$APPLICATION->SetTitle(\"Главная\");\n$APPLICATION->SetPageProperty(\"NOT_SHOW_NAV_CHAIN\", \"Y\");\n?> <?$APPLICATION->IncludeComponent(\n	\"rm:form_order\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:partners\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"4\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:news_list\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"1\",\n		\"ITEMS_LIMIT\" => \"3\"\n	),\nfalse\n);?> <?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/footer.php\');\n?>\";}',1,1352291261),('1ddcd17b15e5a7df783812a7a2d293bcb','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:47:\"/var/www/msk-in/www/corporate-clients/index.php\";s:7:\"content\";s:324:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Корпоративным клиентам\");\n?><?$APPLICATION->IncludeComponent(\n	\"rm:form_order\",\n	\"\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\"\n	),\nfalse\n);?> <?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352224562),('1dec84c643d90dbe4e95fc96240f1ca71','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:44:\"/var/www/msk-in/www/contacts/inc.address.php\";s:7:\"content\";s:86:\"150111 г. Москва,<br />\r\nул. Тверская д. 1 корп. 1, офис 150\";}',1,1352219982),('1e258eb3021194fc3575199c22e4096e1','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:29:\"/var/www/msk-in/www/index.php\";s:7:\"content\";s:485:\"<?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/header.php\');\n$APPLICATION->SetTitle(\"Главная\");\n$APPLICATION->SetPageProperty(\"NOT_SHOW_NAV_CHAIN\", \"Y\");\n?> <?$APPLICATION->IncludeComponent(\n	\"rm:form_order\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:partners\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"4\"\n	),\nfalse\n);?> <?\nrequire($_SERVER[\'DOCUMENT_ROOT\'].\'/bitrix/footer.php\');\n?>\";}',1,1352290867),('1edf16fb89b5fd8ff2f35359d4275045b','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:34:\"/var/www/msk-in/www/news/index.php\";s:7:\"content\";s:356:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Новости\");\n?><?$APPLICATION->IncludeComponent(\"rm:news_list\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\",\n	\"ITEMS_LIMIT\" => \"10\",\n	\"SECTION\" => $_REQUEST[\"SECTION\"]\n	),\n	false\n);?><?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352198861),('1f6281819f3c7e73e0a9d65d1e2033691','fileman','edit_file','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:38:\"/var/www/msk-in/www/partners/index.php\";s:7:\"content\";s:168:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Партнеры\");\n?>\n\n<?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352222937),('1fb3b75a97b8655ebe5903daf829b7a7c','fileman','edit_component_props','CFileman::UndoEditFile','a:2:{s:7:\"absPath\";s:47:\"/var/www/msk-in/www/corporate-clients/index.php\";s:7:\"content\";s:327:\"<?\nrequire($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/header.php\");\n$APPLICATION->SetTitle(\"Корпоративным клиентам\");\n?><?$APPLICATION->IncludeComponent(\"rm:form_order\", \".default\", array(\n	\"IBLOCK_TYPE\" => \"content\",\n	\"IBLOCK_ID\" => \"1\"\n	),\n	false\n);?> <?require($_SERVER[\"DOCUMENT_ROOT\"].\"/bitrix/footer.php\");?>\";}',1,1352224592),('26d79b69e52964ca046787d1109a49788','main','autosave','CAutoSave::_Restore','a:11:{s:9:\"submitbtn\";s:0:\"\";s:4:\"mode\";s:6:\"public\";s:4:\"save\";s:1:\"Y\";s:4:\"site\";s:2:\"s1\";s:8:\"template\";s:0:\"\";s:10:\"templateID\";s:8:\"msk-main\";s:9:\"subdialog\";s:0:\"\";s:8:\"back_url\";s:16:\"/news/?SECTION=0\";s:5:\"title\";s:14:\"Новости\";s:4:\"path\";s:15:\"/news/index.php\";s:11:\"filesrc_pub\";s:155:\"<?$APPLICATION->IncludeComponent(\n	\"rm:news_list\",\n	\".default\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"1\",\n		\"ITEMS_LIMIT\" => \"10\"\n	)\n);?>\";}',1,1352199119),('29de4a6af5acfcfb4b8da6820bbaa2144','main','autosave','CAutoSave::_Restore','a:23:{s:9:\"submitbtn\";s:0:\"\";s:4:\"mode\";s:6:\"public\";s:4:\"save\";s:1:\"Y\";s:4:\"site\";s:2:\"s1\";s:8:\"template\";s:0:\"\";s:10:\"templateID\";s:8:\"msk-main\";s:9:\"subdialog\";s:0:\"\";s:8:\"back_url\";s:21:\"/news/detail.php?ID=3\";s:5:\"title\";s:31:\"Новость детально\";s:4:\"path\";s:16:\"/news/detail.php\";s:14:\"ROOT_MENU_TYPE\";s:4:\"left\";s:18:\"ROOT_MENU_TYPE_alt\";s:0:\"\";s:15:\"MENU_CACHE_TYPE\";s:1:\"N\";s:15:\"MENU_CACHE_TIME\";s:4:\"3600\";s:21:\"MENU_CACHE_USE_GROUPS\";s:1:\"Y\";s:35:\"MENU_CACHE_GET_VARSX000091XX000093X\";a:1:{i:0;s:0:\"\";}s:9:\"MAX_LEVEL\";s:1:\"1\";s:15:\"CHILD_MENU_TYPE\";s:4:\"left\";s:19:\"CHILD_MENU_TYPE_alt\";s:0:\"\";s:7:\"USE_EXT\";s:0:\"\";s:5:\"DELAY\";s:0:\"\";s:18:\"ALLOW_MULTI_SELECT\";s:0:\"\";s:11:\"filesrc_pub\";s:520:\"<?$APPLICATION->IncludeComponent(\n	\"rm:news_detail\",\n	\".default\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"1\",\n		\"ITEM_ID\" => $_REQUEST[\'ID\']\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"bitrix:menu\",\n	\"\",\n	Array(\n		\"ROOT_MENU_TYPE\" => \"top\",\n		\"MAX_LEVEL\" => \"1\",\n		\"CHILD_MENU_TYPE\" => \"left\",\n		\"USE_EXT\" => \"N\",\n		\"DELAY\" => \"N\",\n		\"ALLOW_MULTI_SELECT\" => \"N\",\n		\"MENU_CACHE_TYPE\" => \"N\",\n		\"MENU_CACHE_TIME\" => \"3600\",\n		\"MENU_CACHE_USE_GROUPS\" => \"Y\",\n		\"MENU_CACHE_GET_VARS\" => array()\n	),\nfalse\n);?>\";}',1,1352214856),('2aadefaf0ef3104202ae5af8f12f31c3b','main','autosave','CAutoSave::_Restore','a:29:{s:7:\"logical\";s:1:\"Y\";s:6:\"filter\";s:1:\"Y\";s:10:\"set_filter\";s:1:\"Y\";s:4:\"site\";s:2:\"s1\";s:4:\"path\";s:6:\"/about\";s:4:\"save\";s:0:\"\";s:8:\"back_url\";s:0:\"\";s:3:\"new\";s:1:\"Y\";s:4:\"name\";s:4:\"left\";s:19:\"idsX000091XX000093X\";a:5:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";}s:6:\"text_1\";s:19:\"О компании\";s:6:\"link_1\";s:7:\"/about/\";s:6:\"sort_1\";s:2:\"10\";s:6:\"text_2\";s:16:\"Вакансии\";s:6:\"link_2\";s:12:\"/about/jobs/\";s:6:\"sort_2\";s:2:\"20\";s:6:\"text_3\";s:46:\"Гид по сервисам и салонам\";s:6:\"link_3\";s:7:\"/about/\";s:6:\"sort_3\";s:2:\"30\";s:6:\"text_4\";s:0:\"\";s:6:\"link_4\";s:0:\"\";s:6:\"sort_4\";s:2:\"40\";s:6:\"text_5\";s:0:\"\";s:6:\"link_5\";s:0:\"\";s:6:\"sort_5\";s:2:\"50\";s:7:\"itemcnt\";s:1:\"5\";s:5:\"apply\";s:0:\"\";s:6:\"cancel\";s:0:\"\";s:21:\"tabControl_active_tab\";s:5:\"edit1\";}',1,1352215469),('2cbf4a8ef4e83272fd20997fabcaada7d','main','autosave','CAutoSave::_Restore','a:15:{s:9:\"submitbtn\";s:0:\"\";s:4:\"mode\";s:6:\"public\";s:4:\"save\";s:1:\"Y\";s:4:\"site\";s:2:\"s1\";s:8:\"template\";s:0:\"\";s:10:\"templateID\";s:8:\"msk-main\";s:9:\"subdialog\";s:0:\"\";s:8:\"back_url\";s:38:\"/?bitrix_include_areas=N&clear_cache=Y\";s:5:\"title\";s:14:\"Главная\";s:4:\"path\";s:10:\"/index.php\";s:11:\"IBLOCK_TYPE\";s:7:\"content\";s:9:\"IBLOCK_ID\";s:1:\"6\";s:13:\"IBLOCK_ID_alt\";s:0:\"\";s:11:\"ITEMS_LIMIT\";s:2:\"10\";s:11:\"filesrc_pub\";s:555:\" <?$APPLICATION->IncludeComponent(\n	\"rm:form_order\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"5\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:partners\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"4\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:news_list\",\n	\"main\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"1\",\n		\"ITEMS_LIMIT\" => \"3\"\n	)\n);?><?$APPLICATION->IncludeComponent(\n	\"rm:banner\",\n	\"\",\n	Array(\n		\"IBLOCK_TYPE\" => \"content\",\n		\"IBLOCK_ID\" => \"6\",\n		\"ITEMS_LIMIT\" => \"10\"\n	),\nfalse\n);?> \";}',1,1352293322);
/*!40000 ALTER TABLE `b_undo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user`
--

DROP TABLE IF EXISTS `b_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `TIMESTAMP_X` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `LOGIN` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CHECKWORD` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACTIVE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LAST_LOGIN` datetime DEFAULT NULL,
  `DATE_REGISTER` datetime NOT NULL,
  `LID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_PROFESSION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_WWW` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_ICQ` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_GENDER` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_BIRTHDATE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_PHOTO` int(18) DEFAULT NULL,
  `PERSONAL_PHONE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_FAX` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_MOBILE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_PAGER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_STREET` text COLLATE utf8_unicode_ci,
  `PERSONAL_MAILBOX` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_CITY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_STATE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_ZIP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_COUNTRY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_NOTES` text COLLATE utf8_unicode_ci,
  `WORK_COMPANY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_DEPARTMENT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_POSITION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_WWW` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_PHONE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_FAX` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_PAGER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_STREET` text COLLATE utf8_unicode_ci,
  `WORK_MAILBOX` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_CITY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_STATE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_ZIP` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_COUNTRY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WORK_PROFILE` text COLLATE utf8_unicode_ci,
  `WORK_LOGO` int(18) DEFAULT NULL,
  `WORK_NOTES` text COLLATE utf8_unicode_ci,
  `ADMIN_NOTES` text COLLATE utf8_unicode_ci,
  `STORED_HASH` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERSONAL_BIRTHDAY` date DEFAULT NULL,
  `EXTERNAL_AUTH_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CHECKWORD_TIME` datetime DEFAULT NULL,
  `SECOND_NAME` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CONFIRM_CODE` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LOGIN_ATTEMPTS` int(18) DEFAULT NULL,
  `LAST_ACTIVITY_DATE` datetime DEFAULT NULL,
  `AUTO_TIME_ZONE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TIME_ZONE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TIME_ZONE_OFFSET` int(18) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ix_login` (`LOGIN`,`EXTERNAL_AUTH_ID`),
  KEY `ix_b_user_email` (`EMAIL`),
  KEY `ix_b_user_activity_date` (`LAST_ACTIVITY_DATE`),
  KEY `IX_B_USER_XML_ID` (`XML_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user`
--

LOCK TABLES `b_user` WRITE;
/*!40000 ALTER TABLE `b_user` DISABLE KEYS */;
INSERT INTO `b_user` VALUES (1,'2012-11-02 13:30:17','rmrevin','YHW7K0Vn2e124aa328d6fd87ade307423a4d43b5','MElyXyY46021481852233680580187ec9f74116b','Y','Roman','Revin','xgismox@gmail.com','2012-11-07 16:17:41','2012-11-02 17:30:17',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-11-02 17:30:17',NULL,NULL,0,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `b_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_access`
--

DROP TABLE IF EXISTS `b_user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_access` (
  `USER_ID` int(11) DEFAULT NULL,
  `PROVIDER_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACCESS_CODE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `ix_ua_user_provider` (`USER_ID`,`PROVIDER_ID`),
  KEY `ix_ua_user_access` (`USER_ID`,`ACCESS_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_access`
--

LOCK TABLES `b_user_access` WRITE;
/*!40000 ALTER TABLE `b_user_access` DISABLE KEYS */;
INSERT INTO `b_user_access` VALUES (0,'group','G2'),(1,'group','G1'),(1,'group','G2'),(1,'group','G3'),(1,'group','G4'),(1,'user','U1');
/*!40000 ALTER TABLE `b_user_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_access_check`
--

DROP TABLE IF EXISTS `b_user_access_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_access_check` (
  `USER_ID` int(11) DEFAULT NULL,
  `PROVIDER_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `ix_uac_user_provider` (`USER_ID`,`PROVIDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_access_check`
--

LOCK TABLES `b_user_access_check` WRITE;
/*!40000 ALTER TABLE `b_user_access_check` DISABLE KEYS */;
INSERT INTO `b_user_access_check` VALUES (1,'group'),(1,'user');
/*!40000 ALTER TABLE `b_user_access_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_counter`
--

DROP TABLE IF EXISTS `b_user_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_counter` (
  `USER_ID` int(18) NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '**',
  `CODE` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CNT` int(18) NOT NULL DEFAULT '0',
  `LAST_DATE` datetime DEFAULT NULL,
  `TAG` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARAMS` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`USER_ID`,`SITE_ID`,`CODE`),
  KEY `ix_buc_tag` (`TAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_counter`
--

LOCK TABLES `b_user_counter` WRITE;
/*!40000 ALTER TABLE `b_user_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_digest`
--

DROP TABLE IF EXISTS `b_user_digest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_digest` (
  `USER_ID` int(11) NOT NULL,
  `DIGEST_HA1` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_digest`
--

LOCK TABLES `b_user_digest` WRITE;
/*!40000 ALTER TABLE `b_user_digest` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_digest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_field`
--

DROP TABLE IF EXISTS `b_user_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_field` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ENTITY_ID` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD_NAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_TYPE_ID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SORT` int(11) DEFAULT NULL,
  `MULTIPLE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `MANDATORY` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SHOW_FILTER` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SHOW_IN_LIST` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `EDIT_IN_LIST` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `IS_SEARCHABLE` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SETTINGS` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_user_type_entity` (`ENTITY_ID`,`FIELD_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_field`
--

LOCK TABLES `b_user_field` WRITE;
/*!40000 ALTER TABLE `b_user_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_field_enum`
--

DROP TABLE IF EXISTS `b_user_field_enum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_field_enum` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_FIELD_ID` int(11) DEFAULT NULL,
  `VALUE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DEF` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `SORT` int(11) NOT NULL DEFAULT '500',
  `XML_ID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ux_user_field_enum` (`USER_FIELD_ID`,`XML_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_field_enum`
--

LOCK TABLES `b_user_field_enum` WRITE;
/*!40000 ALTER TABLE `b_user_field_enum` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_field_enum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_field_lang`
--

DROP TABLE IF EXISTS `b_user_field_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_field_lang` (
  `USER_FIELD_ID` int(11) NOT NULL DEFAULT '0',
  `LANGUAGE_ID` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `EDIT_FORM_LABEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LIST_COLUMN_LABEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LIST_FILTER_LABEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ERROR_MESSAGE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HELP_MESSAGE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`USER_FIELD_ID`,`LANGUAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_field_lang`
--

LOCK TABLES `b_user_field_lang` WRITE;
/*!40000 ALTER TABLE `b_user_field_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_field_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_group`
--

DROP TABLE IF EXISTS `b_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_group` (
  `USER_ID` int(18) NOT NULL,
  `GROUP_ID` int(18) NOT NULL,
  `DATE_ACTIVE_FROM` datetime DEFAULT NULL,
  `DATE_ACTIVE_TO` datetime DEFAULT NULL,
  UNIQUE KEY `ix_user_group` (`USER_ID`,`GROUP_ID`),
  KEY `ix_user_group_group` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_group`
--

LOCK TABLES `b_user_group` WRITE;
/*!40000 ALTER TABLE `b_user_group` DISABLE KEYS */;
INSERT INTO `b_user_group` VALUES (1,1,NULL,NULL),(1,2,NULL,NULL),(1,3,NULL,NULL),(1,4,NULL,NULL);
/*!40000 ALTER TABLE `b_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_hit_auth`
--

DROP TABLE IF EXISTS `b_user_hit_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_hit_auth` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(18) NOT NULL,
  `HASH` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `URL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `SITE_ID` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TIMESTAMP_X` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IX_USER_HIT_AUTH_1` (`HASH`),
  KEY `IX_USER_HIT_AUTH_2` (`USER_ID`),
  KEY `IX_USER_HIT_AUTH_3` (`TIMESTAMP_X`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_hit_auth`
--

LOCK TABLES `b_user_hit_auth` WRITE;
/*!40000 ALTER TABLE `b_user_hit_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_user_hit_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_option`
--

DROP TABLE IF EXISTS `b_user_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_option` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `CATEGORY` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `VALUE` text COLLATE utf8_unicode_ci,
  `COMMON` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  KEY `ix_user_option_param` (`CATEGORY`,`NAME`),
  KEY `ix_user_option_user` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_option`
--

LOCK TABLES `b_user_option` WRITE;
/*!40000 ALTER TABLE `b_user_option` DISABLE KEYS */;
INSERT INTO `b_user_option` VALUES (1,NULL,'intranet','~gadgets_admin_index','a:1:{i:0;a:1:{s:7:\"GADGETS\";a:6:{s:20:\"ADMIN_INFO@333333333\";a:3:{s:6:\"COLUMN\";i:0;s:3:\"ROW\";i:0;s:4:\"HIDE\";s:1:\"N\";}s:24:\"ADMIN_SECURITY@555555555\";a:3:{s:6:\"COLUMN\";i:0;s:3:\"ROW\";i:1;s:4:\"HIDE\";s:1:\"N\";}s:23:\"ADMIN_PERFMON@666666666\";a:3:{s:6:\"COLUMN\";i:0;s:3:\"ROW\";i:2;s:4:\"HIDE\";s:1:\"N\";}s:19:\"HTML_AREA@444444444\";a:5:{s:6:\"COLUMN\";i:1;s:3:\"ROW\";i:0;s:4:\"HIDE\";s:1:\"N\";s:8:\"USERDATA\";a:1:{s:7:\"content\";s:797:\"<table class=\"bx-gadgets-info-site-table\" cellspacing=\"0\"><tr>	<td class=\"bx-gadget-gray\">Создатель сайта:</td>	<td>Группа компаний &laquo;1С-Битрикс&raquo;.</td>	<td class=\"bx-gadgets-info-site-logo\" rowspan=\"5\"><img src=\"/bitrix/components/bitrix/desktop/templates/admin/images/site_logo.png\"></td></tr><tr>	<td class=\"bx-gadget-gray\">Адрес сайта:</td>	<td><a href=\"http://www.1c-bitrix.ru\">www.1c-bitrix.ru</a></td></tr><tr>	<td class=\"bx-gadget-gray\">Сайт сдан:</td>	<td>12 декабря 2010 г.</td></tr><tr>	<td class=\"bx-gadget-gray\">Ответственное лицо:</td>	<td>Иван Иванов</td></tr><tr>	<td class=\"bx-gadget-gray\">E-mail:</td>	<td><a href=\"mailto:info@1c-bitrix.ru\">info@1c-bitrix.ru</a></td></tr></table>\";}s:8:\"SETTINGS\";a:1:{s:9:\"TITLE_STD\";s:34:\"Информация о сайте\";}}s:19:\"RSSREADER@777777777\";a:4:{s:6:\"COLUMN\";i:1;s:3:\"ROW\";i:2;s:4:\"HIDE\";s:1:\"N\";s:8:\"SETTINGS\";a:3:{s:9:\"TITLE_STD\";s:33:\"Новости 1С-Битрикс\";s:3:\"CNT\";i:5;s:7:\"RSS_URL\";s:45:\"https://www.1c-bitrix.ru/about/life/news/rss/\";}}s:25:\"ADMIN_CHECKLIST@777888999\";a:3:{s:6:\"COLUMN\";i:1;s:3:\"ROW\";i:1;s:4:\"HIDE\";s:1:\"N\";}}}}','Y'),(2,1,'admin_panel','settings','a:2:{s:4:\"edit\";s:3:\"off\";s:9:\"collapsed\";s:2:\"on\";}','N'),(3,1,'hot_keys','user_defined','b:1;','N'),(4,1,'admin_menu','pos','a:1:{s:8:\"sections\";s:130:\"menu_marketplace,menu_system,menu_fileman,menu_fileman_site_s1_,menu_iblock,menu_iblock_/content,menu_module_settings,iblock_admin\";}','N'),(5,1,'fileman','last_pathes','s:87:\"a:4:{i:0;s:18:\"/corporate-clients\";i:1;s:6:\"/about\";i:2;s:5:\"/news\";i:3;s:7:\"/bitrix\";}\";','N'),(6,1,'fileman','code_editor','a:1:{s:5:\"theme\";s:5:\"light\";}','N'),(7,1,'filter','tbl_iblock_list_b095a8c351bd6c9eb4a0aa9a40ca8120_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(8,1,'form','form_element_1','a:1:{s:4:\"tabs\";s:298:\"edit1--#--Новость--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--*Дата--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DETAIL_PICTURE--#--*Картинка--,--SECTIONS--#--Разделы--,--PREVIEW_TEXT--#--*Анонс--,--DETAIL_TEXT--#--*Текст--;--\";}','N'),(9,NULL,'form','form_element_1','a:1:{s:4:\"tabs\";s:298:\"edit1--#--Новость--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--*Дата--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DETAIL_PICTURE--#--*Картинка--,--SECTIONS--#--Разделы--,--PREVIEW_TEXT--#--*Анонс--,--DETAIL_TEXT--#--*Текст--;--\";}','Y'),(10,1,'BX.WindowManager.9.5','size_/bitrix/admin/public_file_edit.php','a:2:{s:5:\"width\";s:3:\"819\";s:6:\"height\";s:3:\"561\";}','N'),(11,1,'fileman','taskbar_settings_filesrc_pub','s:246:\"a:3:{s:19:\"BXPropertiesTaskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";i:3;s:6:\"active\";b:1;}s:20:\"BXComponents2Taskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";s:1:\"2\";s:6:\"active\";b:1;}s:17:\"BXSnippetsTaskbar\";a:3:{s:4:\"show\";b:1;s:3:\"set\";i:3;s:6:\"active\";b:0;}}\";','N'),(12,1,'fileman','taskbarset_settings_filesrc_pub','s:90:\"a:2:{i:2;a:2:{s:4:\"show\";b:1;s:4:\"size\";i:200;}i:3;a:2:{s:4:\"show\";b:1;s:4:\"size\";i:256;}}\";','N'),(13,1,'form','form_section_1','a:1:{s:4:\"tabs\";s:135:\"edit1--#--Раздел--,--ACTIVE--#--Раздел активен--,--NAME--#--*Название--,--SORT--#--Сортировка--;--\";}','N'),(14,NULL,'form','form_section_1','a:1:{s:4:\"tabs\";s:135:\"edit1--#--Раздел--,--ACTIVE--#--Раздел активен--,--NAME--#--*Название--,--SORT--#--Сортировка--;--\";}','Y'),(15,1,'filter','tbl_iblock_list_b7d3215a9c5d7a3446fc85e1a5877fc2_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(16,1,'form','form_element_2','a:1:{s:4:\"tabs\";s:281:\"edit1--#--Вакансия--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DETAIL_TEXT--#--Описание--;--\";}','N'),(17,NULL,'form','form_element_2','a:1:{s:4:\"tabs\";s:281:\"edit1--#--Вакансия--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DETAIL_TEXT--#--Описание--;--\";}','Y'),(18,1,'filter','tbl_iblock_list_5861fa2d67db16bf1dcab2250c88814c_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(19,1,'form','form_element_3','a:1:{s:4:\"tabs\";s:282:\"edit1--#--Акция--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--DETAIL_PICTURE--#--*Картинка--,--DETAIL_TEXT--#--Описание--;--\";}','N'),(20,NULL,'form','form_element_3','a:1:{s:4:\"tabs\";s:282:\"edit1--#--Акция--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--DETAIL_PICTURE--#--*Картинка--,--DETAIL_TEXT--#--Описание--;--\";}','Y'),(21,1,'filter','tbl_iblock_list_68644bd953cc92c1153348f8217575c4_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(22,1,'form','form_element_4','a:1:{s:4:\"tabs\";s:326:\"edit1--#--Партнеры--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--SORT--#--Сортировка--,--NAME--#--*Название--,--CODE--#--*Ссылка на сайт--,--DETAIL_PICTURE--#--*Картинка--;--\";}','N'),(23,NULL,'form','form_element_4','a:1:{s:4:\"tabs\";s:326:\"edit1--#--Партнеры--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--SORT--#--Сортировка--,--NAME--#--*Название--,--CODE--#--*Ссылка на сайт--,--DETAIL_PICTURE--#--*Картинка--;--\";}','Y'),(24,1,'filter','tbl_iblock_list_dd5ef36e5a447af02ffc50723f333b15_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(25,1,'form','form_element_5','a:1:{s:4:\"tabs\";s:233:\"edit1--#--Заявка--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Дата--,--NAME--#--*Имя заказчика--,--CODE--#--Телефон--,--PROPERTY_1--#--*Тип заявки--,--PROPERTY_2--#--*Статус--;--\";}','N'),(26,NULL,'form','form_element_5','a:1:{s:4:\"tabs\";s:233:\"edit1--#--Заявка--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Дата--,--NAME--#--*Имя заказчика--,--CODE--#--Телефон--,--PROPERTY_1--#--*Тип заявки--,--PROPERTY_2--#--*Статус--;--\";}','Y'),(27,1,'filter','tbl_iblock_list_46f8140327845967c617a49611b20c2c_filter','a:1:{s:4:\"rows\";s:15:\"IBLIST_A_PARENT\";}','N'),(28,1,'form','form_section_6','a:1:{s:4:\"tabs\";s:176:\"edit1--#--Площадка--,--ACTIVE--#--Раздел активен--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DESCRIPTION--#--Описание--;--\";}','N'),(29,NULL,'form','form_section_6','a:1:{s:4:\"tabs\";s:176:\"edit1--#--Площадка--,--ACTIVE--#--Раздел активен--,--NAME--#--*Название--,--SORT--#--Сортировка--,--DESCRIPTION--#--Описание--;--\";}','Y'),(30,1,'form','form_element_6','a:1:{s:4:\"tabs\";s:337:\"edit1--#--Баннер--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--CODE--#--Ссылка--,--SECTIONS--#--Площадка--,--DETAIL_PICTURE--#--Картинка--,--DETAIL_TEXT--#--Текст--;--\";}','N'),(31,NULL,'form','form_element_6','a:1:{s:4:\"tabs\";s:337:\"edit1--#--Баннер--,--ACTIVE--#--Активность--,--ACTIVE_FROM--#--Начало активности--,--ACTIVE_TO--#--Окончание активности--,--NAME--#--*Название--,--CODE--#--Ссылка--,--SECTIONS--#--Площадка--,--DETAIL_PICTURE--#--Картинка--,--DETAIL_TEXT--#--Текст--;--\";}','Y');
/*!40000 ALTER TABLE `b_user_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `b_user_stored_auth`
--

DROP TABLE IF EXISTS `b_user_stored_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b_user_stored_auth` (
  `ID` int(18) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(18) NOT NULL,
  `DATE_REG` datetime NOT NULL,
  `LAST_AUTH` datetime NOT NULL,
  `STORED_HASH` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `TEMP_HASH` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `IP_ADDR` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ux_user_hash` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b_user_stored_auth`
--

LOCK TABLES `b_user_stored_auth` WRITE;
/*!40000 ALTER TABLE `b_user_stored_auth` DISABLE KEYS */;
INSERT INTO `b_user_stored_auth` VALUES (1,1,'2012-11-02 17:30:17','2012-11-07 16:17:41','322d5baa2df44ca75dcb513d493f87e9','N',183640215);
/*!40000 ALTER TABLE `b_user_stored_auth` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-07 18:22:53
