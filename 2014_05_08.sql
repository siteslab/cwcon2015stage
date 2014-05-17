-- MySQL dump 10.13  Distrib 5.1.67, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: siteslab_2014pro
-- ------------------------------------------------------
-- Server version	5.1.67-rel14.3-log

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
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `actions` VALUES ('comment_publish_action','comment','comment_publish_action','','Publish comment'),('comment_save_action','comment','comment_save_action','','Save comment'),('comment_unpublish_action','comment','comment_unpublish_action','','Unpublish comment'),('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky'),('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky'),('node_promote_action','node','node_promote_action','','Promote content to front page'),('node_publish_action','node','node_publish_action','','Publish content'),('node_save_action','node','node_save_action','','Save content'),('node_unpromote_action','node','node_unpromote_action','','Remove content from front page'),('node_unpublish_action','node','node_unpublish_action','','Unpublish content'),('pathauto_node_update_action','node','pathauto_node_update_action','','Update node alias'),('pathauto_taxonomy_term_update_action','taxonomy_term','pathauto_taxonomy_term_update_action','','Update taxonomy term alias'),('pathauto_user_update_action','user','pathauto_user_update_action','','Update user alias'),('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user'),('user_block_user_action','user','user_block_user_action','','Block current user'),('views_bulk_operations_archive_action','file','views_bulk_operations_archive_action','','Create an archive of selected files'),('views_bulk_operations_argument_selector_action','entity','views_bulk_operations_argument_selector_action','','Pass ids as arguments to a page'),('views_bulk_operations_delete_item','entity','views_bulk_operations_delete_item','','Delete item'),('views_bulk_operations_modify_action','entity','views_bulk_operations_modify_action','','Modify entity values');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `advanced_help_index`
--

DROP TABLE IF EXISTS `advanced_help_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advanced_help_index` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary key to give to the search engine for this topic.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module that owns this topic.',
  `topic` varchar(255) NOT NULL DEFAULT '' COMMENT 'The topic id.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this search index relates to.',
  PRIMARY KEY (`sid`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search index correlations for advanced help topics.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advanced_help_index`
--

LOCK TABLES `advanced_help_index` WRITE;
/*!40000 ALTER TABLE `advanced_help_index` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `advanced_help_index` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authmap`
--

LOCK TABLES `authmap` WRITE;
/*!40000 ALTER TABLE `authmap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `authmap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `block` VALUES (1,'system','main','bartik',1,0,'content',0,0,'','',-1),(2,'search','form','bartik',0,-1,'-1',0,0,'abstracts','',-1),(3,'node','recent','seven',1,10,'dashboard_inactive',0,0,'','',-1),(4,'user','login','bartik',1,-9,'sidebar_first',0,0,'','',-1),(5,'system','navigation','bartik',0,0,'-1',0,0,'','',-1),(6,'system','powered-by','bartik',1,-8,'footer',0,0,'','',-1),(7,'system','help','bartik',1,0,'help',0,0,'','',-1),(8,'system','main','seven',1,0,'content',0,0,'','',-1),(9,'system','help','seven',1,0,'help',0,0,'','',-1),(10,'user','login','seven',1,10,'content',0,0,'','',-1),(11,'user','new','seven',1,0,'dashboard_inactive',0,0,'','',-1),(12,'search','form','seven',1,-10,'dashboard_inactive',0,0,'abstracts','',-1),(13,'comment','recent','bartik',0,0,'-1',0,1,'<front>','',1),(14,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1),(15,'node','recent','bartik',0,0,'-1',0,0,'','',1),(16,'shortcut','shortcuts','bartik',0,0,'-1',0,0,'','',-1),(17,'system','management','bartik',0,0,'-1',0,0,'','',-1),(18,'system','user-menu','bartik',0,0,'-1',0,0,'abstracts','<none>',-1),(19,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1),(20,'user','new','bartik',0,0,'-1',0,0,'','',1),(21,'user','online','bartik',0,0,'-1',0,0,'','',-1),(22,'comment','recent','seven',1,0,'dashboard_inactive',0,1,'<front>','',1),(23,'node','syndicate','seven',0,0,'-1',0,0,'','',-1),(24,'shortcut','shortcuts','seven',0,0,'-1',0,0,'','',-1),(25,'system','powered-by','seven',0,10,'-1',0,0,'','',-1),(26,'system','navigation','seven',0,0,'-1',0,0,'','',-1),(27,'system','management','seven',0,0,'-1',0,0,'','',-1),(28,'system','user-menu','seven',0,0,'-1',0,0,'abstracts','<none>',-1),(29,'system','main-menu','seven',0,0,'-1',0,0,'','',-1),(30,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1),(31,'forum','active','bartik',0,0,'-1',0,0,'','',-2),(32,'forum','new','bartik',0,0,'-1',0,0,'','',-2),(33,'forum','active','seven',1,0,'dashboard_inactive',0,0,'','',-2),(34,'forum','new','seven',1,0,'dashboard_inactive',0,0,'','',-2),(35,'menu','menu-submitter-menu','bartik',0,0,'-1',0,0,'','',-1),(36,'menu','menu-submitter-menu','seven',0,0,'-1',0,0,'','',-1),(37,'block','1','bartik',0,-10,'-1',0,0,'','Cogs',-1),(38,'block','1','seven',0,0,'-1',0,0,'','Cogs',-1),(39,'menu','menu-front-page-menu','bartik',1,-10,'sidebar_first',0,1,'<front>','',-1),(40,'menu','menu-front-page-menu','seven',0,0,'-1',0,1,'<front>','',-1),(41,'block','1','zen',1,-10,'navigation',0,0,'','Cogs',-1),(42,'comment','recent','zen',0,0,'-1',0,1,'<front>','',1),(43,'forum','active','zen',0,0,'-1',0,0,'','',-2),(44,'forum','new','zen',0,0,'-1',0,0,'','',-2),(45,'menu','menu-front-page-menu','zen',0,0,'-1',0,1,'<front>','',-1),(46,'menu','menu-submitter-menu','zen',0,0,'-1',0,0,'','',-1),(47,'node','recent','zen',0,0,'-1',0,0,'','',1),(48,'node','syndicate','zen',0,0,'-1',0,0,'','',-1),(49,'search','form','zen',0,-1,'-1',0,0,'abstracts','',-1),(50,'shortcut','shortcuts','zen',0,0,'-1',0,0,'','',-1),(51,'system','help','zen',1,0,'help',0,0,'','',-1),(52,'system','main','zen',1,0,'content',0,0,'','',-1),(53,'system','main-menu','zen',0,0,'-1',0,0,'','',-1),(54,'system','management','zen',0,0,'-1',0,0,'','',-1),(55,'system','navigation','zen',0,0,'-1',0,0,'','',-1),(56,'system','powered-by','zen',1,-8,'footer',0,0,'','',-1),(57,'system','user-menu','zen',0,0,'-1',0,0,'abstracts','<none>',-1),(58,'user','login','zen',1,0,'sidebar_first',0,0,'','',-1),(59,'user','new','zen',0,0,'-1',0,0,'','',1),(60,'user','online','zen',0,0,'-1',0,0,'','',-1),(61,'block','1','cwcon2013',1,-10,'navigation',0,0,'','Cogs',-1),(62,'comment','recent','cwcon2013',0,0,'-1',0,1,'<front>','',1),(63,'forum','active','cwcon2013',0,0,'-1',0,0,'','',-2),(64,'forum','new','cwcon2013',0,0,'-1',0,0,'','',-2),(65,'menu','menu-front-page-menu','cwcon2013',0,0,'-1',0,1,'<front>','',-1),(66,'menu','menu-submitter-menu','cwcon2013',0,0,'-1',0,0,'','',-1),(67,'node','recent','cwcon2013',0,0,'-1',0,0,'','',1),(68,'node','syndicate','cwcon2013',0,0,'-1',0,0,'','',-1),(69,'search','form','cwcon2013',0,-1,'-1',0,0,'abstracts','',-1),(70,'shortcut','shortcuts','cwcon2013',0,0,'-1',0,0,'','',-1),(71,'system','help','cwcon2013',1,0,'help',0,0,'','',-1),(72,'system','main','cwcon2013',1,0,'content',0,0,'','',-1),(73,'system','main-menu','cwcon2013',0,0,'-1',0,0,'','',-1),(74,'system','management','cwcon2013',0,0,'-1',0,0,'','',-1),(75,'system','navigation','cwcon2013',0,0,'-1',0,0,'','',-1),(76,'system','powered-by','cwcon2013',1,-8,'footer',0,0,'','',-1),(77,'system','user-menu','cwcon2013',0,0,'-1',0,0,'abstracts','<none>',-1),(78,'user','login','cwcon2013',1,0,'sidebar_first',0,0,'','',-1),(79,'user','new','cwcon2013',0,0,'-1',0,0,'','',1),(80,'user','online','cwcon2013',0,0,'-1',0,0,'','',-1),(81,'block','2','bartik',0,0,'-1',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(82,'block','2','cwcon2013',0,0,'',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(83,'block','2','seven',0,0,'-1',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(84,'block','2','zen',0,0,'',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(85,'block','1','cw2013',0,-10,'-1',0,0,'','Cogs',-1),(86,'block','2','cw2013',1,-9,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(87,'comment','recent','cw2013',0,0,'-1',0,1,'<front>','',1),(88,'forum','active','cw2013',0,0,'-1',0,0,'','',-2),(89,'forum','new','cw2013',0,0,'-1',0,0,'','',-2),(90,'menu','menu-front-page-menu','cw2013',1,-11,'sidebar_first',0,1,'<front>','',-1),(91,'menu','menu-submitter-menu','cw2013',0,0,'-1',0,0,'','',-1),(92,'node','recent','cw2013',0,0,'-1',0,0,'','',1),(93,'node','syndicate','cw2013',0,0,'-1',0,0,'','',-1),(94,'search','form','cw2013',1,-1,'user_first',0,0,'abstracts','',-1),(95,'shortcut','shortcuts','cw2013',0,0,'-1',0,0,'','',-1),(96,'system','help','cw2013',0,0,'-1',0,0,'','',-1),(97,'system','main','cw2013',1,0,'content',0,0,'','',-1),(98,'system','main-menu','cw2013',0,0,'-1',0,0,'','',-1),(99,'system','management','cw2013',0,0,'-1',0,0,'','',-1),(100,'system','navigation','cw2013',0,0,'-1',0,0,'','',-1),(101,'system','powered-by','cw2013',1,-8,'footer_first',0,0,'','',-1),(102,'system','user-menu','cw2013',0,0,'-1',0,0,'abstracts','<none>',-1),(103,'user','login','cw2013',1,-10,'sidebar_first',0,0,'','',-1),(104,'user','new','cw2013',0,0,'-1',0,0,'','',1),(105,'user','online','cw2013',0,0,'-1',0,0,'','',-1),(106,'block','3','bartik',0,0,'-1',0,0,'','<none>',-1),(107,'block','3','cw2013',1,0,'preface_first',0,0,'','<none>',-1),(108,'block','3','seven',0,0,'-1',0,0,'','<none>',-1),(109,'masquerade','masquerade','bartik',0,0,'-1',0,0,'count/proposals','',-1),(110,'masquerade','masquerade','cw2013',1,0,'user_first',0,0,'count/proposals','',-1),(111,'masquerade','masquerade','seven',0,0,'-1',0,0,'count/proposals','',-1),(112,'superfish','1','bartik',0,0,'-1',0,0,'','<none>',-1),(113,'superfish','2','bartik',0,0,'-1',0,0,'','',-1),(114,'superfish','3','bartik',0,0,'-1',0,0,'','',-1),(115,'superfish','4','bartik',0,0,'-1',0,0,'','',-1),(116,'superfish','1','cw2013',0,0,'-1',0,0,'','<none>',-1),(117,'superfish','2','cw2013',0,0,'-1',0,0,'','',-1),(118,'superfish','3','cw2013',0,0,'-1',0,0,'','',-1),(119,'superfish','4','cw2013',0,0,'-1',0,0,'','',-1),(120,'superfish','1','seven',0,0,'-1',0,0,'','<none>',-1),(121,'superfish','2','seven',0,0,'-1',0,0,'','',-1),(122,'superfish','3','seven',0,0,'-1',0,0,'','',-1),(123,'superfish','4','seven',0,0,'-1',0,0,'','',-1),(124,'block','1','nucleus',0,-10,'-1',0,0,'','Cogs',-1),(125,'block','2','nucleus',1,-9,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(126,'block','3','nucleus',1,0,'content',0,0,'','<none>',-1),(127,'comment','recent','nucleus',0,0,'-1',0,1,'<front>','',1),(128,'forum','active','nucleus',0,0,'-1',0,0,'','',-2),(129,'forum','new','nucleus',0,0,'-1',0,0,'','',-2),(130,'masquerade','masquerade','nucleus',1,0,'content',0,0,'count/proposals','',-1),(131,'menu','menu-front-page-menu','nucleus',1,-11,'sidebar_first',0,1,'<front>','',-1),(132,'menu','menu-submitter-menu','nucleus',0,0,'-1',0,0,'','',-1),(133,'node','recent','nucleus',0,0,'-1',0,0,'','',1),(134,'node','syndicate','nucleus',0,0,'-1',0,0,'','',-1),(135,'search','form','nucleus',1,-1,'content',0,0,'abstracts','',-1),(136,'shortcut','shortcuts','nucleus',0,0,'-1',0,0,'','',-1),(137,'superfish','1','nucleus',0,0,'-1',0,0,'','<none>',-1),(138,'superfish','2','nucleus',0,0,'-1',0,0,'','',-1),(139,'superfish','3','nucleus',0,0,'-1',0,0,'','',-1),(140,'superfish','4','nucleus',0,0,'-1',0,0,'','',-1),(141,'system','help','nucleus',0,0,'-1',0,0,'','',-1),(142,'system','main','nucleus',1,0,'content',0,0,'','',-1),(143,'system','main-menu','nucleus',0,0,'-1',0,0,'','',-1),(144,'system','management','nucleus',0,0,'-1',0,0,'','',-1),(145,'system','navigation','nucleus',0,0,'-1',0,0,'','',-1),(146,'system','powered-by','nucleus',1,-8,'content',0,0,'','',-1),(147,'system','user-menu','nucleus',0,0,'-1',0,0,'abstracts','<none>',-1),(148,'user','login','nucleus',1,-10,'sidebar_first',0,0,'','',-1),(149,'user','new','nucleus',0,0,'-1',0,0,'','',1),(150,'user','online','nucleus',0,0,'-1',0,0,'','',-1),(151,'block','1','tb_events',0,-10,'-1',0,0,'','Cogs',-1),(152,'block','2','tb_events',1,-16,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(153,'block','3','tb_events',0,-11,'-1',0,0,'','<none>',-1),(154,'comment','recent','tb_events',0,-17,'-1',0,1,'<front>','',1),(155,'forum','active','tb_events',0,0,'-1',0,0,'','',-2),(156,'forum','new','tb_events',0,0,'-1',0,0,'','',-2),(157,'masquerade','masquerade','tb_events',1,-22,'sidebar_first',0,0,'count/proposals','',-1),(158,'menu','menu-front-page-menu','tb_events',0,-18,'-1',0,1,'<front>','',-1),(159,'menu','menu-submitter-menu','tb_events',0,0,'-1',0,0,'','',-1),(160,'node','recent','tb_events',0,0,'-1',0,0,'','',1),(161,'node','syndicate','tb_events',0,0,'-1',0,0,'','',-1),(162,'search','form','tb_events',0,-19,'-1',0,0,'abstracts','',-1),(163,'shortcut','shortcuts','tb_events',0,0,'-1',0,0,'','',-1),(164,'superfish','1','tb_events',1,-20,'menu_bar',0,0,'','<none>',-1),(165,'superfish','2','tb_events',0,0,'-1',0,0,'','',-1),(166,'superfish','3','tb_events',0,0,'-1',0,0,'','',-1),(167,'superfish','4','tb_events',0,0,'-1',0,0,'','',-1),(168,'system','help','tb_events',0,0,'-1',0,0,'','',-1),(169,'system','main','tb_events',1,-22,'content',0,0,'','',-1),(170,'system','main-menu','tb_events',0,0,'-1',0,0,'','',-1),(171,'system','management','tb_events',0,0,'-1',0,0,'','',-1),(172,'system','navigation','tb_events',0,0,'-1',0,0,'','',-1),(173,'system','powered-by','tb_events',0,-8,'-1',0,0,'','',-1),(174,'system','user-menu','tb_events',1,-12,'sidebar_first',0,0,'abstracts','<none>',-1),(175,'user','login','tb_events',1,-21,'sidebar_first',0,0,'','',-1),(176,'user','new','tb_events',0,0,'-1',0,0,'','',1),(177,'user','online','tb_events',0,0,'-1',0,0,'','',-1),(178,'views','featured_session_slider-block','cw2013',0,0,'-1',0,1,'slideshows','<none>',-1),(179,'views','featured_session_slider-block','tb_events',0,-22,'-1',0,1,'slideshows','<none>',-1),(180,'views','featured_session_slider-block','bartik',0,0,'-1',0,1,'slideshows','<none>',-1),(181,'views','featured_session_slider-block','nucleus',0,0,'-1',0,1,'slideshows','<none>',-1),(182,'views','featured_session_slider-block','seven',0,0,'-1',0,1,'slideshows','<none>',-1),(183,'menu','features','bartik',0,0,'-1',0,0,'','',-1),(184,'menu','features','cw2013',0,0,'-1',0,0,'','',-1),(185,'menu','features','nucleus',0,0,'-1',0,0,'','',-1),(186,'menu','features','seven',0,0,'-1',0,0,'','',-1),(187,'menu','features','tb_events',0,0,'-1',0,0,'','',-1),(188,'views','cfc850c1b5c51918e2cc56dfe57b3339','bartik',0,0,'-1',0,1,'<front>','Cwcon Video Archive',-1),(189,'views','cfc850c1b5c51918e2cc56dfe57b3339','cw2013',0,0,'-1',0,1,'<front>','Cwcon Video Archive',-1),(190,'views','cfc850c1b5c51918e2cc56dfe57b3339','nucleus',0,0,'-1',0,1,'<front>','Cwcon Video Archive',-1),(191,'views','cfc850c1b5c51918e2cc56dfe57b3339','seven',0,0,'-1',0,1,'<front>','Cwcon Video Archive',-1),(192,'views','cfc850c1b5c51918e2cc56dfe57b3339','tb_events',0,-13,'-1',0,1,'<front>','Cwcon Video Archive',-1),(193,'calendar','calendar_legend','bartik',0,0,'-1',0,0,'','',1),(194,'calendar','calendar_legend','cw2013',0,0,'-1',0,0,'','',1),(195,'calendar','calendar_legend','nucleus',0,0,'-1',0,0,'','',1),(196,'calendar','calendar_legend','seven',0,0,'-1',0,0,'','',1),(197,'calendar','calendar_legend','tb_events',0,0,'-1',0,0,'','',1),(198,'views','conference_calendar-block_1','bartik',0,0,'-1',0,0,'','',-1),(199,'views','conference_calendar-block_2','bartik',0,0,'-1',0,0,'','',-1),(200,'views','conference_calendar-block_1','cw2013',0,0,'-1',0,0,'','',-1),(201,'views','conference_calendar-block_2','cw2013',0,0,'-1',0,0,'','',-1),(202,'views','conference_calendar-block_1','nucleus',0,0,'-1',0,0,'','',-1),(203,'views','conference_calendar-block_2','nucleus',0,0,'-1',0,0,'','',-1),(204,'views','conference_calendar-block_1','seven',0,0,'-1',0,0,'','',-1),(205,'views','conference_calendar-block_2','seven',0,0,'-1',0,0,'','',-1),(206,'views','conference_calendar-block_1','tb_events',0,0,'-1',0,0,'','',-1),(207,'views','conference_calendar-block_2','tb_events',0,0,'-1',0,0,'','',-1),(208,'diff','inline','bartik',0,0,'-1',0,0,'','',1),(209,'diff','inline','cw2013',0,0,'-1',0,0,'','',1),(210,'diff','inline','nucleus',0,0,'-1',0,0,'','',1),(211,'diff','inline','seven',0,0,'-1',0,0,'','',1),(212,'diff','inline','tb_events',0,0,'-1',0,0,'','',1),(213,'menu','menu-presenters','bartik',0,0,'-1',0,0,'','',-1),(214,'menu','menu-presenters','cw2013',0,0,'-1',0,0,'','',-1),(215,'menu','menu-presenters','nucleus',0,0,'-1',0,0,'','',-1),(216,'menu','menu-presenters','seven',0,0,'-1',0,0,'','',-1),(217,'menu','menu-presenters','tb_events',0,0,'-1',0,0,'','',-1),(218,'block','4','bartik',0,0,'-1',0,1,'<front>','',-1),(219,'block','4','cw2013',0,0,'-1',0,1,'<front>','',-1),(220,'block','4','nucleus',0,0,'-1',0,1,'<front>','',-1),(221,'block','4','seven',0,0,'-1',0,1,'<front>','',-1),(222,'block','4','tb_events',0,0,'-1',0,1,'<front>','',-1),(223,'sharethis','sharethis_block','bartik',0,0,'-1',0,0,'','',1),(224,'sharethis','sharethis_block','cw2013',0,0,'-1',0,0,'','',1),(225,'sharethis','sharethis_block','nucleus',0,0,'-1',0,0,'','',1),(226,'sharethis','sharethis_block','seven',0,0,'-1',0,0,'','',1),(227,'sharethis','sharethis_block','tb_events',0,0,'-1',0,0,'','',1),(228,'views','boosted_session_slideshow-block','bartik',0,0,'-1',0,1,'slideshows','Boosted Sessions',-1),(229,'views','boosted_session_slideshow-block','cw2013',0,0,'-1',0,1,'slideshows','Boosted Sessions',-1),(230,'views','boosted_session_slideshow-block','nucleus',0,0,'-1',0,1,'slideshows','Boosted Sessions',-1),(231,'views','boosted_session_slideshow-block','seven',0,0,'-1',0,1,'slideshows','Boosted Sessions',-1),(232,'views','boosted_session_slideshow-block','tb_events',0,-15,'-1',0,1,'slideshows','Boosted Sessions',-1),(233,'views','just_updated_slideshow-block','tb_events',0,-14,'-1',0,1,'slideshows','<none>',-1),(234,'views','just_updated_slideshow-block','bartik',0,0,'-1',0,1,'slideshows','<none>',-1),(235,'views','just_updated_slideshow-block','cw2013',0,0,'-1',0,1,'slideshows','<none>',-1),(236,'views','just_updated_slideshow-block','nucleus',0,0,'-1',0,1,'slideshows','<none>',-1),(237,'views','just_updated_slideshow-block','seven',0,0,'-1',0,1,'slideshows','<none>',-1),(238,'print','print-links','bartik',0,0,'-1',0,0,'','',4),(239,'print','print-top','bartik',0,0,'-1',0,0,'','',8),(240,'print_pdf','print_pdf-top','bartik',0,0,'-1',0,0,'','',8),(241,'print','print-links','cw2013',0,0,'-1',0,0,'','',4),(242,'print','print-top','cw2013',0,0,'-1',0,0,'','',8),(243,'print_pdf','print_pdf-top','cw2013',0,0,'-1',0,0,'','',8),(244,'print','print-links','nucleus',0,0,'-1',0,0,'','',4),(245,'print','print-top','nucleus',0,0,'-1',0,0,'','',8),(246,'print_pdf','print_pdf-top','nucleus',0,0,'-1',0,0,'','',8),(247,'print','print-links','seven',0,0,'-1',0,0,'','',4),(248,'print','print-top','seven',0,0,'-1',0,0,'','',8),(249,'print_pdf','print_pdf-top','seven',0,0,'-1',0,0,'','',8),(250,'print','print-links','tb_events',0,0,'-1',0,0,'','',4),(251,'print','print-top','tb_events',0,0,'-1',0,0,'','',8),(252,'print_pdf','print_pdf-top','tb_events',0,0,'-1',0,0,'','',8),(253,'views','volunteer_list-block_1','tb_events',0,-20,'',0,1,'<front>','Volunteer Spotlight',-1),(254,'views','volunteer_list-block_1','bartik',0,0,'-1',0,1,'<front>','Volunteer Spotlight',-1),(255,'views','volunteer_list-block_1','cw2013',0,0,'-1',0,1,'<front>','Volunteer Spotlight',-1),(256,'views','volunteer_list-block_1','nucleus',0,0,'-1',0,1,'<front>','Volunteer Spotlight',-1),(257,'views','volunteer_list-block_1','seven',0,0,'-1',0,1,'<front>','Volunteer Spotlight',-1),(263,'fancy_login','fancy_login_login_block','bartik',0,0,'-1',0,0,'Array','',-1),(264,'fancy_login','fancy_login_login_block','cw2013',0,0,'-1',0,0,'Array','',-1),(265,'fancy_login','fancy_login_login_block','nucleus',0,0,'-1',0,0,'Array','',-1),(266,'fancy_login','fancy_login_login_block','seven',0,0,'-1',0,0,'Array','',-1),(267,'fancy_login','fancy_login_login_block','tb_events',0,0,'-1',0,0,'Array','',-1),(268,'community_tags','0','bartik',0,0,'-1',0,0,'','Session Tags',-1),(269,'community_tags','0','cw2013',0,0,'-1',0,0,'','Session Tags',-1),(270,'community_tags','0','nucleus',0,0,'-1',0,0,'','Session Tags',-1),(271,'community_tags','0','seven',0,0,'-1',0,0,'','Session Tags',-1),(272,'community_tags','0','tb_events',0,-20,'-1',0,0,'','Session Tags',-1),(273,'views','tweets-block','bartik',0,0,'-1',0,0,'','',-1),(274,'views','tweets-block','cw2013',0,0,'-1',0,0,'','',-1),(275,'views','tweets-block','nucleus',0,0,'-1',0,0,'','',-1),(276,'views','tweets-block','seven',0,0,'-1',0,0,'','',-1),(277,'views','tweets-block','tb_events',0,0,'-1',0,0,'','',-1),(278,'views','session_video_slideshow-block','tb_events',0,-10,'-1',0,1,'<front>','',-1),(279,'views','session_video_slideshow-block','bartik',0,0,'-1',0,1,'<front>','',-1),(280,'views','session_video_slideshow-block','cw2013',0,0,'-1',0,1,'<front>','',-1),(281,'views','session_video_slideshow-block','nucleus',0,0,'-1',0,1,'<front>','',-1),(282,'views','session_video_slideshow-block','seven',0,0,'-1',0,1,'<front>','',-1),(283,'node_comment_block','node_comments','bartik',0,0,'-1',0,0,'','',1),(284,'node_comment_block','node_comments','cw2013',0,0,'-1',0,0,'','',1),(285,'node_comment_block','node_comments','nucleus',0,0,'-1',0,0,'','',1),(286,'node_comment_block','node_comments','seven',0,0,'-1',0,0,'','',1),(287,'node_comment_block','node_comments','tb_events',0,-11,'-1',0,0,'','',1),(288,'views','related_sessions-block','tb_events',0,-19,'-1',0,0,'','',-1),(289,'views','related_sessions-block','bartik',0,0,'-1',0,0,'','',-1),(290,'views','related_sessions-block','cw2013',0,0,'-1',0,0,'','',-1),(291,'views','related_sessions-block','nucleus',0,0,'-1',0,0,'','',-1),(292,'views','related_sessions-block','seven',0,0,'-1',0,0,'','',-1),(293,'devel','execute_php','bartik',0,0,'-1',0,0,'','',-1),(294,'devel','switch_user','bartik',0,0,'-1',0,0,'','',-1),(295,'menu','devel','bartik',0,0,'-1',0,0,'','',-1),(296,'devel','execute_php','cw2013',0,0,'-1',0,0,'','',-1),(297,'devel','switch_user','cw2013',0,0,'-1',0,0,'','',-1),(298,'menu','devel','cw2013',0,0,'-1',0,0,'','',-1),(299,'devel','execute_php','nucleus',0,0,'-1',0,0,'','',-1),(300,'devel','switch_user','nucleus',0,0,'-1',0,0,'','',-1),(301,'menu','devel','nucleus',0,0,'-1',0,0,'','',-1),(302,'devel','execute_php','seven',0,0,'-1',0,0,'','',-1),(303,'devel','switch_user','seven',0,0,'-1',0,0,'','',-1),(304,'menu','devel','seven',0,0,'-1',0,0,'','',-1),(305,'devel','execute_php','tb_events',0,0,'-1',0,0,'','',-1),(306,'devel','switch_user','tb_events',0,0,'-1',0,0,'','',-1),(307,'menu','devel','tb_events',0,0,'-1',0,0,'','',-1),(308,'views','10c58bded9e09ce0212a929eb8617e04','tb_events',0,-23,'-1',0,1,'<front>','Online Conference Events',-1),(309,'views','10c58bded9e09ce0212a929eb8617e04','bartik',0,0,'-1',0,1,'<front>','Online Conference Events',-1),(310,'views','10c58bded9e09ce0212a929eb8617e04','cw2013',0,0,'-1',0,1,'<front>','Online Conference Events',-1),(311,'views','10c58bded9e09ce0212a929eb8617e04','nucleus',0,0,'-1',0,1,'<front>','Online Conference Events',-1),(312,'views','10c58bded9e09ce0212a929eb8617e04','seven',0,0,'-1',0,1,'<front>','Online Conference Events',-1),(313,'views','10c58bded9e09ce0212a929eb8617e04','cw2014',0,-23,'-1',0,1,'<front>','Online Conference Events',-1),(314,'masquerade','masquerade','cw2014',0,-22,'-1',0,0,'count/proposals','',-1),(315,'views','featured_session_slider-block','cw2014',0,-22,'-1',0,1,'slideshows','<none>',-1),(316,'community_tags','0','cw2014',0,-20,'-1',0,0,'','Session Tags',-1),(317,'views','volunteer_list-block_1','cw2014',0,-20,'-1',0,1,'<front>','Volunteer Spotlight',-1),(318,'search','form','cw2014',0,-19,'-1',0,0,'abstracts','',-1),(319,'views','related_sessions-block','cw2014',0,-19,'-1',0,0,'','',-1),(320,'menu','menu-front-page-menu','cw2014',0,-18,'-1',0,1,'<front>','',-1),(321,'comment','recent','cw2014',0,-17,'-1',0,1,'<front>','',1),(322,'views','boosted_session_slideshow-block','cw2014',0,-15,'-1',0,1,'slideshows','Boosted Sessions',-1),(323,'views','just_updated_slideshow-block','cw2014',0,-14,'-1',0,1,'slideshows','<none>',-1),(324,'views','cfc850c1b5c51918e2cc56dfe57b3339','cw2014',0,-13,'-1',0,1,'<front>','Cwcon Video Archive',-1),(325,'block','3','cw2014',0,-11,'-1',0,0,'','<none>',-1),(326,'node_comment_block','node_comments','cw2014',0,-11,'-1',0,0,'','',1),(327,'block','1','cw2014',0,-10,'-1',0,0,'','Cogs',-1),(328,'views','session_video_slideshow-block','cw2014',0,-10,'-1',0,1,'<front>','',-1),(329,'system','powered-by','cw2014',0,-8,'-1',0,0,'','',-1),(330,'block','4','cw2014',0,0,'-1',0,1,'<front>','',-1),(331,'calendar','calendar_legend','cw2014',0,0,'-1',0,0,'','',1),(332,'devel','execute_php','cw2014',0,0,'-1',0,0,'','',-1),(333,'devel','switch_user','cw2014',0,0,'-1',0,0,'','',-1),(334,'diff','inline','cw2014',0,0,'-1',0,0,'','',1),(335,'fancy_login','fancy_login_login_block','cw2014',0,0,'-1',0,0,'Array','',-1),(336,'forum','active','cw2014',0,0,'-1',0,0,'','',-2),(337,'forum','new','cw2014',0,0,'-1',0,0,'','',-2),(338,'menu','menu-submitter-menu','cw2014',0,0,'-1',0,0,'','',-1),(339,'menu','features','cw2014',0,0,'-1',0,0,'','',-1),(340,'menu','menu-presenters','cw2014',0,0,'-1',0,0,'','',-1),(341,'menu','devel','cw2014',0,0,'-1',0,0,'','',-1),(342,'node','recent','cw2014',0,0,'-1',0,0,'','',1),(343,'node','syndicate','cw2014',0,0,'-1',0,0,'','',-1),(344,'print','print-links','cw2014',0,0,'-1',0,0,'','',4),(345,'print','print-top','cw2014',0,0,'-1',0,0,'','',8),(346,'print_pdf','print_pdf-top','cw2014',0,0,'-1',0,0,'','',8),(347,'sharethis','sharethis_block','cw2014',0,0,'-1',0,0,'','',1),(348,'shortcut','shortcuts','cw2014',0,0,'-1',0,0,'','',-1),(349,'superfish','2','cw2014',0,0,'-1',0,0,'','',-1),(350,'superfish','3','cw2014',0,0,'-1',0,0,'','',-1),(351,'superfish','4','cw2014',0,0,'-1',0,0,'','',-1),(352,'system','help','cw2014',0,0,'-1',0,0,'','',-1),(353,'system','main-menu','cw2014',0,0,'-1',0,0,'','',-1),(354,'system','management','cw2014',0,0,'-1',0,0,'','',-1),(355,'system','navigation','cw2014',0,0,'-1',0,0,'','',-1),(356,'user','new','cw2014',0,0,'-1',0,0,'','',1),(357,'user','online','cw2014',0,0,'-1',0,0,'','',-1),(358,'views','conference_calendar-block_1','cw2014',0,0,'-1',0,0,'','',-1),(359,'views','conference_calendar-block_2','cw2014',0,0,'-1',0,0,'','',-1),(360,'views','tweets-block','cw2014',0,0,'-1',0,0,'','',-1),(361,'system','main','cw2014',1,-19,'content',0,0,'','',-1),(362,'superfish','1','cw2014',1,-20,'content',0,0,'','<none>',-1),(363,'user','login','cw2014',1,-21,'sidebar_first',0,0,'','',-1),(364,'block','2','cw2014',1,-16,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(365,'system','user-menu','cw2014',1,-12,'sidebar_first',0,0,'abstracts','<none>',-1),(366,'views','10c58bded9e09ce0212a929eb8617e04','cwcon2014_washington',0,-23,'-1',0,1,'<front>','Online Conference Events',-1),(367,'masquerade','masquerade','cwcon2014_washington',0,-22,'-1',0,0,'count/proposals','',-1),(368,'views','featured_session_slider-block','cwcon2014_washington',0,-22,'-1',0,1,'slideshows','<none>',-1),(369,'community_tags','0','cwcon2014_washington',0,-20,'-1',0,0,'','Session Tags',-1),(370,'views','volunteer_list-block_1','cwcon2014_washington',0,-20,'',0,1,'<front>','Volunteer Spotlight',-1),(371,'search','form','cwcon2014_washington',0,-19,'-1',0,0,'abstracts','',-1),(372,'views','related_sessions-block','cwcon2014_washington',0,-19,'-1',0,0,'','',-1),(373,'menu','menu-front-page-menu','cwcon2014_washington',0,-18,'-1',0,1,'<front>','',-1),(374,'comment','recent','cwcon2014_washington',0,-17,'-1',0,1,'<front>','',1),(375,'views','boosted_session_slideshow-block','cwcon2014_washington',0,-15,'-1',0,1,'slideshows','Boosted Sessions',-1),(376,'views','just_updated_slideshow-block','cwcon2014_washington',0,-14,'-1',0,1,'slideshows','<none>',-1),(377,'views','cfc850c1b5c51918e2cc56dfe57b3339','cwcon2014_washington',0,-13,'-1',0,1,'<front>','Cwcon Video Archive',-1),(378,'block','3','cwcon2014_washington',0,-11,'-1',0,0,'','<none>',-1),(379,'node_comment_block','node_comments','cwcon2014_washington',0,-11,'-1',0,0,'','',1),(380,'block','1','cwcon2014_washington',0,-10,'-1',0,0,'','Cogs',-1),(381,'views','session_video_slideshow-block','cwcon2014_washington',0,-10,'-1',0,1,'<front>','',-1),(382,'system','powered-by','cwcon2014_washington',0,-8,'-1',0,0,'','',-1),(383,'block','4','cwcon2014_washington',0,0,'-1',0,1,'<front>','',-1),(384,'calendar','calendar_legend','cwcon2014_washington',0,0,'-1',0,0,'','',1),(385,'devel','execute_php','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(386,'devel','switch_user','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(387,'diff','inline','cwcon2014_washington',0,0,'-1',0,0,'','',1),(388,'fancy_login','fancy_login_login_block','cwcon2014_washington',0,0,'-1',0,0,'Array','',-1),(389,'forum','active','cwcon2014_washington',0,0,'-1',0,0,'','',-2),(390,'forum','new','cwcon2014_washington',0,0,'-1',0,0,'','',-2),(391,'menu','menu-submitter-menu','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(392,'menu','features','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(393,'menu','menu-presenters','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(394,'menu','devel','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(395,'node','recent','cwcon2014_washington',0,0,'-1',0,0,'','',1),(396,'node','syndicate','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(397,'print','print-links','cwcon2014_washington',0,0,'-1',0,0,'','',4),(398,'print','print-top','cwcon2014_washington',0,0,'-1',0,0,'','',8),(399,'print_pdf','print_pdf-top','cwcon2014_washington',0,0,'-1',0,0,'','',8),(400,'sharethis','sharethis_block','cwcon2014_washington',0,0,'-1',0,0,'','',1),(401,'shortcut','shortcuts','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(402,'superfish','2','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(403,'superfish','3','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(404,'superfish','4','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(405,'system','help','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(406,'system','main-menu','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(407,'system','management','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(408,'system','navigation','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(409,'user','new','cwcon2014_washington',0,0,'-1',0,0,'','',1),(410,'user','online','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(411,'views','conference_calendar-block_1','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(412,'views','conference_calendar-block_2','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(413,'views','tweets-block','cwcon2014_washington',0,0,'-1',0,0,'','',-1),(414,'system','main','cwcon2014_washington',1,-19,'content',0,0,'','',-1),(415,'superfish','1','cwcon2014_washington',1,-20,'content',0,0,'','<none>',-1),(416,'user','login','cwcon2014_washington',1,-21,'sidebar_first',0,0,'','',-1),(417,'block','2','cwcon2014_washington',1,-16,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(418,'system','user-menu','cwcon2014_washington',1,-12,'sidebar_first',0,0,'abstracts','<none>',-1),(424,'block','1','new2014subtheme',0,-10,'-1',0,0,'','Cogs',-1),(425,'block','2','new2014subtheme',1,-22,'sidebar_first',1,0,'404\r\n405\r\nslideshows\r\nusers-contact-info\r\nusers-contact-info/*\r\nassign/reviewer\r\ncount/proposals\r\nuser/*','<none>',-1),(426,'block','3','new2014subtheme',0,-11,'-1',0,0,'','<none>',-1),(427,'block','4','new2014subtheme',0,0,'-1',0,1,'<front>','',-1),(428,'calendar','calendar_legend','new2014subtheme',0,0,'-1',0,0,'','',1),(429,'comment','recent','new2014subtheme',0,-17,'-1',0,1,'<front>','',1),(430,'community_tags','0','new2014subtheme',0,-20,'-1',0,0,'','Session Tags',-1),(431,'devel','execute_php','new2014subtheme',0,0,'-1',0,0,'','',-1),(432,'devel','switch_user','new2014subtheme',0,0,'-1',0,0,'','',-1),(433,'diff','inline','new2014subtheme',0,0,'-1',0,0,'','',1),(434,'fancy_login','fancy_login_login_block','new2014subtheme',0,0,'-1',0,0,'Array','',-1),(435,'forum','active','new2014subtheme',0,0,'-1',0,0,'','',-2),(436,'forum','new','new2014subtheme',0,0,'-1',0,0,'','',-2),(437,'masquerade','masquerade','new2014subtheme',1,-24,'sidebar_first',0,0,'count/proposals','',-1),(438,'menu','devel','new2014subtheme',0,0,'-1',0,0,'','',-1),(439,'menu','features','new2014subtheme',0,0,'-1',0,0,'','',-1),(440,'menu','menu-front-page-menu','new2014subtheme',0,-18,'-1',0,1,'<front>','',-1),(441,'menu','menu-presenters','new2014subtheme',0,0,'-1',0,0,'','',-1),(442,'menu','menu-submitter-menu','new2014subtheme',0,0,'-1',0,0,'','',-1),(444,'node','recent','new2014subtheme',0,0,'-1',0,0,'','',1),(445,'node','syndicate','new2014subtheme',0,0,'-1',0,0,'','',-1),(446,'node_comment_block','node_comments','new2014subtheme',0,-11,'-1',0,0,'','',1),(447,'print','print-links','new2014subtheme',0,0,'-1',0,0,'','',4),(448,'print','print-top','new2014subtheme',0,0,'-1',0,0,'','',8),(449,'print_pdf','print_pdf-top','new2014subtheme',0,0,'-1',0,0,'','',8),(450,'search','form','new2014subtheme',0,-19,'-1',0,0,'abstracts','',-1),(451,'sharethis','sharethis_block','new2014subtheme',0,0,'-1',0,0,'','',1),(452,'shortcut','shortcuts','new2014subtheme',0,0,'-1',0,0,'','',-1),(453,'superfish','1','new2014subtheme',0,-22,'-1',0,0,'','<none>',-1),(454,'superfish','2','new2014subtheme',0,-26,'-1',0,0,'','',-1),(455,'superfish','3','new2014subtheme',0,0,'-1',0,0,'','',-1),(456,'superfish','4','new2014subtheme',0,0,'-1',0,0,'','',-1),(457,'system','help','new2014subtheme',0,0,'-1',0,0,'','',-1),(458,'system','main','new2014subtheme',1,-23,'content',0,0,'','',-1),(459,'system','main-menu','new2014subtheme',0,0,'-1',0,0,'','',-1),(460,'system','management','new2014subtheme',0,0,'-1',0,0,'','',-1),(461,'system','navigation','new2014subtheme',0,0,'-1',0,0,'','',-1),(462,'system','powered-by','new2014subtheme',0,-8,'-1',0,0,'','',-1),(463,'system','user-menu','new2014subtheme',1,-23,'sidebar_first',0,0,'abstracts','<none>',-1),(464,'user','login','new2014subtheme',1,-25,'sidebar_first',0,0,'','',-1),(465,'user','new','new2014subtheme',0,0,'-1',0,0,'','',1),(466,'user','online','new2014subtheme',0,0,'-1',0,0,'','',-1),(467,'views','10c58bded9e09ce0212a929eb8617e04','new2014subtheme',0,-23,'-1',0,1,'<front>','Online Conference Events',-1),(468,'views','boosted_session_slideshow-block','new2014subtheme',1,-17,'sidebar_first',0,1,'slideshows','Boosted Sessions',-1),(469,'views','cfc850c1b5c51918e2cc56dfe57b3339','new2014subtheme',1,-19,'sidebar_first',0,1,'<front>','Cwcon Video Archive',-1),(470,'views','conference_calendar-block_1','new2014subtheme',0,0,'-1',0,0,'','',-1),(471,'views','conference_calendar-block_2','new2014subtheme',0,0,'-1',0,0,'','',-1),(472,'views','featured_session_slider-block','new2014subtheme',1,-24,'content',0,1,'slideshows','<none>',-1),(473,'views','just_updated_slideshow-block','new2014subtheme',0,-16,'-1',0,1,'slideshows','<none>',-1),(474,'views','related_sessions-block','new2014subtheme',0,-19,'-1',0,0,'','',-1),(475,'views','session_video_slideshow-block','new2014subtheme',0,-10,'-1',0,1,'<front>','',-1),(476,'views','tweets-block','new2014subtheme',0,0,'-1',0,0,'','',-1),(477,'views','volunteer_list-block_1','new2014subtheme',0,-24,'-1',0,1,'<front>','Volunteer Spotlight',-1),(478,'block','5','bartik',0,0,'-1',0,0,'<front>','',-1),(479,'block','5','new2014subtheme',0,0,'-1',0,0,'<front>','',-1),(480,'block','5','nucleus',0,0,'-1',0,0,'<front>','',-1),(481,'block','5','seven',0,0,'-1',0,0,'<front>','',-1),(482,'views','news_feed-block','new2014subtheme',0,0,'-1',0,0,'','',-1),(483,'block','6','bartik',0,0,'-1',0,1,'proposal/*\r\nnode/add/peer-review/*','Peer Review Rating Guide',-1),(484,'block','6','new2014subtheme',1,-20,'sidebar_first',0,1,'proposal/*\r\nnode/add/peer-review/*','Peer Review Rating Guide',-1),(485,'block','6','nucleus',0,0,'-1',0,1,'proposal/*\r\nnode/add/peer-review/*','Peer Review Rating Guide',-1),(486,'block','6','seven',0,0,'-1',0,1,'proposal/*\r\nnode/add/peer-review/*','Peer Review Rating Guide',-1),(487,'views','news_feed-block','bartik',0,0,'-1',0,0,'','',-1),(488,'views','news_feed-block','nucleus',0,0,'-1',0,0,'','',-1),(489,'views','news_feed-block','seven',0,0,'-1',0,0,'','',-1),(490,'views','count_tester-block_1','bartik',0,0,'-1',0,0,'','',-1),(491,'views','count_tester-block_1','new2014subtheme',0,0,'-1',0,0,'','',-1),(492,'views','count_tester-block_1','nucleus',0,0,'-1',0,0,'','',-1),(493,'views','count_tester-block_1','seven',0,0,'-1',0,0,'','',-1),(494,'views','33e388ba2111b1bf9cf0c2ff50e9fb0e','bartik',0,0,'-1',0,0,'','',-1),(495,'views','33e388ba2111b1bf9cf0c2ff50e9fb0e','new2014subtheme',0,0,'-1',0,0,'','',-1),(496,'views','33e388ba2111b1bf9cf0c2ff50e9fb0e','nucleus',0,0,'-1',0,0,'','',-1),(497,'views','33e388ba2111b1bf9cf0c2ff50e9fb0e','seven',0,0,'-1',0,0,'','',-1),(498,'views','featured_session_slider-block_1','bartik',0,0,'-1',0,1,'slideshows','Featured Sessions',-1),(499,'views','featured_session_slider-block_1','new2014subtheme',1,-21,'sidebar_first',0,1,'slideshows','Featured Sessions',-1),(500,'views','featured_session_slider-block_1','nucleus',0,0,'-1',0,1,'slideshows','Featured Sessions',-1),(501,'views','featured_session_slider-block_1','seven',0,0,'-1',0,1,'slideshows','Featured Sessions',-1),(502,'block','7','bartik',0,0,'-1',0,1,'preconference','',-1),(503,'block','7','new2014subtheme',1,-25,'content',0,1,'preconference','',-1),(504,'block','7','nucleus',0,0,'-1',0,1,'preconference','',-1),(505,'block','7','seven',0,0,'-1',0,1,'preconference','',-1),(506,'views','keynote_session_view-block','new2014subtheme',1,0,'content',0,1,'slideshows','<none>',-1),(507,'views','keynote_session_view-block_1','new2014subtheme',1,-18,'sidebar_first',0,1,'slideshows','Keynote Sessions',-1),(508,'views','keynote_session_view-block','bartik',0,0,'-1',0,1,'slideshows','<none>',-1),(509,'views','keynote_session_view-block','nucleus',0,0,'-1',0,1,'slideshows','<none>',-1),(510,'views','keynote_session_view-block','seven',0,0,'-1',0,1,'slideshows','<none>',-1),(511,'views','keynote_session_view-block_1','bartik',0,0,'-1',0,1,'slideshows','Keynote Sessions',-1),(512,'views','keynote_session_view-block_1','nucleus',0,0,'-1',0,1,'slideshows','Keynote Sessions',-1),(513,'views','keynote_session_view-block_1','seven',0,0,'-1',0,1,'slideshows','Keynote Sessions',-1),(514,'block','8','bartik',0,0,'-1',0,1,'<front>','',-1),(515,'block','8','new2014subtheme',1,0,'footer_second',0,1,'<front>','',-1),(516,'block','8','nucleus',0,0,'-1',0,1,'<front>','',-1),(517,'block','8','seven',0,0,'-1',0,1,'<front>','',-1),(518,'block','9','bartik',0,0,'-1',0,0,'','Area Resources',-1),(519,'block','9','new2014subtheme',1,-27,'sidebar_first',0,0,'','Area Resources',-1),(520,'block','9','nucleus',0,0,'-1',0,0,'','Area Resources',-1),(521,'block','9','seven',0,0,'-1',0,0,'','Area Resources',-1),(522,'block','10','bartik',0,0,'-1',0,0,'','',-1),(523,'block','10','new2014subtheme',1,0,'preface_first',0,0,'','',-1),(524,'block','10','nucleus',0,0,'-1',0,0,'','',-1),(525,'block','10','seven',0,0,'-1',0,0,'','',-1);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_custom`
--

LOCK TABLES `block_custom` WRITE;
/*!40000 ALTER TABLE `block_custom` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `block_custom` VALUES (1,'<p><img src=\"/cwcon/2013dev/sites/default/files/public/steampunk24.jpg\" alt=\"\" width=\"772\" height=\"200\" /></p>','Cogs block for header','full_html'),(2,'<p>&nbsp;</p><p><a class=\"twitter-timeline\" href=\"https://twitter.com/search?q=%23cwcon\" data-widget-id=\"247032213860925440\">Tweets about \"#cwcon\"</a></p><script type=\"text/javascript\">// <![CDATA[\r\n!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=\"//platform.twitter.com/widgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");\r\n// ]]></script>','Tweets for cwcon','full_html'),(3,'<p><img src=\"/cwcon/2013/sites/default/files/public/steampunk24_0.jpg\" alt=\"\" width=\"772\" height=\"200\" /></p><p>&nbsp;</p>','cog block','filtered_html'),(4,'<p>&lt;meta name=\"google-site-verification\" content=\"cKyiLCFa8lxGWcoJThP4xgVeZAq5ySRbyvfxOfNeNig\" /&gt;</p>','meta tag','filtered_html'),(5,'<p><img src=\"/cwcon/2014stage/sites/default/files/public/wide.png\" alt=\"\" width=\"1428\" height=\"318\" /></p>','2014 header logo image','full_html'),(6,'<p style=\"text-align: center;\"><img style=\"border: 3px solid black; margin-top: 10px; margin-bottom: 10px;\" src=\"/cwcon/2014stage/sites/default/files/public/rating_guide_0.png\" alt=\"\" width=\"244\" height=\"145\" /></p>','rating guide','full_html'),(7,'<div class=\"iconset\"><p class=\"iconcaption\">Registration</p><a href=\"https://cm.wsu.edu/ereg/index.php?eventid=82421&amp;\"><img src=\"/cwcon/2014/sites/default/files/public/Reminder-icon.png\" alt=\"Registration\" width=\"125\" height=\"125\" /></a></div><div class=\"iconset\"><p class=\"iconcaption\">News</p><a href=\"news\"><img src=\"/cwcon/2014/sites/default/files/public/News-icon.png\" alt=\"News\" width=\"125\" height=\"125\" /></a></div><div class=\"iconset\"><p class=\"iconcaption\">Schedule</p><a href=\"http://siteslab.org/cwcon/2014/schedule\"><img src=\"/cwcon/2014/sites/default/files/public/Notes-icon.png\" alt=\"Schedule\" width=\"125\" height=\"125\" /></a></div><div class=\"iconset\"><p class=\"iconcaption\">Transportation</p><a href=\"travel\"><img src=\"/cwcon/2014/sites/default/files/public/Air-icon.png\" alt=\"Transportation\" width=\"125\" height=\"125\" /></a></div><div class=\"iconset\"><p class=\"iconcaption\">GRN</p><a href=\"http://www.gradresearchnetwork.org/\"><img src=\"/cwcon/2014/sites/default/files/public/Contacts-icon.png\" alt=\"Graduate Research Network\" width=\"125\" height=\"125\" /></a></div><div class=\"iconset\">&nbsp;</div><div class=\"iconset\"><p class=\"iconcaption\">Ride2CW</p><a href=\"content/ride2cw\"><img src=\"/cwcon/2014/sites/default/files/public/Settings-icon.png\" alt=\"Ride2CW\" width=\"125\" height=\"125\" /></a></div>','icon menu','full_html'),(8,'<p><a href=\"credits\" style=\"color: #ffffff;\" target=\"_blank\">credits</a></p>','credits','full_html'),(9,'<div class=\"arearesources\"><ul><li><a href=\"content/lodging\"><img style=\"margin-left: 15px; margin-right: 15px;\" src=\"/cwcon/2014/sites/default/files/public/lodging_white.png\" alt=\"\" width=\"45\" height=\"45\" />Lodging</a></li><li><a href=\"http://siteslab.org/cwcon/2014/travel\"><img style=\"margin-left: 15px; margin-right: 15px;\" src=\"/cwcon/2014/sites/default/files/public/travel_white.png\" alt=\"\" width=\"45\" height=\"45\" />Travel</a></li><li><a href=\"http://siteslab.org/cwcon/2014/content/dining\"><img style=\"margin-left: 15px; margin-right: 15px;\" src=\"/cwcon/2014/sites/default/files/public/dining_white.png\" alt=\"\" width=\"45\" height=\"45\" />Dining</a></li></ul></div>','Area Resources','full_html'),(10,'<div class=\"iconmenu\"><ul><li><a href=\"http://siteslab.org/cwcon/2014/content/graduate-research-network\"><img src=\"/cwcon/2014/sites/default/files/public/GRN_white.png\" alt=\"Graduate Research Network\" width=\"30\" height=\"30\" />GRN</a></li><li><a href=\"http://siteslab.org/cwcon/2014/content/ride2cw\"><img src=\"/cwcon/2014/sites/default/files/public/ride2cw.png\" alt=\"Ride to Computers and Writing\" width=\"30\" height=\"30\" />Ride2CW</a></li><li><a href=\"http://siteslab.org/cwcon/2014/news\"><img src=\"/cwcon/2014/sites/default/files/public/news.png\" alt=\"\" width=\"30\" height=\"30\" />News</a></li><li><a href=\"http://siteslab.org/cwcon/2014/user/\"><img src=\"/cwcon/2014/sites/default/files/public/My_Account.png\" alt=\"My Account\" width=\"30\" height=\"30\" />My Account</a></li><li><a href=\"https://cm.wsu.edu/ereg/index.php?eventid=82421&amp;\" target=\"_blank\"><img src=\"/cwcon/2014/sites/default/files/public/clipboard-icon.png\" alt=\"Registration\" width=\"30\" height=\"30\" />Registration</a></li><li><a href=\"http://siteslab.org/cwcon/2014/schedule\"><img src=\"/cwcon/2014/sites/default/files/public/schedule.png\" alt=\"Schedule\" width=\"30\" height=\"30\" />Schedule</a></li></ul></div>','main menu with icons','full_html');
/*!40000 ALTER TABLE `block_custom` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_node_type`
--

LOCK TABLES `block_node_type` WRITE;
/*!40000 ALTER TABLE `block_node_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `block_node_type` VALUES ('community_tags','0','featured_session'),('node_comment_block','node_comments','featured_session'),('community_tags','0','session'),('node_comment_block','node_comments','session'),('views','related_sessions-block','session'),('node_comment_block','node_comments','session_review');
/*!40000 ALTER TABLE `block_node_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_role`
--

LOCK TABLES `block_role` WRITE;
/*!40000 ALTER TABLE `block_role` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `block_role` VALUES ('block','10',1),('block','9',1),('superfish','2',1),('system','user-menu',1),('block','10',2),('block','9',2),('superfish','2',2),('views','10c58bded9e09ce0212a929eb8617e04',2),('views','related_sessions-block',2),('block','10',3),('block','9',3),('superfish','2',3),('views','10c58bded9e09ce0212a929eb8617e04',3),('views','related_sessions-block',3);
/*!40000 ALTER TABLE `block_role` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked_ips`
--

LOCK TABLES `blocked_ips` WRITE;
/*!40000 ALTER TABLE `blocked_ips` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `blocked_ips` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
set autocommit=0;
