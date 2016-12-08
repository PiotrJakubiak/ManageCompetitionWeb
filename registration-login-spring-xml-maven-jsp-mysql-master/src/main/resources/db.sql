CREATE DATABASE  IF NOT EXISTS `accounts`;
USE `accounts`;
--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
INSERT INTO `role` VALUES (1,'ROLE_USER');
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


--
-- Table structure for table `user_role`
--
DROP TABLE IF EXISTS `player`;
CREATE TABLE `player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthday` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_player_teamid_idx` (`team_id`),
  CONSTRAINT `fk_player_teamid` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `shortName` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `emailcontact` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `tournament`;
CREATE TABLE `tournament` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `maxnumberofteam` int(11) DEFAULT NULL,
  `currentnumberofteam` int(11) DEFAULT NULL,
  `dateofbegining` date DEFAULT NULL,
  `categoryoftournament` varchar(255) DEFAULT NULL,
  `stateoftournament` varchar(255) DEFAULT NULL,
  `typetournament` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_roleid_idx` (`role_id`),
  CONSTRAINT `fk_user_role_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tournament_team`;
CREATE TABLE `tournament_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) NOT NULL,
  `tournament_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tournament_team_teamid_idx` (`team_id`),
  KEY `fk_tournament_team_tournamentid_idx` (`tournament_id`),
  CONSTRAINT `fk_tournament_team_teamid` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tournament_team_tournamentid` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `game`;
CREATE TABLE `game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kolejka` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `home` int(11) NOT NULL,
  `away` int(11) NOT NULL,
  `tournament` int(11) NOT NULL,
  `goals_home` int(11) DEFAULT NULL,
  `goals_away` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_game_home_idx` (`home`),
  KEY `fk_game_away_idx` (`away`),
  KEY `fk_game_tournament_idx` (`tournament`),
  CONSTRAINT `fk_game_home` FOREIGN KEY (`home`) REFERENCES `team` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_game_away` FOREIGN KEY (`away`) REFERENCES `team` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_game_tournament` FOREIGN KEY (`tournament`) REFERENCES `tournament` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthday` varchar(255) DEFAULT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_coach_teamid_idx` (`team_id`),
  CONSTRAINT `fk_coach_teamid` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `typeevent_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_event_player_idx` (`player_id`),
  KEY `fk_event_game_idx` (`game_id`),
  KEY `fk_event_type_idx` (`typeevent_id`),
  CONSTRAINT `fk_event_player` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_event_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_event_type` FOREIGN KEY (`typeevent_id`) REFERENCES `typeevent` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `typeevent`;
CREATE TABLE `typeevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;