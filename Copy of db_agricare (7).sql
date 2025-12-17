-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2025 at 05:33 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_agricare`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminapp_tbl_agriofficer`
--

DROP TABLE IF EXISTS `adminapp_tbl_agriofficer`;
CREATE TABLE IF NOT EXISTS `adminapp_tbl_agriofficer` (
  `officerid` int(11) NOT NULL AUTO_INCREMENT,
  `officername` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `contactno` bigint(20) NOT NULL,
  `loginid_id` int(11) NOT NULL,
  `panchayathid_id` int(11) NOT NULL,
  PRIMARY KEY (`officerid`),
  KEY `adminapp_tbl_agriofficer_loginid_id_ccda7789` (`loginid_id`),
  KEY `adminapp_tbl_agriofficer_panchayathid_id_f0e043ad` (`panchayathid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminapp_tbl_agriofficer`
--

INSERT INTO `adminapp_tbl_agriofficer` (`officerid`, `officername`, `email`, `contactno`, `loginid_id`, `panchayathid_id`) VALUES
(2, 'Blesly bijoy', 'bleslybijoy@gmail.com', 9987609981, 7, 7),
(15, 'Manoj Jayan', 'manojjayan@gmail.com', 9980798099, 31, 10);

-- --------------------------------------------------------

--
-- Table structure for table `adminapp_tbl_district`
--

DROP TABLE IF EXISTS `adminapp_tbl_district`;
CREATE TABLE IF NOT EXISTS `adminapp_tbl_district` (
  `districtid` int(11) NOT NULL AUTO_INCREMENT,
  `districtname` varchar(25) NOT NULL,
  PRIMARY KEY (`districtid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminapp_tbl_district`
--

INSERT INTO `adminapp_tbl_district` (`districtid`, `districtname`) VALUES
(2, 'Kannur'),
(3, 'Wayanad'),
(4, 'Ernakulam'),
(5, 'Kozhikode'),
(12, 'Kollam');

-- --------------------------------------------------------

--
-- Table structure for table `adminapp_tbl_location`
--

DROP TABLE IF EXISTS `adminapp_tbl_location`;
CREATE TABLE IF NOT EXISTS `adminapp_tbl_location` (
  `locationid` int(11) NOT NULL AUTO_INCREMENT,
  `locationname` varchar(25) NOT NULL,
  `districtid_id` int(11) NOT NULL,
  PRIMARY KEY (`locationid`),
  KEY `adminapp_tbl_location_districtid_id_582f66a5` (`districtid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminapp_tbl_location`
--

INSERT INTO `adminapp_tbl_location` (`locationid`, `locationname`, `districtid_id`) VALUES
(1, 'Taliparambu', 2),
(2, 'Kalpetta', 3),
(3, 'Muvattupuzha', 4),
(4, 'Kolenchery', 4),
(5, 'koothattukulam', 4);

-- --------------------------------------------------------

--
-- Table structure for table `adminapp_tbl_panchayath`
--

DROP TABLE IF EXISTS `adminapp_tbl_panchayath`;
CREATE TABLE IF NOT EXISTS `adminapp_tbl_panchayath` (
  `panchayathid` int(11) NOT NULL AUTO_INCREMENT,
  `panchayathname` varchar(25) NOT NULL,
  PRIMARY KEY (`panchayathid`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminapp_tbl_panchayath`
--

INSERT INTO `adminapp_tbl_panchayath` (`panchayathid`, `panchayathname`) VALUES
(1, 'Elappara'),
(2, 'Adimaly'),
(3, 'Arakkulam'),
(11, 'Edamalakkudi'),
(10, 'Vazhithala'),
(7, 'Kumily'),
(8, 'parayoor');

-- --------------------------------------------------------

--
-- Table structure for table `adminapp_tbl_product`
--

DROP TABLE IF EXISTS `adminapp_tbl_product`;
CREATE TABLE IF NOT EXISTS `adminapp_tbl_product` (
  `productid` int(11) NOT NULL AUTO_INCREMENT,
  `productname` varchar(25) NOT NULL,
  `productimage` varchar(100) NOT NULL,
  PRIMARY KEY (`productid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adminapp_tbl_product`
--

INSERT INTO `adminapp_tbl_product` (`productid`, `productname`, `productimage`) VALUES
(16, 'pepper plants', 'pepper-plants.jpeg'),
(15, 'cardamom', 'cardomon.webp'),
(12, 'coconut seedlings', 'coconutplant.webp'),
(13, 'coffee seedlings', 'coffee.jpg'),
(14, 'Banana seeds', 'banana_seeds.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add tbl_district', 7, 'add_tbl_district'),
(26, 'Can change tbl_district', 7, 'change_tbl_district'),
(27, 'Can delete tbl_district', 7, 'delete_tbl_district'),
(28, 'Can view tbl_district', 7, 'view_tbl_district'),
(29, 'Can add tbl_location', 8, 'add_tbl_location'),
(30, 'Can change tbl_location', 8, 'change_tbl_location'),
(31, 'Can delete tbl_location', 8, 'delete_tbl_location'),
(32, 'Can view tbl_location', 8, 'view_tbl_location'),
(33, 'Can add tbl_panchayath', 9, 'add_tbl_panchayath'),
(34, 'Can change tbl_panchayath', 9, 'change_tbl_panchayath'),
(35, 'Can delete tbl_panchayath', 9, 'delete_tbl_panchayath'),
(36, 'Can view tbl_panchayath', 9, 'view_tbl_panchayath'),
(37, 'Can add tbl_product', 10, 'add_tbl_product'),
(38, 'Can change tbl_product', 10, 'change_tbl_product'),
(39, 'Can delete tbl_product', 10, 'delete_tbl_product'),
(40, 'Can view tbl_product', 10, 'view_tbl_product'),
(41, 'Can add tbl_login', 11, 'add_tbl_login'),
(42, 'Can change tbl_login', 11, 'change_tbl_login'),
(43, 'Can delete tbl_login', 11, 'delete_tbl_login'),
(44, 'Can view tbl_login', 11, 'view_tbl_login'),
(45, 'Can add tbl_agriofficer', 12, 'add_tbl_agriofficer'),
(46, 'Can change tbl_agriofficer', 12, 'change_tbl_agriofficer'),
(47, 'Can delete tbl_agriofficer', 12, 'delete_tbl_agriofficer'),
(48, 'Can view tbl_agriofficer', 12, 'view_tbl_agriofficer'),
(49, 'Can add tbl_notification', 13, 'add_tbl_notification'),
(50, 'Can change tbl_notification', 13, 'change_tbl_notification'),
(51, 'Can delete tbl_notification', 13, 'delete_tbl_notification'),
(52, 'Can view tbl_notification', 13, 'view_tbl_notification'),
(53, 'Can add tbl_farmer', 14, 'add_tbl_farmer'),
(54, 'Can change tbl_farmer', 14, 'change_tbl_farmer'),
(55, 'Can delete tbl_farmer', 14, 'delete_tbl_farmer'),
(56, 'Can view tbl_farmer', 14, 'view_tbl_farmer'),
(57, 'Can add tbl_ request', 15, 'add_tbl_request'),
(58, 'Can change tbl_ request', 15, 'change_tbl_request'),
(59, 'Can delete tbl_ request', 15, 'delete_tbl_request'),
(60, 'Can view tbl_ request', 15, 'view_tbl_request'),
(61, 'Can add tbl_service', 16, 'add_tbl_service'),
(62, 'Can change tbl_service', 16, 'change_tbl_service'),
(63, 'Can delete tbl_service', 16, 'delete_tbl_service'),
(64, 'Can view tbl_service', 16, 'view_tbl_service'),
(65, 'Can add tbl_ payment', 17, 'add_tbl_payment'),
(66, 'Can change tbl_ payment', 17, 'change_tbl_payment'),
(67, 'Can delete tbl_ payment', 17, 'delete_tbl_payment'),
(68, 'Can view tbl_ payment', 17, 'view_tbl_payment'),
(69, 'Can add tbl_ payments', 17, 'add_tbl_payments'),
(70, 'Can change tbl_ payments', 17, 'change_tbl_payments'),
(71, 'Can delete tbl_ payments', 17, 'delete_tbl_payments'),
(72, 'Can view tbl_ payments', 17, 'view_tbl_payments'),
(73, 'Can add tbl_pay', 18, 'add_tbl_pay'),
(74, 'Can change tbl_pay', 18, 'change_tbl_pay'),
(75, 'Can delete tbl_pay', 18, 'delete_tbl_pay'),
(76, 'Can view tbl_pay', 18, 'view_tbl_pay'),
(77, 'Can add tbl_insurancepolicy', 19, 'add_tbl_insurancepolicy'),
(78, 'Can change tbl_insurancepolicy', 19, 'change_tbl_insurancepolicy'),
(79, 'Can delete tbl_insurancepolicy', 19, 'delete_tbl_insurancepolicy'),
(80, 'Can view tbl_insurancepolicy', 19, 'view_tbl_insurancepolicy'),
(81, 'Can add tbl_insurance', 20, 'add_tbl_insurance'),
(82, 'Can change tbl_insurance', 20, 'change_tbl_insurance'),
(83, 'Can delete tbl_insurance', 20, 'delete_tbl_insurance'),
(84, 'Can view tbl_insurance', 20, 'view_tbl_insurance'),
(85, 'Can add tbl_training', 21, 'add_tbl_training'),
(86, 'Can change tbl_training', 21, 'change_tbl_training'),
(87, 'Can delete tbl_training', 21, 'delete_tbl_training'),
(88, 'Can view tbl_training', 21, 'view_tbl_training');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'adminapp', 'tbl_district'),
(8, 'adminapp', 'tbl_location'),
(9, 'adminapp', 'tbl_panchayath'),
(10, 'adminapp', 'tbl_product'),
(11, 'guestapp', 'tbl_login'),
(12, 'adminapp', 'tbl_agriofficer'),
(13, 'officerapp', 'tbl_notification'),
(14, 'guestapp', 'tbl_farmer'),
(15, 'farmerapp', 'tbl_request'),
(16, 'officerapp', 'tbl_service'),
(17, 'farmerapp', 'tbl_payments'),
(18, 'farmerapp', 'tbl_pay'),
(19, 'farmerapp', 'tbl_insurancepolicy'),
(20, 'farmerapp', 'tbl_insurance'),
(21, 'officerapp', 'tbl_training');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-01-15 08:21:32.388453'),
(2, 'auth', '0001_initial', '2025-01-15 08:21:32.528724'),
(3, 'admin', '0001_initial', '2025-01-15 08:21:32.564134'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-01-15 08:21:32.571127'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-15 08:21:32.579472'),
(6, 'adminapp', '0001_initial', '2025-01-15 08:21:32.604490'),
(7, 'contenttypes', '0002_remove_content_type_name', '2025-01-15 08:21:32.634054'),
(8, 'auth', '0002_alter_permission_name_max_length', '2025-01-15 08:21:32.653224'),
(9, 'auth', '0003_alter_user_email_max_length', '2025-01-15 08:21:32.667039'),
(10, 'auth', '0004_alter_user_username_opts', '2025-01-15 08:21:32.675091'),
(11, 'auth', '0005_alter_user_last_login_null', '2025-01-15 08:21:32.687227'),
(12, 'auth', '0006_require_contenttypes_0002', '2025-01-15 08:21:32.690539'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2025-01-15 08:21:32.697528'),
(14, 'auth', '0008_alter_user_username_max_length', '2025-01-15 08:21:32.711202'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2025-01-15 08:21:32.724630'),
(16, 'auth', '0010_alter_group_name_max_length', '2025-01-15 08:21:32.737225'),
(17, 'auth', '0011_update_proxy_permissions', '2025-01-15 08:21:32.746019'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2025-01-15 08:21:32.760148'),
(19, 'sessions', '0001_initial', '2025-01-15 08:21:32.775203'),
(20, 'adminapp', '0002_rename_ditrictname_tbl_district_districtname', '2025-01-15 08:45:04.125447'),
(21, 'adminapp', '0003_tbl_panchayath', '2025-01-15 14:28:49.110339'),
(22, 'adminapp', '0004_tbl_product', '2025-01-15 15:50:02.830674'),
(23, 'guestapp', '0001_initial', '2025-01-16 04:13:42.043391'),
(24, 'adminapp', '0005_tbl_agriofficer', '2025-01-16 05:19:41.050919'),
(25, 'officerapp', '0001_initial', '2025-01-20 08:58:40.150138'),
(26, 'officerapp', '0002_tbl_notification_image_tbl_notification_officerid', '2025-01-22 09:51:20.667593'),
(27, 'guestapp', '0002_tbl_farmer', '2025-01-23 05:50:15.657256'),
(28, 'guestapp', '0003_alter_tbl_farmer_regdate', '2025-01-23 06:10:18.555891'),
(29, 'farmerapp', '0001_initial', '2025-01-28 09:28:19.442656'),
(30, 'farmerapp', '0002_tbl_request_amount_tbl_request_totalamount', '2025-01-28 09:41:11.358281'),
(31, 'officerapp', '0003_tbl_service', '2025-01-29 07:11:40.981820'),
(32, 'farmerapp', '0003_remove_tbl_request_amount', '2025-02-04 05:47:24.027147'),
(33, 'farmerapp', '0004_tbl_payment', '2025-02-05 06:38:07.730357'),
(34, 'farmerapp', '0005_rename_tbl_payment_tbl_payments', '2025-02-05 07:01:39.978418'),
(35, 'farmerapp', '0004_tbl_pay', '2025-02-05 07:03:59.787679'),
(36, 'farmerapp', '0005_rename_payment_date_tbl_pay_paydate', '2025-02-05 07:04:58.368752'),
(37, 'farmerapp', '0006_tbl_insurancepolicy', '2025-02-10 05:38:40.247701'),
(38, 'farmerapp', '0007_tbl_insurancepolicy_officerid', '2025-02-10 10:15:08.629235'),
(39, 'farmerapp', '0008_tbl_insurance', '2025-02-13 06:27:41.363550'),
(40, 'farmerapp', '0009_tbl_insurance_type', '2025-02-14 06:29:23.314235'),
(41, 'officerapp', '0004_tbl_training', '2025-02-19 08:43:41.240143'),
(42, 'officerapp', '0005_tbl_training_status', '2025-02-19 08:48:02.618024'),
(43, 'officerapp', '0006_alter_tbl_training_cdate', '2025-02-19 10:03:48.210109'),
(44, 'officerapp', '0007_tbl_training_image', '2025-02-21 05:52:21.147357'),
(45, 'officerapp', '0008_alter_tbl_training_description', '2025-02-25 06:54:58.250686');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('h8kei0dl81eu1ox8vky3ofg8do0rri6o', 'e30:1twa8A:FMWQN0bawqaFmd3j7yzTn2htoneNdwPhePum5GRiwTw', '2025-04-07 05:13:46.276102');

-- --------------------------------------------------------

--
-- Table structure for table `farmerapp_tbl_insurance`
--

DROP TABLE IF EXISTS `farmerapp_tbl_insurance`;
CREATE TABLE IF NOT EXISTS `farmerapp_tbl_insurance` (
  `insuranceid` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `photo1` varchar(100) NOT NULL,
  `photo2` varchar(100) NOT NULL,
  `remarkdate` date DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `applyid_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`insuranceid`),
  KEY `farmerapp_tbl_insurance_applyid_id_e694c54e` (`applyid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmerapp_tbl_insurance`
--

INSERT INTO `farmerapp_tbl_insurance` (`insuranceid`, `description`, `photo1`, `photo2`, `remarkdate`, `amount`, `status`, `applyid_id`, `type`) VALUES
(2, 'Wind', 'plantain_disaster_9aSPjBG.jpg', 'zoran-zonde-stojanovski-5cDfpn8raQ8-unsplash1.jpg', NULL, NULL, 'Requested', 4, 'others'),
(4, 'wind cause', 'coconut_plot_y65ryGY.jpg', 'plantain_disaster_DILTiFT.jpg', '2025-03-06', 5000, 'Visited', 6, 'Climate-Related Disaster');

-- --------------------------------------------------------

--
-- Table structure for table `farmerapp_tbl_insurancepolicy`
--

DROP TABLE IF EXISTS `farmerapp_tbl_insurancepolicy`;
CREATE TABLE IF NOT EXISTS `farmerapp_tbl_insurancepolicy` (
  `applyid` int(11) NOT NULL AUTO_INCREMENT,
  `landdetails` longtext NOT NULL,
  `cropdetails` longtext NOT NULL,
  `applydate` date NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(25) NOT NULL,
  `remarkdate` date DEFAULT NULL,
  `photo1` varchar(100) NOT NULL,
  `photo2` varchar(100) NOT NULL,
  `farmerid_id` int(11) NOT NULL,
  `Officerid_id` int(11) NOT NULL,
  PRIMARY KEY (`applyid`),
  KEY `farmerapp_tbl_insurancepolicy_farmerid_id_62cc088b` (`farmerid_id`),
  KEY `farmerapp_tbl_insurancepolicy_Officerid_id_b9418205` (`Officerid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmerapp_tbl_insurancepolicy`
--

INSERT INTO `farmerapp_tbl_insurancepolicy` (`applyid`, `landdetails`, `cropdetails`, `applydate`, `description`, `status`, `remarkdate`, `photo1`, `photo2`, `farmerid_id`, `Officerid_id`) VALUES
(4, '10 Acre plot ', 'Rubber crop', '2025-02-24', 'rubber crops on 10 acre plots', 'Confirmed', '2025-02-26', 'coconut_plot_vhkSmiR.jpg', 'coconut_plot_YZ2nZk0.jpg', 4, 6),
(9, '1 Acre plot', 'plantain crop', '2025-03-24', '1 Acre plot for plantain crop', 'Requested', NULL, 'coconut_plot_rC0y1LV.jpg', 'coconut_plot_qUlWAiv.jpg', 12, 15),
(6, '20 Acre plot', 'watermelon seedlings', '2025-03-04', 'watermelon seedlings', 'Confirmed', '2025-03-08', 'if10.jpg', 'coconut_plot_4ZE0My5.jpg', 8, 11),
(7, '2 acre plott', 'mango seedligs', '2025-03-05', '2 acre', 'Confirmed', '2025-03-08', 'background1.jpg', 'coconut_plot_4TxYrDC.jpg', 8, 11),
(8, '5 acre plot', 'watermelon seedlings', '2025-03-12', 'plot for watermelon', 'Confirmed', '2025-03-15', 'coconut_plot_XgMbhYP.jpg', 'login1.jpg', 8, 11);

-- --------------------------------------------------------

--
-- Table structure for table `farmerapp_tbl_pay`
--

DROP TABLE IF EXISTS `farmerapp_tbl_pay`;
CREATE TABLE IF NOT EXISTS `farmerapp_tbl_pay` (
  `paymentid` int(11) NOT NULL AUTO_INCREMENT,
  `totalamount` int(11) NOT NULL,
  `paydate` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `reqid_id` int(11) NOT NULL,
  PRIMARY KEY (`paymentid`),
  KEY `farmerapp_tbl_pay_reqid_id_0cec9a71` (`reqid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmerapp_tbl_pay`
--

INSERT INTO `farmerapp_tbl_pay` (`paymentid`, `totalamount`, `paydate`, `status`, `reqid_id`) VALUES
(10, 500, '2025-03-24', 'paid', 43);

-- --------------------------------------------------------

--
-- Table structure for table `farmerapp_tbl_payments`
--

DROP TABLE IF EXISTS `farmerapp_tbl_payments`;
CREATE TABLE IF NOT EXISTS `farmerapp_tbl_payments` (
  `payid` int(11) NOT NULL AUTO_INCREMENT,
  `totalamount` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `reqid_id` int(11) NOT NULL,
  PRIMARY KEY (`payid`),
  KEY `farmerapp_tbl_payment_reqid_id_a9dcd31b` (`reqid_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `farmerapp_tbl_request`
--

DROP TABLE IF EXISTS `farmerapp_tbl_request`;
CREATE TABLE IF NOT EXISTS `farmerapp_tbl_request` (
  `reqid` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `farmerid_id` int(11) NOT NULL,
  `notiid_id` int(11) NOT NULL,
  `totalamount` int(11) NOT NULL,
  PRIMARY KEY (`reqid`),
  KEY `farmerapp_tbl_request_farmerid_id_cf2170ae` (`farmerid_id`),
  KEY `farmerapp_tbl_request_notiid_id_39d0f227` (`notiid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmerapp_tbl_request`
--

INSERT INTO `farmerapp_tbl_request` (`reqid`, `quantity`, `status`, `farmerid_id`, `notiid_id`, `totalamount`) VALUES
(44, 20, 'Requested', 10, 16, 300),
(45, 30, 'Requested', 10, 17, 750),
(43, 50, 'Paid', 12, 15, 500);

-- --------------------------------------------------------

--
-- Table structure for table `guestapp_tbl_farmer`
--

DROP TABLE IF EXISTS `guestapp_tbl_farmer`;
CREATE TABLE IF NOT EXISTS `guestapp_tbl_farmer` (
  `farmerid` int(11) NOT NULL AUTO_INCREMENT,
  `farmername` varchar(25) NOT NULL,
  `address` varchar(40) NOT NULL,
  `email` varchar(25) NOT NULL,
  `contactno` bigint(20) NOT NULL,
  `regdate` date NOT NULL,
  `loginid_id` int(11) NOT NULL,
  `panchayathid_id` int(11) NOT NULL,
  PRIMARY KEY (`farmerid`),
  KEY `guestapp_tbl_farmer_loginid_id_3d54e1d7` (`loginid_id`),
  KEY `guestapp_tbl_farmer_panchayathid_id_4a7ecabf` (`panchayathid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guestapp_tbl_farmer`
--

INSERT INTO `guestapp_tbl_farmer` (`farmerid`, `farmername`, `address`, `email`, `contactno`, `regdate`, `loginid_id`, `panchayathid_id`) VALUES
(1, 'Mathayi PJ', 'Muthoottil', 'mathayipj@gmail.com', 9987304563, '2025-01-23', 5, 1),
(2, 'Kuberan KB', 'Manimuttath', 'kuberankb@gmail.com', 9961859042, '2025-01-24', 6, 2),
(12, 'Pathrose Mathayi', 'Puthanpuraykkal', 'pathrosemathayI@gmail.com', 9980768970, '2025-03-23', 30, 10),
(4, 'George', 'Mannarveettil', 'george123@gmail.com', 9961444580, '2025-02-24', 12, 7),
(7, 'Joji George', 'Mannar Madathil(H),vazhakulam PO kavana', 'jojigeorge@gmail.com', 9987609980, '2025-03-04', 18, 7),
(8, 'Gangadharan', 'Kaarikkottil(H),Kumily(PO) Kumily', 'gangaadharan@gmail.com', 9980763340, '2025-03-04', 23, 7),
(11, 'Adhithyavarma', 'Mecheril ', 'adhithyavarma@gmail.com', 8907890054, '2025-03-22', 29, 2),
(10, 'arjun', 'anjiliparambil', 'arjun@gmail.com', 8890876980, '2025-03-05', 25, 7);

-- --------------------------------------------------------

--
-- Table structure for table `guestapp_tbl_login`
--

DROP TABLE IF EXISTS `guestapp_tbl_login`;
CREATE TABLE IF NOT EXISTS `guestapp_tbl_login` (
  `loginid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`loginid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guestapp_tbl_login`
--

INSERT INTO `guestapp_tbl_login` (`loginid`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin', 'admin'),
(6, 'Kuberan', 'Kuberan', 'farmer'),
(5, 'Mathayi', 'Mathayi', 'farmer'),
(4, 'Varsha', 'Varsha', 'officer'),
(7, 'Bleslybijoy', 'Bleslybijoy', 'officer'),
(9, 'joseph', 'joseph', 'officer'),
(10, 'Karunakaran', 'Karunakaran', 'farmer'),
(11, 'new', 'new', 'officer'),
(12, 'George', 'George', 'farmer'),
(13, 'Manoharan', 'Manoharan', 'officer'),
(25, 'arjun123', 'arjun123', 'farmer'),
(23, 'gangadharan', 'gangadharan', 'farmer'),
(29, 'Adithyavarma', 'Adithyavarma', 'farmer'),
(30, 'pathrose', 'pathrose', 'farmer'),
(31, 'Manojjayan', 'Manojjayan', 'officer');

-- --------------------------------------------------------

--
-- Table structure for table `officerapp_tbl_notification`
--

DROP TABLE IF EXISTS `officerapp_tbl_notification`;
CREATE TABLE IF NOT EXISTS `officerapp_tbl_notification` (
  `notiid` int(11) NOT NULL AUTO_INCREMENT,
  `notification` varchar(100) NOT NULL,
  `frdate` date NOT NULL,
  `todate` date NOT NULL,
  `count` int(11) NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `productid_id` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `officerid_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`notiid`),
  KEY `officerapp_tbl_notification_productid_id_f4e7bd32` (`productid_id`),
  KEY `officerapp_tbl_notification_officerid_id_0f7fe662` (`officerid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `officerapp_tbl_notification`
--

INSERT INTO `officerapp_tbl_notification` (`notiid`, `notification`, `frdate`, `todate`, `count`, `amount`, `productid_id`, `image`, `officerid_id`) VALUES
(15, 'Banana seeds are available a Krishibhavan', '2025-03-24', '2025-03-29', 50, '10.00', 14, 'banana_seeds_wvtV1Qk.jpg', 15),
(16, 'Pepper seedlings', '2025-03-25', '2025-03-29', 150, '15.00', 16, 'pepper-plants_9WH5x9T.jpeg', 2),
(17, 'Cardomom seedlings', '2025-03-23', '2025-03-29', 200, '25.00', 15, 'cardomon_DXrYce3.webp', 2);

-- --------------------------------------------------------

--
-- Table structure for table `officerapp_tbl_service`
--

DROP TABLE IF EXISTS `officerapp_tbl_service`;
CREATE TABLE IF NOT EXISTS `officerapp_tbl_service` (
  `serviceid` int(11) NOT NULL AUTO_INCREMENT,
  `servicename` varchar(50) NOT NULL,
  PRIMARY KEY (`serviceid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `officerapp_tbl_training`
--

DROP TABLE IF EXISTS `officerapp_tbl_training`;
CREATE TABLE IF NOT EXISTS `officerapp_tbl_training` (
  `trainingid` int(11) NOT NULL AUTO_INCREMENT,
  `trainingname` varchar(50) NOT NULL,
  `description` varchar(1050) NOT NULL,
  `date` date NOT NULL,
  `cdate` date NOT NULL,
  `officerid_id` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`trainingid`),
  KEY `officerapp_tbl_training_officerid_id_ae39a38f` (`officerid_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `officerapp_tbl_training`
--

INSERT INTO `officerapp_tbl_training` (`trainingid`, `trainingname`, `description`, `date`, `cdate`, `officerid_id`, `status`, `image`) VALUES
(12, 'Fertilizer classes for farmers', 'how to find the best fertilizers for your crop..\r\ntime : 10: 00 am', '2025-03-29', '2025-03-22', 11, 'Published', 'fertilizer_nAW06GE.jpg'),
(7, 'Organic Farming', 'Organic farming is an eco-friendly agricultural approach that avoids synthetic fertilizers, pesticides, and genetically modified organisms (GMOs), focusing instead on natural methods to maintain soil health and biodiversity. It relies on composting, crop rotation, biofertilizers, and natural pest control to enhance productivity while preserving the environment. By eliminating harmful chemicals, organic farming produces healthier, chemical-free food and helps sustain soil fertility in the long run. It also promotes water conservation and reduces pollution, making it a climate-friendly alternative to conventional farming.\r\n\r\nTIME : 10:00 am', '2025-03-08', '2025-03-04', 11, 'Published', 'organicfarming.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
