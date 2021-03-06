-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 01, 2014 at 10:51 AM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db532021402`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `Admin_id` int(1) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(15) NOT NULL,
  PRIMARY KEY (`Admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Admin_id`, `Username`, `Password`) VALUES
(1, 'admin', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `Cate_id` int(1) NOT NULL AUTO_INCREMENT,
  `Cate_name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`Cate_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`Cate_id`, `Cate_name`, `status`) VALUES
(1, 'วัน', 0),
(2, 'เดือน', 0),
(3, 'ฤดูกาล', 0),
(4, 'ช่วงเวลา', 0),
(14, 'ผัก', 0),
(12, 'ครอบครัว', 0),
(13, 'อวัยวะต่าง ๆ ของร่างกาย', 0),
(15, 'ผลไม้', 0),
(16, 'ประเทศและเมืองหลวง', 0),
(27, 'ตัวเลข,จำนวน', 0);

-- --------------------------------------------------------

--
-- Table structure for table `vocabulary`
--

CREATE TABLE IF NOT EXISTS `vocabulary` (
  `Vocab_id` int(1) NOT NULL AUTO_INCREMENT,
  `Thai_Vocab` varchar(50) NOT NULL,
  `Arab_Vocab` varchar(50) NOT NULL,
  `Pronounce` varchar(50) NOT NULL,
  `Sound` varchar(50) NOT NULL,
  `Cate_id` int(1) NOT NULL,
  PRIMARY KEY (`Vocab_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=77 ;

--
-- Dumping data for table `vocabulary`
--

INSERT INTO `vocabulary` (`Vocab_id`, `Thai_Vocab`, `Arab_Vocab`, `Pronounce`, `Sound`, `Cate_id`) VALUES
(1, 'วันอาทิตย์', 'يوم الأحد', 'เยา-มุล-อา-หา-ดี', '001', 1),
(2, 'วันจันทร์', 'يوم الأُ ثنين', 'เยา-มุล-อิซ-นัย-นี่', '002', 1),
(3, 'วันอังคาร', 'يوم الثلا ثاء', 'เยา-มุซ-ซ่า-ลา-ซา-อี', '003', 1),
(4, 'วันพุธ', 'يوم الأر بعاء', 'เยา-มุล-อัร-บี-อา-อี', '004', 1),
(5, 'วันพฤหัสบดี', 'يوم الخميس', 'เยา-มุล-ค่อ-มี่-ซี่', '005', 1),
(6, 'วันศุกร์', 'يوم الجمعة', 'เยา-มุล-ญุม-อา-ตี้', '006', 1),
(7, 'วันเสาร์', 'يوم السبت', 'เยา-มุซ-ซับ-ตี้', '007', 1),
(12, 'มกราคม', 'يناير', 'ย่า-นา-ยิร', '008', 2),
(13, 'กุมภาพันธ์', 'فبراير', 'ฟิบ-รอ-ยิร', '009', 2),
(14, 'มีนาคม', 'مارس', 'มา-ริซ', '010', 2),
(15, 'เมษายน', 'ابريل', 'อับ-รีล', '011', 2),
(16, 'พฤษภาคม', 'مايو', 'มา-ยู', '012', 2),
(17, 'มิถุนายน', 'يونيو', 'ยูน-ยู', '013', 2),
(18, 'กรกฎาคม', 'يوليو', 'ยูล-ยู', '014', 2),
(19, 'สิงหาคม', 'اغسطس', 'อ่า-ฆุซ-ฏุซ', '015', 2),
(20, 'กันยายน', 'سبتمبر', 'ซิบ-ติม-บิร', '016', 2),
(21, 'ตุลาคม', 'اكتوبر', 'อุก-ตู-บิร', '017', 2),
(22, 'พฤศจิกายน', 'نوفمبر', 'นู-ฟิม-บิร', '018', 2),
(23, 'ธันวาคม', 'ديسمبر', 'ดี-ซิม-บิร', '019', 2),
(24, 'ฤดูหนาว', 'شتاء', 'ชี่-ตา-อุน', '020', 3),
(25, 'ฤดูใบไม้ผลิ', 'ربيع', 'ร่อ-บี-อุน', '021', 3),
(26, 'ฤดูร้อน', 'صيف', 'ศ็อย-ฟุน', '022', 3),
(27, 'ฤดูใบไม่ร่วง', 'خريف', 'ค่อ-รี-ฟุน', '023', 3),
(28, 'ฤดูกาล', 'فصل', 'ฟัซ-ลุน', '024', 3),
(29, 'ฤดูฝน', 'مطر', 'มา-ตอ-รุน', '025', 3),
(30, 'เวลา', 'وقت', 'วัก-ตุน', '026', 4),
(31, 'ยุค', 'دهر', 'ดะฮ-รุน', '027', 4),
(32, 'ขณะ', 'اوان', 'อา-วา-นุน', '028', 4),
(33, 'ตลอดไป', 'ابدا', 'อา-บา-ดัน', '029', 4),
(34, 'ระหว่าง', 'خلال', 'คี-ล่า-ลา', '030', 4),
(35, 'วินาที', 'ثانية', 'ซา-นี-ยา-ตุน', '031', 4),
(36, 'นาที', 'دفيقة', 'ดา-กี้-กอ-ตุน', '032', 4),
(37, 'ชั่วโมง', 'ساعة', 'ซา-อา-ตุน', '033', 4),
(38, 'วัน', 'يوم', 'เยา-มุน', '034', 4),
(39, 'สัปดาห์', 'اسبوع', 'อุซ-บู้-อุน', '035', 4),
(40, 'เดือน', 'شهر', 'ช๊ะ-รุน', '036', 4),
(41, 'ปี', 'سنة', 'ซา-นา-ตุน', '037', 4),
(42, 'ศตวรรษ', 'قرن', 'กอร-นุน', '038', 4),
(43, 'เวลาเช้า', 'صباح', 'ซอ-บ่า-ฮุน', '039', 4),
(44, 'เวลาบ่าย', 'ظهر', 'ศุฮฺ-รุน', '040', 4),
(45, 'เวลากลางวัน', 'نهار', 'นา-ฮ่า-รุน', '041', 4),
(46, 'เวลาเที่ยงวัน', 'منتصف النهار', 'มุน-ต้า-ศอ-ฟุน-น่า-ฮา-รี่', '042', 4),
(47, 'เวลาเย็น', 'عصر', 'อัซ-รุน', '043', 4),
(48, 'คืนหนึ่ง', 'ليلة', 'ลัย-ลา-ตุน', '044', 4),
(49, 'บางเวลา', 'احيانا', 'อะฮฺ-ย่า-นัน', '045', 4),
(50, 'วันนี้', 'اليوم', 'อัล-เยา-มา', '046', 4),
(51, 'ขณะนี้', 'الان', 'อัล-อ่า-น่า', '047', 4),
(52, 'พรุ่งนี้', 'غدا', 'ฆ่อ-ดั่น', '049', 4),
(53, 'ตั้งแต่วันนี้เป็นต้นไป', 'منذ اليوم ', 'มุน-ศุล-เยา-มี่', '050', 4),
(54, 'เช้าวานนี้', 'صباح امس', 'ซ่อ-บา-ฮา-อัม-ซี่', '051', 4),
(55, 'บ่ายวานนี้', 'ظهرامس', 'ศุฮฺ-รอ-อัม-ซี่', '052', 4),
(56, 'เย็นวานนี้', 'مساءامس', 'มา-ซ่า-อา-อัม-ซี่', '053', 4),
(57, 'คืนวานนี้', 'ليلةامس', 'ลัย-ลา-ต่า-อัม-ซี่', '054', 4),
(58, 'พรุ่งนี้เช้า', 'صباح غد', 'ซ่อ-บา-ฮา-ฆ่อ-ดิน', '055', 4),
(59, 'พรุ่งนี้บ่าย', 'ظهرغد', 'ศุฮฺ-ร่อ-ฆ่อ-ดิน', '056', 4),
(60, 'พรุ่งนี้เย็น', 'مساءغد', 'มา-ซ่า-อา-ฆ่อ-ดิน', '057', 4),
(61, 'คืนพรุ่งนี้', 'ليلةغد', 'ลัย-ลา-ต่า-ฆ่อ-ดิน', '058', 4),
(62, 'ในหนึ่งวัน', 'في اليوم', 'ฟิล-เยา-มี่', '059', 4),
(63, 'ในหนึ่งสัปดาห์', 'فى الاسبوع', 'ฟิล-อุซ-บู่-อี', '060', 4),
(64, 'ในหนึ่งเดือน', 'فى الشهر', 'ฟิช-ชะฮฺ-รี่', '061', 4),
(65, 'ในหนึ่งปี', 'فى السنة', 'ฟิซ-ซา-น่า-ตี', '062', 4),
(66, 'ทุกวินาที', 'كل ثانية', 'กุล-ลู่-ซ่า-นี่-ย่า-ติน', '063', 4),
(67, 'ทุกนาที', 'كل دقيقة', 'กุล-ลู่-ดา-กี้-ก้อ-ติน', '064', 4),
(68, 'ทุกชั่วโมง', 'كل ساعة', 'กุล-ลู่-ซ่า-อา-ติน', '065', 4),
(69, 'ทุกวัน', 'كل يوم', 'กุล-ลู่-เยา-มิน', '066', 4),
(70, 'ทุกสัปดาห์', 'كل اسبوع', 'กุล-ลู่-อุซ-บู่-อิน', '067', 4),
(71, 'ทุกเดือน', 'كل شهر', 'กุล-ลู่-ชะฮฺ-ริน', '068', 4),
(72, 'สุดสัปดาห์', 'اخرالاسبوع', 'อ่า-คี่-รุล-อุซ-บู่-อี', '069', 4),
(73, 'สิ้นเดือน', 'اخرالشهر', 'อ่า-คี่-รุช-ชะฮฺ-รี่', '070', 4),
(74, 'สิ้นปี', 'اخرالسنة', 'อ่า-คี่-รุซ-ซ่า-น่า-ตี', '071', 4);
