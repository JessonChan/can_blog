# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.28)
# Database: can_blog
# Generation Time: 2020-02-09 03:33:09 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cb_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_category`;

CREATE TABLE `cb_category` (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `name` varchar(255) NOT NULL,
                               `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_category` WRITE;
/*!40000 ALTER TABLE `cb_category` DISABLE KEYS */;

INSERT INTO `cb_category` (`id`, `name`, `created`, `updated`)
VALUES
(2,'美好生活','2020-02-08 18:11:54','2020-02-08 18:11:54'),
(4,'编程相关','2020-02-08 18:11:40','2020-02-08 18:11:40');

/*!40000 ALTER TABLE `cb_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_comment`;

CREATE TABLE `cb_comment` (
                              `id` int(11) NOT NULL AUTO_INCREMENT,
                              `username` varchar(200) DEFAULT NULL,
                              `content` varchar(500) DEFAULT NULL,
                              `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              `ip` varchar(100) DEFAULT NULL,
                              `post_id` int(11) DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_comment` WRITE;
/*!40000 ALTER TABLE `cb_comment` DISABLE KEYS */;

INSERT INTO `cb_comment` (`id`, `username`, `content`, `created`, `ip`, `post_id`)
VALUES
(4,'dsdfsfdsfds','fsdfdsfds','2017-08-16 15:34:09','[',0),
(5,'dsfds','fdsfds','2017-08-09 15:41:12','111',1),
(7,'fsdfdsfdsfds','sdfdsfdsf',NULL,'[',8),
(8,'sdfdsfds','fsdfdsfdsfds',NULL,'[',8),
(9,'fdsfdsfdsfds','<p style=\"text-align: left;\"><b>fdsfdsfdsffdsfdsfdsfdsfdsdsfdsfds</b></p><p style=\"text-align: left;\"><b><br></b></p><p style=\"text-align: left;\"><b>a. fsdfdsf</b></p>','2017-08-09 15:42:54','[',8),
(10,'test','<u>stssssfff</u>','2020-02-08 09:45:59','127.0.0.1:52918',9),
(11,'test','hello','2020-02-08 09:47:29','127.0.0.1:52950',9),
(12,'test','aaaa','2020-02-08 09:48:19','127.0.0.1',9),
(13,'ssssfff','aaaa','2020-02-08 09:48:51','127.0.0.1',9),
(14,'ffff','aaaa','2020-02-08 09:49:47','127.0.0.1',9),
(15,'test','aaaaffff','2020-02-08 09:50:40','127.0.0.1:53261',9),
(16,'ssss','fssss','2020-02-08 09:51:42','127.0.0.1:53337',9),
(17,'sss','fff','2020-02-08 09:52:02','127.0.0.1:53356',9);

/*!40000 ALTER TABLE `cb_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_config`;

CREATE TABLE `cb_config` (
                             `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(30) NOT NULL DEFAULT '',
                             `value` text NOT NULL,
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_config` WRITE;
/*!40000 ALTER TABLE `cb_config` DISABLE KEYS */;

INSERT INTO `cb_config` (`id`, `name`, `value`)
VALUES
(1,'title','Cango blog 例子'),
(2,'url','http://www.ptapp.cnsdfdsfds'),
(5,'keywords','dsfds'),
(6,'description','这是一个使用Cango 框架开发的博客网站'),
(7,'email','example@example.com'),
(9,'timezone','8'),
(11,'start','1'),
(12,'qq','10010');

/*!40000 ALTER TABLE `cb_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_post`;

CREATE TABLE `cb_post` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `user_id` int(11) NOT NULL,
                           `title` varchar(255) NOT NULL,
                           `url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '下载地址',
                           `content` mediumtext,
                           `tags` varchar(100) NOT NULL,
                           `views` mediumint(9) NOT NULL,
                           `status` tinyint(4) NOT NULL,
                           `is_top` tinyint(4) NOT NULL DEFAULT '0',
                           `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           `category_id` int(11) NOT NULL,
                           `types` tinyint(4) DEFAULT NULL COMMENT '1. 文章 0 下载',
                           `info` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '简介',
                           `image` varchar(200) DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_post` WRITE;
/*!40000 ALTER TABLE `cb_post` DISABLE KEYS */;

INSERT INTO `cb_post` (`id`, `user_id`, `title`, `url`, `content`, `tags`, `views`, `status`, `is_top`, `created`, `updated`, `category_id`, `types`, `info`, `image`)
VALUES
(8,1,'dsfdsfds','http://www.baidu.com','<p>fdsfdsfdsfdsfds</p>','aaaa,xxxx,dddd,uuu,xxx',0,0,1,'2017-08-08 17:09:22','2017-08-08 17:09:22',2,1,NULL,NULL),
(9,1,'dfsfdsf','http://sfdsfds.omc','<p>fsdfdsfds</p>','fsdfds',0,0,1,'2017-08-08 17:09:41','2017-08-08 17:09:41',2,0,NULL,NULL),
(11,1,'腾讯公司简介','http://www.qq.com','<p>腾讯公司成立于1998年11月，是目前中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。成立十年多以来，腾讯一直秉承“一切以用户价值为依归”的经营理念，始终处于稳健发展的状态。2004年6月16日，腾讯公司在香港联交所主板公开上市(股票代号700)。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　通过互联网服务提升人类生活品质是腾讯公司的使命。目前，腾讯把为用户提供“一站式在线生活服务”作为战略目标，提供互联网增值服务、移动及电信增值服务和网络广告服务。通过即时通信QQ、腾讯网(QQ.com)、腾讯游戏、QQ空间、无线门户、搜搜、拍拍、财付通等中国领先的网络平台，腾讯打造了中国最大的网络社区，满足互联网用户沟通、资讯、娱乐和电子商务等方面的需求。截至2011年9月30日，QQ即时通信的活跃帐户数达到7.117亿，最高同时在线帐户数达到1.454亿。腾讯的发展深刻地影响和改变了数以亿计网民的沟通方式和生活习惯，并为中国互联网行业开创了更加广阔的应用前景。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　面向未来，坚持自主创新，树立民族品牌是腾讯公司的长远发展规划。目前，腾讯50%以上员工为研发人员。腾讯在即时通信、电子商务、在线支付、搜索引擎、信息安全以及游戏等方面都拥有了相当数量的专利申请。2007年，腾讯投资过亿元在北京、上海和深圳三地设立了中国互联网首家研究院—腾讯研究院，进行互联网核心基础技术的自主研发，正逐步走上自主创新的民族产业发展之路。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　成为最受尊敬的互联网企业是腾讯公司的远景目标。腾讯一直积极参与公益事业、努力承担企业社会责任、推动网络文明。2006年，腾讯成立了中国互联网首家慈善公益基金会—腾讯慈善公益基金会，并建立了腾讯公益网(gongyi.qq.com)，专注于辅助青少年教育、贫困地区发展、关爱弱势群体和救灾扶贫工作。目前，腾讯已经在全国各地陆续开展了多项公益项目，积极践行企业公民责任，为“和谐社会”建设做出贡献。</p><p><br/></p><p>愿景：</p><p><br/></p><p>　　最受尊敬的互联网企业。</p><p><br/></p><p>使命：</p><p><br/></p><p>　　通过互联网服务提升人类生活品质。</p><p><br/></p><p>价值观：</p><p><br/></p><p>　　正直，进取，合作，创新。</p><p><br/></p><p>经营理念：</p><p><br/></p><p>　　一切以用户价值为依归。</p><p><br/></p><p>管理理念：</p><p><br/></p><p>　　关心员工成长。</p><p><br/></p><p>公司战略</p><p><br/></p><p>　　腾讯以“为用户提供一站式在线生活服务”作为自己的战略目标，并基于此完成了业务布局，构建了QQ、腾讯网、QQ游戏以及拍拍网这四大网络平台，形成中国规模最大的网络社区。</p><p><br/></p>','腾讯,互联网',0,0,1,'2020-02-08 16:11:17','2020-02-08 16:11:17',2,1,'',''),
(12,1,'腾讯公司简介','http://www.qq.com','<p>腾讯公司成立于1998年11月，是目前中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。成立十年多以来，腾讯一直秉承“一切以用户价值为依归”的经营理念，始终处于稳健发展的状态。2004年6月16日，腾讯公司在香港联交所主板公开上市(股票代号700)。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　通过互联网服务提升人类生活品质是腾讯公司的使命。目前，腾讯把为用户提供“一站式在线生活服务”作为战略目标，提供互联网增值服务、移动及电信增值服务和网络广告服务。通过即时通信QQ、腾讯网(QQ.com)、腾讯游戏、QQ空间、无线门户、搜搜、拍拍、财付通等中国领先的网络平台，腾讯打造了中国最大的网络社区，满足互联网用户沟通、资讯、娱乐和电子商务等方面的需求。截至2011年9月30日，QQ即时通信的活跃帐户数达到7.117亿，最高同时在线帐户数达到1.454亿。腾讯的发展深刻地影响和改变了数以亿计网民的沟通方式和生活习惯，并为中国互联网行业开创了更加广阔的应用前景。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　面向未来，坚持自主创新，树立民族品牌是腾讯公司的长远发展规划。目前，腾讯50%以上员工为研发人员。腾讯在即时通信、电子商务、在线支付、搜索引擎、信息安全以及游戏等方面都拥有了相当数量的专利申请。2007年，腾讯投资过亿元在北京、上海和深圳三地设立了中国互联网首家研究院—腾讯研究院，进行互联网核心基础技术的自主研发，正逐步走上自主创新的民族产业发展之路。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　成为最受尊敬的互联网企业是腾讯公司的远景目标。腾讯一直积极参与公益事业、努力承担企业社会责任、推动网络文明。2006年，腾讯成立了中国互联网首家慈善公益基金会—腾讯慈善公益基金会，并建立了腾讯公益网(gongyi.qq.com)，专注于辅助青少年教育、贫困地区发展、关爱弱势群体和救灾扶贫工作。目前，腾讯已经在全国各地陆续开展了多项公益项目，积极践行企业公民责任，为“和谐社会”建设做出贡献。</p><p><br/></p><p>愿景：</p><p><br/></p><p>　　最受尊敬的互联网企业。</p><p><br/></p><p>使命：</p><p><br/></p><p>　　通过互联网服务提升人类生活品质。</p><p><br/></p><p>价值观：</p><p><br/></p><p>　　正直，进取，合作，创新。</p><p><br/></p><p>经营理念：</p><p><br/></p><p>　　一切以用户价值为依归。</p><p><br/></p><p>管理理念：</p><p><br/></p><p>　　关心员工成长。</p><p><br/></p><p>公司战略</p><p><br/></p><p>　　腾讯以“为用户提供一站式在线生活服务”作为自己的战略目标，并基于此完成了业务布局，构建了QQ、腾讯网、QQ游戏以及拍拍网这四大网络平台，形成中国规模最大的网络社区。</p><p><br/></p>','腾讯,互联网',0,0,1,'2020-02-08 16:12:12','2020-02-08 16:12:12',2,1,'',''),
(13,1,'Hello Golang','http://www.qq.com','<p>Hello hello</p>','TEST',0,0,0,'2020-02-08 16:13:41','2020-02-08 16:13:41',2,1,'',''),
(16,1,'腾讯公司简介','http://www.qq.com','<p>腾讯公司成立于1998年11月，是目前中国最大的互联网综合服务提供商之一，也是中国服务用户最多的互联网企业之一。成立十年多以来，腾讯一直秉承“一切以用户价值为依归”的经营理念，始终处于稳健发展的状态。2004年6月16日，腾讯公司在香港联交所主板公开上市(股票代号700)。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　通过互联网服务提升人类生活品质是腾讯公司的使命。目前，腾讯把为用户提供“一站式在线生活服务”作为战略目标，提供互联网增值服务、移动及电信增值服务和网络广告服务。通过即时通信QQ、腾讯网(QQ.com)、腾讯游戏、QQ空间、无线门户、搜搜、拍拍、财付通等中国领先的网络平台，腾讯打造了中国最大的网络社区，满足互联网用户沟通、资讯、娱乐和电子商务等方面的需求。截至2011年9月30日，QQ即时通信的活跃帐户数达到7.117亿，最高同时在线帐户数达到1.454亿。腾讯的发展深刻地影响和改变了数以亿计网民的沟通方式和生活习惯，并为中国互联网行业开创了更加广阔的应用前景。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　面向未来，坚持自主创新，树立民族品牌是腾讯公司的长远发展规划。目前，腾讯50%以上员工为研发人员。腾讯在即时通信、电子商务、在线支付、搜索引擎、信息安全以及游戏等方面都拥有了相当数量的专利申请。2007年，腾讯投资过亿元在北京、上海和深圳三地设立了中国互联网首家研究院—腾讯研究院，进行互联网核心基础技术的自主研发，正逐步走上自主创新的民族产业发展之路。</p><p><br/></p><p>腾讯</p><p><br/></p><p>　　成为最受尊敬的互联网企业是腾讯公司的远景目标。腾讯一直积极参与公益事业、努力承担企业社会责任、推动网络文明。2006年，腾讯成立了中国互联网首家慈善公益基金会—腾讯慈善公益基金会，并建立了腾讯公益网(gongyi.qq.com)，专注于辅助青少年教育、贫困地区发展、关爱弱势群体和救灾扶贫工作。目前，腾讯已经在全国各地陆续开展了多项公益项目，积极践行企业公民责任，为“和谐社会”建设做出贡献。</p><p><br/></p><p>愿景：</p><p><br/></p><p>　　最受尊敬的互联网企业。</p><p><br/></p><p>使命：</p><p><br/></p><p>　　通过互联网服务提升人类生活品质。</p><p><br/></p><p>价值观：</p><p><br/></p><p>　　正直，进取，合作，创新。</p><p><br/></p><p>经营理念：</p><p><br/></p><p>　　一切以用户价值为依归。</p><p><br/></p><p>管理理念：</p><p><br/></p><p>　　关心员工成长。</p><p><br/></p><p>公司战略</p><p><br/></p><p>　　腾讯以“为用户提供一站式在线生活服务”作为自己的战略目标，并基于此完成了业务布局，构建了QQ、腾讯网、QQ游戏以及拍拍网这四大网络平台，形成中国规模最大的网络社区。</p><p><br/></p>','腾讯,互联网',0,0,1,'2020-02-08 17:05:02','2020-02-08 17:05:02',2,1,'',''),
(17,1,'测试博客','','<p>你好，我是你的好帮手</p>','美好',0,0,1,'2020-02-08 20:06:37','2020-02-08 20:06:37',2,1,'你好，我是你的好帮手','');

/*!40000 ALTER TABLE `cb_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_tag`;

CREATE TABLE `cb_tag` (
                          `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
                          `name` varchar(20) NOT NULL DEFAULT '' COMMENT '标签名',
                          `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用次数',
                          `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`),
                          KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_tag` WRITE;
/*!40000 ALTER TABLE `cb_tag` DISABLE KEYS */;

INSERT INTO `cb_tag` (`id`, `name`, `count`, `created`, `updated`)
VALUES
(1,'iPhone',3,'2017-08-08 10:58:39','2017-08-08 10:58:39'),
(2,'越狱',3,'2017-08-08 10:58:39','2017-08-08 10:58:39');

/*!40000 ALTER TABLE `cb_tag` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_tag_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_tag_post`;

CREATE TABLE `cb_tag_post` (
                               `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                               `tag_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '标签id',
                               `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '内容id',
                               PRIMARY KEY (`id`),
                               KEY `tagid` (`tag_id`),
                               KEY `postid` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `cb_tag_post` WRITE;
/*!40000 ALTER TABLE `cb_tag_post` DISABLE KEYS */;

INSERT INTO `cb_tag_post` (`id`, `tag_id`, `post_id`)
VALUES
(1,1,22),
(2,2,22),
(3,1,21),
(4,2,21),
(5,1,20),
(6,2,20);

/*!40000 ALTER TABLE `cb_tag_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cb_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cb_user`;

CREATE TABLE `cb_user` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `username` varchar(255) DEFAULT NULL,
                           `password` varchar(255) DEFAULT NULL,
                           `email` varchar(200) DEFAULT NULL,
                           `login_count` int(11) DEFAULT NULL,
                           `last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                           `last_ip` varchar(200) DEFAULT 'current_timestamp()',
                           `state` tinyint(4) DEFAULT NULL,
                           `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `cb_user` WRITE;
/*!40000 ALTER TABLE `cb_user` DISABLE KEYS */;

INSERT INTO `cb_user` (`id`, `username`, `password`, `email`, `login_count`, `last_time`, `last_ip`, `state`, `created`, `updated`)
VALUES
(1,'admin',' e10adc3949ba59abbe56e057f20f883e','',13,NULL,'127.0.0.1:49208',0,NULL,'2017-08-08 19:48:05');

/*!40000 ALTER TABLE `cb_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
