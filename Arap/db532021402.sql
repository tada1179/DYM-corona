-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
-- 
-- โฮสต์: localhost
-- เวลาในการสร้าง: 
-- รุ่นของเซิร์ฟเวอร์: 5.0.51
-- รุ่นของ PHP: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- ฐานข้อมูล: `db532021402`
-- 

-- --------------------------------------------------------

-- 
-- โครงสร้างตาราง `admin`
-- 

CREATE TABLE `admin` (
  `Admin_id` int(1) NOT NULL auto_increment,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(15) NOT NULL,
  PRIMARY KEY  (`Admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- dump ตาราง `admin`
-- 

INSERT INTO `admin` VALUES (1, 'admin', '1234');

-- --------------------------------------------------------

-- 
-- โครงสร้างตาราง `category`
-- 

CREATE TABLE `category` (
  `Cate_id` int(1) NOT NULL auto_increment,
  `Cate_name` varchar(50) NOT NULL,
  PRIMARY KEY  (`Cate_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

-- 
-- dump ตาราง `category`
-- 

INSERT INTO `category` VALUES (1, 'วันต่าง ๆ ในสัปดาห์');
INSERT INTO `category` VALUES (2, 'เดือน');
INSERT INTO `category` VALUES (3, 'ฤดูกาล');
INSERT INTO `category` VALUES (4, 'ช่วงเวลา');
INSERT INTO `category` VALUES (14, 'ผัก');
INSERT INTO `category` VALUES (12, 'ครอบครัว');
INSERT INTO `category` VALUES (13, 'อวัยวะต่าง ๆ ของร่างกาย');
INSERT INTO `category` VALUES (15, 'ผลไม้');
INSERT INTO `category` VALUES (16, 'ประเทศและเมืองหลวง');

-- --------------------------------------------------------

-- 
-- โครงสร้างตาราง `vocabulary`
-- 

CREATE TABLE `vocabulary` (
  `Vocab_id` int(1) NOT NULL auto_increment,
  `Thai_Vocab` varchar(50) NOT NULL,
  `Arab_Vocab` varchar(50) NOT NULL,
  `Pronounce` varchar(50) NOT NULL,
  `Sound` varchar(50) NOT NULL,
  `Cate_id` int(1) NOT NULL,
  PRIMARY KEY  (`Vocab_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

-- 
-- dump ตาราง `vocabulary`
-- 

INSERT INTO `vocabulary` VALUES (1, 'วันอาทิตย์', 'يوم الأحد', 'เยา-มุล-อา-หา-ดี', '', 1);
INSERT INTO `vocabulary` VALUES (2, 'วันจันทร์', 'يوم الأُ ثنين', 'เยา-มุล-อิซ-นัย-นี่', '', 1);
INSERT INTO `vocabulary` VALUES (3, 'วันอังคาร', 'يوم الثلا ثاء', 'เยา-มุซ-ซ่า-ลา-ซา-อี', '', 1);
INSERT INTO `vocabulary` VALUES (4, 'วันพุธ', 'يوم الأر بعاء', 'เยา-มุล-อัร-บี-อา-อี', '', 1);
INSERT INTO `vocabulary` VALUES (5, 'วันพฤหัสบดี', 'يوم الخميس', 'เยา-มุล-ค่อ-มี่-ซี่', '', 1);
INSERT INTO `vocabulary` VALUES (6, 'วันศุกร์', 'يوم الجمعة', 'เยา-มุล-ญุม-อา-ตี้', '', 1);
INSERT INTO `vocabulary` VALUES (7, 'วันเสาร์', 'يوم السبت', 'เยา-มุซ-ซับ-ตี้', '', 1);
INSERT INTO `vocabulary` VALUES (12, 'มกราคม', 'يناير', 'ย่า-นา-ยิร', '', 2);
INSERT INTO `vocabulary` VALUES (13, 'กุมภาพันธ์', 'فبراير', 'ฟิบ-รอ-ยิร', '', 2);
INSERT INTO `vocabulary` VALUES (14, 'มีนาคม', 'مارس', 'มา-ริซ', '', 2);
INSERT INTO `vocabulary` VALUES (15, 'เมษายน', 'ابريل', 'อับ-รีล', '', 2);
INSERT INTO `vocabulary` VALUES (16, 'พฤษภาคม', 'مايو', 'มา-ยู', '', 2);
INSERT INTO `vocabulary` VALUES (17, 'มิถุนายน', 'يونيو', 'ยูน-ยู', '', 2);
INSERT INTO `vocabulary` VALUES (18, 'กรกฎาคม', 'يوليو', 'ยูล-ยู', '', 2);
INSERT INTO `vocabulary` VALUES (19, 'สิงหาคม', 'اغسطس', 'อ่า-ฆุซ-ฏุซ', '', 2);
INSERT INTO `vocabulary` VALUES (20, 'กันยายน', 'سبتمبر', 'ซิบ-ติม-บิร', '', 2);
INSERT INTO `vocabulary` VALUES (21, 'ตุลาคม', 'اكتوبر', 'อุก-ตู-บิร', '', 2);
INSERT INTO `vocabulary` VALUES (22, 'พฤศจิกายน', 'نوفمبر', 'นู-ฟิม-บิร', '', 2);
INSERT INTO `vocabulary` VALUES (23, 'ธันวาคม', 'ديسمبر', 'ดี-ซิม-บิร', '', 2);
INSERT INTO `vocabulary` VALUES (24, 'ฤดูหนาว', 'شتاء', 'ชี่-ตา-อุน', '', 3);
INSERT INTO `vocabulary` VALUES (25, 'ฤดูใบไม้ผลิ', 'ربيع', 'ร่อ-บี-อุน', '', 3);
INSERT INTO `vocabulary` VALUES (26, 'ฤดูร้อน', 'صيف', 'ศ็อย-ฟุน', '', 3);
INSERT INTO `vocabulary` VALUES (27, 'ฤดูใบไม่ร่วง', 'خريف', 'ค่อ-รี-ฟุน', '', 3);
INSERT INTO `vocabulary` VALUES (28, 'ฤดูกาล', 'فصل', 'ฟัซ-ลุน', '', 3);
INSERT INTO `vocabulary` VALUES (29, 'ฤดูฝน', 'مطر', 'มา-ตอ-รุน', '', 3);
INSERT INTO `vocabulary` VALUES (30, 'เวลา', 'وقت', 'วัก-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (31, 'ยุค', 'دهر', 'ดะฮ-รุน', '', 4);
INSERT INTO `vocabulary` VALUES (32, 'ขณะ', 'اوان', 'อา-วา-นุน', '', 4);
INSERT INTO `vocabulary` VALUES (33, 'ตลอดไป', 'ابدا', 'อา-บา-ดัน', '', 4);
INSERT INTO `vocabulary` VALUES (34, 'ระหว่าง', 'خلال', 'คี-ล่า-ลา', '', 4);
INSERT INTO `vocabulary` VALUES (35, 'วินาที', 'ثانية', 'ซา-นี-ยา-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (36, 'นาที', 'دفيقة', 'ดา-กี้-กอ-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (37, 'ชั่วโมง', 'ساعة', 'ซา-อา-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (38, 'วัน', 'يوم', 'เยา-มุน', '', 4);
INSERT INTO `vocabulary` VALUES (39, 'สัปดาห์', 'اسبوع', 'อุซ-บู้-อุน', '', 4);
INSERT INTO `vocabulary` VALUES (40, 'เดือน', 'شهر', 'ช๊ะ-รุน', '', 4);
INSERT INTO `vocabulary` VALUES (41, 'ปี', 'سنة', 'ซา-นา-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (42, 'ศตวรรษ', 'قرن', 'กอร-นุน', '', 4);
INSERT INTO `vocabulary` VALUES (43, 'เวลาเช้า', 'صباح', 'ซอ-บ่า-ฮุน', '', 4);
INSERT INTO `vocabulary` VALUES (44, 'เวลาบ่าย', 'ظهر', 'ศุฮฺ-รุน', '', 4);
INSERT INTO `vocabulary` VALUES (45, 'เวลากลางวัน', 'نهار', 'นา-ฮ่า-รุน', '', 4);
INSERT INTO `vocabulary` VALUES (46, 'เวลาเที่ยงวัน', 'منتصف النهار', 'มุน-ต้า-ศอ-ฟุน-น่า-ฮา-รี่', '', 4);
INSERT INTO `vocabulary` VALUES (47, 'เวลาเย็น', 'عصر', 'อัซ-รุน', '', 4);
INSERT INTO `vocabulary` VALUES (48, 'คืนหนึ่ง', 'ليلة', 'ลัย-ลา-ตุน', '', 4);
INSERT INTO `vocabulary` VALUES (49, 'บางเวลา', 'احيانا', 'อะฮฺ-ย่า-นัน', '', 4);
INSERT INTO `vocabulary` VALUES (50, 'วันนี้', 'اليوم', 'อัล-เยา-มา', '', 4);
INSERT INTO `vocabulary` VALUES (51, 'ขณะนี้', 'الان', 'อัล-อ่า-น่า', '', 4);
INSERT INTO `vocabulary` VALUES (52, 'พรุ่งนี้', 'غدا', 'ฆ่อ-ดั่น', '', 4);
INSERT INTO `vocabulary` VALUES (53, 'ตั้งแต่วันนี้เป็นต้นไป', 'منذ اليوم ', 'มุน-ศุล-เยา-มี่', '', 4);
INSERT INTO `vocabulary` VALUES (54, 'เช้าวานนี้', 'صباح امس', 'ซ่อ-บา-ฮา-อัม-ซี่', '', 4);
INSERT INTO `vocabulary` VALUES (55, 'บ่ายวานนี้', 'ظهرامس', 'ศุฮฺ-รอ-อัม-ซี่', '', 4);
INSERT INTO `vocabulary` VALUES (56, 'เย็นวานนี้', 'مساءامس', 'มา-ซ่า-อา-อัม-ซี่', '', 4);
INSERT INTO `vocabulary` VALUES (57, 'คืนวานนี้', 'ليلةامس', 'ลัย-ลา-ต่า-อัม-ซี่', '', 4);
INSERT INTO `vocabulary` VALUES (58, 'พรุ่งนี้เช้า', 'صباح غد', 'ซ่อ-บา-ฮา-ฆ่อ-ดิน', '', 4);
INSERT INTO `vocabulary` VALUES (59, 'พรุ่งนี้บ่าย', 'ظهرغد', 'ศุฮฺ-ร่อ-ฆ่อ-ดิน', '', 4);
INSERT INTO `vocabulary` VALUES (60, 'พรุ่งนี้เย็น', 'مساءغد', 'มา-ซ่า-อา-ฆ่อ-ดิน', '', 4);
INSERT INTO `vocabulary` VALUES (61, 'คืนพรุ่งนี้', 'ليلةغد', 'ลัย-ลา-ต่า-ฆ่อ-ดิน', '', 4);
INSERT INTO `vocabulary` VALUES (62, 'ในหนึ่งวัน', 'في اليوم', 'ฟิล-เยา-มี่', '', 4);
INSERT INTO `vocabulary` VALUES (63, 'ในหนึ่งสัปดาห์', 'فى الاسبوع', 'ฟิล-อุซ-บู่-อี', '', 4);
INSERT INTO `vocabulary` VALUES (64, 'ในหนึ่งเดือน', 'فى الشهر', 'ฟิช-ชะฮฺ-รี่', '', 4);
INSERT INTO `vocabulary` VALUES (65, 'ในหนึ่งปี', 'فى السنة', 'ฟิซ-ซา-น่า-ตี', '', 4);
INSERT INTO `vocabulary` VALUES (66, 'ทุกวินาที', 'كل ثانية', 'กุล-ลู่-ซ่า-นี่-ย่า-ติน', '', 4);
INSERT INTO `vocabulary` VALUES (67, 'ทุกนาที', 'كل دقيقة', 'กุล-ลู่-ดา-กี้-ก้อ-ติน', '', 4);
INSERT INTO `vocabulary` VALUES (68, 'ทุกชั่วโมง', 'كل ساعة', 'กุล-ลู่-ซ่า-อา-ติน', '', 4);
INSERT INTO `vocabulary` VALUES (69, 'ทุกวัน', 'كل يوم', 'กุล-ลู่-เยา-มิน', '', 4);
INSERT INTO `vocabulary` VALUES (70, 'ทุกสัปดาห์', 'كل اسبوع', 'กุล-ลู่-อุซ-บู่-อิน', '', 4);
INSERT INTO `vocabulary` VALUES (71, 'ทุกเดือน', 'كل شهر', 'กุล-ลู่-ชะฮฺ-ริน', '', 4);
INSERT INTO `vocabulary` VALUES (72, 'สุดสัปดาห์', 'اخرالاسبوع', 'อ่า-คี่-รุล-อุซ-บู่-อี', '', 4);
INSERT INTO `vocabulary` VALUES (73, 'สิ้นเดือน', 'اخرالشهر', 'อ่า-คี่-รุช-ชะฮฺ-รี่', '', 4);
INSERT INTO `vocabulary` VALUES (74, 'สิ้นปี', 'اخرالسنة', 'อ่า-คี่-รุซ-ซ่า-น่า-ตี', '', 4);
