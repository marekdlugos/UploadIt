# ************************************************************
# Sequel Pro SQL dump
# Version 4135
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.34)
# Database: odovzdajtofinal
# Generation Time: 2014-05-17 14:22:22 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table odovzdania
# ------------------------------------------------------------

DROP TABLE IF EXISTS `odovzdania`;

CREATE TABLE `odovzdania` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poznamka` text,
  `zadanie_id` int(10) unsigned NOT NULL,
  `pouzivatel_id` int(10) unsigned NOT NULL,
  `cas_odovzdania` datetime NOT NULL,
  `cas_upravenia` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `zadanie_id_pouzivatel_id` (`zadanie_id`,`pouzivatel_id`),
  KEY `pouzivatel_id` (`pouzivatel_id`),
  CONSTRAINT `odovzdania_ibfk_1` FOREIGN KEY (`zadanie_id`) REFERENCES `zadania` (`id`) ON DELETE CASCADE,
  CONSTRAINT `odovzdania_ibfk_2` FOREIGN KEY (`pouzivatel_id`) REFERENCES `pouzivatelia` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pouzivatelia
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pouzivatelia`;

CREATE TABLE `pouzivatelia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trieda_id` int(11) DEFAULT NULL,
  `meno` varchar(32) NOT NULL,
  `login` varchar(16) NOT NULL,
  `heslo` varchar(64) NOT NULL,
  `skratka` varchar(3) DEFAULT NULL,
  `role` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1 - student; 2 - teacher; 10 - admin',
  PRIMARY KEY (`id`),
  KEY `trieda_id` (`trieda_id`),
  CONSTRAINT `pouzivatelia_ibfk_1` FOREIGN KEY (`trieda_id`) REFERENCES `triedy` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pouzivatelia` WRITE;
/*!40000 ALTER TABLE `pouzivatelia` DISABLE KEYS */;

INSERT INTO `pouzivatelia` (`id`, `trieda_id`, `meno`, `login`, `heslo`, `skratka`, `role`)
VALUES
	(2,1,'Marek','marek','098f6bcd4621d373cade4e832627b4f6',NULL,2),
	(3,4,'ziak','ziak','098f6bcd4621d373cade4e832627b4f6',NULL,1),
	(4,2,'ucitel','ucitel','098f6bcd4621d373cade4e832627b4f6',NULL,2);

/*!40000 ALTER TABLE `pouzivatelia` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table predmety
# ------------------------------------------------------------

DROP TABLE IF EXISTS `predmety`;

CREATE TABLE `predmety` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazov` varchar(128) NOT NULL,
  `skratka` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `predmety` WRITE;
/*!40000 ALTER TABLE `predmety` DISABLE KEYS */;

INSERT INTO `predmety` (`id`, `nazov`, `skratka`)
VALUES
	(1,'Programovanie','PRO'),
	(2,'Sieťové technológie','SIE'),
	(3,'Serverové technológie','SXT'),
	(4,'Elektrotechnické merania','ELM'),
	(5,'Matematika','MAT');

/*!40000 ALTER TABLE `predmety` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table subory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subory`;

CREATE TABLE `subory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `odovzdanie_id` int(10) unsigned NOT NULL,
  `nazov` varchar(128) NOT NULL,
  `cesta` varchar(512) NOT NULL,
  `velkost` bigint(20) unsigned NOT NULL,
  `cas_odovzdania` datetime NOT NULL,
  `cas_upravenia` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `odovzdanie_id` (`odovzdanie_id`),
  CONSTRAINT `subory_ibfk_2` FOREIGN KEY (`odovzdanie_id`) REFERENCES `odovzdania` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table triedy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `triedy`;

CREATE TABLE `triedy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rocnik` tinyint(3) unsigned NOT NULL,
  `kod` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `triedy` WRITE;
/*!40000 ALTER TABLE `triedy` DISABLE KEYS */;

INSERT INTO `triedy` (`id`, `rocnik`, `kod`)
VALUES
	(1,3,'A'),
	(2,3,'B'),
	(3,3,'C'),
	(4,3,'SA'),
	(5,3,'SB'),
	(6,3,'F');

/*!40000 ALTER TABLE `triedy` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table zadania
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zadania`;

CREATE TABLE `zadania` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nazov` varchar(32) NOT NULL,
  `trieda_id` int(11) NOT NULL,
  `pouzivatel_id` int(10) unsigned NOT NULL,
  `predmet_id` int(10) unsigned NOT NULL,
  `stav` tinyint(3) unsigned DEFAULT '0' COMMENT '0 - uzatvorene; 1 - otvorene; 2 - otvorene aj po uzavierke',
  `cas_uzatvorenia` datetime NOT NULL,
  `cas_vytvorenia` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trieda_id` (`trieda_id`),
  KEY `predmet_id` (`predmet_id`),
  KEY `pouzivatel_id` (`pouzivatel_id`),
  CONSTRAINT `zadania_ibfk_1` FOREIGN KEY (`trieda_id`) REFERENCES `triedy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zadania_ibfk_2` FOREIGN KEY (`predmet_id`) REFERENCES `predmety` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zadania_ibfk_3` FOREIGN KEY (`pouzivatel_id`) REFERENCES `pouzivatelia` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
