-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 21, 2013 at 10:52 AM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `puzzle`
--

-- --------------------------------------------------------

--
-- Table structure for table `character`
--

CREATE TABLE IF NOT EXISTS `character` (
  `charac_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `charac_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `charac_def` int(7) NOT NULL,
  `charac_att` int(7) NOT NULL,
  `charac_type` tinyint(1) NOT NULL,
  `charac_rare` tinyint(1) NOT NULL,
  `charac_element` tinyint(1) NOT NULL,
  `charac_img` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `charac_img_mini` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `charac_spw` int(4) NOT NULL,
  `charac_sph` int(4) NOT NULL,
  `charac_hp` int(4) NOT NULL,
  `leader_id` tinyint(2) NOT NULL,
  `pwextra_id` tinyint(2) NOT NULL,
  `charac_no` int(5) NOT NULL,
  `charac_MAXLV` tinyint(2) NOT NULL,
  PRIMARY KEY (`charac_id`),
  UNIQUE KEY `pwextra_id` (`pwextra_id`),
  UNIQUE KEY `leader_id` (`leader_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `character`
--

INSERT INTO `character` (`charac_id`, `charac_name`, `charac_def`, `charac_att`, `charac_type`, `charac_rare`, `charac_element`, `charac_img`, `charac_img_mini`, `charac_spw`, `charac_sph`, `charac_hp`, `leader_id`, `pwextra_id`, `charac_no`, `charac_MAXLV`) VALUES
(1, 'TONGTO', 100, 50, 0, 0, 1, 'img/character/pangtong-v201.png', 'img/characterIcon/img/dgn_pangtong-i201.png', 0, 0, 40, 2, 2, 1, 10),
(2, 'KWANTA', 50, 200, 1, 2, 2, 'img/character/tgr_chfa_v101.png', 'img/characterIcon/img/icon_test6001.png', 0, 0, 100, 1, 1, 2, 10),
(3, 'MONCHOO', 100, 200, 1, 3, 3, 'img/character/tgr_chfb_v201.png', 'img/characterIcon/img/icon_test7001.png', 0, 0, 200, 4, 4, 30, 30),
(4, 'TADA', 100, 200, 1, 3, 5, 'img/character/nmn_chma-v201.png', 'img/characterIcon/img/nmn_chma-i201.png', 1, 1, 200, 3, 3, 30, 30),
(5, 'JOCHO', 200, 100, 2, 2, 4, 'img/character/chohi-v101.png', 'img/characterIcon/img/gdn_chohi-i101.png', 1, 1, 50, 5, 5, 5, 5),
(6, 'KOOMIN', 100, 100, 3, 3, 4, 'img/character/kanu-v101.png', 'img/characterIcon/img/dgn_kanu-i101.png', 6, 6, 30, 6, 6, 6, 10),
(7, 'MACHAO', 1000, 1000, 3, 2, 3, 'img/character/machao-v101.png', 'img/characterIcon/img/icon_test1001.png', 10, 10, 200, 7, 7, 7, 10),
(8, 'MATAI', 200, 300, 1, 3, 2, 'img/character/matai-v101.png', 'img/characterIcon/img/dgn_matai-i101.png', 22, 20, 300, 8, 8, 8, 20),
(9, 'TANGTONG', 100, 450, 1, 1, 1, 'img/character/pangtong-v101.png', 'img/characterIcon/img/dgn_pangtong-i101.png', 20, 20, 30, 9, 9, 9, 15),
(10, 'MEACODA', 250, 200, 1, 2, 1, 'img/character/tgr_chfa-v201.png', 'img/characterIcon/img/tgr_chfa-i201.png', 10, 10, 30, 10, 10, 10, 10),
(11, 'CHOYAI', 300, 300, 1, 4, 5, 'img/character/tgr_chfb-v101.png', 'img/characterIcon/img/icon_test3001.png', 30, 30, 250, 11, 11, 11, 11),
(12, 'TOUTAKU', 230, 230, 3, 4, 4, 'img/character/TouTaku-v101.png', 'img/characterIcon/img/icon_test5001.png', 20, 20, 10, 12, 12, 12, 12),
(13, 'YUYAEN', 300, 300, 2, 5, 4, 'img/character/ytb_chfa-v201.png', 'img/characterIcon/img/ytb_chfa-i201.png', 20, 25, 40, 13, 13, 13, 13),
(14, 'CHOOSE', 200, 200, 2, 5, 5, 'img/character/ytb_chmb-v101.png', 'img/characterIcon/img/ytb_chmb-i101.png', 30, 30, 30, 14, 14, 14, 14);

-- --------------------------------------------------------

--
-- Table structure for table `characterexcoin`
--

CREATE TABLE IF NOT EXISTS `characterexcoin` (
  `charactoC_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `charac_id` int(5) NOT NULL,
  `charactoC_lv` tinyint(2) NOT NULL,
  `charactoC_formular` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`charactoC_id`),
  KEY `charac_id` (`charac_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `characterexcoin`
--


-- --------------------------------------------------------

--
-- Table structure for table `formula_mission`
--

CREATE TABLE IF NOT EXISTS `formula_mission` (
  `frmisstion_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`frmisstion_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `formula_mission`
--


-- --------------------------------------------------------

--
-- Table structure for table `friend`
--

CREATE TABLE IF NOT EXISTS `friend` (
  `friend_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(8) NOT NULL,
  `friend_userid` int(8) NOT NULL,
  `friend_respone` tinyint(1) NOT NULL,
  `friend_create` datetime NOT NULL,
  `friend_modify` datetime NOT NULL,
  PRIMARY KEY (`friend_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61 ;

--
-- Dumping data for table `friend`
--

INSERT INTO `friend` (`friend_id`, `user_id`, `friend_userid`, `friend_respone`, `friend_create`, `friend_modify`) VALUES
(60, 1, 2, 0, '2013-06-21 10:32:49', '2013-06-21 10:33:24'),
(59, 1, 3, 2, '2013-06-17 07:00:42', '2013-06-21 10:32:33'),
(53, 1, 6, 1, '2013-06-17 04:23:34', '2013-06-17 10:27:31'),
(58, 3, 1, 2, '2013-06-17 05:23:00', '2013-06-21 10:32:33'),
(57, 3, 6, 1, '2013-06-17 04:31:21', '2013-06-17 04:31:21'),
(56, 6, 3, 1, '2013-06-17 04:30:41', '2013-06-17 04:31:21'),
(54, 2, 6, 1, '2013-06-17 04:25:25', '2013-06-17 04:28:12'),
(55, 6, 2, 1, '2013-06-17 04:28:12', '2013-06-17 04:28:12'),
(51, 6, 1, 1, '2013-06-17 04:21:07', '2013-06-17 10:27:31');

-- --------------------------------------------------------

--
-- Table structure for table `hold_character`
--

CREATE TABLE IF NOT EXISTS `hold_character` (
  `holdcharac_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `charac_id` int(5) NOT NULL,
  `holdcharac_lv` tinyint(2) NOT NULL,
  `holdcharac_att` int(7) NOT NULL,
  `holdcharac_def` int(7) NOT NULL,
  `holdcharac_hp` int(4) NOT NULL,
  PRIMARY KEY (`holdcharac_id`),
  KEY `user_id` (`user_id`),
  KEY `charac_id` (`charac_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=32 ;

--
-- Dumping data for table `hold_character`
--

INSERT INTO `hold_character` (`holdcharac_id`, `user_id`, `charac_id`, `holdcharac_lv`, `holdcharac_att`, `holdcharac_def`, `holdcharac_hp`) VALUES
(15, 1, 7, 2, 100, 200, 300),
(2, 1, 2, 1, 300, 120, 10),
(3, 1, 3, 2, 300, 350, 200),
(4, 1, 4, 3, 400, 450, 100),
(5, 1, 5, 5, 250, 200, 30),
(6, 1, 6, 2, 300, 500, 100),
(16, 1, 1, 1, 200, 300, 100),
(8, 1, 8, 3, 400, 100, 300),
(14, 1, 5, 3, 200, 200, 200),
(13, 1, 2, 1, 100, 100, 50),
(17, 2, 3, 1, 500, 100, 200),
(18, 2, 10, 10, 200, 300, 300),
(19, 2, 3, 5, 200, 300, 100),
(20, 2, 10, 2, 100, 200, 300),
(21, 2, 4, 3, 200, 100, 300),
(22, 2, 8, 4, 200, 150, 150),
(23, 3, 1, 1, 100, 100, 100),
(24, 3, 2, 2, 100, 100, 100),
(25, 4, 4, 2, 200, 200, 100),
(26, 4, 5, 1, 200, 100, 300),
(27, 5, 6, 2, 200, 100, 100),
(28, 5, 7, 10, 200, 230, 250),
(29, 6, 3, 10, 100, 100, 100),
(30, 6, 6, 2, 300, 200, 100),
(31, 6, 1, 1, 100, 250, 300);

-- --------------------------------------------------------

--
-- Table structure for table `hold_item`
--

CREATE TABLE IF NOT EXISTS `hold_item` (
  `holditem_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(8) NOT NULL,
  `item_id` int(3) NOT NULL,
  `holditem_amount` tinyint(3) NOT NULL,
  PRIMARY KEY (`holditem_id`),
  KEY `item_id` (`item_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `hold_item`
--

INSERT INTO `hold_item` (`holditem_id`, `user_id`, `item_id`, `holditem_amount`) VALUES
(1, 1, 1, 2),
(2, 1, 2, 3),
(3, 1, 3, 5),
(4, 2, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `hold_team`
--

CREATE TABLE IF NOT EXISTS `hold_team` (
  `holdteam_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int(10) NOT NULL,
  `holdcharac_id` int(10) NOT NULL,
  `holdteam_no` tinyint(1) NOT NULL,
  PRIMARY KEY (`holdteam_id`),
  KEY `team_id` (`team_id`),
  KEY `holdcharac_id` (`holdcharac_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=285 ;

--
-- Dumping data for table `hold_team`
--

INSERT INTO `hold_team` (`holdteam_id`, `team_id`, `holdcharac_id`, `holdteam_no`) VALUES
(256, 9, 27, 1),
(254, 8, 25, 1),
(252, 7, 23, 1),
(251, 6, 18, 3),
(250, 6, 20, 2),
(258, 10, 29, 1),
(249, 6, 19, 1),
(269, 2, 2, 2),
(268, 1, 6, 1),
(271, 4, 16, 1),
(282, 2, 6, 1),
(272, 5, 8, 1),
(270, 3, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `item_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `item_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `item_detail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `item_type` tinyint(1) NOT NULL,
  `item_rare` tinyint(1) NOT NULL,
  `item_level` tinyint(2) DEFAULT NULL,
  `item_element` tinyint(1) NOT NULL,
  `item_img` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `item_img_mini` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `item_spw` int(4) NOT NULL,
  `item_sph` int(4) NOT NULL,
  `item_excoin` int(7) NOT NULL,
  `item_ticket` tinyint(2) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_id`, `item_name`, `item_detail`, `item_type`, `item_rare`, `item_level`, `item_element`, `item_img`, `item_img_mini`, `item_spw`, `item_sph`, `item_excoin`, `item_ticket`) VALUES
(1, 'Wooden', 'can protect good ', 1, 1, 1, 1, 'img/item/test5001.png', '', 0, 0, 50, 5),
(2, 'Armour', 'can protect good ', 1, 1, 1, 1, 'img/item/testItem1.png', '', 10, 10, 100, 1),
(3, 'Sword', 'Attack good', 2, 2, 2, 2, 'img/item/testItem2.png', '', 0, 0, 100, 2);

-- --------------------------------------------------------

--
-- Table structure for table `item_type`
--

CREATE TABLE IF NOT EXISTS `item_type` (
  `itty_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `itty_name` varchar(100) DEFAULT NULL,
  `itty_detail` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`itty_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `item_type`
--


-- --------------------------------------------------------

--
-- Table structure for table `leader`
--

CREATE TABLE IF NOT EXISTS `leader` (
  `leader_id` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `leader_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `leader_detail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `leader_formular` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`leader_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `leader`
--


-- --------------------------------------------------------

--
-- Table structure for table `powerextra`
--

CREATE TABLE IF NOT EXISTS `powerextra` (
  `pwextra_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `pwextra_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pwextra_detail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pwextra_formular` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pwextra_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `powerextra`
--


-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `state_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `state_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `state_level` int(4) NOT NULL,
  `state_no` tinyint(2) NOT NULL,
  `state_amount` tinyint(1) NOT NULL,
  `state_img` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `state_detecreate` datetime NOT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`, `state_level`, `state_no`, `state_amount`, `state_img`, `state_detecreate`) VALUES
(1, 'Feast of the Cannibal', 1, 1, 1, '', '2013-06-03 13:51:31'),
(2, 'Hollow city', 2, 1, 2, '', '2013-06-17 09:18:28'),
(3, 'ThaiLand', 2, 1, 3, '', '2013-06-18 09:18:57'),
(4, 'Hollow japan', 10, 3, 3, '', '2013-06-18 09:19:28'),
(5, 'hello Phuket city ', 1, 1, 2, '', '2013-06-18 09:20:05');

-- --------------------------------------------------------

--
-- Table structure for table `state_user`
--

CREATE TABLE IF NOT EXISTS `state_user` (
  `stateuser_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(8) NOT NULL,
  `state_id` int(5) NOT NULL,
  `stateuser_pass` tinyint(2) NOT NULL,
  PRIMARY KEY (`stateuser_id`),
  KEY `user_id` (`user_id`),
  KEY `state_id` (`state_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `state_user`
--

INSERT INTO `state_user` (`stateuser_id`, `user_id`, `state_id`, `stateuser_pass`) VALUES
(1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE IF NOT EXISTS `team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(8) NOT NULL,
  `team_no` tinyint(1) NOT NULL,
  `team_lastuse` datetime NOT NULL,
  PRIMARY KEY (`team_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`team_id`, `user_id`, `team_no`, `team_lastuse`) VALUES
(1, 1, 1, '2013-05-23 08:47:54'),
(2, 1, 2, '2013-05-23 14:31:27'),
(3, 1, 3, '2013-05-23 14:34:23'),
(4, 1, 4, '2013-05-23 14:34:30'),
(5, 1, 5, '2013-05-23 14:34:44'),
(6, 2, 1, '2013-06-04 15:57:34'),
(7, 3, 1, '2013-06-04 16:06:18'),
(8, 4, 1, '2013-06-04 16:06:26'),
(9, 5, 1, '2013-06-04 16:06:39'),
(10, 6, 1, '2013-06-04 16:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE IF NOT EXISTS `ticket` (
  `ticket_id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_img` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ticket_amound` tinyint(3) NOT NULL,
  `ticket_price` float(5,2) NOT NULL,
  `ticket_datecreate` datetime NOT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `ticket_img`, `ticket_amound`, `ticket_price`, `ticket_datecreate`) VALUES
(1, 'img/gacha/gold1.png', 1, 0.99, '2013-04-10 00:00:00'),
(2, 'img/gacha/gold2.png', 6, 4.99, '2013-04-10 00:00:00'),
(3, 'img/gacha/gold3.png', 12, 9.99, '2013-04-10 00:00:00'),
(4, 'img/gacha/gold4.png', 30, 22.99, '2013-04-10 00:00:00'),
(5, 'img/gacha/gold5.png', 60, 43.99, '2013-04-10 00:00:00'),
(6, 'img/gacha/gold5.png', 85, 59.99, '2013-04-10 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_udid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `user_type` tinyint(1) NOT NULL,
  `user_exp` int(4) NOT NULL,
  `user_level` tinyint(2) NOT NULL,
  `user_element` tinyint(1) NOT NULL,
  `user_coin` int(8) NOT NULL,
  `user_ticket` int(7) NOT NULL,
  `user_power` tinyint(3) NOT NULL,
  `user_deck` tinyint(3) NOT NULL,
  `user_borncharac` tinyint(3) NOT NULL,
  `user_lastlogin` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_udid`, `user_type`, `user_exp`, `user_level`, `user_element`, `user_coin`, `user_ticket`, `user_power`, `user_deck`, `user_borncharac`, `user_lastlogin`) VALUES
(2, 'two two', '', 10, 10, 2, 1, 100, 1200, 2, 2, 5, '2013-05-22 00:00:00'),
(3, 'three three', '', 3, 3, 10, 3, 200, 1000, 3, 3, 1, '0000-00-00 00:00:00'),
(4, 'four four', '', 1, 200, 3, 4, 200, 100, 127, 100, 2, '0000-00-00 00:00:00'),
(5, 'five five', '', 2, 2, 2, 5, 200, 1500, 3, 3, 3, '2013-06-04 00:00:00'),
(1, 'TongTo_one', 'ca778ed75dc5abd740fe86e5839fc97f', 0, 200, 1, 1, 1100, 1038, 120, 127, 0, '2013-05-23 00:00:00'),
(6, 'six six', '', 2, 200, 4, 5, 300, 100, 10, 10, 3, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `use_item`
--

CREATE TABLE IF NOT EXISTS `use_item` (
  `useitem_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `holditem_id` int(5) NOT NULL,
  `state_id` int(5) NOT NULL,
  PRIMARY KEY (`useitem_id`),
  KEY `holditem_id` (`holditem_id`),
  KEY `state_id` (`state_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=72 ;

--
-- Dumping data for table `use_item`
--

INSERT INTO `use_item` (`useitem_id`, `holditem_id`, `state_id`) VALUES
(71, 3, 0),
(70, 1, 0);
