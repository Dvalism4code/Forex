/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: peophtkq_FINNEX_NEW_DB
-- ------------------------------------------------------
-- Server version	11.4.9-MariaDB-cll-lve-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `account_account`
--

DROP TABLE IF EXISTS `account_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_account` (
  `id` char(32) NOT NULL,
  `capital` decimal(20,2) NOT NULL,
  `profit` decimal(20,2) NOT NULL,
  `accumulating_balance` decimal(20,2) NOT NULL,
  `bonus` decimal(20,2) NOT NULL,
  `account_status` varchar(20) NOT NULL,
  `kyc_confirmed` tinyint(1) NOT NULL,
  `kyc_submitted` tinyint(1) NOT NULL,
  `withdrawal_pin` varchar(128) DEFAULT NULL,
  `pin_set` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_account`
--

LOCK TABLES `account_account` WRITE;
/*!40000 ALTER TABLE `account_account` DISABLE KEYS */;
INSERT INTO `account_account` (`id`, `capital`, `profit`, `accumulating_balance`, `bonus`, `account_status`, `kyc_confirmed`, `kyc_submitted`, `withdrawal_pin`, `pin_set`, `date_joined`, `user_id`) VALUES ('3575a3311c2d431199f10344ae9088fb',0.00,0.00,0.00,0.00,'inactive',0,0,NULL,0,'2026-01-12 16:35:39.031934',21),
('ed4e3563f6d341c4b88bfdcfda41a5fa',15000.00,250000.00,265000.00,0.00,'inactive',0,0,NULL,0,'2026-01-12 16:07:19.808352',20),
('fe9e8204331c49f9940541a556a93adb',100000.00,0.00,0.00,1500.00,'inactive',0,0,NULL,0,'2025-12-23 18:04:08.063780',13),
('3fdb8879863a47c98947b38db27f1f36',300.00,7000.00,7300.00,0.00,'inactive',0,0,'pbkdf2_sha256$600000$eBB7zwqS9ZvFJgC0nVrCcH$66GKxkRxtrI9tjYFceGdgTbT3fSoOAFxbV6cNWD27bk=',1,'2025-12-25 21:16:18.775296',14),
('cb41632b7747434faeaa029d61d2e56c',0.00,0.00,0.00,0.00,'inactive',0,0,NULL,0,'2025-12-23 15:42:47.079203',9),
('f79d3b40cb6c4bf3a0d66a9633d72b9e',0.00,0.00,0.00,0.00,'inactive',0,0,NULL,0,'2026-01-10 23:17:57.138167',17),
('de4c785f355146fe826d11eb4670f43c',2900000.00,0.00,0.00,0.00,'inactive',0,0,NULL,0,'2026-01-11 20:58:07.373746',19);
/*!40000 ALTER TABLE `account_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_deposit`
--

DROP TABLE IF EXISTS `account_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_deposit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(20,2) NOT NULL,
  `asset` varchar(10) NOT NULL,
  `deposit_address` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `account_id` char(32) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_deposit_account_id_b899008c` (`account_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_deposit`
--

LOCK TABLES `account_deposit` WRITE;
/*!40000 ALTER TABLE `account_deposit` DISABLE KEYS */;
INSERT INTO `account_deposit` (`id`, `amount`, `asset`, `deposit_address`, `created_at`, `account_id`, `status`) VALUES (2,24500.00,'BTC','ieoqutpwjepwpeppetpejeptepe','2025-12-23 17:03:29.020669','cb41632b7747434faeaa029d61d2e56c','pending');
/*!40000 ALTER TABLE `account_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_kyc`
--

DROP TABLE IF EXISTS `account_kyc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_kyc` (
  `id` char(32) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `date_of_birth` date NOT NULL,
  `identity_image` varchar(100) NOT NULL,
  `identity_type` varchar(142) NOT NULL,
  `country` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `date_submitted` datetime(6) NOT NULL,
  `account_id` char(32) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_kyc`
--

LOCK TABLES `account_kyc` WRITE;
/*!40000 ALTER TABLE `account_kyc` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_kyc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_signalbot`
--

DROP TABLE IF EXISTS `account_signalbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_signalbot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `plan` varchar(30) NOT NULL,
  `price` varchar(10) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `time` varchar(30) DEFAULT NULL,
  `leverage` longtext DEFAULT NULL,
  `features` longtext DEFAULT NULL,
  `market_review` longtext DEFAULT NULL,
  `priority_market` longtext DEFAULT NULL,
  `direct` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_signalbot`
--

LOCK TABLES `account_signalbot` WRITE;
/*!40000 ALTER TABLE `account_signalbot` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_signalbot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_withdraw`
--

DROP TABLE IF EXISTS `account_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_withdraw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(10) NOT NULL,
  `withdraw_address` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `account_id` char(32) NOT NULL,
  `swift_code` varchar(10) DEFAULT NULL,
  `bank_account_number` varchar(10) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `bank_account_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_withdraw_account_id_23391cf3` (`account_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_withdraw`
--

LOCK TABLES `account_withdraw` WRITE;
/*!40000 ALTER TABLE `account_withdraw` DISABLE KEYS */;
INSERT INTO `account_withdraw` (`id`, `amount`, `method`, `withdraw_address`, `status`, `created_at`, `verified`, `account_id`, `swift_code`, `bank_account_number`, `bank_name`, `bank_account_name`) VALUES (5,8000.00,'Bank',NULL,'pending','2026-01-13 02:26:39.912399',0,'de4c785f355146fe826d11eb4670f43c','DBBLBDDH','7017328637','DUTCH-BANGLA BANK LIMITED','MD NURUL ISLAM PATOARY'),
(4,8000.00,'Bank',NULL,'pending','2026-01-13 02:24:52.207505',0,'de4c785f355146fe826d11eb4670f43c','DBBLBDDH','7017328637','DUTCH-BANGLA BANK LIMITED','MD NURUL ISLAM PATOARY'),
(6,5000.00,'Bank',NULL,'pending','2026-01-13 02:29:09.904485',0,'de4c785f355146fe826d11eb4670f43c','DBBLBDDH','7017328637','DUTCH-BANGLA BANK LIMITED','MD NURUL ISLAM PATOARY');
/*!40000 ALTER TABLE `account_withdraw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add content type',4,'add_contenttype'),
(14,'Can change content type',4,'change_contenttype'),
(15,'Can delete content type',4,'delete_contenttype'),
(16,'Can view content type',4,'view_contenttype'),
(17,'Can add session',5,'add_session'),
(18,'Can change session',5,'change_session'),
(19,'Can delete session',5,'delete_session'),
(20,'Can view session',5,'view_session'),
(21,'Can add account',6,'add_account'),
(22,'Can change account',6,'change_account'),
(23,'Can delete account',6,'delete_account'),
(24,'Can view account',6,'view_account'),
(25,'Can add deposit',7,'add_deposit'),
(26,'Can change deposit',7,'change_deposit'),
(27,'Can delete deposit',7,'delete_deposit'),
(28,'Can view deposit',7,'view_deposit'),
(29,'Can add kyc',8,'add_kyc'),
(30,'Can change kyc',8,'change_kyc'),
(31,'Can delete kyc',8,'delete_kyc'),
(32,'Can view kyc',8,'view_kyc'),
(33,'Can add withdraw',9,'add_withdraw'),
(34,'Can change withdraw',9,'change_withdraw'),
(35,'Can delete withdraw',9,'delete_withdraw'),
(36,'Can view withdraw',9,'view_withdraw'),
(37,'Can add user',10,'add_customuser'),
(38,'Can change user',10,'change_customuser'),
(39,'Can delete user',10,'delete_customuser'),
(40,'Can view user',10,'view_customuser'),
(41,'Can add signal bot',11,'add_signalbot'),
(42,'Can change signal bot',11,'change_signalbot'),
(43,'Can delete signal bot',11,'delete_signalbot'),
(44,'Can view signal bot',11,'view_signalbot');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (1,'2025-12-23 17:03:29.023474','2','finnex deposited 24500 BTC to ieoqutpwjepwpeppetpejeptepe',1,'[{\"added\": {}}]',7,9),
(2,'2025-12-23 17:36:24.740475','9','finnex',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Full name\"]}}]',10,9),
(3,'2025-12-23 17:46:44.503690','10','',3,'',10,9),
(4,'2025-12-23 17:46:44.509351','8','',3,'',10,9),
(5,'2025-12-23 17:47:04.483263','7','',3,'',10,9),
(6,'2025-12-23 17:47:04.484337','6','',3,'',10,9),
(7,'2025-12-23 17:47:04.485005','5','',3,'',10,9),
(8,'2025-12-23 17:47:04.485662','4','',3,'',10,9),
(9,'2025-12-23 17:47:04.486282','3','',3,'',10,9),
(10,'2025-12-23 17:48:01.119096','11','Ramona',1,'[{\"added\": {}}]',10,9),
(11,'2025-12-23 17:54:41.857549','11','Ramona',2,'[]',10,9),
(12,'2025-12-23 17:56:11.260799','11','Ramona',3,'',10,9),
(13,'2025-12-23 17:58:56.097856','12','Ramona',1,'[{\"added\": {}}]',10,9),
(14,'2025-12-23 18:03:29.336716','12','Ramona',3,'',10,9),
(15,'2025-12-23 18:06:18.853994','13','Ramona',2,'[{\"changed\": {\"fields\": [\"Superuser status\", \"First name\", \"Last name\", \"Staff status\", \"Full name\"]}}]',10,9),
(16,'2025-12-23 18:17:33.032819','fe9e8204-331c-49f9-9405-41a556a93adb','Ramona\'s Account',2,'[{\"changed\": {\"fields\": [\"Account balance\", \"Bonus\"]}}]',6,9),
(17,'2025-12-23 18:34:21.236653','fe9e8204-331c-49f9-9405-41a556a93adb','Ramona\'s Account',2,'[]',6,9),
(18,'2025-12-24 02:14:46.094716','fe9e8204-331c-49f9-9405-41a556a93adb','Ramona\'s Account',2,'[{\"changed\": {\"fields\": [\"Account balance\"]}}]',6,9),
(19,'2025-12-25 22:41:37.440971','3fdb8879-863a-47c9-8947-b38db27f1f36','\'s Account',2,'[{\"changed\": {\"fields\": [\"Account balance\", \"Profit\", \"Accumulating balance\"]}}]',6,9),
(20,'2025-12-25 23:16:45.401089','3fdb8879-863a-47c9-8947-b38db27f1f36','\'s Account',2,'[]',6,9),
(21,'2025-12-25 23:23:22.839933','14','Willie',2,'[]',10,9),
(22,'2025-12-25 23:29:12.590923','3fdb8879-863a-47c9-8947-b38db27f1f36','Willie\'s Account',2,'[]',6,9),
(23,'2026-01-12 00:23:57.758815','5d1967af-ff6b-45a2-81a6-d6999e4cca10','james\'s Account',2,'[{\"changed\": {\"fields\": [\"Capital\", \"Profit\"]}}]',6,9),
(24,'2026-01-12 01:34:38.824520','4482d8ea-da30-4c6a-b588-18318d8b0740','\'s Account',3,'',6,9),
(25,'2026-01-12 01:34:38.825506','2bfceaf4-60eb-4699-9ca7-5f65bbf5f7c5','\'s Account',3,'',6,9),
(26,'2026-01-12 02:19:12.191731','de4c785f-3551-46fe-826d-11eb4670f43c','Md Mamun\'s Account',2,'[{\"changed\": {\"fields\": [\"Capital\"]}}]',6,9),
(27,'2026-01-12 17:01:12.399731','ed4e3563-f6d3-41c4-b88b-fdcfda41a5fa','Reginald\'s Account',2,'[{\"changed\": {\"fields\": [\"Capital\", \"Profit\", \"Accumulating balance\"]}}]',6,9),
(28,'2026-01-12 17:11:35.495809','ed4e3563-f6d3-41c4-b88b-fdcfda41a5fa','Reginald\'s Account',2,'[{\"changed\": {\"fields\": [\"Capital\", \"Profit\", \"Accumulating balance\"]}}]',6,9),
(29,'2026-01-13 02:12:09.465008','ed4e3563-f6d3-41c4-b88b-fdcfda41a5fa','Reginald\'s Account',2,'[{\"changed\": {\"fields\": [\"Capital\", \"Profit\", \"Accumulating balance\"]}}]',6,9),
(30,'2026-01-13 02:13:29.382047','15','james',3,'',10,9),
(31,'2026-01-13 02:13:43.326480','16','likee',3,'',10,9),
(32,'2026-01-13 02:14:08.879243','18','patrick',3,'',10,9),
(33,'2026-01-13 02:14:25.034387','2','',3,'',10,9),
(34,'2026-01-13 02:14:25.035410','1','',3,'',10,9);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1,'admin','logentry'),
(2,'auth','permission'),
(3,'auth','group'),
(4,'contenttypes','contenttype'),
(5,'sessions','session'),
(6,'account','account'),
(7,'account','deposit'),
(8,'account','kyc'),
(9,'account','withdraw'),
(10,'users','customuser'),
(11,'account','signalbot');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1,'account','0001_initial','2025-10-15 02:06:27.507516'),
(2,'account','0002_deposit_status','2025-10-15 02:06:27.577375'),
(3,'account','0003_rename_asset_withdraw_method_and_more','2025-10-15 02:06:27.681905'),
(4,'account','0004_alter_account_pin_set_alter_withdraw_method','2025-10-15 02:06:27.708902'),
(5,'account','0005_rename_bank_account_name_withdraw_swift_code','2025-10-15 02:06:27.745360'),
(6,'account','0006_alter_account_pin_set_alter_kyc_identity_image','2025-10-15 02:06:27.765720'),
(7,'contenttypes','0001_initial','2025-10-15 02:06:27.794920'),
(8,'admin','0001_initial','2025-10-15 02:06:27.905180'),
(9,'admin','0002_logentry_remove_auto_add','2025-10-15 02:06:27.917635'),
(10,'admin','0003_logentry_add_action_flag_choices','2025-10-15 02:06:27.934351'),
(11,'contenttypes','0002_remove_content_type_name','2025-10-15 02:06:27.987149'),
(12,'auth','0001_initial','2025-10-15 02:06:28.223844'),
(13,'auth','0002_alter_permission_name_max_length','2025-10-15 02:06:28.258589'),
(14,'auth','0003_alter_user_email_max_length','2025-10-15 02:06:28.265508'),
(15,'auth','0004_alter_user_username_opts','2025-10-15 02:06:28.273135'),
(16,'auth','0005_alter_user_last_login_null','2025-10-15 02:06:28.280522'),
(17,'auth','0006_require_contenttypes_0002','2025-10-15 02:06:28.282623'),
(18,'auth','0007_alter_validators_add_error_messages','2025-10-15 02:06:28.290109'),
(19,'auth','0008_alter_user_username_max_length','2025-10-15 02:06:28.297534'),
(20,'auth','0009_alter_user_last_name_max_length','2025-10-15 02:06:28.305582'),
(21,'auth','0010_alter_group_name_max_length','2025-10-15 02:06:28.343566'),
(22,'auth','0011_update_proxy_permissions','2025-10-15 02:06:28.376891'),
(23,'auth','0012_alter_user_first_name_max_length','2025-10-15 02:06:28.384839'),
(24,'sessions','0001_initial','2025-10-15 02:06:28.420906'),
(25,'account','0007_signalbot_rename_account_balance_account_capital_and_more','2026-01-11 23:57:56.668599');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('kqalqrd00acyc0wnayc6qcjg703wx56e','.eJxVjEEOwiAQRe_C2pAplKnj0n3PQIaBStVAUtqV8e7apAvd_vfefynP25r91tLi56guyqjT7xZYHqnsIN653KqWWtZlDnpX9EGbHmtMz-vh_h1kbvlbs3UQB0SWXnowmIJ1HQpOBESU4lmMiAnBdmkgQaDo7EQERoAMMqj3B9soN3Y:1v8rMN:HPsAXt6NceiLuBBKz8IaKvVyPyqtnwjZ2ANtKVWYvk0','2025-10-29 02:35:27.318706'),
('row3s1otlnb4pcicm5lat9tki896u2mp','.eJxVjEsOAiEQBe_C2hB-Arp07xlId9PIqIFkmFkZ766TzEK3r6reSyRYl5rWwXOasjgLJw6_GwI9uG0g36HduqTelnlCuSlyp0Nee-bnZXf_DiqM-q2LdRxKiIpdYWuNYh8DeocawgkUYURNxdHRaw6YQ1ZaGUtARkMmV8T7A--WOIA:1vG10S:3kj79dxmlSZWKN4iKRzt250fJJM_HVqn7FefHZABqmU','2025-11-17 20:18:24.362872'),
('prlhwgg7rbtw6kk7heumh5vdeumu2weh','.eJxVjEsOAiEQBe_C2hB-Arp07xlId9PIqIFkmFkZ766TzEK3r6reSyRYl5rWwXOasjgLJw6_GwI9uG0g36HduqTelnlCuSlyp0Nee-bnZXf_DiqM-q2LdRxKiIpdYWuNYh8DeocawgkUYURNxdHRaw6YQ1ZaGUtARkMmV8T7A--WOIA:1vG10T:-lz6IZ5W8OCxXcz73dV0NEHTtWd3h9msXg3VKDGImS8','2025-11-17 20:18:25.391798'),
('8z3ykeb2qttaylbhsinrvkz6x7sovrai','.eJxVjEEOwiAQRe_C2hBkOiAu3XsGMsOAVA1NSrsy3l2bdKHb_977LxVpXWpce57jKOqsUB1-N6b0yG0Dcqd2m3Sa2jKPrDdF77Tr6yT5edndv4NKvX7rgAAFrUtHIjAG0A3ssZDhE3gMjJTEhpTFsyDmJCXDAME6Yw0EdOr9AdSNN3I:1vG2Km:qoB_02XwP8YsyPdD2BjvBs_7dDEwDKEuawcGH-u6mrQ','2025-11-17 21:43:28.342652'),
('s42ri6lwt3cu1opdh5grj2xgevz630do','.eJxVjDsOgzAQRO_iOrL8Yb12yvScAdnedUwSgYShinL3gESRdKN5b-YthritddgaL8NI4ipQXH67FPOTpwPQI073WeZ5WpcxyUORJ22yn4lft9P9O6ix1X2t2RVLSXncAzJwDgwKonGmQ8-kXbY2Q0AMhUpxFrU3RlnoNCjsSHy-6AM3Mg:1vXmgp:Gcl_cdk4jh2bNP35vzzvtXSuuPJqRjoF2U1qVTSAflE','2026-01-05 20:39:35.531582'),
('gmx8rosvhclry9h6i8ecd8xl4o01bx89','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vYPk6:2AT25es1p_g_p6t2ltj1vKqT1YMaxh42HRj5zO0nBAQ','2026-01-07 14:21:34.695665'),
('w5v6wdf0kzqaadyjfq051j3etgk446sj','.eJxVjEEOwiAQRe_C2hBKhSku3fcMZJgBqRpISrsyvXtt0oVu_3vvf4THdcl-bXH2E4ubcOLyuwWkVywH4CeWR5VUyzJPQR6KPGmTY-X4vp_u30HGlr-1Cf2gUowMBColIDJkNPeIGnXnFDMMbEE57IJTV0oG0IIFDGxJE4ttBwiXOMc:1vYE5n:i3XYiUJp3a3Pc3uWFq3A5wAGbGeT8bWJsdAqYD9bY7M','2026-01-07 01:55:11.832686'),
('8dnx1jw2s23ol8fm8qkp23svx3cyxfsh','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vYL9S:FQFU1yHmdzSv2nkTB5enNjQ01v3L_C6_KNwCfu8_7g8','2026-01-07 09:27:26.290027'),
('jq63wk03jya6c7deghnk59dvc6ymgiya','.eJxVjEEOwiAQRe_C2hBKhSku3fcMZJgBqRpISrsyvXtt0oVu_3vvf4THdcl-bXH2E4ubcOLyuwWkVywH4CeWR5VUyzJPQR6KPGmTY-X4vp_u30HGlr-1Cf2gUowMBColIDJkNPeIGnXnFDMMbEE57IJTV0oG0IIFDGxJE4ttBwiXOMc:1vetaQ:0A9kGEXX9civZAW5r6P27vxBoNIXy_NajFIaKI3j4jY','2026-01-25 11:26:22.601771'),
('aa3vtlbh2hp80nnjf7kqn5nc82fwqekf','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vYESp:jrHOE4roMmfZWQZJFy_AmD_WtAGww-8HJXWxl68qJ8U','2026-01-07 02:18:59.115401'),
('d1fds5t0vvr6xl8j0e1kp8i7i3ggt932','.eJxVjMsOwiAQRf-FtSEDnQng0r3fQHgMUjWQlHZl_Hdt0oVu7znnvoQP21r9NnjxcxZnoVCcfscY0oPbTvI9tFuXqbd1maPcFXnQIa898_NyuH8HNYz6rY1xORqAwrEgGSw6FYdEKjqFGoDyRM5OENgQokZn0KKiiTWCBWbx_gDmLzaS:1vfkQp:ZJkBnhuTpVY_1np7YUy4sTgfdxha17ttHPl7X3x0wOo','2026-01-27 19:51:59.514632'),
('jh8ab2y9q8q0wr8z8rzo11kostzozb6c','.eJxVjEEOwiAQRe_C2hBKhSku3fcMZJgBqRpISrsyvXtt0oVu_3vvf4THdcl-bXH2E4ubcOLyuwWkVywH4CeWR5VUyzJPQR6KPGmTY-X4vp_u30HGlr-1Cf2gUowMBColIDJkNPeIGnXnFDMMbEE57IJTV0oG0IIFDGxJE4ttBwiXOMc:1vfL7s:hI9qNvqj02tWU8nKOtJNjv4bRkH9rYSaPhW-Bpx1Xbg','2026-01-26 16:50:44.601810'),
('wop9cfbry5pdi89hdvaxvo8yhvmc3rgs','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vf7U3:-UycLy_t2F83PsmkFn7iVvzmGlNm_lKwMHeOjiOVRuU','2026-01-26 02:16:43.750362'),
('32y8b5zb1ypnee4rfqln7uky6p51f1zx','.eJxVjEEOwiAQRe_C2pACZQCX7j0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnEWKojT75iQHrnthO_YbrOkua3LlOSuyIN2eZ05Py-H-3dQsddvPeqgwkCgNAH6YGi0idlYr7y2OXMqFqwBX0pwhnTytjgHPKiCHsCxeH8A79U3ng:1vf2Wq:Cipd8JdFzx887rU7HTWAHhJ_l477RzM_R48kw9c-G5U','2026-01-25 20:59:16.419154'),
('uva08mqj7ubo65unl10ps119ypxpqroz','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vf7U4:JJ6MGyMkWuBXETRmxWZ2ffpiJpzTihnoCujyib3rGSw','2026-01-26 02:16:44.326699'),
('uj1wfhplmg7qehl1t7k5lz3b1shjk1wh','.eJxVjEEOwiAQRe_C2hA6FNq6dN8zkIGZkaqhSWlXxrsbki50-997_60CHnsOR-UtLKSuCoy6_I4R05NLI_TAcl91Wsu-LVE3RZ-06nklft1O9-8gY82tBuCI4gZ0UVJnQQCEfI-dHcWMbC0DOjI9DWbygo4h-QktRCAhYfX5AiWPORI:1vfOor:aHH93ChaOQTPgZ6FhsHifpFgqKatqMtucajChsGwgbY','2026-01-26 20:47:21.609699'),
('9kurp5dxb6p29de2yngl7lfi8tx622ad','.eJxVjEEOwiAQAP_C2ZCy1AoevfcNZNldpGogKe3J-Het6UGvM5N5qoDrksPaZA4Tq7MCow6_MCLdpWyGb1iuVVMtyzxFvSV6t02PleVx2du_QcaWv9_UW-dxYMvORIABU_LxRBascUdh8UnEmM4SOflQAo4emH3qOxFUrzcQKjjy:1vfNrT:yAiNee1Y8fMzv9VQTHYNU38OuoMfqHpyMoN-UN3IhHM','2026-01-26 19:45:59.483751'),
('chyki3wbg1qh2cy59cl4x1yc5sphkhji','.eJxVjDsOwjAQBe_iGlm7IfGHkj5niHbXNg4gW4qTCnF3iJQC2jcz76Um2tY8bS0u0xzUReFZnX5HJnnEspNwp3KrWmpZl5n1ruiDNj3WEJ_Xw_07yNTytx48dNEyoScC55DJGJRkDbB4iNRbCyEADUnQozeDROkYMYE3qWen3h8HZDgo:1vfTpM:zkxemVqYOUzorST0dRiGTD4AR3JvAoWZhxT-HY2yiNw','2026-01-27 02:08:12.894856');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser`
--

DROP TABLE IF EXISTS `users_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `country` varchar(2) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser`
--

LOCK TABLES `users_customuser` WRITE;
/*!40000 ALTER TABLE `users_customuser` DISABLE KEYS */;
INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `username`, `email`, `full_name`, `country`, `date_joined`) VALUES (13,'pbkdf2_sha256$600000$5mbQE3uBrF9NNTpi2sLer4$VdvEYwm/uDHbatyADi2JrRFI7zE0raUfbBrIO3GFVIg=','2026-01-13 02:08:12.884384',0,'Ramona','Brockett',0,1,'Ramona','drramonabrockett@yahoo.com','Ramona Brocket','','2025-12-23 18:04:08.062485'),
(14,'pbkdf2_sha256$600000$cA0OAsyCQE4N5uHiHsP4el$ua4hlTFNuQ9fE7eY2VZWSHpf/nLZVxLLa5wAKwiAN8M=','2026-01-13 19:51:59.512077',0,'Willie','Turner',0,1,'','turnerwd57@gmail.com',NULL,'','2025-12-25 21:16:18.760254'),
(9,'pbkdf2_sha256$600000$pTHFusPOfEghL5sgRjxfQO$27uNPZ7XtBFu5OXb3PZUtD8yzaSs/8nEWuFFYMRbzcQ=','2026-01-12 16:50:44.600494',1,'kent','ken',1,1,'finnex','admin@finnexglobecon.com','patrick winny','','2025-12-23 15:42:47.076841'),
(17,'pbkdf2_sha256$600000$yyuLQgc0vogcwW76g99ua2$naHd2y1PecP6l9fUv5nt/P8QjYrb0degmkhwWE1hzf0=',NULL,0,'Khalid','Carry',0,1,NULL,'kimj80396@gmail.com',NULL,'','2026-01-10 23:17:57.136515'),
(19,'pbkdf2_sha256$600000$Dba7UcXkZtyTrHOrT66l5F$I3G71WCj+eDmR9xQ7GyuliGgDqt7ha6mHA66KJs0QNQ=','2026-01-11 20:59:16.417294',0,'Md Mamun','chaudhary',0,1,NULL,'mdmamunchaudhary562@gmail.com',NULL,'','2026-01-11 20:58:07.370011'),
(20,'pbkdf2_sha256$600000$1FUbRuYsSUqTREIymul9rj$7hnY4g5nozGaH9F5bsRUmsLn9k1NxvBavH0+83eCX/g=','2026-01-12 20:47:21.608249',0,'Reginald','Patton',0,1,NULL,'rlpatton35@gmail.com',NULL,'','2026-01-12 16:07:19.806484'),
(21,'pbkdf2_sha256$600000$aC0WR8UTbec5w0a71oEmGN$dLFfgj3Wq3NE0UHA2Wkw8NS10mS0C91LfUkBOG55p1I=','2026-01-12 19:45:59.481683',0,'Steph','Evans',0,1,NULL,'Stephanieevans271@gmail.com',NULL,'','2026-01-12 16:35:39.029854');
/*!40000 ALTER TABLE `users_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_groups`
--

DROP TABLE IF EXISTS `users_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  KEY `users_customuser_groups_customuser_id_958147bf` (`customuser_id`),
  KEY `users_customuser_groups_group_id_01390b14` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_groups`
--

LOCK TABLES `users_customuser_groups` WRITE;
/*!40000 ALTER TABLE `users_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_user_permissions`
--

DROP TABLE IF EXISTS `users_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  KEY `users_customuser_user_permissions_customuser_id_5771478b` (`customuser_id`),
  KEY `users_customuser_user_permissions_permission_id_baaa2f74` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_user_permissions`
--

LOCK TABLES `users_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'peophtkq_FINNEX_NEW_DB'
--

--
-- Dumping routines for database 'peophtkq_FINNEX_NEW_DB'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-01-13 16:57:04
